class SnippetsController < ApplicationController

  before_filter :find_all_snippets
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @snippet in the line below:
    present(@page)
  end

  def show
    @snippet = Snippet.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @snippet in the line below:
    present(@page)
  end

protected

  def find_all_snippets
    @snippets = Snippet.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/snippets").first
  end

end
