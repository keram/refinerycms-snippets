module Refinery
  class PagePartSnippet < ActiveRecord::Base

    self.abstract_class = true

    belongs_to :snippet, foreign_key: :snippet_id
    belongs_to :page_part, foreign_key: :page_part_id

    validates_uniqueness_of :snippet_id,  scope: [:page_part_id]

    delegate :title, :body, to: :snippet

    def canonical_friendly_id
      "#{snippet.canonical_friendly_id}-#{position_to_part}-#{page_part.title}"
    end

    def position_to_part
      'before'
    end

    def render(context)
      presenter.new(self, context).wrapped_html
    end

    def presenter
      @presenter ||= "Refinery::Snippets::#{snippet.snippet_type.classify}SnippetPresenter".safe_constantize
    end
  end
end
