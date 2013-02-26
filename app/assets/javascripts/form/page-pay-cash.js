$(function() {
	var scope = '#pay-cash'; var jScope = $(scope);
	var nameMatcher = new Bespeak.Matcher(
		function(selector) {
			jScope.find('.errors > .name_error').remove();
			var match = !!$(selector).find('input[name="name"]').val();
			
			return match;
		},
		function() {
			jScope.find('.errors').append('<div class="alert alert-error name_error">Please enter your name.</div>');
		});
	Bespeak.activeValidation.add_validation(scope, nameMatcher);
	
	var phoneMatcher = new Bespeak.Matcher(
		function(selector) {
			jScope.find('.errors > .phone_error').remove();
			var phone_number = ($(selector).find('input[name="telephone"]').val() || "").replace(/\s+/g, "");
			match = phone_number.length > 9 &&
				phone_number.match(/^(1[-\.]?)?(\([2-9]\d{2}\)|[2-9]\d{2})[-\.]?[2-9]\d{2}[-\.]?\d{4}$/);
			
			return match;
		},
		function() {
			jScope.find('.errors').append('<div class="alert alert-error phone_error">Please enter a valid phone number.</div>');
		});
	Bespeak.activeValidation.add_validation(scope, phoneMatcher);
});
