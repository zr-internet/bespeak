require 'spec_helper'

describe "course_types/show" do
  before(:each) do
    @course_type = assign(:course_type, stub_model(CourseType,
      :name => "Name",
      :description => "MyText",
      :cost => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(//)
  end
end
