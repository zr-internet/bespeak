require 'spec_helper'

describe "courses/new" do
  before(:each) do
    assign(:course, stub_model(Course,
      :office_id => 1,
      :course_type_id => 1,
      :max_occupancy => 1
    ).as_new_record)
  end

  it "renders new course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => courses_path, :method => "post" do
      assert_select "input#course_office_id", :name => "course[office_id]"
      assert_select "input#course_course_type_id", :name => "course[course_type_id]"
      assert_select "input#course_max_occupancy", :name => "course[max_occupancy]"
    end
  end
end
