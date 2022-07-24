# frozen_string_literal: true

# Internal: Base class for all tags.
class Jekyll::Vite::Tag < Jekyll::Tags::IncludeTag
  include Jekyll::Filters::URLFilters

  # Override: Set the context to make the site available in the URLFilters.
  def render(context)
    @context = context
    @params = @params.is_a?(String) ? parse_params(context).transform_keys(&:to_sym) : @params || {}
    if @file = render_variable(@file)
      validate_file_name(@file)
      track_file_dependency(@file)
    end
    block_given? ? yield : raise(NotImplementedError, "Implement render in #{ self.class.name }")
  end

  # Override: Modified version that can resolve recursive references.
  def render_variable(variable)
    variable = Liquid::Template.parse(variable).render!(@context) while VARIABLE_SYNTAX =~ variable
    variable
  end

protected

  # Internal: Resolves the path for the specified Vite asset.
  def vite_asset_path(name, **options)
    vite_manifest.path_for(name, **options)
  end

  # Internal: Returns the current manifest loaded by Vite Ruby.
  def vite_manifest
    ViteRuby.instance.manifest
  end

  # Internal: Renders HTML attributes inside a tag.
  def stringify_attrs(**attrs)
    attrs.map { |key, value| %(#{ key }="#{ value }") }.join(' ')
  end

  # Internal: Renders an HTML tag of the specified type.
  def tag(type, **attrs)
    self_closing = type != :script
    %i[href src].each { |key| attrs[key] = relative_url(attrs[key]) if attrs.key?(key) }
    ["<#{ type } ", stringify_attrs(**attrs), self_closing ? '/>' : "></#{ type }>"].join
  end

  # Internal: Renders HTML link tags.
  def link_tags(sources, **attrs)
    sources.map { |href| tag(:link, href: href, **attrs) }.join("\n")
  end

  # Internal: Renders HTML script tags.
  def script_tags(sources, **attrs)
    sources.map { |src| tag(:script, src: src, **attrs) }.join("\n")
  end

  # Internal: Adds entrypoint files managed by Vite as a dependency in the
  # renegerator in order to support --incremental mode.
  def track_file_dependency(name)
    site = @context.registers[:site]
    path = site.in_source_dir(File.join(ViteRuby.config.source_code_dir, ViteRuby.config.entrypoints_dir, name))

    ['', '.css', '.js', '.ts'].each do |ext|
      if File.file?(asset_path = "#{ path }#{ ext }")
        return [asset_path, last_build_metadata_path].each do |filename|
          add_include_to_dependency(site, filename.to_s, @context)
        end
      end
    end
  end

  # Internal: Adding the last build metadata file as a dependency ensures
  # all pages using Vite assets are regenerated if a Vite build is triggered.
  def last_build_metadata_path
    ViteRuby.instance.builder.send(:last_build_path, ssr: false)
  end
end

# Public: Renders a path to a Vite asset.
class Jekyll::Vite::AssetPathTag < Jekyll::Vite::Tag
  def render(context)
    super { vite_asset_path(@file, **@params) }
  end
end

# Public: Renders the @vite/client script tag.
class Jekyll::Vite::ClientTag < Jekyll::Vite::Tag
  def render(context)
    return unless src = vite_manifest.vite_client_src

    super {
      tag :script, src: src, type: 'module'
    }
  end

  def syntax_example
    "{% #{ @tag_name } %}"
  end
end

# Public: Renders a script tag to enable HMR with React Refresh.
class Jekyll::Vite::ReactRefreshTag < Jekyll::Vite::Tag
  def render(_context)
    vite_manifest.react_refresh_preamble&.html_safe
  end

  def syntax_example
    "{% #{ @tag_name } %}"
  end
end

# Public: Renders a <link> tag for the specified stylesheet.
class Jekyll::Vite::StylesheetTag < Jekyll::Vite::Tag
  def render(context)
    super {
      tag :link, **{
        rel: 'stylesheet',
        href: vite_asset_path(@file, type: :stylesheet),
        media: 'screen',
      }.merge(@params)
    }
  end

  def syntax_example
    "{% #{ @tag_name } application.scss media='screen, projection' %}"
  end
end

# Public: Renders a <script> tag for the specified file.
class Jekyll::Vite::JavascriptTag < Jekyll::Vite::Tag
  def render(context)
    super {
      media = @params.delete(:media) || 'screen'
      crossorigin = @params.delete(:crossorigin) || 'anonymous'
      type = @params.delete(:type) || 'module'
      asset_type = @tag_name == 'vite_typescript_tag' ? :typescript : :javascript

      entries = vite_manifest.resolve_entries(@file, type: asset_type)

      [
        script_tags(entries.fetch(:scripts), crossorigin: crossorigin, type: type, **@params),
        link_tags(entries.fetch(:imports), rel: 'modulepreload', as: 'script', crossorigin: crossorigin, **@params),
        link_tags(entries.fetch(:stylesheets), rel: 'stylesheet', media: media, crossorigin: crossorigin, **@params),
      ].join("\n")
    }
  end

  def syntax_example
    "{% #{ @tag_name } application %}"
  end
end

# Recreating tag helpers in Jekyll requires considerably more code than in web
# frameworks, since Liquid does not provide HTML helpers and parsing parameters
# is more complex than a Ruby method invocation.
{
  'vite_asset_path' => Jekyll::Vite::AssetPathTag,
  'vite_client_tag' => Jekyll::Vite::ClientTag,
  'vite_javascript_tag' => Jekyll::Vite::JavascriptTag,
  'vite_typescript_tag' => Jekyll::Vite::JavascriptTag,
  'vite_stylesheet_tag' => Jekyll::Vite::StylesheetTag,
  'vite_react_refresh_tag' => Jekyll::Vite::ReactRefreshTag,
}.each do |name, tag|
  Liquid::Template.register_tag(name, tag)
end
