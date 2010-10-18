require 'spec_helper'

describe "videofiles/edit.html.erb" do
  before(:each) do
    @videofile = assign(:videofile, stub_model(Videofile,
      :new_record? => false,
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit videofile form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => videofile_path(@videofile), :method => "post" do
      assert_select "input#videofile_title", :name => "videofile[title]"
      assert_select "textarea#videofile_body", :name => "videofile[body]"
    end
  end
end
