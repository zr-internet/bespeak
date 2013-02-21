$(function() {
	$(document).on('change', '#course-type-filter input[type="radio"]', function(e) {
		Bespeak.selectedCourse.set_course_type_name($(e.target).data('course-type-name'));
		Bespeak.selectedCourse.set_office_name($(e.target).data('office-name'));
	});
});