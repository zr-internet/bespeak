class OfficesController < InheritedResources::Base
	responders :http_cache
	respond_to :json
end
