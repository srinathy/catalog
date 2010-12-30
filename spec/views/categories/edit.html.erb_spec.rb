require 'spec_helper'

describe "categories/edit.html.erb" do
  before(:each) do
    @category = assign(:category, stub_model(Category,
      :title => "MyString"
    ))
  end

  it "renders the edit category form" do
    render

    rendered.should have_selector("form", :action => category_path(@category), :method => "post") do |form|
      form.should have_selector("input#category_title", :name => "category[title]")
    end
  end
end
