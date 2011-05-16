class CreateSnippets < ActiveRecord::Migration

  def self.up
    create_table :snippets do |t|
      t.string :title, :limit => 36, :null => false
      t.text :body
      t.integer :position, :null => false, :default => 0
      t.timestamps
    end

    load(Rails.root.join('db', 'seeds', 'snippets.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "snippets"})

    Page.delete_all({:link_url => "/snippets"})

    drop_table :snippets
  end

end
