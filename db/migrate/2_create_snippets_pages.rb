class CreateSnippetsPages < ActiveRecord::Migration

  def self.up
    create_table :snippets_pages do |t|
      t.integer :snippet_id, :null => false, :references => [:snippets, :id]
      t.integer :page_id, :null => false, :references => [:pages, :id]
      t.integer :position, :null => false, :default => 0
    end

#    add_index :snippets_pages, :snippet_id
    add_index :snippets_pages, :page_id
  end

  def self.down
    drop_table :snippets_pages
  end

end