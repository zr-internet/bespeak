require 'spec_helper'

describe Office do
	it { should respond_to :name }
	it { should respond_to :address }
	it { should respond_to :time_zone }
	describe "#directions" do
		it { should respond_to :directions }
	  context "with nil directions" do
			before(:each) do
	    	subject.assign_attributes({directions: nil}, without_protection: true)
			end
			
			it "should return an empty string" do
				subject.directions.should == ""
			end
	  end
	 context "with html directions" do
			let(:directions) { "<p>Go left, then right</p>".html_safe }
			before(:each) do
	    	subject.assign_attributes({directions: directions}, without_protection: true)
			end

			it "should return the html directions" do
				subject.directions.should == directions
			end
	  end
		context "with text directions" do
			let(:directions) { "Go left, then right" }
			before(:each) do
	    	subject.assign_attributes({directions: directions}, without_protection: true)
			end
			
			it "should return the text directions" do
				subject.directions.should == directions
			end
		end
	end

end
