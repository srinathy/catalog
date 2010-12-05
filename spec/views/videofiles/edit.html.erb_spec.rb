require 'spec_helper'

describe "videofiles/edit.html.erb" do
  before(:each) do
    @videofile = assign(:videofile, Factory.stub(:videofile))
    render    
  end

  it "renders the edit videofile form" do    
    rendered.should have_selector('input', :id => 'videofile_title', :name => 'videofile[title]')

    rendered.should have_selector('textarea', :id => 'videofile_body', :name => 'videofile[body]')

    rendered.should have_selector('input', :type=> 'file', :id => 'videofile_original', :name => 'videofile[original]')
  end
end
