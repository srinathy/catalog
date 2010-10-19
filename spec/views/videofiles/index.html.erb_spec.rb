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
    render
  end

  it "renders a list of videofiles" do
    rendered.should have_selector "h1" do |h1|
      h1.inner_html.should == "Listing videofiles"
    end
    
    pending "write test after design changes"
  end
end
