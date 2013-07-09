AvailableCourseData = Struct.new(:courses, :offices, :course_types)

class CoursesController < ApplicationController
	inherit_resources
	respond_to :json
	
	def available
		site = Site.find_by_token(params[:site_id])
		@courses = site.courses.available.order(:start_at)
		course_types = site.course_types.order(:name)
		offices = site.offices.order(:name)
		@available_data = AvailableCourseData.new(@courses, offices, course_types)
		
		respond_with @available_data do |format|
			format.json {
				fresh_when(:etag => site.available_key, :last_modified => site.bookings.maximum(:updated_at), :public => true)
				expires_in(1.minute, :public => true)
			}
		end
	end
	
end


