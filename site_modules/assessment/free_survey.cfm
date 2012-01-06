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
	<!---<cfset qInvites = objAssessments.retrieve_invites(user_id="#REQUEST.user_id#")>--->
	<cfset VARIABLES.memberships = objAssessments.retrieve_membership(user_id="#REQUEST.user_id#")>
	
    <cfparam name="qUser.user_first_name" default="">	
	<cfparam name="qUser.user_last_name" default="">	
	<cfparam name="qUser.user_email" default="">	
	<cfparam name="qUser.user_address1" default="">	
	<cfparam name="qUser.user_address2" default="">	
	<cfparam name="qUser.user_city" default="">	
	<cfparam name="qUser.user_state" default="">	
	<cfparam name="qUser.user_zip" default="">	
	<cfparam name="qUser.user_phone" default="">	
	<cfparam name="qUser.user_image" default="">	
	<cfparam name="qUser.user_description" default="">	
	<cfparam name="qUser.user_store_id" default="">	
	
	<!---<cfdump var="#qResults#">--->
	<div class="assessment_wrapper box">
	<h2>Your Available Surveys:</h2>
	<ul>
		<li class="assessment_list_title"><strong>Free Survey</strong></li>
		<ul>
	<cfloop query="qAssessments">
		<li><a href="index.cfm?page=assessment&assessment_id=#qAssessments.assessment_id#">#qAssessments.assessment_name#</a></li>
	</cfloop>	
	</ul>
		<li><strong>Purchased Surveys</strong></li>
	<ul>
	<cfif ArrayLEN(VARIABLES.memberships) GT 0>
		<cfset VARIABLES.membership_list = "">
		<cfloop from="1" to="#ArrayLen(VARIABLES.memberships)#" index="i">
			<cfset VARIABLES.membership_list = ListAppend(VARIABLES.membership_list,"#VARIABLES.memberships[i].id#")>
		</cfloop>
		<cfset qPaidAssessments = objAssessments.retrieve_assessments(memberships="#VARIABLES.membership_list#")>
		<cfloop query="qPaidAssessments">
			<li><a href="index.cfm?page=assessment&assessment_id=#qPaidAssessments.assessment_id#">#qPaidAssessments.assessment_name#</a></li>
		</cfloop>	
	<cfelse>
			<li>- You've not purchased any surveys -</li>
	</cfif>
	</ul>
	</ul>
	</div>
	<!---<br />
	<div class="result">
		<h2>Invite A Friend</h2>
        <br />
        Have your friends do the survey about you. This will give you valuable additional feedback.<br /><br />
		<a href="index.cfm?invite=1">Send an invite</a>
        <br /><br />Active Invitations<br />
		<ul>
			<cfif qInvites.recordcount GT 0>
				<cfloop query="qInvites">
					<li>#qInvites.invite_first_name# #qInvites.invite_last_name#
						<br/>
						<cfset qIResult = objAssessments.retrieve_result(user_id="#REQUEST.user_id#",invite="#qInvites.invite_uid#")>
						<!---<cfdump var="#qIResult#">--->
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
		<h2>Survey Results: ###qResults.result_id#</h2>
		#objAssessments.process_results(result_id="#qResults.result_id#")#
		</div>
	</cfloop>--->
	
	<!---<div class="result">
		<h2>Compiled Results</h2>
		#objAssessments.compile_results(user_id="#REQUEST.user_id#")#
	</div>--->