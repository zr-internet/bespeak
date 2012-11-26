require 'spec_helper'

describe "bookings/new" do
  before(:each) do
    assign(:booking, stub_model(Booking,
      :course => "",
      :customer => "",
      :attendees => 1
    ).as_new_record)
  end

  it "renders new booking form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bookings_path, :method => "post" do
      assert_select "input#booking_course", :name => "booking[course]"
      assert_select "input#booking_customer", :name => "booking[customer]"
      assert_select "input#booking_attendees", :name => "booking[attendees]"
    end
  end
end
