<cfset objQueries = CreateObject("component","cfcs.queries")>
<cfset objAssessments = CreateObject("component","cfcs.assessment")>
<cfset qInviteuid = objAssessments.retrieve_invite_userid(invite="#HTMLEditFormat(URL.invite)#") />
<cfset vTempVar = objAssessments.process_results(nodisplay=1,result_id=qInviteuid.result_id, gift_type_id=URL.gift_type_id,assessment_id=1) />
<cfset qResults = objAssessments.retrieve_result(user_id="#qInviteuid.user_id#",invite="#HTMLEditFormat(URL.invite)#") />

<cfoutput>
	<div class="result">
		<cfif qResults.recordcount GT 0>
			<cfset qUser = objQueries.user_detail(user_id="#qResults.user_id#")>        
			<cfset qInvites = objAssessments.retrieve_invites(invite_uid="#HTMLEditFormat(URL.invite)#")>

			<h2>Result For #qUser.user_first_name# #qUser.user_last_name#</h2>
			<p>
				Thanks for taking the survey about your friend.
				The Friends 360 Survey is a short version of the Destiny Survey. 
				It reveals what we call a destiny orientation. It's one's core trait, the basic way a person relates to the world. 
				Your survey results will give your friend valuable feedback.
			</p>
			<p>
				Your friend's Destiny Orientation: 
				<strong>#Trim(objAssessments.compile_results(user_id="#qInviteuid.user_id#",invite="#qInvites.invite_uid#"))#</strong>
			</p>
			<h4>Now What?</h4>
			<p>
				You can find out more about the various destiny orientations in the Resources section.
			</p>
			<p>
				Now that you've done the free survey about your friend, we hope you'll take it for yourself. 
				Get started on your destiny discovery and fulfillment now. It's free and easy!  
				<a href="/profile/?page=assessment&assessment_id=1&gift_type_id=1" class="btn btn-primary">Take the Free Test Today!</a>
			</p>
		</cfif>
	</div>

</cfoutput>
