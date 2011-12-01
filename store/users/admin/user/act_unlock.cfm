
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Marks the email for a user record as "Verified". Called by fuseaction users.admin&user=unlock. --->

<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Users
	SET EmailIsBad = 0, 
	EmailLock = 'verified'
	WHERE User_ID = #attributes.uid#
	</cfquery>

<cfinclude template="../../act_set_registration_permissions.cfm">
	

