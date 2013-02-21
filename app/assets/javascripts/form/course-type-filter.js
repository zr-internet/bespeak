$(function() { 
	var Target = function(element) {
		this.course_type = $(element).data('course-type-id');
		this.office = $(element).data('office-id');
		this.selector = function() {
			
			return {
				element: "#courses .course-select",
				attr: '[data-course-type-id="' + this.course_type + '"]'  + '[data-office-id="' + this.office + '"]'
			}
		};
	};
	
	$(document).on('click', '#course-type-filter input[name="filters-courses"]', function(e) {
  	
	var selector = new Target(e.target).selector();
  $(selector.element + selector.attr).removeClass('hidden');
  $(selector.element).not(selector.attr).addClass('hidden');
	
})});