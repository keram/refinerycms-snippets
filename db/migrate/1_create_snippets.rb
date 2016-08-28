class CreateSnippets < ActiveRecord::Migration

  def self.up
    create_table :snippets do |t|
      t.string :title, :limit => 36, :null => false
      t.text :body
      t.integer :position, :null => false, :default => 0
      t.timestamps
    end
  end

  def self.down
    if defined?(Refinery::UserPlugin)
      Refinery::UserPlugin.destroy_all({:name => "snippets"})
    end

    Refinery::Page.delete_all({:link_url => "/snippets"})

    drop_table :snippets
  end

end
