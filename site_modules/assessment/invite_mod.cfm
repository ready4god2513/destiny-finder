<cfset objQueries = CreateObject("component","cfcs.queries")>
<cfset objAssessments = CreateObject("component","cfcs.assessment")>
<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>
<cfset qAssessments = objAssessments.retrieve_assessments()>
<cfset qResults = objAssessments.retrieve_result(user_id="#REQUEST.user_id#")>
<cfset qInvites = objAssessments.retrieve_invites(user_id="#REQUEST.user_id#")>
<cfset VARIABLES.memberships = objAssessments.retrieve_membership(user_id="#REQUEST.user_id#")>

<cfoutput>
	<div class="result">
		<h2>Invite A Friend:</h2>
        <cfif isDefined('URL.invite')>
        	<cfmodule template="/site_modules/assessment/invite.cfm">
        <cfelse>
            <p><a href="index.cfm?page=invmod&assessment_id=1&gift_type_id=1&invite=1">Add Invite</a></p>
            
                <cfif qInvites.recordcount GT 0>
                	<table>	
                    	<tr>
                        	<td width="30%"><strong>Name</strong></td>
                            <td width="70%"><strong>Result</strong></td>
                        </tr>
                    <cfloop query="qInvites">
                    	<cfset qIResult = objAssessments.retrieve_result(user_id="#REQUEST.user_id#",invite="#HTMLEditFormat(qInvites.invite_uid)#")>
                        <tr>
                        	<td>#HTMLEditFormat(qInvites.invite_first_name)# #HTMLEditFormat(qInvites.invite_last_name)#</td>
                            <td>#objAssessments.compile_results(user_id="#REQUEST.user_id#",invite="#qInvites.invite_uid#")#</td>
                        </tr>
                        
                        
                    </cfloop>
                    </table>
                <cfelse>
                    - No Invites Have Been Sent -
                </cfif>

    	</cfif>
	</div>

</cfoutput>