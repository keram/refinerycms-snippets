class RefinerycmsSnippetsGenerator < Rails::Generators::Base

  source_root File.expand_path('../../../', __FILE__)

  def rake_db
    rake("refinery_snippets_engine:install:migrations")
  end

  def append_load_seed_data
    create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
    append_file 'db/seeds.rb', :verbose => true do
      <<-EOH

# Added by Refinery CMS Snippets engine
Refinery::Snippets::Engine.load_seed
      EOH
    end
  end
end
