require 'spec_helper'

describe Page do

  before(:each) do
    @page = Page.create!(:title => 'Page title')
    @part = PagePart.create!(:title => 'Part', :body => "PART BODY")
    @snippet_before = Snippet.create!(:title => 'Before title', :body => "BEFORE BODY")
    @snippet_after = Snippet.create!(:title => 'After title', :body => "AFTER BODY")
    SnippetPagePart.create!(:page_part_id => @part.id, :snippet_id => @snippet_before.id, :before_body => true)
    SnippetPagePart.create!(:page_part_id => @part.id, :snippet_id => @snippet_after.id)
    @page.parts << @part
  end

  it 'should return all snippets attached to its parts' do
    page = Page.create!(:title => 'Other page')
    part = PagePart.create!(:title => 'Other part', :body => "OTHER PART BODY")
    snippet = Snippet.create!(:title => 'Other snippet', :body => "SNIPPET BODY")
    part.snippets << snippet
    @page.snippets.should have(2).snippets
    @page.snippets.each do |s|
      s.title.should_not == snippet.title
    end
    part.snippets.clear
    part.save
    page.snippets.should be_empty
  end

  it "should work when body of part is nil or don't have snippets" do
    @part.update_attributes(:body => nil)
    @part.snippets.map(&:delete)
    Proc.new {@page.content_for(:part)}.should_not raise_exception
  end

end
