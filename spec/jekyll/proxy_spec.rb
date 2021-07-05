# frozen_string_literal: true

require 'webrick'
require 'net/http'
require 'rack-proxy'
require 'support/test_webrick'

RSpec.describe Jekyll::Vite::Proxy do
  def get(path, &block)
    TestWEBrick.mount_server(dest) do |_server, addr, port|
      http = Net::HTTP.new(addr, port)
      req = Net::HTTP::Get.new(path)

      http.request(req, &block)
    end
  end

  before do
    stub_env('development')
    config
  end

  it 'should serve a vite asset even if the dev server is down' do
    allow(ViteRuby.instance.logger).to receive(:debug)
    site.process # build Vite assets

    get('/vite-dev/manifest.json') do |response|
      expect(response.code).to eq('200')
      expect(response.body).to eq(output_dir.join('manifest.json').read)
    end

    # Should not proxy requests for content.
    get('/index.html') do |response|
      expect(response.code).to eq('200')
      expect(response.body.force_encoding('utf-8')).to eq(dest.join('index.html').read)
    end
  end

  it 'should proxy vite assets if the vite dev server is running' do
    # Stub request to the Vite dev server.
    allow_any_instance_of(Rack::Proxy).to receive(:perform_request) { |_, env|
      expect(env['HTTP_X_FORWARDED_SERVER']).to eq ViteRuby.config.host_with_port
      [200, {}, [output_dir.join('manifest.json').read]]
    }
    # Stub the uptime check to the Vite dev server.
    allow(ViteRuby.instance).to receive(:dev_server_running?).and_return(true)

    get('/vite-dev/manifest.json') do |response|
      expect(response.code).to eq('200')
      expect(response.body.strip).to eq(output_dir.join('manifest.json').read)
    end
  end

  it 'should return 404 for non-existing files' do
    get('/bar/missing') do |response|
      expect(response.code).to eq('404')
    end
  end
end
