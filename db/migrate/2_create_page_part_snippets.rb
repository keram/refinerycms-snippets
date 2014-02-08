class CreatePagePartSnippets < ActiveRecord::Migration

  def up
    create_table ::Refinery::BeforePagePartSnippet.table_name do |t|
      t.integer :snippet_id, null: false, references: [:snippets, :id]
      t.integer :page_part_id, null: false, references: [:page_parts, :id]
      t.integer :position, null: false, default: 0
    end

    create_table ::Refinery::AfterPagePartSnippet.table_name do |t|
      t.integer :snippet_id, null: false, references: [:snippets, :id]
      t.integer :page_part_id, null: false, references: [:page_parts, :id]
      t.integer :position, null: false, default: 0
    end

    add_index ::Refinery::BeforePagePartSnippet.table_name, [:snippet_id, :page_part_id],
                unique: true,
                name: 'index_on_snippet_id_and_page_part_id'

    add_index ::Refinery::AfterPagePartSnippet.table_name, [:snippet_id, :page_part_id],
                unique: true,
                name: 'index_on_snippet_id_and_page_part_id'
  end

  def down
    drop_table ::Refinery::BeforePagePartSnippet.table_name
    drop_table ::Refinery::AfterPagePartSnippet.table_name
  end

end
