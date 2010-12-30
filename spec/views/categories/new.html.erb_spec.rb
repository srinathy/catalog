require 'spec_helper'

describe "categories/new.html.erb" do
  before(:each) do
    assign(:category, stub_model(Category,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new category form" do
    render

    rendered.should have_selector("form", :action => categories_path, :method => "post") do |form|
      form.should have_selector("input#category_title", :name => "category[title]")
    end
  end
end
