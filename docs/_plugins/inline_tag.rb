# frozen_string_literal: true

class InlineTag < Liquid::Tag
  def render(context)
    Pathname.new(context.registers[:site].source).join(@markup.strip).read
  end
end

Liquid::Template.register_tag('inline', InlineTag)
