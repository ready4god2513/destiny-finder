$(function(){
	
	$.validator.setDefaults({ 
	    errorElement: "em"
	});
	
	
	// Form Validations
	$("#signup-form").validate({
		rules:
		{
			user_first_name: "required",
			user_last_name: "required",
			user_email: 
			{
				required: true,
				email: true
			},
			user_email2:
			{
				required: true,
				email: true,
				equalTo: "#user_email"
			},
			user_password: 
			{
				required: true,
				minlength: 6
			},
			user_password2: 
			{
				required: true,
				minlength: 6,
				equalTo: "#user_password"
			},
			agree_to_terms:
			{
				required: true
			}
		}
	});
	
	$("#update-account-form").validate({
		rules:
		{
			user_first_name: "required",
			user_last_name: "required",
			user_email: 
			{
				required: true,
				email: true
			},
			user_email2:
			{
				required: true,
				email: true,
				equalTo: "#user_email"
			},
			user_password: 
			{
				minlength: 6
			},
			user_password2: 
			{
				minlength: 6,
				equalTo: "#user_password"
			}
		}
	});
	
	$("#login-form").validate({
		rules:
		{
			user_name: 
			{
				required: true,
				email: true
			},
			password: 
			{
				required: true,
				minlength: 6
			}
		}
	});
	
	
	// Remove inline styles as they tend to break things
	$("*").removeAttr("style");
	
	// Remove empty paragraph tags.  These often come from the CMS/blog
	$("p").filter(function() {
		return $.trim($(this).text()) === ""
	}).remove();
	
	
	// Dropdown Menu
	$("#topbar").dropdown();
	
});