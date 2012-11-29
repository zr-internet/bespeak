require 'spec_helper'

describe "payments/index" do
  before(:each) do
    assign(:payments, [
      stub_model(Payment,
        :amount_cents => 1,
        :type => "Type",
        :token => "Token",
        :booking => nil
      ),
      stub_model(Payment,
        :amount_cents => 1,
        :type => "Type",
        :token => "Token",
        :booking => nil
      )
    ])
  end

  it "renders a list of payments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
