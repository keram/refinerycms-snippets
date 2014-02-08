class CreateSnippets < ActiveRecord::Migration

  def up
    create_table ::Refinery::Snippet.table_name do |t|
      t.string :snippet_type, null: false, default: ::Refinery::Snippet::TYPES.first
      t.string :canonical_friendly_id, null: false
      t.timestamps null: false
    end

    ::Refinery::Snippet.create_translation_table!({
      title: { type: :string, null: false, default: '', limit: 64 },
      body: :text
    })
  end


  def down
    ::Refinery::UserPlugin.destroy_all({name: 'snippets'})

    drop_table ::Refinery::Snippet.table_name
    ::Refinery::Snippet.drop_translation_table!
  end

end
