<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from the users.email circuit this template processses the email address update form. --->

<cfparam name="attributes.xfa_success" default="#self#?fuseaction=users.manager">

<cfset attributes.Message="">

<!--- Make sure required fields are not blank --->
<cfif len(attributes.verify) AND len(attributes.email)>

	<!--- check that email address has correct syntax --->
	<cfmodule template="../../customtags/form/validate_email.cfm" email="#attributes.email#">

	<cfif ok><!--- (response variable from validate_email) --->

	<!--- check addresses are same --->
	<cfif attributes.email is attributes.Verify>

		<!--- Check if email already exists as a username for another user --->
		<cfquery name="FindName" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
		SELECT User_ID FROM #Request.DB_Prefix#Users 
		WHERE Email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.email#">
		AND User_ID <> <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">
		</cfquery>

		<!--- If email not already in use, update user record --->
		<cfif NOT FindName.Recordcount>
		
			<cfif get_User_Settings.EmailAsName>
				<cfset attributes.username = attributes.email>
			<cfelse>
				<cfset attributes.username = "">
			</cfif>
			
			<cfset attributes.UID = Session.User_ID>
			<cfset attributes.EmailIsBad = 0>
			<cfset attributes.EmailLock = "">
			<cfset attributes.password = "">
			<cfset attributes.edittype = "email">
	
			<!--- update the user account --->
			<cfset Application.objUsers.UpdateUser(argumentcollection=attributes)>

			<cfif get_User_Settings.UseEmailConf>
				<cfinclude template="../qry_get_user.cfm">
				<cfinclude template="../act_email_conf.cfm">
			</cfif>
			
			<cfinclude template="../act_set_registration_permissions.cfm">

			<cflocation url="#attributes.xfa_success##Request.Token2#" addtoken="no">
		
		<cfelse>
			<cfset attributes.Message = "This username is already in use!">
		</cfif>
				
	<cfelse>
		<cfset attributes.Message = "You entered two different email addresses!">
	</cfif>

<cfelse>
	<cfset attributes.Message = "Invalid email address.">
</cfif>

<cfelse>
	<cfset attributes.Message = "Please fill out all the required fields.">
</cfif>
		