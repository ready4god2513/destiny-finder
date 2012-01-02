$(function(){
	
	// Drop Down Menu
	$("ul.sf-menu").superfish();
	
	// Form Validations
	$("form").validate();
	
	// Modal Box
	$("a.enlarge_link").fancybox();
	
	$("#signup-form").validate({
		user_first_name: "required",
		user_last_name: "required",
		user_email: {
			required: true,
			email: true
		},
		user_email2 {
			required: true,
			email: true,
			equalTo: "user_email"
		},
		password: {
			required: true,
			minlength: 6
		},
		password2: {
			required: true,
			minlength: 6,
			equalTo: "password"
		}
	});
	
	$("#login-form").validate({
		user_name: {
			required: true,
			email: true
		},
		password: {
			required: true,
			minlength: 6
		}
	});
});