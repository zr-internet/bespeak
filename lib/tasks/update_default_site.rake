namespace :sites do
	namespace :update do
		desc "Update all courses not assigned to a site to the passed in site_id (defaults to Site.first.id)"
		task :courses, [:site] => :environment do |t, args|
			puts "Starting Sites::Update::Courses"
			args.with_defaults(:site => Site.first.id)
			
			site = Site.find(args.site)
			courses = Course.where(site_id: nil)
			puts "Updating #{courses.count} courses."
			ActiveRecord::Base.transaction do
				courses.each { |c| c.update_attributes({site_id: site.id}, as: :admin) }
			end
			
			puts "completed"
		end
		
		desc "Update all course_types not assigned to a site to the passed in site_id (defaults to Site.first.id)"
		task :course_types, [:site] => :environment do |t, args|
			puts "Starting Sites::Update::CourseTypes"
			args.with_defaults(:site => Site.first.id)
			
			site = Site.find(args.site)
			course_types = CourseType.where(site_id: nil)
			puts "Updating #{course_types.count} course_types."
			ActiveRecord::Base.transaction do
				course_types.each{|ct| ct.update_attributes({site_id: site.id}, as: :admin) }
			end
			
			puts "completed"
		end
		
		desc "Update all offices not assigned to a site to the passed in site_id (defaults to Site.first.id)"
		task :offices, [:site] => :environment do |t, args|
			puts "Starting Sites::Update::Offices"
			args.with_defaults(:site => Site.first.id)
			
			site = Site.find(args.site)
			offices = Office.where(site_id: nil)
			puts "Updating #{offices.count} offices."
			ActiveRecord::Base.transaction do
				offices.each { |o| o.update_attributes({site_id: site.id}, as: :admin) }
			end
			
			puts "completed"
		end
		
		desc "update all customers not assigned to a site to the site of their first booking"
		task :customers, [:site] => :environment do |t, args|
			puts "Starting Sites::Update::Customers"
			
			customers = Customer.where(site_id: nil)
			puts "Updating #{customers.count} customers."
			ActiveRecord::Base.transaction do
				customers.each do |c| 
					first_booking = c.bookings.first
					if first_booking
						course = first_booking.course
						assigned_site = ccourse.site
						c.update_attributes({site_id: assigned_site.id}, as: :admin)
					else
						puts "Customer #{c.id} no bookings"
					end
				end
			end
			
			puts "completed"
		end
		
		task :all, [:site]  => [:offices, :course_types, :courses, :customers, :environment] do |t, args|
		end
	end
end