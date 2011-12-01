
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template sets the Registration permissions for a user. It is called when a user record is created or updated. The information is used by secure.cfm for user validations.

	User.Permissions.Registration:
		1 - email not known to be bad	
		2 - email address confirmed		
		4 - customer record exits
		8 - account record exists
		16 - birthdate is over 18	
		32 - cc validated
--->

<!--- Get User --->	
<cfif NOT isDefined("qry_get_user")>
<cfinclude template="qry_get_user.cfm">
</cfif>

<cfset User_Permissions = qry_get_user.permissions>


<!--- Find Registration Key in user.Permission & Delete it --->	
<cfset listindex = listContains(User_Permissions, "registration", ";")>
	
	<cfif listindex is not 0>
		<cfset User_Permissions = "#ListDeleteAt(User_Permissions, listindex, ';')#">
	</cfif>
	
<!--- Create New Registration Key Value --->	
<cfset key_Value = 0>
	
	<!--- 1 - email not known to be bad	 --->
	<cfif qry_get_user.EmailIsBad is 0>
		<cfset key_Value = key_Value + 1>
	</cfif>
	
	<!--- 2 - email address confirmed --->
	<cfif not len(qry_get_user.EmailLock) or qry_get_user.EmailLock is "verified">
		<cfset key_Value = key_Value + 2>
	</cfif>
	
	<!--- 4 - customer record exits --->
	<cfif qry_get_user.customer_id neq '' and qry_get_user.customer_id neq 0>
		<cfset key_Value = key_Value + 4>
	</cfif>

	<!--- 8 - account record exists --->
	<cfif qry_get_user.account_id neq ''>
		<cfset key_Value = key_Value + 8>
	</cfif>
	
	<!--- 16 - birthdate is over 18	 --->
	<cfif len(qry_get_user.birthdate) and dateadd('YYYY', 18, qry_get_user.birthdate) lt now()>
		<cfset key_Value = key_Value + 16>
	</cfif>
	
	<!--- 32 - cc validated - CardisValid is yes and credit card has not expired --->
	<cfif len(qry_get_user.cardexpire) and datecompare(qry_get_user.cardexpire,now(),'m') is 1>
		<cfset key_Value = key_Value + 32>
	</cfif>

	
<cfset User_Permissions = "#listAppend(User_Permissions, 'registration^' & key_value ,';' )#">


<!--- update User table with new permission --->
<cfquery name="Update_permissions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" >
	UPDATE #Request.DB_Prefix#Users
	SET Permissions = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#user_permissions#">
	WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
</cfquery>


<!--- ========== RESET SESSION USER PERMISSIONS ========== --->
<cfinclude template="qry_get_user.cfm">
<cfinclude template="login/act_set_login_permissions.cfm">

