
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This query gets the User Settings --->
<cfquery name="get_User_Settings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1 cachedwithin="#Request.Cache#">
SELECT * FROM #Request.DB_Prefix#UserSettings
</cfquery>


