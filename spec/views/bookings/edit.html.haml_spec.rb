require 'spec_helper'

describe "bookings/edit" do
  before(:each) do
    @booking = assign(:booking, stub_model(Booking,
      :course => "",
      :customer => "",
      :attendees => 1
    ))
  end

  it "renders the edit booking form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bookings_path(@booking), :method => "post" do
      assert_select "input#booking_course", :name => "booking[course]"
      assert_select "input#booking_customer", :name => "booking[customer]"
      assert_select "input#booking_attendees", :name => "booking[attendees]"
    end
  end
end
