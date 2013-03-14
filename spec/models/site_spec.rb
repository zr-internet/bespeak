require 'spec_helper'

describe Site do
	context 'class methods' do
		subject { Site }
		describe ".generate_token" do
			it { should respond_to :generate_token }
			it "should generate a token with a length of 16" do
				subject.generate_token.length.should == 16
			end

			it "should generate an unused token" do
				pending "Need to figure out how to test this"
			end
			
		end
	end
	
	it { should respond_to :name }
	describe "#display_name" do
		it { should respond_to :display_name }
		it "should return the site's name" do
			subject.name = "Test Site Name"
			subject.display_name.should == subject.name
		end
	end
	
	it { should respond_to :token }
	it "should return the token for param" do
	  subject.token = "token"
		subject.to_param.should == subject.token
	end
	
	it { should have_many :courses }
	it { should have_many :course_types }
	it { should have_many :bookings }
	it { should have_many :payments }
	it { should have_many :customers }
	it { should have_many :offices }
	
	it { should have_one :payment_processor }
	it { should accept_nested_attributes_for :payment_processor }
	
	context "callbacks" do
		describe "before valiation" do
			context "without a token set" do
				it "should set to token to a Site.generate_token result" do
					subject.token = nil
					Site.should_receive(:generate_token).once.and_return('test token')
					subject.valid?
					subject.token.should == 'test token'
				end
			end
			context "with a token" do
				it "should not change the token" do
					subject.token = 'foo'
					expect {
						subject.valid?
					}.to_not change{subject.token}
				end
			end
		end
	end
end