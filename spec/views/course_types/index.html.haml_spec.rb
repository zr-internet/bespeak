require 'spec_helper'

describe "course_types/index" do
  before(:each) do
    assign(:course_types, [
      stub_model(CourseType,
        :name => "Name",
        :description => "MyText",
        :cost => ""
      ),
      stub_model(CourseType,
        :name => "Name",
        :description => "MyText",
        :cost => ""
      )
    ])
  end

  it "renders a list of course_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
