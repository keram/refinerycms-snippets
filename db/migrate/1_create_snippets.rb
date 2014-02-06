class CreateSnippets < ActiveRecord::Migration

  def up
    create_table ::Refinery::Snippet.table_name do |t|
      t.string :snippet_type, null: false, default: ::Refinery::Snippet::TYPES.first
      t.timestamps null: false
      t.boolean :active_before_by_default, null: false, default: false
      t.boolean :active_after_by_default, null: false, default: false
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
