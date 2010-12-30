require 'spec_helper'

describe "categories/show.html.erb" do
  before(:each) do
    @category = assign(:category, stub_model(Category,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Title".to_s)
  end
end
