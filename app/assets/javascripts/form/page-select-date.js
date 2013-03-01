$(function() {
	var courseMatcher = new Bespeak.Matcher(
		function(selector) {
			$('#select-date .errors .course_error').remove();
			var match = $(selector).find('#courses > label.course-select:not(.hidden) > select').val() > 0;
			
			return match;
		},
		function() {
			$('#select-date .errors').append('<div class="alert alert-error course_error">Please select a course and date.</div>');
		});
		
	var emailMatcher = new Bespeak.Matcher(
		function(selector) {
			$('#select-date .errors .email_error').remove();
			var match = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test($(selector).find('input[name="email"]').val());

			return match;
		},
		function() {
			$('#select-date .errors').append('<div class="alert alert-error email_error">Please enter a valid email address.</div>');
		});
	Bespeak.activeValidation.add_validation('#select-date', courseMatcher);
	Bespeak.activeValidation.add_validation('#select-date', emailMatcher);
});