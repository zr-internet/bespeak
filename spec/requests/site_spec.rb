require 'spec_helper'



describe "Sites" do
	context "site specific paths" do
		context "with an existing site" do
		  let(:site) { FactoryGirl.create(:site) }
		
			describe "GET /sites/:param/courses/available.json" do
				let(:action) { :get }
				let(:path) { "/sites/#{site.to_param}/courses/available.json" }
				before(:each) do
					self.send(action, path)
				end
				subject { response }
				
				it { should be_success }
			end
			
			describe "GET /sites/:param/courses/available.jsonp?callback=foo" do
				let(:action) { :get }
				let(:path) { "/sites/#{site.to_param}/courses/available.jsonp?callback=foo" }
				before(:each) do
					self.send(action, path)
				end
				subject { response }
				
				it { should be_success }
				it { subject.body.should match /foo\(\[.*\]\);/}
			end
		
			describe "GET /sites/:param/form/" do		
				context "with an open course" do
					let!(:course) { FactoryGirl.create(:open_course) }
			
					it "should return a success code" do
						get form_site_path(site)
						response.should be_success
					end
					
					context "with a site that has customized its form" do
					  let!(:site) do
							course.site.tap { |site| site.form = FactoryGirl.build(:customized_form, site: site); }
						end
					
						it "should return a customized form with each value in form options" do
							pending "getting an anonymous class here"
							get form_site_path(site)
							site.form.each do |k,v|
								response.body.should include v
							end
						end
					end
				end
			end
			
			describe "GET /sites/:id/payment/" do		
				context "with an open course" do
					let!(:course) { FactoryGirl.create(:open_course) }
			
					 it "should return a success code" do
						get payment_site_path(site), course_id: course.id
						response.should be_success
					end
				end
			end
		end
	end
	
	context "old paths" do
	  describe "GET /book" do		
			context "with an open course" do
				let!(:course) { FactoryGirl.create(:open_course) }
			
				 it "should return a success code" do
					get book_path
					response.should be_success
				end
			end
		end
		describe "GET /form/" do		
			context "with an open course" do
				let!(:course) { FactoryGirl.create(:open_course) }
			
				 it "should return a success code" do
					get form_path
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
end

