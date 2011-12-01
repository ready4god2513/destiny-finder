<cfset objQueries = CreateObject("component","cfcs.queries")>
<cfset objAssessments = CreateObject("component","cfcs.assessment")>
<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>
<cfset qAssessments = objAssessments.retrieve_assessments()>
<cfset qResults = objAssessments.retrieve_result(user_id="#REQUEST.user_id#")>
<cfset qInvites = objAssessments.retrieve_invites(user_id="#REQUEST.user_id#")>
<cfset VARIABLES.memberships = objAssessments.retrieve_membership(user_id="#REQUEST.user_id#")>


<cfloop query="qResults">
    <cfoutput>#objAssessments.process_results(result_id="#qResults.result_id#",assessment_id="#URL.assessment_id#",gift_type_id="#URL.gift_type_id#")#</cfoutput>
</cfloop>
<cfif URL.assessment_id EQ 2>
<div>
<h2>Compiled Results</h2>
<cfset qCombinedResult = ArrayNew(1)>
<cfset qCombinedResult = objAssessments.compile_results(user_id="#REQUEST.user_id#")>
<cfdump var="#qCombinedResult#">
<cfoutput></cfoutput>
</div>
</cfif>