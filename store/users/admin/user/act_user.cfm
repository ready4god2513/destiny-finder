	
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for users: add, update, delete.
Called by users.admin&user=act --->

<cfset attributes.error_message = "">

<cfif Submit is not "Delete">

	<!--- Username must be unique, check if already exists --->
	<cfquery name="FindName" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
	SELECT User_ID FROM #Request.DB_Prefix#Users 
	WHERE Username = '#attributes.username#'
	</cfquery>

	<cfif NOT FindName.Recordcount OR FindName.User_ID is attributes.uid>
			
		<!--- Check if email address already exists --->
		<cfquery name="FindEmail" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
		SELECT User_ID FROM #Request.DB_Prefix#Users 
		WHERE Email = '#attributes.email#'
		</cfquery>

		<cfif FindEmail.Recordcount AND FindEmail.User_ID is not attributes.uid>
			<cfset attributes.Error_Message = "This email has already been registered.">
			
		<!--- Make sure not changing the admin user and in demo mode --->
		<cfelseif Request.DemoMode AND attributes.uid IS 1>
			<cfset attributes.Error_Message = "The admin user cannot be modified while in demo mode!">	
		</cfif>

	<cfelse>
		<cfset attributes.Error_Message = "This username is already in use!">		
	</cfif>	

</cfif>

	
<cfif NOT len(attributes.Error_Message)>

	<cfswitch expression="#mode#">
		<cfcase value="i">
		
			<!--- Add New User --->
			<cfset attributes.admin = "yes">	
			<cfset user_id = Application.objUsers.AddUser(argumentcollection=attributes)>
				
			<cfset attributes.uid = user_id>
			<cfset attributes.message = "User Added!">
			
			<cfinclude template="act_set_registration_permissions.cfm">		
			
		</cfcase>
				
		<cfcase value="u">
			<!--- Delete User. Admin user can not be deleted. --->
			<cfif submit is "Delete">
			
				<cfif attributes.uid is "1">	
					<cfset attributes.error_message = "You cannot delete the main admin user.">
				<cfelse>
					<cfinclude template="act_delete_user.cfm">
				</cfif>
									
			<cfelse>
			<!--- Update User --->
			
				<cfset attributes.admin = "yes">
				<cfset attributes.edittype = "admin">				
				<cfset Application.objUsers.UpdateUser(argumentcollection=attributes)>

				<cfinclude template="act_set_registration_permissions.cfm">
	
			</cfif>
		
		</cfcase>
				
	</cfswitch>
</cfif>	

<!--- update admin menu  --->
<cfset attributes.admin_reload = "usercount">


		