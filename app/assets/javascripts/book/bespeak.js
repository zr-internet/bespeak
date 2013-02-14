function creditCardPayload(payload) {
  payload.payment_method = "credit_card"
  payload.name = $('#nameCreditCard').val();
  payload.payment_details = { credit_card_number: $('#creditCardNumber').val(),
    credit_card_expiration_month: $('#creditCardExpMonth').val(),
    credit_card_expiration_year: $('#creditCardExpYear').val(),
    credit_card_ccv: $('#ccv').val()
  };
  return payload;
}

function cashPayload(payload) {
  payload.payment_method = "cash"
  payload.name = $('#nameCash').val();
  payload.phone = $('#telephone').val();
  payload.payment_details = { };
  return payload;
}

function couponPayload(payload) {
	payload.coupon = $('.coupon-code').text();
	
	return payload;
}

function buildPayload(form) {
  var payload = { email: $('#email').val(), 
    attendees: $('input.attendee-selector').val(),
    course_id: $(".booking").data("course_id"),
  };
  if($('#paymentOptionsCreditCard').is(':checked')) {
    payload = creditCardPayload(payload);
  }
  else if($('#paymentOptionsCash').is(':checked'))
  {
    payload = cashPayload(payload)
  }

	if($('.coupon-code').text() != '') {
		payload = couponPayload(payload)
	}
	
  return payload;
}

function onSuccess(data, status, jqXHR) {
  window.location.href = 'http://www.massachusettsgunsafety.com/thanks.html'
}

function onError(data, status, jqXHR) {
  $("#booking-form input[type='submit']").attr('disabled', false).val("Try again");
	
	var response = JSON.parse(data.responseText);
	var errors = $("<ul></ul>");
	for(var e in response.errors) {
		var heading = e;
		var error = $("<li data-errors-for='" + heading + "'></li>");
		if(e == 'payments') {
			error.append("<p>Credit card failed to process. Please double check your credit card details.</p>");
		}
		else {
			for(var i = 0; i < response.errors[e].length; i++) { error.append("<p>"+heading + " " + response.errors[e][i]+"</p>"); }
		}
		errors.append(error);
	}
  $("#submit-errors").html(errors);
}


displayTime = function(time) {
	var hours = "";
	var suffix = "";
	if(time.getHours() < 12) {
		hours = time.getHours();
		suffix = " am"
	} else if(time.getHours() == 12) {
		hours = time.getHours();
		suffix = " pm"
	} else {
		hours = time.getHours() - 12;
		suffix = " pm"
	}
	var minutes = "";
	if(time.getMinutes().toString().length < 2) {
		minutes = "0" + time.getMinutes().toString();
	} else {
		minutes = time.getMinutes().toString();
	}
	return hours + ":" + minutes + suffix;
}

var _nameByIndex = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
dayName = function(date) {
	return _nameByIndex[date.getDay()];
}

IdentityMap = function() {
}
IdentityMap.prototype.as_array = function() {
	var arr = [];
	var keys = Object.keys(this);
	for(var i = 0; i < keys.length; i++) {
		arr.push(this[keys[i]]);
	}
	return arr;
}

Course = function (id, courseType, start, end, office) {
	this.id = id;
	this.courseType = courseType;
	this.start = start;
	this.end = end;
	this.office = office;
	
	if(typeof Course.all === 'undefined') { 
		Course.all = new IdentityMap(); 
	}
	Course.all[this.id] = this;
};
Course.prototype.draw = function(parent) {
	$(parent).append(ich.tmplcourse(this));
};
Course.prototype.date = function() {
	var localDate = this.office.localTime(this.start);
	return dayName(localDate) + " " + (localDate.getMonth() + 1) + "/" + localDate.getDate() + "/" + localDate.getFullYear().toString().substr(2);
};

Course.prototype.startTime = function() {
	return displayTime(this.office.localTime(this.start));
};
Course.prototype.endTime = function() {
	return displayTime(this.office.localTime(this.end));
};

Course.fromJson = function (props) {
	c = new Course(props.id, CourseType.all[props.course_type_id], new Date(props.start_at * 1000), new Date(props.end_at * 1000), Office.all[props.office_id])
	return c;
}

Booking = function (courseId) {
	this.course = Course.all[courseId]
	this.name = "";
	this.email = "";
	this.attendees = 1;
	this.paymentType = "credit-card";
	this.confirmation = "";
	
	this.total = function() {
		return this.course.courseType.cost * this.attendees;
	}
	
	this.draw = function(parent) {
		$(parent).append(ich.tmplbooking(this));
	};
}

CourseType = function(id, name, description, cost) {
	this.id = id;
	this.name = name;
	this.description = description;
	this.cost = cost;
	
	if(typeof CourseType.all === 'undefined') { CourseType.all = new IdentityMap(); }
	CourseType.all[this.id] = this;
}
CourseType.prototype.label = function() {
	if(this.name == "MA LTC-007") {
		return "mass-ltc";
	} else if(this.name == 'Utah Non-Resident LTC') {
		return "utah-ltc";
	} else {
		return 'unknown';
	}
}

