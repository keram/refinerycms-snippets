module Extensions
  module PagePart

    def self.included(base)

      base.class_eval do
        has_many :before_page_part_snippets, dependent: :destroy
        has_many :after_page_part_snippets, dependent: :destroy

        accepts_nested_attributes_for :before_page_part_snippets, allow_destroy: false
        accepts_nested_attributes_for :after_page_part_snippets, allow_destroy: false

        after_initialize do |part|
          snippets_before_ids = before_page_part_snippets.map(&:snippet_id)
          snippets_after_ids = after_page_part_snippets.map(&:snippet_id)

          snippets.each do |snippet|
            part.before_page_part_snippets << Refinery::BeforePagePartSnippet.new(
              snippet: snippet,
              position: before_page_part_snippets.size,
              active: snippet.active_before_by_default
            ) unless snippets_before_ids.include?(snippet.id)

            part.after_page_part_snippets << Refinery::AfterPagePartSnippet.new(
              snippet: snippet,
              position: after_page_part_snippets.size,
              active: snippet.active_after_by_default
            ) unless snippets_after_ids.include?(snippet.id)
          end
        end

        def snippets
          @snippets ||= Refinery::Snippet.all
        end

        def snippets_before
          before_page_part_snippets
        end

        def snippets_after
          after_page_part_snippets
        end

        def before_body_with_snippets
          before_body_without_snippets + snippets_before.map(&:to_html).join
        end
        alias_method_chain :before_body, :snippets

        def after_body_with_snippets
          after_body_without_snippets + snippets_after.map(&:to_html).join
        end
        alias_method_chain :after_body, :snippets

      end

    end

  end
end
