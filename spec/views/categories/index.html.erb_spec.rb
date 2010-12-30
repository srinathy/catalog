require 'spec_helper'

describe "categories/index.html.erb" do
  before(:each) do
    assign(:categories, [
      stub_model(Category,
        :title => "Title"
      ),
      stub_model(Category,
        :title => "Title"
      )
    ])
  end

  it "renders a list of categories" do
    render
    rendered.should have_selector("tr>td", :content => "Title".to_s, :count => 2)
  end
end
