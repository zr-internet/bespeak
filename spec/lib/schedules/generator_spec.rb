require 'spec_helper'

# generator = Schedules::Generator.new(timezone: tz)
# newCourseTimes = generator.times(pattern: "Every Tuesday at 6:30 pm", start: Time.zone.now, end: Time.zone.now + 1.month, maxcount: 10)

describe Schedules::Generator do
	describe "#new" do
	  context "with default arguments" do
	    subject { Schedules::Generator.new }
	
			it "should set timezone to the server timezone" do
			  subject.timezone.should == Time.zone
			end
	  end
	  context "with a timezone argument" do
			let(:zone) { ActiveSupport::TimeZone[-5] }
	    subject { Schedules::Generator.new(timezone: zone) }
	
			it "should set timezone to the passed in timezone" do
			  subject.timezone.should == zone
			end
	  end
	end
	
	describe "#times" do
		let(:generator) { Schedules::Generator.new() }
		subject { generator.times(pattern: "Now") }
		
		it "should exist" do
			Schedules::Generator.new.should respond_to :times
		end
		it { should be_kind_of Array }
		
		context "with a pattern" do
		  context "Every [Weekday] at [Time]" do
		    let(:pattern) { "Every Tuesday at 6:15 pm"}
				subject { generator.times(pattern: pattern)}
				
				it "Should return the first day matching the pattern after Generator.timezone.now" do
					Chronic.time_class = generator.timezone
					nextTime = Chronic.parse(pattern)
					subject.should include nextTime
				end
				
				context "with a count N" do
			    let(:count) { 2 }
					subject { generator.times(pattern: pattern, count: count)}
				  
					it "should return 'count' times" do
					  subject.size.should == count
					end
					
					it "Should return the first day matching the pattern after Generator.timezone.now" do
						Chronic.time_class = generator.timezone
						nextTime = Chronic.parse(pattern)
						subject.should include nextTime
					end
					
					it "Should return the N-th day matching the pattern after Generator.timezone.now" do
						Chronic.time_class = generator.timezone
						nextTime = Chronic.parse(pattern)+(count - 1).weeks
						subject.should include nextTime
					end
				end
				
				context "with a start time" do
			    let(:start) { Time.zone.parse("January 1st, 2012") }
					subject { generator.times(pattern: pattern, start: start)}
					
					it "Should return the first day matching the pattern after start" do
						Chronic.time_class = generator.timezone
						nextTime = Chronic.parse("January 3rd, 2012 at 6:15 pm")
						subject.should include nextTime
					end
				end
		  end
		end
	end
end