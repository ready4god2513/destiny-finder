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
	<h4>Your Available Surveys:</h4>
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