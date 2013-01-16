namespace 'Bespeak', (exports) ->
  class exports.Client
		constructor: (@client_key) ->
			this
			
		course_types: () =>
			exports.CourseType.all
		
		offices: () =>
			exports.Office.all
		
		courses: () =>
			exports.Course.all
