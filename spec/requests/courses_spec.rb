require 'spec_helper'



describe "Courses" do
  describe "GET /book" do		
		context "with an open course" do
			let!(:course) { FactoryGirl.create(:open_course) }
			
			 it "should return a success code" do
				get book_path
				response.should be_success
			end
		end
	end
	describe "GET /book/payment" do		
		context "with an open course" do
			let!(:course) { FactoryGirl.create(:open_course) }
			
			 it "should return a success code" do
				get payment_book_path, id: course.id
				response.should be_success
			end
		end
		context "with a closed course" do
			let!(:course) { FactoryGirl.create(:course, max_occupancy: 0) }
			
			 it "should return a 403 code" do
				get payment_book_path, id: course.id
				response.status.should == 403
			end
		end
		context "without a course" do
			 it "should return a 422 code" do
				get payment_book_path
				response.status.should == 422
			end
		end
	end
end

		