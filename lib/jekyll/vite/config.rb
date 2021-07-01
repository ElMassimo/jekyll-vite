# frozen_string_literal: true

module Jekyll::Vite::Config
  # Override: Default values for a Rails application.
  def config_defaults
    require 'jekyll'
    super(mode: Jekyll.env)
  end
end

ViteRuby::Config.singleton_class.prepend(Jekyll::Vite::Config)
