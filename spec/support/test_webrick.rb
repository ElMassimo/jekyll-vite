# frozen_string_literal: true

class FakeLogger
  def <<(str); end
end

module TestWEBrick
module_function

  def mount_server(document_root, &block)
    server = WEBrick::HTTPServer.new(config)

    begin
      server.mount('/', Jekyll::Commands::Serve::Servlet, document_root,
                   document_root_options)

      server.start
      addr = server.listeners[0].addr
      block.yield([server, addr[3], addr[1]])
    rescue StandardError => error
      raise error
    ensure
      server.shutdown
      sleep 0.1 until server.status == :Stop
    end
  end

  def config
    logger = FakeLogger.new
    {
      BindAddress: '127.0.0.1', Port: 0,
      ShutdownSocketWithoutClose: true,
      ServerType: Thread,
      Logger: WEBrick::Log.new(logger),
      AccessLog: [[logger, '']],
      JekyllOptions: {}
    }
  end

  def document_root_options
    WEBrick::Config::FileHandler.merge(
      FancyIndexing: true,
      NondisclosureName: [
        '.ht*', '~*'
      ],
    )
  end
end
