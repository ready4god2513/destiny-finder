
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the main page for retrieving product listings. It is used by the various catcore pages listing products as well as product searches. --->

<!--- Searches by... --->
<cfparam name="numlist" default="0">
<cfparam name="attributes.category_id" default="">

<cfif Session.User_ID>
	<cfset accesskeys = '0,1'>
	<cfset key_loc = ListContainsNoCase(session.userPermissions,'contentkey_list',';')>
	<cfif key_loc>
		<cfset accesskeys = ListAppend(accesskeys,ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^'))>
	</cfif>
</cfif>
<cfparam name="accesskeys" default="0">
<cfparam name="attributes.currentpage" default=1>

<cfparam name="attributes.name" default="">
<cfparam name="attributes.search_string" default="">
<cfparam name="attributes.type" default="">
<cfparam name="attributes.mfg_account_id" default=""><!--- vender ID --->
<cfparam name="attributes.sortby" default="">
<cfparam name="attributes.order" default="">
<cfparam name="attributes.all_words" default="1">

<cfparam name="attributes.availability" default="">
<cfparam name="attributes.onsale" default="0">
<cfparam name="attributes.new" default="0">
<cfparam name="attributes.hot" default="0">
<cfparam name="attributes.notsold" default="0">
<cfparam name="attributes.alphaSearch" default="">
<!--- If search form submitted, make sure to reset these values to new settings --->
<cfif isDefined("attributes.dosearch")>
	<cfset search_fields = "sortby,order,availability,name,search_string">
	<cfloop index="checkfield" list="#search_fields#">
		<cfif StructKeyExists(form,checkfield)>
			<cfset attributes[checkfield] = form[checkfield]>
		</cfif>
	</cfloop>	
	<cfset attributes.currentpage = 1>
</cfif>

<!--- remove any non-alphanumeric or non-space characters --->
<cfset attributes.name = Trim(sanitize(attributes.name))>
<cfset search_string = Trim(sanitize(attributes.search_string))>
<cfset attributes.type = Trim(sanitize(attributes.type))>
<cfset attributes.sortby = Trim(sanitize(attributes.sortby))>
<cfset attributes.order = Trim(sanitize(attributes.order))>
<cfset attributes.availability = Trim(sanitize(attributes.availability))>
<cfset attributes.alphaSearch = Trim(sanitize(attributes.alphaSearch))>

<!--- Undercat allows a product search for products under a specific category ---->
<cfparam name="attributes.UnderCategory_id" default="">

<!--- create search results header --->
<cfif isNumeric(attributes.mfg_account_id)>
	<cfset qry_Account = Application.objUsers.GetAccount(attributes.mfg_account_id)>
	<cfif NOT isDefined("request.qry_get_cat.Name")>
		<cfset request.qry_get_cat.Name = qry_Account.Account_Name>
	</cfif>
</cfif>

<!--- If not set yet, create this variable --->
<cfparam name="request.qry_get_cat.Name" default="All Products">

<cfset searchheader = "">
<cfif Len(attributes.type)>
	<cfset searchheader = "#searchheader# that are ""<b>#attributes.type#</b>""">
</cfif>

<cfif Len(attributes.name)>
	<cfset searchheader = "#searchheader# with a name like ""<b>#attributes.name#</b>""">
</cfif>

<cfif Len(attributes.alphasearch)>
	<cfset searchheader = "#searchheader# with a name starting with ""<b>#attributes.alphasearch#</b>""">
</cfif>

<cfif Len(search_string)>
	<cfset searchheader = "#searchheader# matching ""<b>#search_string#</b>""">	
</cfif>

<!--- Set the order by clause --->
	<cfif len(attributes.sortby)>		
		<cfif attributes.sortby is "Low">
			<cfset orderby_clause = "P.Base_Price ASC">
		<cfelseif attributes.sortby is "High">
			<cfset orderby_clause = "P.Base_Price DESC">
		<cfelseif attributes.sortby is "sitemap" OR attributes.sortby is "name">
			<cfset orderby_clause = "P.Name #attributes.order#">
		<cfelseif attributes.sortby is "sku">
			<cfset orderby_clause = "P.SKU">
		<cfelseif attributes.sortby is "dateadded">
			<cfset orderby_clause = "P.DateAdded DESC">
		<cfelseif attributes.sortby is "availability">
			<cfset orderby_clause = "P.Availability  #attributes.order#">
			<cfset searchheader = "#searchheader# sorted by availability ">
		<cfelse>
			<cfset orderby_clause = "P.#attributes.sortby# #attributes.order#">
		</cfif>
	<cfelse>
		<cfset orderby_clause = "P.Priority">
		<cfif Request.AppSettings.ItemSort IS "Name">
			<cfset orderby_clause = orderby_clause & ", P.Name">
		<cfelseif Request.AppSettings.ItemSort IS "SKU">
			<cfset orderby_clause = orderby_clause & ", P.SKU">
		</cfif>
	</cfif>
	
<!--- Add an explicit sort --->
<cfset orderby_clause = orderby_clause & ", P.Product_ID">

<cfif Request.AppSettings.CachedProds AND NOT len(search_string)>
	<cfset Cached = Request.Cache>
<cfelse>
	<cfset Cached = 0>
</cfif>

<!--- Get products --->
<cfquery name="qry_get_products" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" cachedwithin="#Cached#">
SELECT P.*,	(SELECT AVG(R.Rating) FROM #Request.DB_Prefix#ProductReviews R 
				WHERE R.Product_ID = P.Product_ID AND Approved = 1)  AS Avg_Rating
FROM #Request.DB_Prefix#Products P 
<cfif isNumeric(attributes.category_id)>
INNER JOIN #Request.DB_Prefix#Product_Category PCat ON P.Product_ID = PCat.Product_ID
</cfif> 
WHERE 
<cfif not (isdefined("attributes.product_searchsubmit") and not Len(trim(searchheader)))>
	1=1 
		
	AND AccessKey IN (#accesskeys#)
	
	AND NOT EXISTS (SELECT C.Category_ID FROM #Request.DB_Prefix#Categories C 
		INNER JOIN #Request.DB_Prefix#Product_Category PCat ON C.Category_ID = PCat.Category_ID
		 WHERE PCat.Product_ID = P.Product_ID
		 AND (C.Display = 0 OR (
			C.AccessKey IS NOT NULL AND C.AccessKey <> 0 AND C.AccessKey NOT IN (#accesskeys#)) ) )
	<cfif attributes.hot is 1 OR attributes.new is 1 OR attributes.onsale is 1 OR attributes.notsold is 1>
	AND (1=0 
		<cfif attributes.hot is 1>OR P.Hot = 1 </cfif>
		<cfif attributes.new is 1>OR P.Highlight = 1 </cfif>
		<cfif attributes.onsale is 1>OR P.Sale = 1 </cfif>
		<cfif attributes.notsold is 1>OR P.NotSold = 1 </cfif>
	)
	</cfif>					
	<cfif trim(attributes.availability) is not "">
		AND P.Availability = '#attributes.availability#'
	</cfif>		
	<cfif isNumeric(attributes.mfg_account_id)>
		AND P.Mfg_Account_ID = #Val(attributes.mfg_account_id)#
	</cfif>	
	<cfif isNumeric(attributes.category_id)>
	AND PCat.Category_ID = #Val(attributes.Category_id)#
	</cfif>	
	<cfif isNumeric(attributes.UnderCategory_id) And attributes.UnderCategory_id IS NOT 0>
	AND ( PCat.Category_ID = #Val(attributes.UnderCategory_id)#
			OR PCat.Category_ID IN (SELECT Category_ID FROM Categories
				WHERE Parent_ID = #Val(attributes.UnderCategory_id)#
				OR ParentIDs LIKE '%,#Val(attributes.UnderCategory_id)#'
				OR ParentIDs LIKE '#Val(attributes.UnderCategory_id)#,%'
				OR ParentIDs LIKE '%,#Val(attributes.UnderCategory_id)#,%' ) )
	</cfif>			
	<cfif Request.AppSettings.InvLevel IS NOT "None" AND NOT Request.AppSettings.OutOfStock>
	AND P.NumInStock > 0 </cfif>
	<cfset useparam = "no">
	<cfif len(search_string)> AND (
		<cfset fieldname = "Long_Desc">
		<cfinclude template="../../customtags/safesearch.cfm"> OR 
		<cfset fieldname = "Short_Desc">
		<cfinclude template="../../customtags/safesearch.cfm"> OR 
		<cfset fieldname = "Metadescription">
		<cfinclude template="../../customtags/safesearch.cfm"> OR
		<cfset fieldname = "Keywords">
		<cfinclude template="../../customtags/safesearch.cfm"> )
	</cfif>	
	
	<cfif Len(attributes.name)> AND 
		<cfset search_string = attributes.name>
		<cfset fieldname = "Name">
		<cfinclude template="../../customtags/safesearch.cfm">
	</cfif>
	
	<cfif Len(attributes.type)>
		AND P.Prod_Type = '#attributes.type#'
	</cfif>
	
	AND (P.Sale_Start IS NULL OR P.Sale_Start <= #createODBCdate(now())#)
	AND (P.Sale_End IS NULL OR P.Sale_End > #createODBCdate(now())#)
	AND P.Display = 1
	<cfif len(attributes.alphasearch) AND attributes.alphasearch IS NOT "All">
		<cfif attributes.alphasearch IS "Num">
		AND ( P.Name Like '1%' OR P.Name Like '2%' OR P.Name Like '3%' OR P.Name Like '4%' 
		OR P.Name Like '5%' OR P.Name Like '6%' OR P.Name Like '7%' OR P.Name Like '8%' 
		OR P.Name Like '9%' OR P.Name Like '0%')
		<cfelse>
		AND P.Name Like '#alphasearch#%'
		</cfif>
	</cfif>
	<!--- Helps prevent SQL injection --->
	AND 1 = 1
<cfelse>
	1 = 0
</cfif>
ORDER BY #orderby_clause#

</cfquery>

<cfset ProdList = ValueList(qry_Get_products.Product_ID)>

<!--- Set product list for current page being displayed --->
<cfparam name="attributes.displaycount" default="#Request.AppSettings.maxprods#">

<cfset StartRow = (attributes.currentpage - 1) * attributes.displaycount + 1>

<cfset EndRow = iif((StartRow + attributes.displaycount) LT qry_Get_products.Recordcount, (StartRow + attributes.displaycount - 1), qry_Get_products.Recordcount)>

<!--- Determine the products to get options and addons for --->
<cfset ProdList = "">
<cfloop index="x" from="#StartRow#" to="#EndRow#">
	<cfset ProdList = ListAppend(ProdList, qry_Get_products.Product_ID[x])>
</cfloop>

<!--- Get the stock amounts and update query and product lists if necessary --->
<cfinclude template="qry_stock_amounts.cfm">


<!--- Get options for these products --->
<cfquery name="GetOptions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT PO.*, P.Priority, P.Name, P.SKU, SO.Std_Prompt, SO.Std_Desc, SO.Std_ShowPrice, SO.Std_Display, SO.Std_Required
FROM (#Request.DB_Prefix#Product_Options PO 
LEFT JOIN #Request.DB_Prefix#StdOptions SO ON PO.Std_ID = SO.Std_ID) 
INNER JOIN #Request.DB_Prefix#Products P ON P.Product_ID = PO.Product_ID
WHERE <cfif len(ProdList)>PO.Product_ID IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ProdList#" list="Yes">)
			<cfelse>0 = 1 </cfif>
AND P.NotSold = 0
ORDER BY #orderby_clause#, PO.Priority, PO.Option_ID
</cfquery>

<!--- Get the list of option choices --->
<cfinclude template="qry_get_opt_choices.cfm">

<!--- Get addons for these products --->
<cfquery name="GetAddons" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT PA.*, P.Priority, P.Name, SA.Std_Prompt, SA.Std_Type, SA.Std_Display, SA.Std_Required, SA.Std_Desc
FROM (#Request.DB_Prefix#ProdAddons PA 
LEFT JOIN #Request.DB_Prefix#StdAddons SA ON PA.Standard_ID = SA.Std_ID) 
INNER JOIN #Request.DB_Prefix#Products P ON P.Product_ID = PA.Product_ID
WHERE <cfif len(ProdList)>PA.Product_ID IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ProdList#" list="Yes">)
			<cfelse>0 = 1 </cfif>
ORDER BY #orderby_clause#, PA.Priority, PA.Addon_ID
</cfquery>

<!--- If using product reviews, get review summary for the products --->
<cfif request.appsettings.productreviews>
	<cfquery name="GetReviews" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT AVG(R.Rating) AS Avg_Rating, COUNT(R.Rating) AS Total_Ratings, R.Product_ID
	FROM #Request.DB_Prefix#ProductReviews R
	LEFT JOIN #Request.DB_Prefix#Users U on R.User_ID = U.User_ID
	WHERE R.Approved = 1
	<cfif len(ProdList)>AND R.Product_ID IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ProdList#" list="Yes">)
	<cfelse>AND 0 = 1 </cfif>
	<cfif request.appsettings.ProductReview_Add is "2">
		AND U.EmailLock = 'verified'
	</cfif>
	GROUP BY R.Product_ID
	</cfquery>
</cfif>

<!--- Get Custom Fields for these products --->
<cfquery name="GetCustomInfo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT PI.*, PC.Custom_Name
FROM #Request.DB_Prefix#Prod_CustInfo PI, #Request.DB_Prefix#Prod_CustomFields PC
WHERE PI.Custom_ID = PC.Custom_ID
AND PC.Custom_Display = 1
<cfif len(ProdList)>AND PI.Product_ID IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ProdList#" list="Yes">)
	<cfelse>AND 0 = 1 </cfif>
</cfquery>

<cfinclude template="qry_grp_prices.cfm">

<cfset searchheader = "<b>#request.qry_get_cat.Name#</b> #searchheader#">
<cfset NumList = NumList + qry_Get_products.RecordCount>

<!---- set product "next item" list ------------>
<cfset attributes.type = "product">
<cfinclude template="../../customtags/nextitems.cfm">


