require 'refinerycms-base'

module Refinery
  module Snippets
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end
      
      config.to_prepare do
        Page.module_eval do
          has_many :snippet_page
          has_many :snippets, :through => :snippet_page, :order => 'position ASC'
        end
      end

      config.after_initialize do
       ::Refinery::Pages::Tab.register do |tab|
          tab.name = "snippets"
          tab.partial = "/admin/pages/tabs/snippets"
        end
        Refinery::Plugin.register do |plugin|
          plugin.name = "snippets"
          plugin.url = {:controller => '/admin/snippets'}
          plugin.menu_match = /^\/?(admin|refinery)\/snippets/
          plugin.activity = [{
            :class => Snippet
          }, {
            :class => SnippetPage
          }]
        end
      end
    end
  end
end
