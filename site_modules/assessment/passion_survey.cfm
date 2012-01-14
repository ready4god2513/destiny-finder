
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
</cfif>

<cfparam name="ATTRIBUTES.sort_id" default="#VARIABLES.vCount#">
<cfoutput>
	<div id="sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_result" class="sort_result" style="background-color:white;">
		
	</div>

	<div class="sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_wrapper" style="background-color:white;">
	<cfinclude template="../passion_files/#HTMLEditFormat(VARIABLES.passion_file)#">
	</div>
</cfoutput>

<script>
	$(function(){
		$(".survey-form").ajaxForm({
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
	});
</script>