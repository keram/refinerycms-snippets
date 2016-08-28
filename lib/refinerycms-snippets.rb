module Refinery
  module Snippets
    class Engine < Rails::Engine

      config.before_initialize do
        require 'extensions/page_extensions'
        require 'extensions/pages_helper_extensions'
      end

      config.to_prepare do
        Refinery::PagePart.module_eval do
          has_many :snippet_page_parts, :dependent => :destroy
          has_many :snippets, :through => :snippet_page_parts
        end
        Refinery::Page.send :include, Extensions::Page
        Refinery::Admin::PagesHelper.send :include, Extensions::PagesHelper
      end

      config.after_initialize do
        Refinery::Pages::Tab.register do |tab|
          tab.name = "snippets"
          tab.partial = "/admin/pages/tabs/snippets"
        end
        Refinery::Plugin.register do |plugin|
          plugin.name = "snippets"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.admin_snippets_path }
          plugin.menu_match = /^\/?(admin|refinery)\/snippets/
        end
      end
    end
  end
end
