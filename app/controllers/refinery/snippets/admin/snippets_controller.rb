module Refinery
  module Snippets
    module Admin
      class SnippetsController < ::Refinery::AdminController

        crudify :snippet, :xhr_paging => true
        
        def create
          if (@snippet = Snippet.create(snippet_params)).valid?
            (request.xhr? ? flash.now : flash).notice = t(
              'refinery.crudify.created',
              :what => "#{@snippet.title}"
            )

            unless request.xhr?
              redirect_to (params[:continue_editing] =~ /1/ ? edit_snippets_admin_snippet_path(@snippet) : snippets_admin_snippets_url)
            else
              response = Hash.new
              response['redirect'] = edit_snippets_admin_snippet_path(@snippet) if params[:continue_editing]
              render :json => response
            end

          else
            unless request.xhr?
              render :action => 'new'
            else
              html_snippets = Hash.new
              html_snippets['flash_container'] = render_to_string(:partial => "/refinery/admin/error_messages",
                                                                  :locals => {
                                                                    :object => @snippet,
                                                                    :include_object_name => true
                                                                  })
              render :json => {'snippets' => html_snippets}
            end
          end
        end

        private

        def snippet_params
          params.require(:snippet).permit(:title, :body)
        end
      end
    end
  end
end
