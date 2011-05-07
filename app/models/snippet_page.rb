class SnippetPage < ActiveRecord::Base

  belongs_to :snippet
  belongs_to :page

  before_save do |snippet_page|
    snippet_page.position = (SnippetPage.maximum(:position) || -1) + 1
  end
  
end