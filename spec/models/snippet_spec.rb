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

  def write_template(snippet = @snippet)
    FileUtils.mkdir_p Snippet::TEMPLATES_DIR
    @file = File.open("#{Snippet::TEMPLATES_DIR}/#{snippet.template_filename}", 'w')
    @file.write("<%= snippet.title %>")
    @file.close
    return @file
  end

  before(:each) do
    reset_snippet
  end

  after(:each) do
    File.delete(@file.path) if @file
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

  it 'should verify if template for it exists' do
    @snippet.template?.should be_false
    write_template
    @snippet.template?.should be_true
  end

  it 'should sanitize its title for a filename' do
    @snippet.template_filename.should == '_rspec_is_great_for_testing_too.html.erb'
    @snippet.title = '/dir & folder/FooÑBar'
    @snippet.template_filename.should == '_dir_folder_foo_bar.html.erb'
  end

end
