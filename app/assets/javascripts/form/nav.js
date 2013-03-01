(function( $ ){
  $.fn.navigation = function( options ) {  

    // Create some defaults, extending them with any options that were provided
    var settings = $.extend( {
      validate : function() { 
				return Bespeak.activeValidation.validate(this.data('validate'))
			},
      success : function() { 
				$(this.data('show')).removeClass('hidden'); $(this.data('hide')).addClass('hidden');
				return this; 
			},
			failure : function () { return this; }
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
});

