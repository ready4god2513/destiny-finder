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
	<cfset qAssessments = objAssessments.retrieve_assessments(user_id="#REQUEST.user_id#")>
	<!---<cfset qResults = objAssessments.retrieve_result(user_id="#REQUEST.user_id#")>--->
	<cfset qInvites = objAssessments.retrieve_invites(user_id="#REQUEST.user_id#")>
	<cfset VARIABLES.memberships = objAssessments.retrieve_membership(user_id="#REQUEST.user_id#")>

	<cfoutput>
	<div class="user_greeting">
		Welcome, #HTMLEditFormat(qUser.user_first_name)# #HTMLEditFormat(qUser.user_last_name)# <br /><a href="index.cfm?page=user&edit=1">Edit Your Account Profile</a>
	</div>
	
	<div class="assessment_wrapper">
	<h2>Your Available Assessments</h2>
	<!---<ul>
		<li class="assessment_list_title">Free Assessments</li>--->
	<ul>
	<cfloop query="qAssessments">
    <br />
		<li class="assessment_list_title">#HTMLEditFormat(qAssessments.assessment_name)#<a class="results_button" href="index.cfm?page=assessment&assessment_id=#HTMLEditFormat(val(qAssessments.assessment_id))#&gift_type_id=#HTMLEditFormat(val(qAssessments.gift_type_id))#" style="color:white;"><cfif isDefined("qAssessments.result_id") AND Len(qAssessments.result_id) GT 0>RETAKE<cfelse>TAKE SURVEY</cfif></a> <a class="results_button" href="index.cfm?page=viewresult&assessment_id=#HTMLEditFormat(val(qAssessments.assessment_id))#&gift_type_id=#HTMLEditFormat(val(qAssessments.gift_type_id))#" style="color:white;">RESULT</a></li><br />
	</cfloop>	
	<!---</ul><br /><hr />
		<li class="assessment_list_title">Purchased Assessments</li>--->
	<!---<ul>--->
	<cfif ArrayLEN(VARIABLES.memberships) GT 0>
		<cfset VARIABLES.membership_list = "">
		<cfloop from="1" to="#ArrayLen(VARIABLES.memberships)#" index="i">
			<cfset VARIABLES.membership_list = ListAppend(VARIABLES.membership_list,"#VARIABLES.memberships[i].id#")>
		</cfloop>
		<cfset qPaidAssessments = objAssessments.retrieve_assessments(memberships="#VARIABLES.membership_list#")>
		<cfloop query="qPaidAssessments">
        <br />
			<li class="assessment_list_title">#HTMLEditFormat(qPaidAssessments.assessment_name)#<a class="take_survey" href="index.cfm?page=assessment&assessment_id=#val(qPaidAssessments.assessment_id)#" style="color:white;">TAKE SURVEY</a></li>
		</cfloop>	
	<cfelse>
			<li class="assessment_list_title">- NO PURCHASED SURVEYS -</li>
	</cfif>
	</ul><br />
    <hr />
	</ul>
	</div>
	
	<!---<div class="result">
		<h2>Invites:</h2>
		<ul>
			<cfif qInvites.recordcount GT 0>
				<cfloop query="qInvites">
					<li>#qInvites.invite_first_name# #qInvites.invite_last_name#
					</li>
				</cfloop>
			<cfelse>
				<li>- No Invites Have Been Sent -</li>
			</cfif>
		</ul>
		<a href="index.cfm?invite=1">Add Invite</a>
	</div>--->
</cfoutput>
</cfif>