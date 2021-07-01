# frozen_string_literal: true

require 'jekyll'
require 'vite_ruby'

require 'jekyll/vite/version'
require 'jekyll/vite/config'
require 'jekyll/vite/tags'
require 'jekyll/vite/generator'
require 'jekyll/vite/proxy'

Jekyll::Hooks.register(:site, :after_init) do |site|
  if site.config['serving'] && ViteRuby.instance.dev_server_running?
    site.config['exclude'] << ViteRuby.config.source_code_dir
  end
end
