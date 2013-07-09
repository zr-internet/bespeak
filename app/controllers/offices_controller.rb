class OfficesController < InheritedResources::Base
	responders :http_cache
	respond_to :json
	
	def index
		site = Site.find_by_token(params[:site_id])
		if site
			@offices = site.offices
		else
			@offices = Office.all
		end
	end
end
