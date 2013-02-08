$(function() { $(document).on('click', '.see-more', function(e) {
  var target = $($(e.target).data('more-selector'));
  target.slideDown();
})});