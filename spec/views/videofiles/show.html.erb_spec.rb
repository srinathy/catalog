require 'spec_helper'

describe "videofiles/show.html.erb" do
  before(:each) do
    @videofile = assign(:videofile, Factory.stub(:videofile))
    
    render
  end

  it "renders attributes in <p>" do
    rendered.should have_selector "div.content" do |content|
      content.should have_selector("h2") do |h2|
        h2.inner_html.should == h(@videofile.title)
      end
      content.should have_selector("p") do |content|
        content.inner_html.should == @videofile.body
      end
      content.should have_selector("img") do |img|
        h2.src.should == @videofile.poster.url
      end
    end
  end
end
