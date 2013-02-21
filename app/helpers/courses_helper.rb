module CoursesHelper
	
	def select_by_course_type_and_office(courses, course_type, office)
		filtered_courses = courses.where(course_type_id: course_type.id, office_id: office.id).decorate
		html_options = {
			data: {course_type_id: course_type.id, course_type_name: course_type.name, office_id: office.id, office_name: office.name}, 
			class: ['course-select','hidden']
		} 
		content_tag(:label, html_options) do
				select_tag(['courses',course_type.name, office.name].join('_').parameterize, options_from_collection_for_select(filtered_courses, 'id', 'start_date_time'), {class: ['input-xlarge']})
		end
	end
end
