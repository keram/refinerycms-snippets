require 'spec_helper'

describe PagesHelper do

  before(:each) do
    @page = Page.create!(:title => 'Page title')
    @part = PagePart.create!(:title => 'Part', :body => "PART BODY")
    @snippet_before = Snippet.create!(:title => 'Before title', :body => "BEFORE BODY")
    @snippet_after = Snippet.create!(:title => 'After title', :body => "AFTER BODY")
    SnippetPagePart.create!(:page_part_id => @part.id, :snippet_id => @snippet_before.id, :before_body => true)
    SnippetPagePart.create!(:page_part_id => @part.id, :snippet_id => @snippet_after.id)
    @page.parts << @part
  end

  it 'should give content for one part wrapped with its snippets' do
    content_of(@page, :part).should == "BEFORE BODY<p>PART BODY</p>AFTER BODY"
  end

  it "should work when body of part is nil or don't have snippets" do
    @part.update_attributes(:body => nil)
    @part.snippets.map(&:delete)
    Proc.new {content_of(@page, :part)}.should_not raise_exception
  end

end
