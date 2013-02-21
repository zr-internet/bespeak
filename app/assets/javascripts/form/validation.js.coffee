namespace 'Bespeak', (exports) =>

  class exports.Matcher extends Object
    constructor: (@matcher, @onfailure) ->
      
    match: (selector) =>
      match = @matcher(selector)
      @onfailure() unless match

      return match


  class exports.Validation extends Object
    constructor: (@validations) ->
      @validations ||= {}
    
    add_validation: (selector, matcher) =>
      @validations[selector] = matcher
    
    validation: (selector) =>
      @validations[selector]
    
    validate: (selector) ->
      v = this.validation(selector) 
      return true unless v
      
      return v.match(selector)
      
    
  Bespeak.activeValidation = new Bespeak.Validation
        
      
      