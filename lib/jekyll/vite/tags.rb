# frozen_string_literal: true

# Internal: Base class for all tags.
class Jekyll::Vite::Tag < Liquid::Tag
  # Internal: Returns the current manifest loaded by Vite Ruby.
  def vite_manifest
    ViteRuby.instance.manifest
  end
end

# Public: Renders the @vite/client script tag.
class Jekyll::Vite::ClientTag < Jekyll::Vite::Tag
  def render(_context)
    return unless src = vite_manifest.vite_client_src
    <<~HTML
      <script src="#{src}" type="module"></script>
    HTML
  end
end

{
  'vite_client_tag' => Jekyll::Vite::ClientTag,
  'vite_javascript_tag' => Jekyll::Vite::ClientTag,
  'vite_typescript_tag' => Jekyll::Vite::ClientTag,
  'vite_stylesheet_tag' => Jekyll::Vite::ClientTag,
}.each do |name, tag|
  Liquid::Template.register_tag(name, tag)
end
