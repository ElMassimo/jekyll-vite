# frozen_string_literal: true

require 'bundler/setup'

require 'simplecov'
SimpleCov.start {
  add_filter '/spec/'
}

require 'jekyll/vite'
require 'pry-byebug'

RSpec.configure do |config|
  SITE_DIR = File.expand_path('../docs', __dir__)

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

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
