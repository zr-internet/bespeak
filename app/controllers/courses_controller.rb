class CoursesController < ApplicationController
	inherit_resources
	respond_to :json
	
	def available
		@courses = Course.available.order(:start_at)
		respond_with @courses do |format|
			format.json {
				fresh_when(:etag => Course.available_key, :last_modified => Booking.maximum(:updated_at), :public => true)
				expires_in(1.minute, :public => true)
			}
		end
	end	
end


