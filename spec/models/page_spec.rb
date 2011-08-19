require 'spec_helper'

describe Page do

  before(:each) do
    @page = Page.create!(:title => 'Page title')
    @part = PagePart.create!(:title => 'Part', :body => "PART BODY")
    @snippet_before = Snippet.create!(:title => 'Before title', :body => "BEFORE BODY")
    @snippet_after = Snippet.create!(:title => 'After title', :body => "AFTER BODY")
    SnippetPagePart.create(:page_part_id => @part.id, :snippet_id => @snippet_before.id, :before_body => true)
    SnippetPagePart.create(:page_part_id => @part.id, :snippet_id => @snippet_after.id)
    @page.parts << @part
  end

  it 'should give content for one part wrapped with is snippets' do
    @page.content_for(:part).should == "BEFORE BODY<p>PART BODY</p>AFTER BODY"
  end

  it 'should give content for one part without is snippets' do
    @page.content_without_snippets_for(:part).should == "<p>PART BODY</p>"
  end

end