CourseType.fromJson = function (props) {
	ct = new CourseType(props.id, props.name, props.description, props.cost)
	return ct;
}
CourseType.Sorters = { alphabetical: function(a,b) { return a.name > b.name; } };

Office = function(id, name, address, phone, timeZoneOffset) {
	this.id = id;
	this.name = name;
	this.address = address;
	this.phone = phone;
	this.timeZoneOffset = timeZoneOffset;
	
	if(typeof Office.all === 'undefined') { Office.all = new IdentityMap(); }
	Office.all[this.id] = this;
}
Office.prototype.localTime = function(time) {
	var localOffset = new Date().getTimezoneOffset()*60;
	return new Date(time.getTime() + (this.timeZoneOffset + localOffset) * 1000);
}
Office.fromJson = function (props) {
	o = new Office(props.id, props.name, props.address, props.phone, props.timeZoneOffset)
	return o;
}
Office.Sorters = { alphabetical: function(a,b) { return a.name > b.name} };


Schedule = function() {};

Schedule.Sorters = { byDateAsc: function(a, b) { return a.start > b.start ? 1 : a.start < b.start ? -1 : 0; } };
Schedule.Filters = { 
	byOffices: function(course) {
		var offices = $.map($('#office-filter .active'), function(element) { return $(element).data('office_id') });
		var match = $.inArray($(course).data('office_id'), offices);
		return match >= 0;
	},
	byCourseTypes: function(course) {
		var courseTypes = $.map($('#course-type-filter .active'), function(element) { return $(element).data('course_type_id')});
		var match = $.inArray($(course).data('course_type_id'), courseTypes);
		return match >= 0;
	},
	active: [],
	current: function(index) {
		var pass = true;
		var course = this;
		$.each(Schedule.Filters.active, function(index, filter) {
			pass = pass && filter(course);
		});
		return pass;
	}
}
Schedule.load = function(courseIndexUrl, courseTypeIndexUrl, officeIndexUrl, success) {
	Bespeak.bsp.load(success);
};

Schedule.draw = function(parent) {
	var filteredCourses = $(parent).children('.course');
	filteredCourses = filteredCourses.filter(Schedule.Filters.current);
	$(parent).children().hide();
	if(filteredCourses.length == 0)
	{
		$(parent).append('<tr class="warning"><td colspan="5"><p><strong>No courses currently available</strong><p><p class="small">Please try looking for different location, course, and time combinations</p></td></tr>');
	}
	
	$.each(filteredCourses, function(index, course) {
		$(course).show();
	});
};

Bespeak = function() {
  this.clientId = "crowdvert";
	this.protocol = location.protocol;
	this.server = serverDomain();
  this.bookingUrl = "/bookings.json";
	this.courseTypesUrl = "/course_types.json";
	this.coursesUrl = "/courses/available.json";
	this.officesUrl = "/offices.json";
	
	
	
	function serverDomain() {
	 	if((location.hostname == "crowdvert.local" || location.hostname == "0.0.0.0") && location.protocol == "https:") {
			return "//0.0.0.0:5001";
		} else if((location.hostname == "crowdvert.local" || location.hostname == "0.0.0.0")  && location.protocol == "http:") {
			return "//0.0.0.0:5000";
		} else {
			return "//bespeak.herokuapp.com";
		}
	}
}

Bespeak.prototype.get = function (url, onsuccess, onerror) {
	$.ajax({
		type : 'GET',
		url : url,
		contentType : 'text/plain',
		dataType : 'text json',
		error : onerror,
		success : onsuccess,
		timeout : 2000
	});
}

Bespeak.prototype.post = function (url, data, onsuccess, onerror) {
	$.ajax({
		type : 'POST',
		url : url,
		contentType : 'text/plain',
		data : data,
		dataType : 'text json',
		error : onerror,
		success : onsuccess,
		timeout : 4000
	});
}

Bespeak.prototype.load = function(onsuccess, onerror) {
	Bespeak.bsp.get(Bespeak.bsp.protocol + Bespeak.bsp.server + Bespeak.bsp.officesUrl, function(data) { 
		$.each(data, function(i, props) { Office.fromJson(props) });
		Bespeak.bsp.get(Bespeak.bsp.protocol + Bespeak.bsp.server + Bespeak.bsp.courseTypesUrl , function(data) { 
			$.each(data, function(i, props) { CourseType.fromJson(props) } );
			Bespeak.bsp.get(Bespeak.bsp.protocol + Bespeak.bsp.server + Bespeak.bsp.coursesUrl, function(data) {
				$.each(data, function(i, props) { Course.fromJson(props) });
				onsuccess();
				$(Bespeak.bsp).trigger("data-load");
			});
		});
	});
}

Bespeak.prototype.process_booking = function(payload, onsuccess, onerror) {
	Bespeak.bsp.post(Bespeak.bsp.protocol + Bespeak.bsp.server + Bespeak.bsp.bookingUrl, payload, onSuccess, onError);
}

Bespeak.bsp = new Bespeak;