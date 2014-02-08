module Extensions
  module PagePart

    def self.included(base)

      base.class_eval do
        has_many :before_page_part_snippets, dependent: :destroy
        has_many :after_page_part_snippets, dependent: :destroy

        accepts_nested_attributes_for :before_page_part_snippets, allow_destroy: true
        accepts_nested_attributes_for :after_page_part_snippets, allow_destroy: true

        def before_snippets_with_globalize
          before_page_part_snippets.
            includes(snippet: :translations).
            joins(snippet: :translations).
            where(Refinery::Snippet::Translation.arel_table[:locale].eq(Globalize.locale))
        end

        def after_snippets_with_globalize
          after_page_part_snippets.
            includes(snippet: :translations).
            joins(snippet: :translations).
            where(Refinery::Snippet::Translation.arel_table[:locale].eq(Globalize.locale))
        end

      end

    end

  end
end
