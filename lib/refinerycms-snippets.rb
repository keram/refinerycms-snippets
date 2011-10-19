require 'refinerycms-base'

module Refinery
  module Snippets
    
    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end
    
    class Engine < Rails::Engine

      config.before_initialize do
        require 'extensions/page_extensions'
        require 'extensions/pages_helper_extensions'
      end

      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
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
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "snippets"
          plugin.url = '/refinery/snippets'
          plugin.activity = [{
                               :class => Refinery::Snippet
                             }, {
                               :class => Refinery::SnippetPage
                             }]
        end
        
        Refinery::Pages::Tab.register do |tab|
          tab.name = "snippets"
          tab.partial = "/refinery/admin/pages/tabs/snippets"
        end
      end
    end
  end
end
