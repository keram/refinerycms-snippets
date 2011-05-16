class Snippet < ActiveRecord::Base
  
  acts_as_indexed :fields => [:title, :body]

  validates :title, :presence => true, :uniqueness => true

  translates :body

  has_many :snippet_page, :dependent => :destroy
  has_many :pages, :through => :snippet_page

  def self.inactive(page)
      @page = page
      snippets = scoped      
      snippets = snippets.where('id NOT IN (?)', @page.snippets) unless @page.snippets.empty?
      snippets
  end

  # rejects any page that has not been translated to the current locale.
  scope :translated, lambda {
    pages = Arel::Table.new(Snippet.table_name)
    translations = Arel::Table.new(Snippet.translations_table_name)

    includes(:translations).where(
      translations[:locale].eq(Globalize.locale)).where(pages[:id].eq(translations[:snippet_id]))
  }
end
