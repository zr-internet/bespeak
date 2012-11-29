require 'spec_helper'

describe "payments/edit" do
  before(:each) do
    @payment = assign(:payment, stub_model(Payment,
      :amount_cents => 1,
      :type => "",
      :token => "MyString",
      :booking => nil
    ))
  end

  it "renders the edit payment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => payments_path(@payment), :method => "post" do
      assert_select "input#payment_amount_cents", :name => "payment[amount_cents]"
      assert_select "input#payment_type", :name => "payment[type]"
      assert_select "input#payment_token", :name => "payment[token]"
      assert_select "input#payment_booking", :name => "payment[booking]"
    end
  end
end
