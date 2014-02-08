module Refinery
  module Snippets
    class TextSnippetPresenter < SectionPresenter
      def initialize snippet_wrapper, context
        super()
        @content = snippet_wrapper.body
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
