$(function() {
	var scope = '#pay-coupon'; var jScope = $(scope);
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
				!!phone_number.match(/^(1[-\.]?)?(\([2-9]\d{2}\)|[2-9]\d{2})[-\.]?[2-9]\d{2}[-\.]?\d{4}$/);
			
			return match;
		},
		function() {
			jScope.find('.errors').append('<div class="alert alert-error phone_error">Please enter a valid phone number.</div>');
		});
	Bespeak.activeValidation.add_validation(scope, phoneMatcher);
	
	var couponMatcher = new Bespeak.Matcher(
		function(selector) {
			jScope.find('.errors > .coupon_error').remove();
			var match = !!$(selector).find('input[name="code"]').val();
			
			return match;
		},
		function() {
			jScope.find('.errors').append('<div class="alert alert-error coupon_error">Please enter your coupon code.</div>');
		});
	Bespeak.activeValidation.add_validation(scope, couponMatcher);
	
	var submit = function() {
		var submitButton = this;
		submitButton.text("Submitting...").attr('disabled', true);
		jScope.find('.errors > .submit_error').remove();

		var payload = {
			course_id : Bespeak.selectedCourse.get_course_id(),
			email : $('#email input[name="email"]').val(),
			attendees : 1,
			payment_method : 'cash',
			name : jScope.find('input[name="name"]').val(),
			phone : jScope.find('input[name="telephone"]').val(),
			coupon : jScope.find('input[name="code"]').val(),
			payment_details : {}
		};

		Bespeak.bsp.process_booking(payload, 
			function() {   window.top.location.href = 'http://www.massachusettsgunsafety.com/thanks.html' }, 
			function(jqXHR, status, error) {
			  submitButton.attr('disabled', false).text("Try again");
				var errors = "";
				if(status == "timeout") {
						errors = '<div class="alert alert-error submit_error timeout_error">The connection with the booking server has been interrupted. Please check your email to see if your booking has gone through. If not please try again.</div>';
				}
				else {
					var response = JSON.parse(jqXHR.responseText);
					for(var e in response.errors) {
						var heading = e;
						var error = "";
						if(e == 'payments') {
							error = '<div class="alert alert-error submit_error card_error">Coupon failed to process. Please double check your coupon details.</div>';
						}
						else {
							for(var i = 0; i < response.errors[e].length; i++) { 
								error += '<div class="alert alert-error submit_error ' + heading + '_error">'+heading + " " + response.errors[e][i]+'</p>'; 
							}
						}
						errors += error;
					}
				}
				jScope.find('.errors').append(errors);
			}
		);
	}
	jScope.find('button.submit').navigation({success: submit})
});