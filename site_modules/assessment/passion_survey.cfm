
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
<script type='text/javascript'>
	<!---$(function() {
		$('##sortable#ATTRIBUTES.sort_id#').sortable(
			{
			update: function(event, ui) 
				{					
					$('##serialize#ATTRIBUTES.sort_id#').val($("##sortable#ATTRIBUTES.sort_id#").sortable("serialize"));
				} 			
			});

		$('##sortable#ATTRIBUTES.sort_id#').disableSelection();
	});--->
	
	$(function(){
		//AJAX submit
		$('##sort_form_#HTMLEditFormat(val(ATTRIBUTES.sort_id))#').submit(function() { 
			//alert('Submitted' + $(this).attr("id"));
			$(this).ajaxSubmit(submitOptions#ATTRIBUTES.sort_id#);
			return false;
			});
	});
		
		//Parameters for ajaxSubmit
		var submitOptions#ATTRIBUTES.sort_id# = {
		target: '##sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_result',
		beforeSubmit:showProcessing#HTMLEditFormat(val(ATTRIBUTES.sort_id))#,
		success: hideProcessing#HTMLEditFormat(val(ATTRIBUTES.sort_id))#,
		type:'post',
		url: '/site_modules/assessment/act_passion_survey.cfm'
		};
	
		function showProcessing#ATTRIBUTES.sort_id#() {

			$(".sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_wrapper").fadeOut(500);
		} 
	
		function hideProcessing#ATTRIBUTES.sort_id#() {
		   $("##processingMessage").addClass("hideElement");
		   setTimeout(function() {
		   $("##sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_result").fadeIn(500);
			}, 500); 
		}
		
		$('.retake#ATTRIBUTES.sort_id#').click(
			function(){
				$(".retake#HTMLEditFormat(val(ATTRIBUTES.sort_id))#").hide();
				$(".sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_wrapper").fadeIn(500);
			}
		);
</script>
</cfoutput>