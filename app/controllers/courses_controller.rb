class CoursesController < InheritedResources::Base
	respond_to :json
	
  protected
    def collection
      @courses ||= end_of_association_chain.upcoming.available.order(:start_at)
    end
end
