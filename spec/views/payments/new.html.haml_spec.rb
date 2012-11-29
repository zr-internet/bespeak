require 'spec_helper'

describe "payments/new" do
  before(:each) do
    assign(:payment, stub_model(Payment,
      :amount_cents => 1,
      :type => "",
      :token => "MyString",
      :booking => nil
    ).as_new_record)
  end

  it "renders new payment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => payments_path, :method => "post" do
      assert_select "input#payment_amount_cents", :name => "payment[amount_cents]"
      assert_select "input#payment_type", :name => "payment[type]"
      assert_select "input#payment_token", :name => "payment[token]"
      assert_select "input#payment_booking", :name => "payment[booking]"
    end
  end
end
