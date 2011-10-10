require 'spec_helper'

describe ApplicationHelper do

  def write_template(snippet = @snippet)
    FileUtils.mkdir_p Snippet::TEMPLATES_DIR
    @file = File.open("#{Snippet::TEMPLATES_DIR}/#{snippet.template_filename}", 'w')
    @file.write("<%= snippet.title %>")
    @file.close
    return @file
  end
  
  before(:each) do
    @page = Page.create!(:title => 'Page title')
    @part = PagePart.create!(:title => 'Part', :body => "PART BODY")
    @snippet_before = Snippet.create!(:title => 'Before title', :body => "BEFORE BODY")
    @snippet_after = Snippet.create!(:title => 'After title', :body => "AFTER BODY")
    SnippetPagePart.create!(:page_part_id => @part.id, :snippet_id => @snippet_before.id, :before_body => true)
    SnippetPagePart.create!(:page_part_id => @part.id, :snippet_id => @snippet_after.id)
    @page.parts << @part
  end

  after(:each) do
    File.delete(@file.path) if @file
  end
  
  it 'should give content for one part wrapped with its snippets' do
    content_of(@page, :part).should == "BEFORE BODY<p>PART BODY</p>AFTER BODY"
  end

  it 'should render snippets templates if present' do
    write_template(@snippet_before)
    should_receive(:render).with({:file => @snippet_before.template_path}).and_return('TEMPLATE')
    content_of(@page, :part).should == "TEMPLATE<p>PART BODY</p>AFTER BODY"
  end

  it "should work when body of part is nil or don't have snippets" do
    @part.update_attributes(:body => nil)
    @part.snippets.map(&:delete)
    Proc.new {content_of(@page, :part)}.should_not raise_exception
  end

end
