
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to create the string of parent category names. These are used to create the various breadcrumb trails. Called from act.categories.cfm and act_update_children.cfm --->

<cfset CatIDs = "">
<cfset CatNames = "">
<cfset Parent = Parent_ID>

<cfloop condition="Parent GT 0">
<cfset CatIDs = ListPrepend(CatIDs, Parent)>

<cfquery name="GetParent" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
SELECT Name, Parent_ID
FROM #Request.DB_Prefix#Categories
WHERE Category_ID = #Parent#
</cfquery>

<cfset CatNames = ListPrepend(CatNames, GetParent.Name, ":")>
<cfset Parent = GetParent.Parent_ID>
</cfloop>



