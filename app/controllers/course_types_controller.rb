class CourseTypesController < InheritedResources::Base
	responders :http_cache
	
	respond_to :json
	
	def index
		site = Site.find_by_token(params[:site_id])
		if site
			@course_types = site.course_types
		else
			@course_types = CourseType.all
		end
	end
end
