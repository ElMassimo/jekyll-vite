# frozen_string_literal: true

require 'rack'
require 'webrick'
require 'jekyll/commands/serve/servlet'

# Internal: Extend the default servlet to add a Rack-based proxy in order to
# forward asset requests to the Vite.js development server.
module Jekyll::Vite::Proxy
  # Internal: Used to detect proxied requests since it's not a valid status code.
  STATUS_SERVE_ORIGINAL = 7

  def initialize(server, *args)
    @server = server
    super
  end

  # Override: Serve compiled Vite assets from the temporary folder as needed.
  def set_filename(req, res)
    original_root = @root.dup
    if req.path_info.start_with?("/#{ ViteRuby.config.public_output_dir }/")
      @root = ViteRuby.config.root.join(ViteRuby.config.public_dir)
    end
    super.tap { @root = original_root }
  end

  # Override: Detect the special status set by the Proxy Servlet and use the
  # default Jekyll response instead.
  def service(req, res)
    proxy_servlet.service(req, res)
    if res.status == STATUS_SERVE_ORIGINAL
      res.status = 200
      super
    end
  end

private

  # Internal: A WEBRick servlet that uses a Rack proxy internally.
  def proxy_servlet
    @proxy_servlet ||= begin
      # Called by the proxy if a request shouldn't be served by Vite.
      app = ->(_env) { [STATUS_SERVE_ORIGINAL, {}, []] }

      # Initialize the proxy which is a Rack app.
      proxy = ViteRuby::DevServerProxy.new(app)

      # Return a servlet compliant with WEBrick.
      Rack::Handler::WEBrick.new(@server, proxy)
    end
  end
end

Jekyll::Commands::Serve::Servlet.prepend Jekyll::Vite::Proxy
