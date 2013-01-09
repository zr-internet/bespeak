require 'spec_helper'

describe Customer do
	it { should have_many :bookings }
	it { should have_many :payments }
	
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
end
