require 'rails_helper'

RSpec.describe "libraries/edit", type: :view do
  let(:library) {
    Library.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:library, library)
  end

  it "renders the edit library form" do
    render

    assert_select "form[action=?][method=?]", library_path(library), "post" do

      assert_select "input[name=?]", "library[name]"
    end
  end
end
