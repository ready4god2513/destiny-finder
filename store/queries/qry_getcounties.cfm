
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This query retrieves the list of counties. --->

<cfquery name="GetCounties" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" 
cachedwithin="#Request.Cache#">
SELECT DISTINCT Name, State FROM #Request.DB_Prefix#Counties
ORDER BY State, Name
</cfquery>



