require 'spec_helper'

describe "videofiles/index.html.erb" do
  before(:each) do
    assign(:videofiles, [
      Factory.stub(:videofile),
      Factory.stub(:videofile),
      Factory.stub(:videofile),
      Factory.stub(:videofile),
      Factory.stub(:videofile)
    ].paginate(:page => 1))
  end

  it "renders a list of videofiles" do
    render
    
    pending "it should check listing"
  end
end
