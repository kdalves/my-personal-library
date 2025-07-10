require 'rails_helper'

RSpec.describe "publishers/edit", type: :view do
  let(:publisher) {
    Publisher.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:publisher, publisher)
  end

  it "renders the edit publisher form" do
    render

    assert_select "form[action=?][method=?]", publisher_path(publisher), "post" do
      assert_select "input[name=?]", "publisher[name]"
    end
  end
end
