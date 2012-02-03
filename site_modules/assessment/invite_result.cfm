<cfset objQueries = CreateObject("component","cfcs.queries")>
<cfset objAssessments = CreateObject("component","cfcs.assessment")>
<cfset qResults = objAssessments.retrieve_result(invite="#HTMLEditFormat(URL.invite)#") />
<cfset objAssessments.process_results(result_id = qResults.result_id) />
<cfset qResults = objAssessments.retrieve_result(invite="#HTMLEditFormat(URL.invite)#") />

<cfoutput>
	<div class="result">
		<cfif qResults.recordcount GT 0>
			<cfset qUser = objQueries.user_detail(user_id="#qResults.user_id#")>        
			<cfset qInvites = objAssessments.retrieve_invites(invite_uid="#HTMLEditFormat(URL.invite)#")>
			<h1>Invite A Friend</h1>

			<h2>You're a good friend #HTMLEditFormat(qInvites.invite_first_name)# #HTMLEditFormat(qInvites.invite_last_name)#</h2>

			<h3>Result For #qUser.user_first_name# #qUser.user_last_name#</h3>
			Your results suggest your friend #qUser.user_first_name# is  		
			#objAssessments.compile_results(user_id="#REQUEST.user_id#",invite="#qInvites.invite_uid#")#.
		</cfif>
		
		<cfif REQUEST.user_id EQ 0>
			<a href="/profile/?page=assessment&amp;assessment_id=1&amp;gift_type_id=1" class="btn primary">Create Your Account Today!</a>
		</cfif>
	</div>

</cfoutput>
