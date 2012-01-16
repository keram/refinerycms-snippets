class TranslateSnippets < ActiveRecord::Migration

  def up
    ::Refinery::Snippet.reset_column_information
    unless ::Refinery::Snippet::Translation.table_exists?
      ::Refinery::Snippet.create_translation_table!({
        :body => :text
      }, {
        :migrate_data => true
      })
    end
  end

  def down
    ::Refinery::Snippet.reset_column_information

    ::Refinery::Snippet.drop_translation_table!
  end

end