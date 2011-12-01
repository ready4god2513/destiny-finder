
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to retrieve the listing of features. Creates the search header and filters according to the search parameters that are passed. Called by feature.list|search as well as numerous category template pages --->

<!--- Searches by... --->

<cfparam name="attributes.category_id" default="">
<cfparam name="attributes.search_string" default="">
<cfparam name="attributes.title" default="">
<cfparam name="attributes.all_words" default="1">
<cfparam name="attributes.new" default="0">

<cfif Session.User_ID>
	<cfset key_loc = ListContainsNoCase(session.userPermissions,'contentkey_list',';')>
	<cfif key_loc>
		<cfset accesskeys = ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^')>
		<cfset accesskeys = ListAppend(accesskeys,'0')>
	</cfif>
</cfif>
<cfparam name="accesskeys" default="0">

<!--- remove any non-alphanumeric or non-space characters --->
<cfset search_string = Trim(sanitize(attributes.search_string))>
<cfset attributes.title = Trim(sanitize(attributes.title))>


<!--- create search results header --->
<cfparam name="GetCat.Name" default="all articles">
<cfset searchheader = "">
<cfif Len(search_string)>
	<cfset searchheader = "#searchheader# containing ""<b>#search_string#</b>""">
</cfif>
<cfif Len(attributes.title)>
	<cfset searchheader = "#searchheader# with a title or author like ""<b>#attributes.title#</b>""">
</cfif>
	
<cftry>
	<!--- find features --->
	<cfquery name="qry_Get_Features" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT *
	FROM #Request.DB_Prefix#Features F
	
	<cfif not (isdefined("attributes.Feature_searchsubmit") and not Len(trim(searchheader)))>
		<cfif Len(attributes.category_id)>, Feature_Category FC</cfif> 
		WHERE 
		<cfif Len(attributes.category_id)>F.Feature_ID = FC.Feature_ID 
		AND FC.Category_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.category_id#"> AND</cfif>	
		AccessKey IN (#accesskeys#) AND	
		
		NOT EXISTS (SELECT C.AccessKey FROM #Request.DB_Prefix#Categories C 
		INNER JOIN #Request.DB_Prefix#Feature_Category FCat ON C.Category_ID = FCat.Category_ID
		 WHERE FCat.Feature_ID = F.Feature_ID
		AND (C.Display = 0 OR (
			C.AccessKey IS NOT NULL AND C.AccessKey <> 0 AND C.AccessKey NOT IN (#accesskeys#)) ) ) AND
		
		<cfif len(attributes.search_string)>
			<cfinclude template="../customtags/safesearch.cfm"> AND
		</cfif>
		<cfif attributes.new is 1>Highlight = 1 AND</cfif> 
		<cfif len(attributes.title)>
			(Name LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.title#%">
			OR Short_Desc LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.title#%">
			OR Author LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.title#%">) 
			AND
		</cfif>
		Display = 1 AND 
		Approved = 1
		AND (Start <= #createODBCdate(now())# OR Start is null)
		AND (Expire >= #createODBCdate(now())# OR Expire is null)
		<cfif isDefined("alphasearch") AND alphasearch IS NOT "All">
			<cfif alphasearch IS "Num">
			AND ( Name Like '1%' OR Name Like '2%' OR Name Like '3%' OR Name Like '4%' 
			OR Name Like '5%' OR Name Like '6%' OR Name Like '7%' OR Name Like '8%' 
			OR Name Like '9%' OR Name Like '0%')
			<cfelse>
			AND Name Like <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#alphasearch#%">
			</cfif>
		</cfif>
	<cfelse>
		WHERE 1 = 0 
	</cfif>
	ORDER BY Priority, Created DESC, Name
	</cfquery>
	
	<cfset searchheader = "<b>#GetCat.Name#</b> #searchheader#">

<cfcatch type="Any">
	<!--- Return an empty query --->
	<cfset qry_Get_Features = QueryNew('Feature_ID')>
	<cfset searchheader = "this search">
</cfcatch>
</cftry>





