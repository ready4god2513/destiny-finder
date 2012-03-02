<cfset objQueries = CreateObject("component","cfcs.queries")>
<cfset objAssessments = CreateObject("component","cfcs.assessment")>
<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>
<cfset qAssessments = objAssessments.retrieve_assessments()>
<cfset qResults = objAssessments.retrieve_result(user_id="#REQUEST.user_id#")>
<cfset qInvites = objAssessments.retrieve_invites(user_id="#REQUEST.user_id#")>
<cfset VARIABLES.memberships = objAssessments.retrieve_membership(user_id="#REQUEST.user_id#")>

<cfoutput>
	<div class="result">
        <cfif isDefined('URL.invite')>
        	<cfmodule template="/site_modules/assessment/invite.cfm">
        <cfelse>
            <p><a href="index.cfm?page=invmod&amp;assessment_id=1&amp;gift_type_id=1&amp;invite=1" class="btn btn-info">Add Invite</a></p>
			<cfif qInvites.recordcount GT 0>
				<table class="table table-striped table-bordered table-condensed">
					<tr>
						<th>Name</th>
						<th>Email</th>
						<th>Result</th>
					</tr>
					<cfloop query="qInvites">
						<cfset qIResult = objAssessments.retrieve_result(user_id="#REQUEST.user_id#",invite="#HTMLEditFormat(qInvites.invite_uid)#")>
						<tr>
							<td>#HTMLEditFormat(qInvites.invite_first_name)# #HTMLEditFormat(qInvites.invite_last_name)#</td>
							<td>#qInvites.invite_email#</td>
							<td><a href="/profile/?page=viewresult&amp;assessment_id=#qIResult.assessment_id#&amp;gift_type_id=1&amp;result_id=#qIResult.result_id#">#objAssessments.compile_results(user_id="#REQUEST.user_id#",invite="#qInvites.invite_uid#")#</a></td>
						</tr>
					</cfloop>
				</table>
			<cfelse>
				- No Invites Have Been Sent -
			</cfif>

    	</cfif>
	</div>

</cfoutput>