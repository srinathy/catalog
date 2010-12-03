require 'spec_helper'

describe "videofiles/edit.html.erb" do
  before(:each) do
    @videofile = assign(:videofile, Factory.stub(:videofile))
    render    
  end

  it "renders the edit videofile form" do
    pending "Write tests for edit form"
    # assert_select "form", :action => videofile_path(@videofile), :method => "post" do
    #   assert_select "input#videofile_title", :name => "videofile[title]"
    #   assert_select "textarea#videofile_body", :name => "videofile[body]"
    # end
  end
end
