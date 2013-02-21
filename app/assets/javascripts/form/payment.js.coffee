namespace 'Bespeak', (exports) =>

  class exports.Payment extends Object
    descriptions = {"cash" : 'Pay-Later', "credit_card" : 'Pay-Now', "coupon" : 'Coupon' }
    
    constructor: (@method, @course_type) ->
    
    description: () ->
      @descriptions[@method]    