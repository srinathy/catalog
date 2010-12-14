require 'spec_helper'

describe "videofiles/index.html.erb" do
  before(:each) do
    @videofiles = []
    12.times do
        @videofiles.push Factory.stub(:videofile)
    end
    
    assign(:videofiles, @videofiles.paginate(:page => 1))
  end

  it "renders a list of videofiles" do
    render
    
    rendered.should have_selector "h1" do |h1|
      h1.inner_html.should == "Listing videofiles"
    end
    
    @videofiles.each do |videofile|
      rendered.should have_selector("td.content-block#item-#{videofile.id}") do |f|
        f.should have_selector("img", :src => videofile.poster.url(:mainpage))
        f.should contain(videofile.title)
        f.should_not contain(videofile.body)

        f.should_not have_selector('a', :content => 'Edit')
        f.should_not have_selector('a', :content => 'Destroy')        
      end
    end
    
    rendered.should_not have_selector('a', :content => 'New Videofile')
  end
  
  it "renders additional buttons for admin" do
    sign_in Factory.create(:admin)
    render
    
    @videofiles.each do |videofile|
      rendered.should have_selector("td.content-block#item-#{videofile.id}") do |f|
        f.should contain(videofile.title)

        f.should have_selector('a', :content => 'Edit')
        f.should have_selector('a', :content => 'Destroy')        
      end
    end

    
    rendered.should have_selector('a', :content => 'New Videofile')
  end
end
