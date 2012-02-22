<cfparam name="URL.assessment_id" default="5">
<cfparam name="URL.user_id" default="#REQUEST.user_id#">
<cfparam name="ATTRIBUTES.assessment_id" default="#val(URL.assessment_id)#">

<cfif isDefined("URL.nxpb3")>
	<cfset vHiddenList = DEcrypt(URL.nxpb3,'keyei3v2','CFMX_COMPAT','Hex')>
	<cfset VARIABLES.passion_file = ListGetAt(vHiddenList,2) & '.cfm'>
	<cfset VARIABLES.vCount = ListGetAt(vHiddenList,1)>
<cfelse>
    <cfset VARIABLES.passion_file="sphere-1.cfm">
    <cfset VARIABLES.vCount=1>
	
	<cfset passionSurveyObj = CreateObject("component","cfcs.passion").init(user_id = REQUEST.user_id) />
	<cfset passionSurvey = passionSurveyObj.beginSurvey()>
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

<cfset progbar = (VARIABLES.vCount / 25) * 100>
<div class="percent_complete_label">% of survey completed</div>
<div class="progress progress-info progress-striped active">
	<div class="bar" style="width: <cfoutput>#progbar#</cfoutput>%;"></div>
</div>

<script>
	$(function(){
		$(".survey-form input[type=checkbox]").attr("validate", "required:true, minlength:2");
		$(".survey-form input[type=radio]").attr("validate", "required:true");
		$.metadata.setType("attr", "validate");
		
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