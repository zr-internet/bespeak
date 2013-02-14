$(function() { 
	Schedule.Filters.active.push(Schedule.Filters.byOffices);
	Schedule.Filters.active.push(Schedule.Filters.byCourseTypes);
		
	$(document).on('click', "#courses .course",  function(e) {
		e.preventDefault();
  	var selectedCourse = e.currentTarget;
  	window.window.location = "payment.html?id=" + $(selectedCourse).data("course_id");
	})
});
