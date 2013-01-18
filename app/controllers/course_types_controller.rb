class CourseTypesController < InheritedResources::Base
	responders :http_cache
	
	respond_to :json
end
