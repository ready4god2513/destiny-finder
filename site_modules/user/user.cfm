
<cfif REQUEST.user_id EQ 0 AND NOT isDefined('URL.create')>

	<cfmodule template="/site_modules/user/login_box.cfm" >

<cfelseif isDefined('URL.create')>

	<cfmodule template="/site_modules/user/user_profile.cfm">

<cfelseif isDefined('URL.invite')>
	
	<cfmodule template="/site_modules/user/invite.cfm">

<cfelseif REQUEST.user_id GT 0>
	
	<cfset objQueries = CreateObject("component","cfcs.queries")>
	<cfset objAssessments = CreateObject("component","cfcs.assessment")>
	<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>
	<cfset qAssessments = objAssessments.retrieve_assessments()>
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
    
	<cfoutput>
		<h2>Account - #HTMLEditFormat(qUser.user_first_name)# #HTMLEditFormat(qUser.user_last_name)#</h2>

		<cfmodule template="/site_modules/user/user_profile.cfm">
	</cfoutput>
</cfif>