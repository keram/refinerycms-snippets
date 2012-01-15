require 'spec_helper'

describe ApplicationHelper do

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

  it "should return template if snippet template exists" do
    should_receive(:render).with("shared/before_title").and_return('TEMPLATE')
    render_snippet(@snippet_before).should == 'TEMPLATE'
  end

  it "should return body if snippet template doesn't exist" do
    should_receive(:render).with("shared/before_title").and_raise(ActionView::MissingTemplate)
    render_snippet(@snippet_before).should == 'BEFORE BODY'
  end

  it "should return nil if snippet body and template don't exist" do
    @before_snippet.update_attribute(:body, nil)
    should_receive(:render).with("shared/before_title").and_raise(ActionView::MissingTemplate)
    render_snippet(@snippet_before).should be_nil
  end

  it 'should return title' do
    title(@part.title).should == :part
  end

end
