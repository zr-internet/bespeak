$(function() {
	var scope = '#select-course'; var jScope = $('#select-course');
	var matcher = new Bespeak.Matcher(
		function(selector) {
			jScope.find('.errors').remove('.payment_method_error');
			var match = !!$(selector).find('input[type="radio"][name="payment[method]"]').filter(':checked').val();
			if(match) { jScope.find('.errors').empty(); }
			
			return match;
		},
		function() {
			jScope.find('.errors').append('<div class="alert alert-error payment_method_error">Please select a payment method.</div>');
		});
	Bespeak.activeValidation.add_validation(scope, matcher);
	
	$(Bespeak.selectedCourse).on('change', function(e) {
		jScope.find('span.course_type_name').text(e.target.get_course_type_name());
		jScope.find('label.credit_card span.payment .cost').text("$" + e.target.get_cost());
	});
	
	jScope.on('change', 'input[type="radio"][name="payment[method]"]', function(e) {
		var paymentOption = $(e.target);
		jScope.find('.nav button.next').data('show', paymentOption.data('target'))
	});
});
