# frozen_string_literal: true

require 'jekyll/vite'

# Internal: Extends the base installation script from Vite Ruby to work for a
# typical Jekyll site.
module Jekyll::Vite::Installation
  JEKYLL_TEMPLATES = Pathname.new(File.expand_path('../../../templates', __dir__))

  # Override: Setup a typical Jekyll site to use Vite.
  def setup_app_files
    cp JEKYLL_TEMPLATES.join('config/jekyll-vite.json'), config.config_path
    append root.join('Procfile.dev'), 'jekyll: bin/jekyll-vite wait && bundle exec jekyll serve --livereload'
    cp JEKYLL_TEMPLATES.join('exe/dev'), root.join('exe/dev')
    `bundle binstub jekyll-vite --path #{ root.join('bin') }`
    `bundle config --delete bin`
    append root.join('Rakefile'), <<~RAKE
      require 'jekyll/vite'
      ViteRuby.install_tasks
    RAKE
  end

  # Override: Inject the vite client and sample script to the default HTML template.
  def install_sample_files
    super
    inject_line_after_last root.join('_config.yml'), 'plugins:', '  - jekyll/vite'
    inject_line_after_last root.join('_config.yml'), 'exclude:', <<-YML.chomp("\n")
  - bin
  - config
  - vite.config.ts
  - tmp
  - Procfile.dev
    YML
    inject_line_before root.join('_layouts/default.html'), '</head>', <<-HTML.chomp("\n")
    {% vite_client_tag %}
    {% vite_javascript_tag application %}
    HTML
  end
end

ViteRuby::CLI::Install.prepend(Jekyll::Vite::Installation)
