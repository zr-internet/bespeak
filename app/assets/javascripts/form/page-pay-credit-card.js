$(function() {
	var scope = '#pay-credit_card'; var jScope = $(scope);
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
	
	var creditCardMatcher = new Bespeak.Matcher(
		function(selector) {
			jScope.find('.errors > .credit-card_error').remove();
			var match = Bespeak.creditCardValidator.validate($(selector).find('input[name="credit-card-number"]').val());

			return match;
		},
		function() {
			jScope.find('.errors').append('<div class="alert alert-error credit-card_error">Please enter a valid credit card number.</div>');
		});
	Bespeak.activeValidation.add_validation(scope, creditCardMatcher);
	
	var ccvMatcher = new Bespeak.Matcher(
		function(selector) {
			jScope.find('.errors > .ccv_error').remove();
			var match = !!$(selector).find('input[name="credit-card-ccv"]').val();
			
			return match;
		},
		function() {
			jScope.find('.errors').append('<div class="alert alert-error ccv_error">Please enter your ccv code (you can find this on the back of your credit card).</div>');
		});
	Bespeak.activeValidation.add_validation(scope, ccvMatcher);
	
	var expirationMatcher = new Bespeak.Matcher(
		function(selector) {
			jScope.find('.errors > .expiration_error').remove();
			var match = !!jScope.find('select[name="credit-card-exp-month"]').val() && !!jScope.find('select[name="credit-card-exp-year"]').val();
			
			return match;
		},
		function() {
			jScope.find('.errors').append('<div class="alert alert-error expiration_error">Please enter your credit card\'s expiration date.</div>');
		});
	Bespeak.activeValidation.add_validation(scope, expirationMatcher);
	
	// attendee updates update total cost
	jScope.on('change', 'input[name="attendees"]', function(e) {
		jScope.find("div.total[name='due-now']").text(($(e.target).val() * Bespeak.selectedCourse.get_cost()).toFixed(2))
	});
	
	var submit = function() {
		var submitButton = this;
		submitButton.text("Submitting...").attr('disabled', true);
		jScope.find('.errors > .submit_error').remove();

		var payload = {
			course_id : Bespeak.selectedCourse.get_course_id(),
			email : $('#email input[name="email"]').val(),
			attendees : jScope.find('input[name="attendees"]').val(),
			payment_method : 'credit_card',
			name : jScope.find('input[name="name"]').val(),
			payment_details : { credit_card_number: jScope.find('input[name="credit-card-number"]').val(),
		    credit_card_expiration_month: jScope.find('select[name="credit-card-exp-month"]').val(),
		    credit_card_expiration_year: jScope.find('select[name="credit-card-exp-year"]').val(),
		    credit_card_ccv: jScope.find('input[name="credit-card-ccv"]').val()
		  }
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
							error = '<div class="alert alert-error submit_error card_error">Credit card failed to process. Please double check your credit card details.</div>';
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