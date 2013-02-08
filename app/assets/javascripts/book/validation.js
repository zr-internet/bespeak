$(function() { $.metadata.setType("attr", "validate") });
$(function() {
		jQuery.validator.addMethod("phoneUS", function(phone_number, element) {
	    phone_number = phone_number.replace(/\s+/g, ""); 
		return this.optional(element) || phone_number.length > 9 &&
			phone_number.match(/^(1[-\.]?)?(\([2-9]\d{2}\)|[2-9]\d{2})[-\.]?[2-9]\d{2}[-\.]?\d{4}$/);
	}, "Please specify a valid phone number");

	$(function(){
	  $("#booking-form").validate({
	      groups: {
	      creditCardExpiration: "creditCardExpMonth creditCardExpYear"
	    },
	    rules: {
	      name: "required",
	      email: {required: true, email: true},
	      creditCardExpMonth: { required: function () { $("#creditCardExpYear").val() != "" } },
	      creditCardExpYear: { required: function () { $("#creditCardExpMonth").val() != "" } },
	      creditCardNumber: { required: true, creditcard: true },
	      ccv: { required: true, digits: true, maxlength: 4 },
	      telephone: { required: true, phoneUS: true }
	    },
	    messages: {
	      name: "Please enter your full name.",
	      ccv: { required: "Please enter your CCV code (you can find this on the back of your credit card)." },
	      telephone: { required: "Please enter your telephone number, eg. (617)555-1212" }
	    },
	    highlight: function(label) {
	        $(label)
	          .removeClass('valid')
	          .closest('.control-group').addClass('error').removeClass('success');
	    },
	    success: function(label) {
	      label
	        .addClass('valid')
	        .closest('.control-group').addClass('success').removeClass('error');
	    },
	    submitHandler: function(form) {
	      var btn = $("#booking-form input[type='submit']");
			  btn.attr('disabled', true).val("Submitting...");
			  var payload = buildPayload($('#booking-form'));

				Bespeak.bsp.process_booking(payload);

			  return false;
			}
	  });
	});
});
