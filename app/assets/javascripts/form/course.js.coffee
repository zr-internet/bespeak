namespace 'Bespeak', (exports) =>

  class exports.Course extends Object
    constructor: (@course_id, @course_type_id, @office_id) ->
    
    set_course_id: (course_id) =>
      @course_id = course_id
      this._trigger_change()
      @course_id
      
    get_course_id: => 
      @course_id  
    
    set_course_type_name: (course_type_name) =>
      @course_type_name = course_type_name
      this._trigger_change()
      @course_type_name
      
    get_course_type_name: => 
      @course_type_name
    
    set_office_name: (office_name) =>
      @office_name = office_name
      this._trigger_change()
      @office_name
    
    get_office_name: => @office_name
    
    _trigger_change: () =>
      jQuery(this).trigger("change", this);
      
  Bespeak.selectedCourse = new Bespeak.Course()