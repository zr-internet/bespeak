$(function() { 
	$(document).on('click', "#courses .course",  function(e) {
		e.preventDefault();
  	var selectedCourse = e.currentTarget;
  	window.window.location = "payment.html?course=" + $(selectedCourse).data("course_id");
	})
});
