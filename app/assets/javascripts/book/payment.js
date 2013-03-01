$(function() { setGrandTotal(); });

$(function() { $('#payment').on('change', "input[type='radio'][name='paymentOptions']", function(e) {
  var payOpt = $("input[type='radio'][name='paymentOptions']:checked").val();
  if(payOpt == 'cash') {
    $('#cash-details input[name="name"]').val($('#credit-card-details input[name="name"]').val());
    $('#credit-card-details :input').prop('disabled',true);
    $('#cash-details :input').prop('disabled',false);
    $('#credit-card-details').slideUp();
    $('#cash-details').slideDown();
  }
  else {
    $('#cash-details :input').prop('disabled',true);
    $('#credit-card-details :input').prop('disabled',false);
    $('#credit-card-details input[name="name"]').val($('#cash-details input[name="name"]').val());
    $('#cash-details').slideUp();
    $('#credit-card-details').slideDown();
  }
})});

function setGrandTotal() {
  var grandTotal = 0;
  $(".bookings .total").each(function() {
      grandTotal += parseFloat($(this).text());
  });
	$(".coupon .discount").each(function() {
		grandTotal += parseFloat($(this).data('discount'));
	});

  $(".grandTotal").text(parseFloat(grandTotal).toFixed(2));

	if(parseFloat(grandTotal).toFixed(2) == 0.00 && $('.payments').is(':visible')) {
		$('.payments').slideUp();
	}
	else if(parseFloat(grandTotal).toFixed(2) > 0.00 && !$('.payments').is(':visible')) {
		$('.payments').slideDown();
	}
}
$(function() { $('#payment').on('change', '.attendee-selector', function(e) {
  var attendeeCount = $(e.currentTarget).val();
  $(".total").text((attendeeCount * $(".cost").text()).toFixed(2));
  setGrandTotal();
})});

$(function() { $('#payment').on('click', '#bill a[data-other-id="coupon-form"]', function(e) {
	e.preventDefault();
  $(e.currentTarget).hide();
  $('#coupon-form').show();
	return false;
})});

$(function() { $('#payment').on('submit', "#coupon-form", function() {
	var code = $('#coupon-form input[name="coupon-code"]').val();
  if(code != '') { 
		$('#coupon-form').replaceWith("<p class='coupon well'>Coupon: <span class='coupon-code'>" + code + "</span><span class='discount' data-discount='-95'>-95.00</span></p>");
		setGrandTotal();
  } 
  return false;
})});
