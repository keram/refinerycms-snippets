module ::Refinery
  module Admin
    class SnippetsPagePartsController < ::Refinery::AdminController

      def add
        @page = Refinery::Page.find(params[:id])
        @part = Refinery::PagePart.find(params[:part_id])
        @snippet = Refinery::Snippet.find(params[:snippet_id])
        before_body = params[:before_body] == 'true' ? true : false

        sp = Refinery::SnippetPagePart.new(:page_part => @part, :snippet => @snippet, :before_body => before_body)

        if sp.save
          flash[:notice] = "Snippet #{@snippet.title} was successfully added."
        end

        render :layout => false if request.xhr?
      end

      def remove
        @page = Refinery::Page.find(params[:id])
        @part = Refinery::PagePart.find(params[:part_id])
        @snippet = Refinery::Snippet.find(params[:snippet_id])
        before_body = params[:before_body] == 'true' ? true : false

        sp = Refinery::SnippetPagePart.where(:page_part_id => @part, :snippet_id => @snippet, :before_body => before_body)

        removed = sp.first.destroy() unless sp.empty?

        if removed
          flash[:notice] = "Snippet #{@snippet.title} was successfully removed."
        end

        render :layout => false if request.xhr?
      end
    end
  end
end
