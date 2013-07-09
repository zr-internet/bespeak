object false

node :courses do
	@available_data.courses.map { |c| partial("courses/_course", object: c) }
end
node :offices do
	@available_data.offices.map { |o| partial("offices/_office", object: o) }
end
node :course_types do
	@available_data.course_types.map { |ct| partial("course_types/_course_type", object: ct) }
end
