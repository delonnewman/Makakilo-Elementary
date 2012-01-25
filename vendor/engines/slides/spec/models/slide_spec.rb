require 'spec_helper'

describe Slide do

  def reset_slide(options = {})
    @valid_attributes = {
      :id => 1,
      :text => "RSpec is great for testing too"
    }

    @slide.destroy! if @slide
    @slide = Slide.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_slide
  end

  context "validations" do
    
    it "rejects empty text" do
      Slide.new(@valid_attributes.merge(:text => "")).should_not be_valid
    end

    it "rejects non unique text" do
      # as one gets created before each spec by reset_slide
      Slide.new(@valid_attributes).should_not be_valid
    end
    
  end

end