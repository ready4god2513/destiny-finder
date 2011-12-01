
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to perform the SQL search. Called from act_search.cfm --->


<cfparam name="attributes.string" default="">
<cfparam name="attributes.all_words" default="1">

<!--- remove any characters, other than alphanumeric, space or dashes --->
<cfset search_string = Trim(ReReplace(attributes.string, "[^\w+^\s+^\-]", " ", "All"))>

<cfif Session.User_ID>
 	 <cfset key_loc = ListContainsNoCase(session.userPermissions,'contentkey_list',';')>
 	 <cfif key_loc>
  	 	<cfset accesskeys = ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^')>
		<cfset accesskeys = ListAppend(accesskeys,'0')>
  	</cfif>
</cfif>
<cfparam name="accesskeys" default="0">


<cfquery name="GetProducts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Product_ID, Name, Short_Desc, SKU
FROM #Request.DB_Prefix#Products P
WHERE 
 	AccessKey IN (#accesskeys#) 
	AND NOT EXISTS (SELECT C.AccessKey FROM #Request.DB_Prefix#Categories C 
		INNER JOIN #Request.DB_Prefix#Product_Category PCat ON C.Category_ID = PCat.Category_ID
		 WHERE PCat.Product_ID = P.Product_ID
		AND (C.Display = 0 OR (
			C.AccessKey IS NOT NULL AND C.AccessKey <> 0 AND C.AccessKey NOT IN (#accesskeys#)) ) )
	AND
	(Sale_Start IS NULL OR Sale_Start < #createODBCdate(now())#) AND 
	(Sale_End IS NULL OR Sale_End > #createODBCdate(now())#) AND 
	<cfif Request.AppSettings.InvLevel IS NOT "None" AND NOT Request.AppSettings.OutOfStock>
	NumInStock > 0 AND</cfif>
<cfif len(search_string)> (
	<cfset sqltype = "longvarchar">
	<cfset fieldname = "Long_Desc">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset fieldname = "Short_Desc">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset sqltype = "varchar">
	<cfset fieldname = "Name">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset fieldname = "SKU">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset fieldname = "Metadescription">
	<cfinclude template="../customtags/safesearch.cfm"> OR
	<cfset fieldname = "Keywords">
	<cfinclude template="../customtags/safesearch.cfm"> ) AND
</cfif>
	Display = 1 
ORDER BY Name
</cfquery>
		  
<cfquery name="GetCategories" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Category_ID, Name, Short_Desc
FROM #Request.DB_Prefix#Categories
WHERE Display = 1 AND 
AccessKey IN (#accesskeys#) 
<cfif len(search_string)> AND (
	<cfset sqltype = "longvarchar">
	<cfset fieldname = "Long_Desc">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset fieldname = "Short_Desc">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset sqltype = "varchar">
	<cfset fieldname = "Name">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset fieldname = "Metadescription">
	<cfinclude template="../customtags/safesearch.cfm"> OR
	<cfset fieldname = "Keywords">
	<cfinclude template="../customtags/safesearch.cfm"> )
</cfif>
ORDER BY Name
</cfquery>

<cfquery name="GetFeatures" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Feature_ID, Name, Short_Desc
FROM #Request.DB_Prefix#Features F
WHERE AccessKey IN (#accesskeys#) AND
	NOT EXISTS (SELECT C.AccessKey FROM #Request.DB_Prefix#Categories C 
	INNER JOIN #Request.DB_Prefix#Feature_Category FCat ON C.Category_ID = FCat.Category_ID
	 WHERE FCat.Feature_ID = F.Feature_ID
	AND (C.Display = 0 OR (
			C.AccessKey IS NOT NULL AND C.AccessKey <> 0 AND C.AccessKey NOT IN (#accesskeys#)) ) ) AND
<cfif len(search_string)> (
<cfset sqltype = "longvarchar">
	<cfset fieldname = "Long_Desc">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset fieldname = "Short_Desc">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset sqltype = "varchar">
	<cfset fieldname = "Name">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset fieldname = "Author">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset fieldname = "Metadescription">
	<cfinclude template="../customtags/safesearch.cfm"> OR
	<cfset fieldname = "Keywords">
	<cfinclude template="../customtags/safesearch.cfm"> ) AND
</cfif>
Display = 1 
AND Approved = 1
AND (Start <= #createODBCdate(now())# OR Start is null)
AND (Expire >= #createODBCdate(now())# OR Expire is null)
ORDER BY Name
</cfquery>

<cfquery name="GetPages" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Page_ID, Page_Name, PageText, Page_URL
FROM #Request.DB_Prefix#Pages
WHERE Display = 1
AND AccessKey IN (#accesskeys#) 
AND Page_URL <> 'none'
<cfif len(search_string)> AND (
	<cfset sqltype = "longvarchar">
	<cfset fieldname = "PageText">
	<cfinclude template="../customtags/safesearch.cfm"> OR 
	<cfset sqltype = "varchar">
	<cfset fieldname = "Page_Name">
	<cfinclude template="../customtags/safesearch.cfm"> )
</cfif>
ORDER BY Page_Name
</cfquery>

<cfquery name="CountProducts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT COUNT(Product_ID) AS TotalProducts
FROM #Request.DB_Prefix#Products
</cfquery>
		  
<cfquery name="CountCategories" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT COUNT(Category_ID) AS TotalCategories
FROM #Request.DB_Prefix#Categories
</cfquery>
		  
<cfquery name="CountFeatures" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT COUNT(Feature_ID) AS TotalFeatures
FROM #Request.DB_Prefix#Features
</cfquery>

<cfquery name="CountPages" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT COUNT(Page_ID) AS TotalPages
FROM #Request.DB_Prefix#Pages
</cfquery>

<cfset Results = GetProducts.RecordCount + GetCategories.RecordCount + GetFeatures.RecordCount + GetPages.RecordCount>
<cfset Searched = CountProducts.TotalProducts + CountCategories.TotalCategories + CountFeatures.TotalFeatures + CountPages.TotalPages>




