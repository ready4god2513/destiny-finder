
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This query is used throughout the store to retrieve the settings related to placing orders. It is cached to improve performance so is also called after changing any of the settings to update the cached query.  --->

<cfquery name="get_Order_Settings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1 cachedwithin="#Request.Cache#">
SELECT * FROM #Request.DB_Prefix#OrderSettings
</cfquery>


