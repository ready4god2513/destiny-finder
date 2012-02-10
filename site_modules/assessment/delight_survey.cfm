<cfset delightSurvey = CreateObject("component","cfcs.delight") /> 

<cfif isDefined("FORM.aptitudes") AND isDefined("FORM.delights")>
	<cfset delightSurvey.insertRecord(user_id = REQUEST.user_id, aptitudes = FORM.aptitudes, delights = FORM.delights)>
	<cfinclude template="../delight_survey/results.cfm" />
<cfelse>
	<cfinclude template="../delight_survey/test.cfm" />
</cfif>