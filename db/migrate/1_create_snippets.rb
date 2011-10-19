class CreateSnippets < ActiveRecord::Migration

  def self.up
    unless Refinery::Snippet.table_exists?
      create_table Refinery::Snippet.table_name do |t|
        t.string :title, :limit => 36, :null => false
        t.text :body
        t.integer :position, :null => false, :default => 0
        t.timestamps
      end
    end
    
    load(Rails.root.join('db', 'seeds', 'snippets.rb'))
  end

  def self.down
    Refinery::UserPlugin.destroy_all({:name => "snippets"})

    drop_table Refinery::Snippet.table_name
  end

end
