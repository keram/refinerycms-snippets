class CreateSnippetsPageParts < ActiveRecord::Migration

  def up
    unless ::Refinery::SnippetPagePart.table_exists?
      create_table ::Refinery::SnippetPagePart.table_name do |t|
        t.integer :snippet_id, :null => false, :references => [:snippets, :id]
        t.integer :page_part_id, :null => false, :references => [:page_parts, :id]
        t.integer :position, :null => false, :default => 0
        t.boolean :before_body, :null => false, :default => false
      end
    end

    add_index ::Refinery::SnippetPagePart.table_name, :snippet_id
    add_index ::Refinery::SnippetPagePart.table_name, :page_part_id
  end

  def down
    drop_table ::Refinery::SnippetPagePart.table_name
  end

end
