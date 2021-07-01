# frozen_string_literal: true

require 'rack'
require 'webrick'
require 'jekyll/commands/serve/servlet'

# Monkeypatch: Extend the default servlet to add a Rack-based proxy in order to
# forward asset requests to the Vite.js development server.
Jekyll::Commands::Serve::Servlet.prepend Module.new {
  # Internal: Used to detect proxied requests since it's not a valid status code.
  STATUS_SERVE_ORIGINAL = 007

  def initialize(server, *args)
    @server = server
    super
  end

  # Override: Detect the special status set by the Proxy Servlet and use the
  # default Jekyll response instead.
  def service(req, res)
    proxy_servlet.service(req, res)
    super if res.status == STATUS_SERVE_ORIGINAL
  end

private

  # Internal: A WEBRick servlet that uses a Rack proxy internally.
  def proxy_servlet
    @proxy_servlet ||= begin
      # Called by the proxy if a request shouldn't be served by Vite.
      app = ->(env) { [STATUS_SERVE_ORIGINAL, {}, []] }

      # Initialize the proxy which is a Rack app.
      proxy = ViteRuby::DevServerProxy.new(app)

      # Return a servlet compliant with WEBrick.
      Rack::Handler::WEBrick.new(@server, proxy)
    end
  end
}
