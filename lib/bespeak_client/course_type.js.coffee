namespace 'Bespeak', (exports) ->
  class exports.CourseType extends Object
		@all = {}
	
		constructor: (@id, @name, @description, @cost) ->
			me = if Bespeak.CourseType.all[@id]? then Bespeak.CourseType.all[@id] else Bespeak.CourseType.all[@id] = this
			[me.name, me.description, me.cost] = [@name, @description, @cost]
			
			return me