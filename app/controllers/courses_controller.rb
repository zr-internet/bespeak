class CoursesController < ApplicationController
	inherit_resources
	respond_to :json
	respond_to :html, only: [:book, :formstack, :payment]
	
	CourseFilters = Struct.new(:course_type, :office)
	
	def available
		@courses = Course.available.order(:start_at)
		respond_with @courses do |format|
			format.json {
				fresh_when(:etag => Course.available_key, :last_modified => Booking.maximum(:updated_at), :public => true)
				expires_in(1.minute, :public => true)
			}
		end
	end
	
	def formstack
		@courses = Course.available.order(:start_at)
		@offices = Office.all
		@course_types = CourseType.all
		@course_filters = @courses.map{ |c| CourseFilters.new(c.course_type, c.office) }.uniq.sort { |a,b| a.course_type.name + a.office.name <=> b.course_type.name + b.course_type.name }
		respond_with @courses
	end
	
	def book
		@courses = Course.available.order(:start_at).decorate
		@offices = Office.all
		@course_types = CourseType.all
		respond_with @courses
	end
	
	def payment
		@course = if params.has_key? :id
				Course.find(params[:id])
			else 
				nil
			end
		@course = @course.decorate if @course.present?
		respond_with @course do |format|
			if @course.nil?
				format.html { render :text => "No course selected, please go back and select a course to book", :status => :unprocessable_entity }
			elsif @course.closed?
				format.html { render :text => "This course is no longer available, please select a new course.", :status => :forbidden }
			end
		end
	end
end


