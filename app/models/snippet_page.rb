class SnippetPage < ActiveRecord::Base
  
  set_table_name 'snippets_pages'
  
  belongs_to :snippet, :foreign_key => :snippet_id, :dependent => :destroy
  belongs_to :page, :foreign_key => :page_id, :dependent => :destroy
  
  validates_uniqueness_of(:snippet_id, :scope => :page_id)

  before_save do |snippet_page|
    snippet_page.position = (SnippetPage.where('page_id = ?', snippet_page.page_id).maximum(:position) || -1) + 1
  end
  
end