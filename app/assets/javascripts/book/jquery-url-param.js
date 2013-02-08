$(function() {
	$.urlParam = function(key){
    var result = new RegExp(key + "=([^&]*)", "i").exec(window.location.search); 
		return result && result[1] || "";
	}
});
