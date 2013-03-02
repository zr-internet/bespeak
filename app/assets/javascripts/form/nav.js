(function( $ ){
	var events = {
		next : function(navigation) { navigation.trigger('next'); },
		previous : function(navigation) { navigation.trigger('previous'); }
	};
	
	var methods = {
		notify : function(navigation) {
			return navigation.hasClass('next') ? events.next(navigation) : events.previous(navigation);
		}
	};
	
  $.fn.navigation = function( options ) {  
		
    // Create some defaults, extending them with any options that were provided
    var settings = $.extend( {
      validate : function(e) { 
				return Bespeak.activeValidation.validate(this.data('validate'))
			},
      success : function(e) { 
				$(this.data('show')).removeClass('hidden'); $(this.data('hide')).addClass('hidden');
				methods.notify(this);
				return this; 
			},
			failure : function (e) { return this; }
    }, options);

    return this.each(function(i,element) {        
			var e = $(element);
			e.on('click', function(ev) { 
				if(settings.validate.apply(e)) { settings.success.apply(e); } else { settings.failure.apply(e); } 
			});
    });
  };
})( jQuery );

$(function() {
	$('.nav > button.next, .nav > button.previous').navigation();
	
	$('.nav > button').on('next', function(e) {
		var currentProgress = $('#form .intro header .progress .bar.active').last();
		currentProgress.removeClass('active').next('.bar').addClass('active bar-success');
	});
	$('.nav > button').on('previous', function(e) {
		$('#form .intro header .progress .bar.active').last().removeClass('active bar-success').prev('.bar').addClass('active');
	});
});

