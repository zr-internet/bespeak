require 'spec_helper'

# params = {	
# 	"email"=>"yosem@crowdvert.com", 
# 	"attendees"=>"1", 
# 	"course_id"=>"53", 
# 	"payment_method"=>"credit_card", 
# 	"name"=>"Yosem Sweet", 
# 	"payment_details"=>"[FILTERED]"
# }

describe "Bookings", :vcr do
  describe "POST /bookings.json" do
		let(:email)	{ "test@test.com" }
		let(:name)	{ "Test User" }
		let(:site) { FactoryGirl.create(:site, :authorize_net)}
		
		context "with an open course" do
			let!(:course) { FactoryGirl.create(:open_course, site: site) }
			
			context "with text/plain post" do
			  let(:params) {
					URI.encode_www_form({
						"email"=>email, 
						"attendees"=>"1", 
						"course_id"=>"#{course.id}", 
						"payment_method"=>"cash", 
						"name"=>name, 
						"payment_details"=> { }
					})
				}
			
				it "should return a success code" do
					post bookings_path(:format => :json), params
					response.should be_success
				end
			end
			context "with valid params" do
				context "with cash payment" do
				  let(:params) {
						{
							"email"=>email, 
							"attendees"=>"1", 
							"course_id"=>"#{course.id}", 
							"payment_method"=>"cash", 
							"name"=>name, 
							"payment_details"=> { }
						}
					}
				
					it "should return a success code" do
						post bookings_path(:format => :json), params
						response.should be_success
					end
					
					context "data returned on successful booking" do
						it "should include confirmation_page" do
							post bookings_path(:format => :json), params
							JSON.parse(response.body).should have_key "confirmation_url"
						end
					  
					end
					
					
					it "should create a booking for the course" do
					  expect {
							post bookings_path(:format => :json), params
						}.to change {course.bookings.count }.by(1)
					end
				
					it "should leave the customer owing the course value" do
						post bookings_path(:format => :json), params
						
						customer = course.site.customers.where(email: email).first_or_create({}, as: :admin)
						customer.owed.should == course.cost
					end
				end
				context "with credit card payment" do
					
				  let(:params) {
						{
							"email"=>email, 
							"attendees"=>"1", 
							"course_id"=>"#{course.id}", 
							"payment_method"=>"credit_card", 
							"name"=>name, 
							"payment_details"=> { 
								"credit_card_number" => "4111111111111",
								"credit_card_expiration_month" => Time.now.month,
								"credit_card_expiration_year" => Time.now.year + 1,
								"credit_card_ccv" => "123"
							}
						}
					}
					
					context "with valid credit card details" do
						it "should return a success code" do
							pending "I think I blew up Auth.net - not sure why vcr isn't working"
							post bookings_path(:format => :json), params
							response.should be_success
						end

						it "should create a booking for the course" do
							pending "I think I blew up Auth.net - not sure why vcr isn't working"
						  expect {
								post bookings_path(:format => :json), params
							}.to change {course.bookings.count }.by(1)
						end
					end

					context "with invalid credit card details" do
						before(:each) do
						  params["payment_details"]["credit_card_expiration_month"] = "13"
						end

						context "invalid experation date" do
							it "should return a 422 code" do
								pending "I think I blew up Auth.net - not sure why vcr isn't working"
								post bookings_path(:format => :json), params
								response.status.should == 422
							end

							it "should return an error for payments" do
								pending "I think I blew up Auth.net - not sure why vcr isn't working"
								post bookings_path(:format => :json), params
								JSON.parse(response.body).should have_key "errors"
								JSON.parse(response.body)["errors"].should have_key "payments"
								JSON.parse(response.body)["errors"]["payments"].size.should  > 0
							end  
						end
					end
				end
				context "with coupons" do
					context "cash payment" do
					  let(:params) {
							{
								"email"=>email, 
								"attendees"=>"1", 
								"course_id"=>"#{course.id}", 
								"payment_method"=>"cash", 
								"name"=>name, 
								"payment_details"=> { },
								"coupon" => "a valid free course coupon code"
							}
						}

						it "should return a success code" do
							post bookings_path(:format => :json), params
							response.should be_success
						end
						
						context "data returned on successful booking" do
							it "should include confirmation_page" do
								post bookings_path(:format => :json), params
								JSON.parse(response.body).should have_key "confirmation_url"
							end
						  
						end
						
						it "should create a booking for the course" do
						  expect {
								post bookings_path(:format => :json), params
							}.to change {course.bookings.count }.by(1)
						end

						it "should create a booking for the customer" do
							customer = course.site.customers.where(email: email).first_or_create({}, as: :admin)
						  expect {
								post bookings_path(:format => :json), params
							}.to change {customer.bookings.count }.by(1)
						end

						it "should create a coupon payment for the customer" do
							customer = course.site.customers.where(email: email).first_or_create({}, as: :admin)

						  expect {
								post bookings_path(:format => :json), params
							}.to change { customer.reload.payments.coupons.count }.by(1)
						end
					end
					context "credit card payment" do
					  let(:params) {
							{
								"email"=>email, 
								"attendees"=>"1", 
								"course_id"=>"#{course.id}", 
								"payment_method"=>"credit_card", 
								"name"=>name, 
								"payment_details"=> { },
								"coupon" => "a valid free course coupon code"
							}
						}

						it "should return a success code" do
							post bookings_path(:format => :json), params
							response.should be_success
						end

						context "data returned on successful booking" do
							it "should include confirmation_page" do
								post bookings_path(:format => :json), params
								JSON.parse(response.body).should have_key "confirmation_url"
							end
						  
						end


						it "should create a booking for the course" do
						  expect {
								post bookings_path(:format => :json), params
							}.to change {course.bookings.count }.by(1)
						end

						it "should create a booking for the customer" do
							customer = course.site.customers.where(email: email).first_or_create({}, as: :admin)
						  expect {
								post bookings_path(:format => :json), params
							}.to change {customer.bookings.count }.by(1)
						end

						it "should create a coupon payment for the customer" do
							customer = course.site.customers.where(email: email).first_or_create({}, as: :admin)

						  expect {
								post bookings_path(:format => :json), params
							}.to change { customer.reload.payments.coupons.count }.by(1)
						end
					end
				end
			end
		end
	end
end