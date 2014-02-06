require File.expand_path('../page_part_snippet.rb', __FILE__)

module Refinery
  class BeforePagePartSnippet < PagePartSnippet

    belongs_to :snippet, foreign_key: :snippet_id
    belongs_to :page_part, foreign_key: :page_part_id

    validates_uniqueness_of :snippet_id,  scope: [:page_part_id]

    delegate :title, :body, to: :snippet

    default_scope -> { order(position: :asc) }

    def position_to_part
      'before'
    end
  end
end
