module Admin
  class SnippetsPagesController < Admin::BaseController
    def index
      
      @page = Page.find(params[:page_id])
      @do = 'nothing'
      
      if params[:add].to_i > 0
        @do = 'add'
        sp = SnippetPage.new(:page => @page, :snippet => Snippet.find(params[:add].to_i))
        
        if sp.save
           flash[:notice] = 'Snippet was successfully added to page.'
        end
      else
        if params[:remove].to_i > 0
          @do = 'remove'
          sp = SnippetPage.where(:page_id => @page.id, :snippet_id => params[:remove].to_i)
          removed = sp.first.delete() unless sp.empty?

          if removed
             flash[:notice] = 'Snippet was successfully removed from page.'
          end
        end
      end
      
      render :layout => false if request.xhr?
      
    end
  end
end
