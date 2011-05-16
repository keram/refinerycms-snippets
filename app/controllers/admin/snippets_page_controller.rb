module Admin
  class SnippetsPageController < Admin::BaseController
    
    def add
      @page = Page.find(params[:id])
      @snippet = Snippet.find(params[:snippet_id])

      sp = SnippetPage.new(:page => @page, :snippet => @snippet)

      if sp.save
         flash[:notice] = "Snippet #{@snippet.title} was successfully added to page."
      end
      
      render :layout => false if request.xhr?
    end

    def remove
      @page = Page.find(params[:id])
      @snippet = Snippet.find(params[:snippet_id])

      sp = SnippetPage.where(:page_id => @page, :snippet_id => @snippet)
      
      removed = sp.first.destroy() unless sp.empty?

      if removed
         flash[:notice] = "Snippet #{@snippet.title} was successfully removed from page."
      end
      
      render :layout => false if request.xhr?
    end
  end
end
