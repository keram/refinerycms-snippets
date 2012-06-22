require 'refinerycms-snippets'

module Refinery
  module Snippets
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery
      engine_name :refinery_snippets

      config.before_initialize do
        require 'extensions/page_extensions'
        require 'extensions/application_helper_extensions'
      end

      initializer "register refinery_snippets plugin", :after => :set_routes_reloader do |app|

        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinery_snippets"
          plugin.url = proc {Refinery::Core::Engine.routes.url_helpers.admin_snippets_path}
          plugin.menu_match = /^\/?(admin|refinery)\/snippets/
          plugin.activity = [{
                               :class_name => :'refinery/snippet',
                               :title => 'title'
                             }, {
                               :class_name => :'refinery/snippet_page_part',
                             }]
        end
      end

      config.to_prepare do
        Refinery::PagePart.module_eval do
          has_many :snippet_page_parts, :dependent => :destroy
          has_many :snippets, :through => :snippet_page_parts, :order => 'position ASC'
        end
        Refinery::Page.send :include, Extensions::Page
        ApplicationHelper.send :include, Extensions::ApplicationHelper
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
