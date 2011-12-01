
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is used to unblock an account that has been locked due to maximum failed logins or too many logins for the day. Called by fuseaction users.admin&user=unblock. --->

<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE Users
	SET FailedLogins = 0,
	LastAttempt = #CreateODBCDateTime(now())#,
	LoginsDay = 1
	WHERE User_ID = #attributes.uid#
	</cfquery>


	

