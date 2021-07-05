# frozen_string_literal: true

module Jekyll::Vite::Config
  # Override: Provide default values for a typical Jekyll site.
  def config_defaults(**opts)
    require 'jekyll'
    cache_dir = Jekyll.configuration['cache_dir'] || '.jekyll-cache'
    super(**opts, mode: Jekyll.env).tap do |defaults|
      defaults['public_dir'] = cache_dir
      defaults['build_cache_dir'] = File.join(cache_dir, 'vite-build')
    end
  end
end

ViteRuby::Config.singleton_class.prepend(Jekyll::Vite::Config)
