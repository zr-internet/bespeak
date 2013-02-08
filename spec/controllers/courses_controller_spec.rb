require 'spec_helper'

describe CoursesController do

  describe "GET available.json" do
    it "assigns Course.available as @courses" do
			available_courses = double("Course.available")
			available_courses.stub(:order) { available_courses }
			
			Course.should_receive(:available).and_return(available_courses)
      get :available, format: "json"
      assigns(:courses).should eq(available_courses)
    end
  end

	describe "GET book" do
		it "renders the book template" do
			get :book
			response.should render_template("book")
		end
		
    it "assigns Course.available as @courses" do
			available_courses = double("Course.available")
			available_courses.stub(:order) { available_courses }
			available_courses.stub(:decorate) { available_courses }
			
			Course.should_receive(:available).and_return(available_courses)
      get :book
      assigns(:courses).should eq(available_courses)
    end

    it "assigns CourseType.all as @course_types" do
			course_types = []
			CourseType.should_receive(:all).once.and_return(course_types)
      get :book
      assigns(:course_types).should eq(course_types)
    end

    it "assigns Office.all as @offices" do
			offices = []
			Office.should_receive(:all).once.and_return(offices)
      get :book
      assigns(:offices).should eq(offices)
    end
	end

	describe "GET payment" do
		context "without an id param" do
		  it "returns a 422 status" do
		    get :payment
				response.status.should == 422
		  end
		end
		
		context "with an id param" do
			context "where id refers to an open course" do
			  
				let(:course) do 
					FactoryGirl.build_stubbed(:open_course).tap do |c|
						Course.stub(:find).with(c.id.to_s).and_return(c)
					end
				end
			
				it "renders the payment template" do
					get :payment, id: course.id
					response.should render_template("payment")
				end
			
				it "assigns the course with the passed in course id as @course" do
					get :payment, id: course.id
					assigns(:course).should eq(course)
				end
			
			end
			context "where id refers to a closed course" do
			  
				let(:course) do 
					FactoryGirl.build_stubbed(:course, max_occupancy: 0).tap do |c|
						Course.stub(:find).with(c.id.to_s).and_return(c)
					end
				end
			
				it "returns a 403" do
					get :payment, id: course.id
					response.status.should == 403
				end
			
			end
		end
	end

end
