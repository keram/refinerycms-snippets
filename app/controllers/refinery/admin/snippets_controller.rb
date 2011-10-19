module ::Refinery
  module Admin
    class SnippetsController < ::Refinery::AdminController

      crudify :'refinery/snippet', :xhr_paging => true

      def create
        if (@snippet = Refinery::Snippet.create(params[:snippet])).valid?
          (request.xhr? ? flash.now : flash).notice = t(
            'refinery.crudify.created',
            :what => "#{@snippet.title}"
          )

          unless request.xhr?
            redirect_to (params[:continue_editing] =~ /1/ ? main_app.edit_refinery_admin_snippet_path(@snippet) : main_app.refinery_admin_snippets_url)
          else
            response = Hash.new
            response['redirect'] = main_app.edit_refinery_admin_snippet_path(@snippet) if params[:continue_editing]
            render :json => response
          end

        else
          unless request.xhr?
            render :action => 'new'
          else
            html_snippets = Hash.new
            html_snippets['flash_container'] = render_to_string(:partial => "/shared/admin/error_messages",
              :locals => {
                :object => @snippet,
                :include_object_name => true
              })
            render :json => {'snippets' => html_snippets}
          end
        end
      end
    end
  end
end