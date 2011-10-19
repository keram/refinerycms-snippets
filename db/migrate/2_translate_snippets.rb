class TranslateSnippets < ActiveRecord::Migration

  def self.up
    Refinery::Snippet.reset_column_information
    unless defined?(Refinery::Snippet::Translation) && Refinery::Snippet::Translation.table_exists?
      Refinery::Snippet.create_translation_table!({
        :body => :text
      }, {
        :migrate_data => true
      })
    end

    load(Rails.root.join('db', 'seeds', 'snippets.rb').to_s)
  end

  def self.down
    Refinery::Snippet.reset_column_information

    Refinery::Snippet.drop_translation_table!
  end

end