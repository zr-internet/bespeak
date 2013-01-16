namespace 'Bespeak', (exports) ->
  class exports.Office extends Object
		@all = {}
	
		constructor: (@id,  @name, @address, @phone, @timeZoneOffset) ->
			me = if Bespeak.Office.all[@id]? then Bespeak.Office.all[@id] else Bespeak.Office.all[@id] = this
			[me.name, me.address, me.phone, me.timeZoneOffset] = [@name, @address, @phone, @timeZoneOffset]
			
			return me	
		constructor: (@id, @name, @address, @phone, @timeZoneOffset) ->
