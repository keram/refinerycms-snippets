class CreateSnippetsPageParts < ActiveRecord::Migration

  def self.up
    create_table :snippets_page_parts do |t|
      t.integer :snippet_id, :null => false, :references => [:snippets, :id]
      t.integer :page_part_id, :null => false, :references => [:page_parts, :id]
      t.integer :position, :null => false, :default => 0
      t.boolean :before_body, :null => false, :default => false
    end

    add_index :snippets_page_parts, :snippet_id
    add_index :snippets_page_parts, :page_part_id
  end

  def self.down
    drop_table :snippet_page_parts
  end

end
