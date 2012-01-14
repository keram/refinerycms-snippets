require 'refinerycms-base'

module Refinery
  module Snippets
    class Engine < Rails::Engine

      config.before_initialize do
        require 'extensions/page_extensions'
        require 'extensions/application_helper_extensions'
      end

      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.to_prepare do
        PagePart.module_eval do
          has_many :snippet_page_parts, :dependent => :destroy
          has_many :snippets, :through => :snippet_page_parts, :order => 'position ASC'
        end
        Page.send :include, Extensions::Page
        ApplicationHelper.send :include, Extensions::ApplicationHelper
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
