
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
	<!---<cfset qResults = objAssessments.retrieve_result(user_id="#REQUEST.user_id#")>--->
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
    
	  <cfoutput>
        
    
    
    <div class="user_greeting">
            <h2>Account - #HTMLEditFormat(qUser.user_first_name)# #HTMLEditFormat(qUser.user_last_name)#</h2>
            
            <a href="/profile/index.cfm?page=user&edit=1">Edit Profile</a>
          <table style="border:none;background-color:transparent;">
          <tr>
              <td class="form_label" width="1%">First&nbsp;Name:&nbsp;</td>
              <td width="99%">#HTMLEditFormat(qUser.user_first_name)#</td>
		  </tr>
		  <tr>
			  <td class="form_label">Last&nbsp;Name:&nbsp;</td>
			  <td>#HTMLEditFormat(qUser.user_last_name)#</td>
		  </tr>
		  <tr>
			  <td class="form_label">Email&nbsp;Address:&nbsp;</td>
			  <td>#HTMLEditFormat(qUser.user_email)#</td>
		  </tr>
          <tr>
          	  <td height="99%">&nbsp;</td>
		  </table>
    </div><!--- END class="user_greeting"--->
   
	  </cfoutput>
</cfif>