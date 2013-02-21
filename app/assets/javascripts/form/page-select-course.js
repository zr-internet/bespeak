$(function() {
	var scope = $('#select-course');
	var matcher = new Bespeak.Matcher(
		function(selector) {
			match = !!$(selector).find('input[type="radio"][name="payment[method]"]').filter(':checked').val();
			if(match) { scope.find('.errors').empty(); }
			
			return match;
		},
		function() {
			scope.find('.errors').append('Please select a payment method.');
		});
	Bespeak.activeValidation.add_validation('#select-course', matcher);
	
	$(Bespeak.selectedCourse).on('change', function(e) {
		scope.find('span.course_type_name').text(e.target.get_course_type_name());
	});
	
	scope.on('change', 'input[type="radio"][name="payment[method]"]', function(e) {
		var paymentOption = $(e.target);
		scope.find('.nav button.next').data('show', paymentOption.data('target'))
	});
});
