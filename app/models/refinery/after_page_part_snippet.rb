require File.expand_path('../page_part_snippet.rb', __FILE__)

module Refinery
  class AfterPagePartSnippet < PagePartSnippet

    default_scope -> { order(position: :asc) }

    def position_to_part
      'after'
    end
  end
end
