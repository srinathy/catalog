require 'spec_helper'

describe "videofiles/new.html.erb" do
  before(:each) do
    assign(:videofile, stub_model(Videofile,
      :title => "MyString",
      :body => "MyText"
    ).as_new_record)
  end

  it "renders new videofile form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => videofiles_path, :method => "post" do
      assert_select "input#videofile_title", :name => "videofile[title]"
      assert_select "textarea#videofile_body", :name => "videofile[body]"
    end
  end
end
