namespace 'Bespeak', (exports) ->
	class exports.Course extends Object
		@all = {}
	
		constructor: (@id, @office_id, @course_type_id, @start_at, @end_at) ->
			me = if Bespeak.Course.all[@id]? then Bespeak.Course.all[@id] else Bespeak.Course.all[@id] = this
			[me.office_id, me.course_type_id, me.start_at, me.end_at] = [@office_id, @course_type_id, @start_at, @end_at]
			
			return me