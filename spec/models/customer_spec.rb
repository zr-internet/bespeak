require 'spec_helper'

describe Customer do
	it { should have_many :bookings }
	it { should have_many :payments }
	it { should belong_to :site }
	
	context "#owed" do
	  it { should respond_to :owed }
		context "with bookings" do
		  let(:bookings) { FactoryGirl.build_list(:booking, 2, :customer => subject) }
			
			before(:each) { subject.stub(:bookings => bookings) }
			
			it "should equal the total bookings course_cost" do
			  subject.owed.should == bookings.reduce( Money.new(0) ) { |total, booking| total += booking.course_cost }
			end
			
			context "with payments for the first booking" do
			  let(:payment) { FactoryGirl.build_stubbed(:payment, :booking => bookings.first, :amount => bookings.first.course_cost) }
				before(:each) do
					bookings.first.stub(:payments => [payment])
				end
				
				it "should equal the course_cost of the last booking" do
				  subject.owed.should == bookings.last.course_cost
				end
			end
		end
	end
	
	context "#to_s" do
		context "with an email" do
		  subject { FactoryGirl.build(:customer) }
			it "should == customer.email" do
				subject.to_s.should == subject.email
			end
		end
		context "without an email" do
		  subject { FactoryGirl.build(:customer, email: nil) }
			context "with an id" do
				before(:each) do
					subject.stub(id: 1337)
				end
				
				it "should == 'customer_\#{id}" do
					subject.to_s.should == "customer_#{subject.id}"
				end			  
			end
			context "without an id" do
				before(:each) do
					subject.stub(id: nil)
				end
				
				it "should == inspect" do
					subject.to_s.should == subject.inspect
				end			  
			end
		end
	end
	
	describe "#to_label" do
		let(:customer) { FactoryGirl.build_stubbed(:customer) }
		it { should respond_to :to_label }
		it "should return customer.to_s" do
			customer.to_label.should == customer.to_s
		end
	end
end
