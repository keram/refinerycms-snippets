class CreateSnippets < ActiveRecord::Migration

  def self.up
    create_table :snippets do |t|
      t.string :title
      t.text :body
      t.integer :position

      t.timestamps
    end

    add_index :snippets, :id

    load(Rails.root.join('db', 'seeds', 'snippets.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "snippets"})

#    Page.delete_all({:link_url => "/snippets"})

    drop_table :snippets
  end

end
