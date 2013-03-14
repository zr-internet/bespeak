require 'spec_helper'

describe SitesController do
	let(:site) { FactoryGirl.build_stubbed(:site) }
	
	context "for an existing site" do
		before(:each) do
			Site.stub(:find_by_token).with(site.token).and_return(site)
		end
		
		context "site specific actions" do
			describe "GET /:site.to_param/form" do
				it "renders the form template" do
					get :formstack, id: site.to_param
					response.should render_template("form")
				end
		
				it "assigns site.courses.available as @courses" do
					available_courses = double("Site.courses.available")
					available_courses.stub(:order) { available_courses }
					available_courses.stub(:map) { Array.new }
			
					site.courses.should_receive(:available).and_return(available_courses)
					get :formstack, id: site.to_param
					assigns(:courses).should eq(available_courses)
				end

				it "assigns site.course_types.all as @course_types" do
					course_types = []
					site.course_types.should_receive(:all).once.and_return(course_types)
					get :formstack, id: site.to_param
					assigns(:course_types).should eq(course_types)
				end

				it "assigns site.offices.all as @offices" do
					offices = []
					site.offices.should_receive(:all).once.and_return(offices)
					get :formstack, id: site.to_param
					assigns(:offices).should eq(offices)
				end	
			end
		end
		
		context "old methods" do
			describe "GET /book" do
				it "renders the book template" do
					get :old_book
					response.should render_template("book")
				end
		
				it "assigns Course.available as @courses" do
					available_courses = double("Course.available")
					available_courses.stub(:order) { available_courses }
					available_courses.stub(:decorate) { available_courses }
			
					Course.should_receive(:available).and_return(available_courses)
					get :old_book
					assigns(:courses).should eq(available_courses)
				end

				it "assigns CourseType.all as @course_types" do
					course_types = []
					CourseType.should_receive(:all).once.and_return(course_types)
					get :old_book
					assigns(:course_types).should eq(course_types)
				end

				it "assigns Office.all as @offices" do
					offices = []
					Office.should_receive(:all).once.and_return(offices)
					get :old_book
					assigns(:offices).should eq(offices)
				end
			end

			describe "GET payment" do
				context "without an id param" do
					it "returns a 422 status" do
						get :old_payment
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
							get :old_payment, id: course.id
							response.should render_template("payment")
						end
			
						it "assigns the course with the passed in course id as @course" do
							get :old_payment, id: course.id
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
							get :old_payment, id: course.id
							response.status.should == 403
						end
					end
				end
			end
		end
	end
end
