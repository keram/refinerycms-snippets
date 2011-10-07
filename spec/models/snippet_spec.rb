require 'spec_helper'

describe Snippet do

  def reset_snippet(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @snippet.destroy! if @snippet
    @snippet = Snippet.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_snippet
  end

  context "validations" do

    it "rejects empty title" do
      Snippet.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end

    it "rejects non unique title" do
      # as one gets created before each spec by reset_snippet
      Snippet.new(@valid_attributes).should_not be_valid
    end

  end

  it 'should return the page it is attached' do
    @snippet.pages.should be_empty
    page = Page.create!(:title => 'Page')
    2.times do
      part = PagePart.create!(:title => 'Other part', :body => "OTHER PART BODY", :page_id => Page.create!(:title => 'Other Page').id)
      part.snippets << @snippet
    end
    @snippet.pages.should have(2).pages
    @snippet.pages.each do |p|
      p.title.should_not == page.title
    end
  end

end
