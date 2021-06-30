# frozen_string_literal: true

# Public: Renders the @vite/client script tag.

class Jekyll::Vite::Generator < Jekyll::Generator
  safe true
  priority :high

  # Main plugin action, called by jekyll-core
  def generate(site)
    @site = site
    ViteRuby.commands.build_from_task
  end
end
