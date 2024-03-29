$(function(){
	
	$(".nav-collapse li.dropdown").children("a").append('<b class="caret"></b>');
	
	$("form").addClass("form-horizontal");
	$("label").addClass("control-label");
	$("label.checkbox, label.radio").removeClass("control-label");
	

	if($("#rotating-banner").length)
	{
		$("#rotating-images").cycle({
			fx: "fade",
			pager: "#cycle-nav",
			pause: true,
			timeout: 3000,
			width: 590,
			height: 280,
			speed: 500,
			pagerAnchorBuilder: function(idx, slide) 
			{ 
				return '<a href="#">&bull;</a>'; 
			}
		});
	}

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
	
	$(".do-share-passion").click(function(){
		$(this).attr("href", $(this).data("base-url") + $("#share-your-passion").val());
	});
	
	$("#delight-talents input").on("blur", function(){
		$("#show-talents").html("<h4>Delights</h4><ol></ol>");
		$("#delight-talents input").each(function(){
			if($(this).val() != "")
			{
				$("#show-talents ol").append("<li>" + $(this).val() + "</li>");
			}
		});
	});
	
	$("#delight-loves input").on("blur", function(){
		$("#show-loves").html("<h4>Loves</h4><ol></ol>");
		$("#delight-loves input").each(function(){
			if($(this).val() != "")
			{
				$("#show-loves ol").append("<li>" + $(this).val() + "</li>");
			}
		});
	});

});