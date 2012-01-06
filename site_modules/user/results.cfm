
<cfif REQUEST.user_id EQ 0 AND NOT isDefined('URL.create')>

	<cfmodule template="/site_modules/user/login_box.cfm" >

<cfelseif isDefined('URL.create') OR isDefined('URL.edit')>

	<cfmodule template="/site_modules/user/user_profile.cfm">

<cfelseif isDefined('URL.invite')>
	
	<cfmodule template="/site_modules/user/invite.cfm">

<cfelseif REQUEST.user_id GT 0>
	
	<cfset objQueries = CreateObject("component","cfcs.queries")>
	<cfset objAssessments = CreateObject("component","cfcs.assessment")>
	<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>
	<cfset qAssessments = objAssessments.retrieve_assessments()>
	<cfset qResults = objAssessments.retrieve_result(user_id="#REQUEST.user_id#")>
	<cfset qInvites = objAssessments.retrieve_invites(user_id="#REQUEST.user_id#")>
	<cfset VARIABLES.memberships = objAssessments.retrieve_membership(user_id="#REQUEST.user_id#")>

	<cfoutput>
	<div class="user_greeting">
		Welcome, #HTMLEditFormat(qUser.user_first_name)# #HTMLEditFormat(qUser.user_last_name)# <a href="index.cfm?page=user&edit=1">Edit Your Account Profile</a>
	</div>
	
	<!---<cfdump var="#qResults#">--->
	<div class="assessment_wrapper box">
	<strong>Your Available Assessments:</strong>
	<ul>
		<li class="assessment_list_title"><strong>Free Assessments</strong></li>
		<ul>
	<cfloop query="qAssessments">
		<li><a href="index.cfm?page=assessment&assessment_id=#HTMLEditFormat(val(qAssessments.assessment_id))#">#HTMLEditFormat(qAssessments.assessment_name)#</a></li>
	</cfloop>	
	</ul>
		<li><strong>Purchased Assessments</strong></li>
	<ul>
	<cfif ArrayLEN(VARIABLES.memberships) GT 0>
		<cfset VARIABLES.membership_list = "">
		<cfloop from="1" to="#ArrayLen(VARIABLES.memberships)#" index="i">
			<cfset VARIABLES.membership_list = ListAppend(VARIABLES.membership_list,"#VARIABLES.memberships[i].id#")>
		</cfloop>
		<cfset qPaidAssessments = objAssessments.retrieve_assessments(memberships="#VARIABLES.membership_list#")>
		<cfloop query="qPaidAssessments">
			<li><a href="index.cfm?page=assessment&assessment_id=#HTMLEditFormat(val(qPaidAssessments.assessment_id))#">#HTMLEditFormat(qPaidAssessments.assessment_name)#</a></li>
		</cfloop>	
	<cfelse>
			<li>- No purchased assessments -</li>
	</cfif>
	</ul>
	</ul>
	</div>
	
	<div class="result">
		<h2>Invites:</h2>
		<a href="index.cfm?invite=1">Add Invite</a>
		<ul>
			<cfif qInvites.recordcount GT 0>
				<cfloop query="qInvites">
					<li>#HTMLEditFormat(qInvites.invite_first_name)# #HTMLEditFormat(qInvites.invite_last_name)#
						<br/>
						<cfset qIResult = objAssessments.retrieve_result(user_id="#REQUEST.user_id#",invite="#HTMLEditFormat(qInvites.invite_uid)#")>
						<cfdump var="#qIResult#">
					#objAssessments.compile_results(user_id="#REQUEST.user_id#",invite="#qInvites.invite_uid#")#
					</li>
				</cfloop>
			<cfelse>
				<li>- No Invites Have Been Sent -</li>
			</cfif>
		</ul>
	</div>
	
	<cfloop query="qResults">
		<div class="result">
		<h2>Result: ###HTMLEditFormat(val(qResults.result_id))#</h2>
		#objAssessments.process_results(result_id="#qResults.result_id#")#
		</div>
	</cfloop>
	
	<div class="result">
		<h2>Compiled Results</h2>
		#objAssessments.compile_results(user_id="#REQUEST.user_id#")#
	</div>
	</cfoutput>

</cfif>