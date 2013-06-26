class CoursesController < ApplicationController
	inherit_resources
	respond_to :json
	
	def available
		site = Site.find_by_token(params[:site_id])
		@courses = site.courses.available.order(:start_at)
		respond_with @courses do |format|
			format.json {
				fresh_when(:etag => site.available_key, :last_modified => site.bookings.maximum(:updated_at), :public => true)
				expires_in(1.minute, :public => true)
			}
		end
	end
	
end


