class CreatePageSnippets < ActiveRecord::Migration

  def self.up
    create_table :snippet_pages, :id => false do |t|
      t.integer :snippet_id
      t.integer :page_id
      t.integer :position
    end

    add_index :snippet_pages, :snippet_id
    add_index :snippet_pages, :page_id
  end

  def self.down
    drop_table :snippet_pages
  end

end