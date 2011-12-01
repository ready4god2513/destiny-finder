
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves a list of categories, given the parent ID, which defaults to 0. Used by category.topcatmenu and called by category admin action pages to refresh the cached query.  --->

<cfparam name="attributes.rootcat" default="0" type="numeric">

<cfquery name="qry_get_topcats" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" cachedwithin="#Request.Cache#">
SELECT Sm_Image, Sm_Title, Short_Desc, Category_ID, Name, Highlight, Sale 
FROM #Request.DB_Prefix#Categories
WHERE Parent_ID = #Val(attributes.rootcat)#
AND Display = 1
ORDER BY Priority, Name
</cfquery>



