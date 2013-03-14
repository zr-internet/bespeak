class SitesController < ApplicationController
	inherit_resources
	respond_to :html, only: [:book, :formstack, :payment]
	
	
	CourseFilters = Struct.new(:course_type, :office)
	def formstack
		@site = Site.find_by_token(params[:id])
		@courses = @site.courses.available.order(:start_at)
		@offices = @site.offices.all
		@course_types = @site.course_types.all
		@course_filters = @courses.map{ |c| CourseFilters.new(c.course_type, c.office) }.uniq.sort { |a,b| a.course_type.name + a.office.name <=> b.course_type.name + b.course_type.name }
		respond_with @courses
	end
	
	def payment
		@site = Site.find_by_token(params[:id])
		@course = if params.has_key? :course_id
				Course.find(params[:course_id])
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
	
	def old_formstack
		@courses = Course.available.order(:start_at)
		@offices = Office.all
		@course_types = CourseType.all
		@course_filters = @courses.map{ |c| CourseFilters.new(c.course_type, c.office) }.uniq.sort { |a,b| a.course_type.name + a.office.name <=> b.course_type.name + b.course_type.name }
		respond_with @courses do |format|
			format.html { render 'formstack' }
		end
	end
	
	def old_book
		@courses = Course.available.order(:start_at).decorate
		@offices = Office.all
		@course_types = CourseType.all
		respond_with @courses do |format|
			format.html { render 'book' }
		end
	end
	
	def old_payment
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
			else
				format.html { render 'payment' }
			end
		end
	end
end