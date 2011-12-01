
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfset ParentStringSearch = "">

<cfif isDefined("root_category") and root_category is not 0>
	<cfset loop_start = #ListFind(request.qry_get_cat.ParentIDs,root_category)#>
<cfelse>
	<cfset loop_start = 1>
</cfif>

<!--- Change the 0 below to adjust when the parent categories show up --->
<cfif Listlen(Trim(request.qry_get_cat.ParentIDs)) GT 0>
<cfif loop_start gt 0>
<cfloop index="num" from="#loop_start#" to="#Listlen(Trim(request.qry_get_cat.ParentIDs))#">

<cfif ListGetAt(Trim(request.qry_get_cat.ParentIDs), num) is not root_category>
	<cfset ParentStringSearch = ListAppend(ParentstringSearch, "<a href=""javascript^DoCatSearch('", ":")>
	<cfset ParentStringSearch = ParentstringSearch & ListGetAt(Trim(request.qry_get_cat.ParentIDs), num) & "')"">">
</cfif>

<cfset ParentStringSearch = ParentstringSearch & ListGetAt(request.qry_get_cat.ParentNames, num, ":")>

<cfif ListGetAt(Trim(request.qry_get_cat.ParentIDs), num) is not root_category>
	<cfset ParentStringSearch = ParentstringSearch & "</a>">
</cfif>

</cfloop>
</cfif>

<!--- original - the changed section below removes root link ----------->
<cfset ParentStringSearch = ParentstringSearch & ":<a href=""javascript^DoCatSearch('#request.qry_get_cat.category_id#')"" class=""cat_text_list"">#request.qry_get_cat.name#</a>">

<!------------ 
<cfif request.qry_get_cat.category_id is not root_category>
<cfset ParentStringSearch = ParentstringSearch & ":<a href=""javascript^DoCatSearch('#request.qry_get_cat.category_id#')"">">
</cfif>

<cfset ParentStringSearch = ParentstringSearch & request.qry_get_cat.name>

<cfif request.qry_get_cat.category_id is not root_category>
<cfset ParentStringSearch = ParentstringSearch & "</a>">
</cfif>

end change ---------->


<cfset ParentStringSearch = Replace(ParentStringSearch, ":", " . ", "ALL")>
<cfset ParentStringSearch = Replace(ParentStringSearch, "^", ":", "ALL")>


<cfelse><!--- this category has no parent IDs ---->

<cfif ParentStringSearch is "">


<cfif request.qry_get_cat.category_id is not root_category>
<cfset ParentStringSearch = ParentstringSearch & ":<a href=""javascript^DoCatSearch('#request.qry_get_cat.category_id#')"" class=""cat_text_list"">">
</cfif>

<cfset ParentStringSearch = ParentstringSearch & request.qry_get_cat.name>

<cfif request.qry_get_cat.category_id is not root_category>
<cfset ParentStringSearch = ParentstringSearch & "</a>">
</cfif>

</cfif>

</cfif>



