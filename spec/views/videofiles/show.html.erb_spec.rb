require 'spec_helper'

describe "videofiles/show.html.erb" do
  before(:each) do
    @videofile = assign(:videofile, Factory.stub(:videofile))
  end

  it "renders main design" do
    render
    
    rendered.should have_selector "div.content" do |content|
      content.should have_selector("h2") do |h2|
        h2.inner_html.strip.should == h(@videofile.title.strip)
      end
      
      content.should have_selector("p") do |body|
        body.inner_html.strip.should == @videofile.body.strip
      end
      
      content.should have_selector("img", :src => @videofile.poster.url)
    end
  end
  
  it "shows media player if file is present" do
    @videofile = assign(:videofile, Factory.stub(:videofile_with_file))

    render
        
    rendered.should have_selector("a", :href => @videofile.repacked.url)
  end
  
  it "should not show media player if no file present" do
    render
        
    rendered.should_not have_selector("a", :href => @videofile.repacked.url)
  end
  
end
