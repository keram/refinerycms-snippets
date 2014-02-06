module Refinery
  module Snippets
    class TextSnippetPresenter < SectionPresenter
      def initialize snippet_wrapper
        super()
        @content = snippet_wrapper.body
        @hidden = !snippet_wrapper.active
        @id = "snippet-#{snippet_wrapper.position_to_part}-#{snippet_wrapper.page_part.title}-#{snippet_wrapper.id}"
      end

      def not_present_css_class
        "no_snippet_#{id}"
      end

    private

      def wrap_content_in_tag(content)
        content_tag(:div, content_tag(:div, content, class: 'inner'), id: id, class: 'snippet')
      end

      def render_content content
        renderer.render content
      end

      def renderer
        @renderer ||= Refinery.content_renderer
      end
    end
  end
end
