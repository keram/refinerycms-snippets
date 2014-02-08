require File.expand_path('../page_part_snippet.rb', __FILE__)

module Refinery
  class BeforePagePartSnippet < PagePartSnippet

    default_scope -> { order(position: :asc) }

  end
end
