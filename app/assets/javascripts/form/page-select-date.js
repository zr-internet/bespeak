$(function() {
	var matcher = new Bespeak.Matcher(
		function(selector) {
			match = $(selector).find('#courses > label.course-select:not(.hidden) > select').val() > 0;
			if(match) { $('#select-date .errors').empty(); }
			
			return match;
		},
		function() {
			$('#select-date .errors').append('Please select a course and date.')
		});
	Bespeak.activeValidation.add_validation('#select-date', matcher);
});