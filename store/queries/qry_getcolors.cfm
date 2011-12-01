
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This query retrieves the colors for a page. --->
<cfparam name="request.color_id" type="numeric" default="0">

<cftry>
<cfquery name="Request.GetColors" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1 cachedwithin="#Request.Cache#">
SELECT * FROM #Request.DB_Prefix#Colors
WHERE Color_ID = 
<cfif request.color_id IS NOT 0>
	#Val(request.color_id)#
<cfelse>
	#Request.AppSettings.color_id#
</cfif>
</cfquery>


<cfcatch type="Database">
	<!--- If the query fails, try resetting the cached data for the site --->
	<cfobjectcache action = "clear" />
</cfcatch>

</cftry>



