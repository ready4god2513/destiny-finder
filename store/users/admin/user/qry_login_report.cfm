<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Recent Logins --->
<cfquery name="Login_Report" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT User_ID, Username, Email, Created, LastLogin, LoginsTotal, LoginsDay, Disable, EmailLock, EmailIsBad
FROM #Request.DB_Prefix#Users
WHERE LastLogin > #CreateODBCDate(DateAdd('d',-30,now()))#
ORDER BY LastLogin DESC, LoginsDay DESC
</cfquery>

<cfsetting enablecfoutputonly="no">
