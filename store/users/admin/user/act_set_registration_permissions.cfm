
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template sets the Registration permissions for a user. It is called when a user record is created or updated.

	User.Permissions.Registration:
		1 - email not known to be bad	
		2 - email address confirmed		
		4 - cutomer record exits
		8 - account record exists
		16 - birthdate is over 18	
		32 - cc validated
		64 - profile exists
--->

<!--- Get User --->	
<cfquery name="qry_Get_User" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
SELECT U.*, A.Account_ID 
FROM #Request.DB_Prefix#Users U 
LEFT JOIN #Request.DB_Prefix#Account A on A.User_ID = U.User_ID
WHERE U.User_ID = #attributes.UID#
</cfquery>

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
	
	<!--- 4 - cutomer record exits --->
	<cfif qry_get_user.customer_id>
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
	
	<!--- 32 - cc validated --->
	<cfif qry_get_user.CardisValid is 1 AND isDate(qry_get_user.cardexpire) and 			
	datecompare(qry_get_user.cardexpire,now(),'m') is 1>
		<cfset key_Value = key_Value + 32>
	</cfif>
	
	
<cfset User_Permissions = "#listAppend(User_Permissions, 'registration^' & key_value ,';' )#">


<!--- update User table with new permission --->
<cfquery name="Update_permissions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" >
	UPDATE #Request.DB_Prefix#Users
	SET Permissions = '#user_permissions#'
	WHERE User_ID = #attributes.UID#
</cfquery>



<!--- ========== RESET SESSION USER PERMISSIONS ========== --->

<!--- Retrieve User Group info --->
<cfquery name="UserGroup" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
	SELECT Permissions FROM #Request.DB_Prefix#Groups
	WHERE Group_ID = #qry_get_user.Group_ID#
</cfquery>
			

<!--- combine User Permissions & Group Permissions --->
<cfset Keys = StructNew()>
			
<!--- loop through user permissions and put them in keys --->
<cfif len(User_Permissions)>
	<cfloop index="thiskey" list="#User_Permissions#" delimiters=";">	
		<cfset success = StructInsert(keys, listGetAt(thiskey, 1, '^'),listGetAt(thiskey, 2, '^'))>
	</cfloop>
</cfif>

<!--- loop through group permissions and add them to keys --->
<cfif len(UserGroup.permissions)>
					
	<cfloop index="thiskey" list="#UserGroup.permissions#" delimiters=";">
		<cfset thiskey_name = listGetAt(thiskey, 1, '^')>
		
		<cfif listLen(thiskey,'^') is not 1>
			<cfset thiskey_value = listGetAt(thiskey, 2, '^')>
		<cfelse>
			<cfset thiskey_value = 0>
		</cfif>
							
		<cfif StructKeyExists(Keys, thiskey_name)>
			<cfif Right(thiskey_name,4) is "list">
				<cfset newlist = ListAppend(evaluate("Keys." & thiskey_name), thiskey_value)>
				<cfset success = SetVariable("keys." & thiskey_name, newlist)>
			<cfelse>
				<cfset success = SetVariable("keys." & thiskey_name, BitOr(Evaluate("Keys." & thiskey_name), thiskey_value))>
			</cfif>										
		<cfelse>
			<cfset success = StructInsert(keys, thiskey_name, thiskey_value)>
		</cfif>
	</cfloop>
</cfif>
				
	

			