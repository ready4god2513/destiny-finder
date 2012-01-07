<cfset objQueries = CreateObject("component","cfcs.queries")>
<cfset objAssessments = CreateObject("component","cfcs.assessment")>
<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>
<cfset qAssessments = objAssessments.retrieve_assessments()>
<cfset qResults = objAssessments.retrieve_result(user_id="#REQUEST.user_id#")>
<cfset qInvites = objAssessments.retrieve_invites(user_id="#REQUEST.user_id#")>
<cfset VARIABLES.memberships = objAssessments.retrieve_membership(user_id="#REQUEST.user_id#")>


<cfloop query="qResults">
    <div class="result">
    <cfoutput>
    <h3>#HTMLEditFormat(qResults.result_id)#</h3>
    <!---#objAssessments.process_results(result_id="#qResults.result_id#")#--->
	</cfoutput>
    </div>
</cfloop>