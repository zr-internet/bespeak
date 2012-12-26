require 'spec_helper'

describe ActiveSupport::TimeZone do
	describe "::from_string" do
		subject { ActiveSupport::TimeZone }
		it { should respond_to(:from_string).with(1).argument }
		
		[ActiveSupport::TimeZone[0], ActiveSupport::TimeZone[12], ActiveSupport::TimeZone[-5]].each do |zone|
			context "for timezone #{zone} (timezone.to_s)" do 
				context "with #{zone.to_s}" do
				  let(:time_zone) { zone }
					let(:string) { time_zone.to_s }
		
					it "should return a timezone equivalent to time_zone" do
					  ActiveSupport::TimeZone.from_string(string).should == time_zone
					end
				end
				
				context "with #{zone.name} (timezone.name)" do
				  let(:time_zone) { zone }
					let(:string) { time_zone.name }
		
					it "should return a timezone equivalent to time_zone" do
					  ActiveSupport::TimeZone.from_string(string).should == time_zone
					end
				end
			end
		end
		
	end
end