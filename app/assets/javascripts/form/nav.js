$(function() {
	$(document).on('click', '.nav > button', function(e) {
		var button = $(e.target);
		if(Bespeak.activeValidation.validate(button.data('validate'))) {
			$(button.data('show')).removeClass('hidden');
			$(button.data('hide')).addClass('hidden');
		}
	});
});