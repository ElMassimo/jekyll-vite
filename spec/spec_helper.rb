# frozen_string_literal: true

require 'bundler/setup'

require 'simplecov'
SimpleCov.start {
  add_filter '/spec/'
}

require 'jekyll/vite'
require 'pry-byebug'

Jekyll.logger.log_level = ENV['JEKYLL_LOG_LEVEL'] || :error

RSpec.configure do |config|
  SITE_DIR = File.expand_path('../docs', __dir__)

  config.include(Module.new {
    def self.included(base)
      base.let(:config) { ViteRuby.reload_with('VITE_RUBY_ROOT' => SITE_DIR) }
      base.let(:root) { config.root }
      base.let(:site) { Jekyll::Site.new(load_jekyll({})) }
      base.let(:dest) { Pathname.new(site.dest) }
      base.let(:output_dir) { config.build_output_dir }
    end

    def stub_env(environment)
      allow(Jekyll).to receive(:env).and_return(environment)
    end

    def site_dir(*paths)
      File.join(SITE_DIR, *paths)
    end

    def load_jekyll(options)
      Jekyll.configuration(
        options.merge(
          'skip_config_files' => false,
          'source' => site_dir,
          'destination' => site_dir('_site'),
        ),
      )
    end
  })

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
