class DropSnippetPage < ActiveRecord::Migration

  def self.up
    remove_index :snippet_page, :snippet_id
    remove_index :snippet_page, :page_id
    drop_table :snippet_page
  end

  def self.down
    create_table :snippet_page do |t|
      t.integer :snippet_id, :null => false, :references => [:snippets, :id]
      t.integer :page_id, :null => false, :references => [:pages, :id]
      t.integer :position, :null => false, :default => 0
    end

    add_index :snippet_page, :snippet_id
    add_index :snippet_page, :page_id
  end
  
end
