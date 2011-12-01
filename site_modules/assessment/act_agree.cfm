<cfset objAssessment = CreateObject("component","cfcs.assessment")> 
	Submitted
	
<cfif FindNoCase('destinyfinder',CGI.HTTP_REFERER)>

	<cfset VARIABLES.result = { gift = FORM.agree_gift, rate = FORM.rate }>
	
	<cfset VARIABLES.item = {
		id = '#FORM.agree_id#',
		type_id = '#FORM.type_id#',
		result = '#SerializeJSON(VARIABLES.result)#'
	}>
		
	<cfoutput>
		#objAssessment.insert_assessment(
			assessment_id="#FORM.assessment_id#",
			item_detail="#VARIABLES.item#",
			user_id="#FORM.user_id#"
			)#
	</cfoutput>
	
</cfif>