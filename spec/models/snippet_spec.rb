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

end