require 'spec_helper'

describe "course_types/new" do
  before(:each) do
    assign(:course_type, stub_model(CourseType,
      :name => "MyString",
      :description => "MyText",
      :cost => ""
    ).as_new_record)
  end

  it "renders new course_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => course_types_path, :method => "post" do
      assert_select "input#course_type_name", :name => "course_type[name]"
      assert_select "textarea#course_type_description", :name => "course_type[description]"
      assert_select "input#course_type_cost", :name => "course_type[cost]"
    end
  end
end
