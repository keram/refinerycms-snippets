module Admin
  class SnippetsPagePartsController < Admin::BaseController
    
    def add
      @page = Page.find(params[:id])
      @part = PagePart.find(params[:part_id])
      @snippet = Snippet.find(params[:snippet_id])
      before_body = params[:before_body] == 'true' ? true : false
      
      sp = SnippetPagePart.new(:page_part => @part, :snippet => @snippet, :before_body => before_body)

      if sp.save
         flash[:notice] = "Snippet #{@snippet.title} was successfully added."
      end
      
      render :layout => false if request.xhr?
    end

    def remove
      @page = Page.find(params[:id])
      @part = PagePart.find(params[:part_id])
      @snippet = Snippet.find(params[:snippet_id])
      before_body = params[:before_body] == 'true' ? true : false

      sp = SnippetPagePart.where(:page_part_id => @part, :snippet_id => @snippet, :before_body => before_body)
      
      removed = sp.first.destroy() unless sp.empty?

      if removed
         flash[:notice] = "Snippet #{@snippet.title} was successfully removed."
      end
      
      render :layout => false if request.xhr?
    end
  end
end
