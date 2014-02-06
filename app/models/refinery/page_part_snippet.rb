module Refinery
  class PagePartSnippet < ActiveRecord::Base

    self.abstract_class = true

    def self.active
      where(active: true)
    end

    def to_html
      presenter.new(self).wrapped_html
    end

    def presenter
      @presenter ||= "Refinery::Snippets::#{snippet.snippet_type.classify}SnippetPresenter".safe_constantize
    end
  end
end
