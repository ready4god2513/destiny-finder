
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to retrieve a list of all the categories --->

<!--- Used for the sitemap and verity search --->

<cfquery name="qry_Get_allCats" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Category_ID, Name, Short_Desc, Long_Desc, Metadescription, Keywords
	FROM #Request.DB_Prefix#Categories
	WHERE Display = 1
<cfif isDefined("alphasearch") AND alphasearch IS NOT "All">
	<cfif alphasearch IS "Num">
	AND ( Name Like '1%' OR Name Like '2%' OR Name Like '3%' OR Name Like '4%' 
	OR Name Like '5%' OR Name Like '6%' OR Name Like '7%' OR Name Like '8%' 
	OR Name Like '9%' OR Name Like '0%')
	<cfelse>
	AND Name Like <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#alphasearch#%">
	</cfif>
</cfif>
ORDER BY Name
</cfquery>



