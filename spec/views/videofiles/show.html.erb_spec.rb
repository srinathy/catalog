require 'spec_helper'

describe "videofiles/show.html.erb" do
  before(:each) do
    @videofile = assign(:videofile, Factory.stub(:videofile))
    
    render
  end

  it "renders attributes in <p>" do
    rendered.should have_selector "div.content" do |content|
      content.should have_selector("h2") do |h2|
        h2.inner_html.strip.should == h(@videofile.title.strip)
      end
      
      content.should have_selector("p") do |body|
        body.inner_html.strip.should == @videofile.body.strip
      end
      
      content.should have_selector("img", :src => @videofile.poster.url)
      
      #content.should have_selector("a", :href => @videofile.processed.url)
    end
  end
end
