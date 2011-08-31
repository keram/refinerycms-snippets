# -*- coding: utf-8 -*-
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

  it 'should return the page it is attached to' do
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

  it 'should sanitize its title for a filename' do
    @snippet.template_filename.should == '_rspec_is_great_for_testing_too.html.erb'
    @snippet.title = '/dir & folder/FooÑBar'
    @snippet.template_filename.should == '_dir_folder_foo_bar.html.erb'
  end

  it 'should return its default template' do
    mock_action_view = mock('mock_action_view')
    ActionView::Base.stub!(:new).and_return(mock_action_view)
    mock_action_view.should_receive(:render).with({:file =>'shared/snippets/_rspec_is_great_for_testing_too.html.erb', :locals => {:snippet => @snippet}}).and_return('HTML')
    @snippet.content.should == 'HTML'
  end

  it 'should return its body if template not available' do
    mock_action_view = mock('mock_action_view')
    ActionView::Base.stub!(:new).and_return(mock_action_view)
    mock_action_view.should_receive(:render).with({:file =>'shared/snippets/_rspec_is_great_for_testing_too.html.erb', :locals => {:snippet => @snippet}}).and_raise(ActionView::MissingTemplate.new([],nil,nil,nil))
    @snippet.body = 'BODY'
    @snippet.content.should == 'BODY'
  end

end
