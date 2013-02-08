$(function() {
	var courseType = $.urlParam('course-type');
	var office = $.urlParam('office');
	
	if(office != '') {
		$('.btn-group[data-filter="office"] > button').not("[data-office_id=" + office + "]").removeClass('active').find('i').hide();
	}
	if(courseType != '') {
		$('.btn-group[data-filter="course-type"] > button').not("[data-course_type_id=" + courseType + "]").removeClass('active').find('i').hide();
	}
	Schedule.draw('#courses > tbody');
});

$(document).on('click', ".btn-group[data-filter] > button", function(e) {
	var button = $(e.target);
	if(e.target.nodeName == "I")
	{
		button = $(e.target).parent('button');
	}
	button.button('toggle');
	button.find('i').toggle();

	Schedule.draw('#courses > tbody');
});
