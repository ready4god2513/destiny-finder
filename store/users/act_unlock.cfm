<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called by users.unlock circuit, this template processes the email verification.--->

<cfparam name="attributes.email" default="">
<cfparam name="attributes.emaillock" default="">

<cfset attributes.Error_Message="">

<cfif Session.User_ID>
	<cfparam name="attributes.xfa_success" default="#self#?fuseaction=users.manager">
<cfelse>
	<cfparam name="attributes.xfa_success" default="">
</cfif>


<!--- Make sure required fields are not blank --->
<cfif len(attributes.emaillock)>

	<!--- Look up the user's email lock code --->
	<cfquery name="FindUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
	SELECT User_ID, EmailLock FROM #Request.DB_Prefix#Users 
	WHERE
	<cfif isdefined("attributes.email") and len(attributes.email)>
		Email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(attributes.email)#">
	<cfelse>
		User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	</cfquery>

	<cfif not FindUser.Recordcount>
		<cfset attributes.Error_Message = "User Not Found">
	
	<cfelseif FindUser.EmailLock is 'verified'>
		<cfset attributes.message= "You have already successfully confirmed your email address.">
		<cfif not Session.User_ID>
			<cfset attributes.message= attributes.message & "\n Please Log In.">
			<cfinclude template="../includes/form_confirmation.cfm">
		</cfif>	
	
	<cfelseif FindUser.EmailLock is not trim(attributes.emaillock)>	
		<cfset attributes.Error_Message = "Incorrect Confirmation Code">	

	<cfelse>
	
		<!--- confirmation message --->	
		<cfset attributes.message= "You have successfully confirmed your email address.">
		<cfif not Session.User_ID>
			<cfset attributes.message= attributes.message & "\n Please Log In.">
		</cfif>
	
		<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Users
		SET EmailIsBad = 0, 
		EmailLock = 'verified'
		WHERE User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#FindUser.user_ID#">
		</cfquery>

		<cfif Session.User_ID IS NOT 0>
		<cfinclude template="act_set_registration_permissions.cfm">
		</cfif>
						
		<cfinclude template="../includes/form_confirmation.cfm">
			
	</cfif>
	
</cfif>
		