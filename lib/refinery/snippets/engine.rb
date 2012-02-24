require 'refinerycms-snippets'

module Refinery
  module Snippets
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery
      engine_name :refinery_snippets

      config.before_initialize do
        require 'extensions/page_extensions'
        require 'extensions/pages_helper_extensions'
      end

      initializer "register refinery_snippets plugin", :after => :set_routes_reloader do |app|

        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinery_snippets"
          plugin.url = {:controller => '/refinery/admin/snippets'}
          plugin.menu_match = /^\/?(admin|refinery)\/snippets/
          plugin.activity = [{
                               :class_name => :'refinery/snippet',
                               :url => "refinery.admin_snippet_path"
                             }, {
                               :class_name => :'refinery/snippet_page_part',
                               :nested_with => ['snippet'],
                               :url => "refinery.admin_snippet_snippets_page_part_path"
                             }]
        end
      end

      config.to_prepare do
        Refinery::PagePart.module_eval do
          has_many :snippet_page_parts, :dependent => :destroy
          has_many :snippets, :through => :snippet_page_parts, :order => 'position ASC'
        end
        Refinery::Page.send :include, Extensions::Page
        Refinery::PagesHelper.send :include, Extensions::PagesHelper
      end
      
      config.after_initialize do
        ::Refinery::Pages::Tab.register do |tab|
          tab.name = "snippets"
          tab.partial = "/refinery/admin/pages/tabs/snippets"
        end

        Refinery.register_engine(Refinery::Snippets)
      end
    end
  end
end
