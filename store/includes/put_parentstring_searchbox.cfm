
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used for search forms --------->
<cfparam name="attributes.separator" default="&##149;">
<cfset ParentStringSearch = "">

<cfif isDefined("root_category")>
	<cfset loop_start = ListFind(GetCat.ParentIDs,evaluate(root_category))>
<cfelse>
	<cfset loop_start = 1>
</cfif>

<!--- Change the 0 below to adjust when the parent categories show up --->
<cfif Listlen(Trim(GetCat.ParentIDs)) GT 0>

<cfif loop_start gt 0>
<cfloop index="num" from="#loop_start#" to="#Listlen(Trim(GetCat.ParentIDs))#">

<cfset ParentStringSearch = ListAppend(ParentstringSearch, "<a href=""javascript^DoCatSearch('", ":")>
<cfset ParentStringSearch = ParentstringSearch & ListGetAt(Trim(GetCat.ParentIDs), num) & "')"">">
<cfset ParentStringSearch = ParentstringSearch & ListGetAt(GetCat.ParentNames, num, ":")>
<cfset ParentStringSearch = ParentstringSearch & "</a>">

</cfloop>
</cfif>

<cfset ParentStringSearch = ParentstringSearch & ":<a href=""javascript^DoCatSearch('#getcat.category_id#')"">#getcat.name#</a>">
<cfset ParentStringSearch = Replace(ParentStringSearch, ":", " #attributes.separator# ", "ALL")>
<cfset ParentStringSearch = Replace(ParentStringSearch, "^", ":", "ALL")>
</cfif>



