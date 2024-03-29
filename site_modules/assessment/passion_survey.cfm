<cfparam name="URL.assessment_id" default="5">
<cfparam name="URL.user_id" default="#REQUEST.user_id#">
<cfparam name="ATTRIBUTES.assessment_id" default="#val(URL.assessment_id)#">

<cfif isDefined("URL.nxpb3")>
	<cfset vHiddenList = DEcrypt(URL.nxpb3,'keyei3v2','CFMX_COMPAT','Hex')>
	<cfset VARIABLES.passion_file = ListGetAt(vHiddenList,2) & '.cfm'>
	<cfset VARIABLES.vCount = ListGetAt(vHiddenList,1)>
<cfelse>
	<cfif isDefined("URL.begin")>
		<cfset VARIABLES.passion_file="sphere-1.cfm">
	    <cfset VARIABLES.vCount=1>

		<cfset passionSurveyObj = CreateObject("component","cfcs.passion").init(user_id = REQUEST.user_id) />
		<cfset passionSurvey = passionSurveyObj.beginSurvey()>
	<cfelse>
		<cfset VARIABLES.passion_file="intro.cfm">
		<cfset VARIABLES.vCount = 0>
		<cfset passionSurveyObj = CreateObject("component","cfcs.passion").init(user_id = REQUEST.user_id) />
	</cfif>
</cfif>

<cfparam name="ATTRIBUTES.sort_id" default="#VARIABLES.vCount#">
<cfoutput>
	<div id="sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_result" class="sort_result" style="background-color:white;">
		
	</div>
	
	<div id="validation-errors" class="alert alert-error hide"></div>

	<div class="sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_wrapper" style="background-color:white;">
		<cfinclude template="../passion_files/#HTMLEditFormat(VARIABLES.passion_file)#">
	</div>
</cfoutput>

<cfif VARIABLES.vCount GT 0>
	<cfset progbar = ((VARIABLES.vCount - 1) / 25) * 100>
	<h6><cfoutput>#progbar#</cfoutput>% Complete</h6>
	<div class="progress progress-info progress-striped active">
		<div class="bar" style="width: <cfoutput>#progbar#</cfoutput>%;"></div>
	</div>
</cfif>

<script>
	$(function(){
		$.metadata.setType("attr", "validate");
		$(".survey-form input[type=text]").addClass("other");
		$(".survey-form input[type=checkbox]").attr("validate", "checkedOrCustom: true");
		$(".survey-form input[type=radio]").attr("validate", "required:true");
		
		$.validator.addMethod("checkedOrCustom", function(value, element){
			if($("input:checkbox:checked").length == 2)
			{
				return true;
			}

			if($(".other").val() != "")
			{
				return true;
			}

			if($("input[value=undecided]").is(":checked"))
			{
				return true;
			}

			return false;
		}, $.format("Please choose two options or fill in your own"));
		
		$(".survey-form").validate({
			errorLabelContainer: $("#validation-errors"),
			errorElement: "p",
			submitHandler: function(form)
			{
				$(form).ajaxSubmit({
					target: ".assessment_item",
					type: "POST",
					url: "/site_modules/assessment/act_passion_survey.cfm",
					beforeSubmit: function()
					{
						$(".assessment_item").fadeOut();
					},
					success: function()
					{
						$(".assessment_item").fadeIn();
					}
				});
			}
		});
	});
</script>