require 'spec_helper'

describe "videofiles/index.html.erb" do
  before(:each) do
    @videofiles = []
    12.times do
        @videofiles.push Factory.stub(:videofile)
    end
    
    assign(:videofiles, @videofiles.paginate(:page => 1))
    render
  end

  it "renders a list of videofiles" do
    rendered.should have_selector "h1" do |h1|
      h1.inner_html.should == "Listing videofiles"
    end
    
    @videofiles.each do |videofile|
      rendered.should have_selector("img", :src => videofile.poster.url(:mainpage))
      rendered.should contain(videofile.title)
      rendered.should_not contain(videofile.body)
    end
  end
end
