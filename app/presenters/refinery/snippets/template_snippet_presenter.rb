module Refinery
  module Snippets
    class TemplateSnippetPresenter < SectionPresenter
      def initialize snippet_wrapper, context
        super()
        @content = context.render(
          partial: snippet_wrapper.body,
          locals: {
            snippet: snippet_wrapper
          }
        )

        @id = snippet_wrapper.canonical_friendly_id
      end

    private

      def wrapper_class
        'snippet-wrapper'
      end

      def content_class
        'snippet'
      end

    end
  end
end
