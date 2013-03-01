$(function() {
	$('#course-type-filter').on('change', 'input[type="radio"]', function(e) {
		Bespeak.selectedCourse.set_course_type_name($(e.target).data('course-type-name'));
		Bespeak.selectedCourse.set_office_name($(e.target).data('office-name'));
		Bespeak.selectedCourse.set_course_id($($(e.target).data('dates')).val());
	});
	
	$('#courses').on('change', '.course-select > select', function(e) {
		Bespeak.selectedCourse.set_course_id($(e.target).val());
	});
});