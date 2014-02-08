require 'refinerycms-snippets'

module Refinery
  module Snippets
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery
      engine_name :refinery_snippets

      config.before_initialize do
        require 'extensions/page_part_extensions'
      end

      initializer 'register refinery_snippets plugin', after: :set_routes_reloader do |app|

        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = 'snippets'
          plugin.url = proc {Refinery::Core::Engine.routes.url_helpers.admin_snippets_path}
          plugin.activity = {
            class_name: :'refinery/snippet',
            title: 'title'
          }
        end
      end

      config.to_prepare do
        Refinery::PagePart.send :include, Extensions::PagePart

      end

      config.after_initialize do
        ::Refinery::Pages::Tab.register do |tab|
          tab.name = 'snippets'
          tab.partial = '/refinery/admin/pages/tabs/snippets'
        end

        Refinery::Admin::PagesController.class_eval do
          before_action :add_snippets_to_page_params, only: [:update, :create]

          private

          def permitted_page_parts_params_with_snippets
            @permitted_page_parts_params ||= permitted_page_parts_params_without_snippets + permitted_snippet_page_parts_params
          end

          def permitted_snippet_page_parts_params
            [
              before_page_part_snippets_attributes: [:id, :snippet_id, :page_part_id, :position, :_destroy],
              after_page_part_snippets_attributes: [:id, :snippet_id, :page_part_id,  :position, :_destroy]
            ]
          end

          alias_method_chain :permitted_page_parts_params, :snippets

          def add_snippets_to_page_params
            if params[:page] && params[:page][:parts_attributes]

              params[:page][:parts_attributes].each do |part|
                part_bkey = "snippets_before_#{part[1][:id] || part[1][:title]}"
                params[part_bkey].each_with_index do |snippet, index|
                  part[1][:before_page_part_snippets_attributes] ||= []
                  if snippet[1][:active] == "1" || snippet[1][:id].present?
                    snippet_block = {
                      snippet_id: snippet[1][:snippet_id],
                      position: index,
                      _destroy: (snippet[1][:active] == "0")
                    }

                    snippet_block[:id] = snippet[1][:id] if snippet[1][:id].present?
                    part[1][:before_page_part_snippets_attributes] << snippet_block
                  end
                end if params[part_bkey]

                part_akey = "snippets_after_#{part[1][:id] || part[1][:title]}"
                params[part_akey].each_with_index do |snippet, index|
                  part[1][:after_page_part_snippets_attributes] ||= []
                  if snippet[1][:active] == "1" || snippet[1][:id].present?
                    snippet_block = {
                      snippet_id: snippet[1][:snippet_id],
                      position: index,
                      _destroy: (snippet[1][:active] == "0")
                    }

                    snippet_block[:id] = snippet[1][:id] if snippet[1][:id].present?
                    part[1][:after_page_part_snippets_attributes] << snippet_block
                  end
                end if params[part_akey]
              end
            end
          end
        end

        Refinery.register_engine(Refinery::Snippets)
      end
    end
  end
end
