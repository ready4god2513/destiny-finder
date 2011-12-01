
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- gets both direct and related categories for a given parent_ID. --->

<!--- Called by category.display and category.subcatmenu --->

<!--- Also used by a variety of admin pages to retrieve subcategories while browsing the store categories on the list pages --->

<cfparam name="attributes.parent_id" default="0">
<cfparam name="attributes.subcatkey" default="">
<cfparam name="all" default="0">

<cfquery name="request.qry_get_subcats" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT A.Sm_Image, A.Sm_Title, A.Short_Desc, A.Category_ID, A.Name, A.Highlight, A.Sale, A.ParentIDs, A.Priority
FROM #Request.DB_Prefix#Categories A
WHERE Parent_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.parent_id#">
		<cfif len(attributes.subcatkey)>
		AND A.AccessKey = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.subcatkey#">
		</cfif>
		<cfif not all>AND Display= 1</cfif>
ORDER BY Priority, Name
</cfquery>

<cfset numlist= request.qry_get_subcats.recordcount>



