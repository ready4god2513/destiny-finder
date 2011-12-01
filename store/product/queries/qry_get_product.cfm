
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves all the information for a selected product. Called from product.display and dsp_productofday.cfm --->

<cfparam name="attributes.product_id" default="0">
<!--- Used to check for invalid query strings --->
<cfparam name="invalid" default="0">
<cfparam name="attributes.ParentCat" default="0">

<!--- Make sure this is an available product! --->

<cfif Session.User_ID>
	<cfset accesskeys = '0,1'>
	<cfset key_loc = ListContainsNoCase(session.userPermissions,'contentkey_list',';')>
	<cfif key_loc>
		<cfset accesskeys = ListAppend(accesskeys,ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^'))>
	</cfif>
</cfif>
<cfparam name="accesskeys" default="0">

<cftry>
	<!--- Get the product information --->
	<cfquery name="qry_get_products" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT P.*, A.Account_Name, A.Logo 
	FROM #Request.DB_Prefix#Products P 
	LEFT JOIN #Request.DB_Prefix#Account A on P.Mfg_Account_ID = A.Account_ID
	WHERE P.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
		AND Display = 1
		AND NOT EXISTS (SELECT C.Category_ID FROM #Request.DB_Prefix#Categories C 
			INNER JOIN #Request.DB_Prefix#Product_Category PCat ON C.Category_ID = PCat.Category_ID
		 	WHERE PCat.Product_ID = P.Product_ID
			AND C.Display = 0)
		<!--- Comment out the next line if you prefer the site to forward to the login page 
		when the access key for the product is not found --->
		AND AccessKey IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#accesskeys#" list="Yes">)
		AND (P.Sale_Start IS NULL OR P.Sale_Start <= <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">)
		AND (P.Sale_End IS NULL OR P.Sale_End > <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">)
		<cfif Request.AppSettings.InvLevel IS NOT "None" AND NOT Request.AppSettings.OutOfStock>AND NumInStock > 0</cfif>
	</cfquery>
	
	<!--- Get Inventory Amount for the product --->
	<cfquery name="qry_prod_stock" dbtype="query">
	SELECT NumInStock FROM qry_get_products
	</cfquery>	
	
	<!--- Get options for this product --->
	<cfquery name="GetProdOpts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT PO.*, SO.Std_Prompt, SO.Std_Desc, SO.Std_ShowPrice, SO.Std_Display, SO.Std_Required
		FROM #Request.DB_Prefix#Product_Options PO 
		LEFT JOIN #Request.DB_Prefix#StdOptions SO ON PO.Std_ID = SO.Std_ID
		WHERE PO.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
		ORDER BY PO.Priority, PO.Option_ID
	</cfquery>
	
	<!--- Get the option choices for this product --->
	<cfset ProdList = attributes.Product_ID>
	<cfinclude template="qry_get_opt_choices.cfm">
	
	<!--- Check if there are any categories with an access key that this product belongs to --->
	<cfquery name="qry_check_accesskey" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
		SELECT C.Category_ID, C.AccessKey FROM #Request.DB_Prefix#Categories C
		INNER JOIN #Request.DB_Prefix#Product_Category PCat ON C.Category_ID = PCat.Category_ID
		WHERE PCat.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
		AND C.AccessKey IS NOT NULL AND C.AccessKey <> 0 AND C.AccessKey NOT IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#accesskeys#" list="Yes">)
	</cfquery>
	
	<!--- Get addons for this product --->
	<cfquery name="GetProdAddons" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT PA.*, SA.Std_Prompt, SA.Std_Type, SA.Std_Display, SA.Std_Required, SA.Std_Desc
	FROM #Request.DB_Prefix#ProdAddons PA 
	LEFT JOIN #Request.DB_Prefix#StdAddons SA ON PA.Standard_ID = SA.Std_ID
	WHERE PA.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
	ORDER BY PA.Priority, PA.Addon_ID
	</cfquery>
	
	<!--- If using product reviews, get review summary for the product --->
	<cfif request.appsettings.productreviews>
		<cfquery name="qry_prod_reviews" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT AVG(R.Rating) AS Avg_Rating, COUNT(R.Rating) AS Total_Ratings, R.Product_ID
		FROM #Request.DB_Prefix#ProductReviews R
		LEFT JOIN #Request.DB_Prefix#Users U on R.User_ID = U.User_ID
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
		AND R.Approved = 1
		<cfif request.appsettings.ProductReview_Add is "2">
			AND U.EmailLock = 'verified'
		</cfif>
		GROUP BY R.Product_ID
		</cfquery>
	</cfif>
	
	<!--- Get Custom Fields for this product --->
	<cfquery name="GetProdCustom" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT PI.*, PC.Custom_Name
	FROM #Request.DB_Prefix#Prod_CustInfo PI, #Request.DB_Prefix#Prod_CustomFields PC
	WHERE PI.Custom_ID = PC.Custom_ID
	AND PC.Custom_Display = 1
	AND PI.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
	</cfquery>
	
	<!--- Get Group Price for this product --->
	<cfquery name="GetGroupPrice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Price FROM #Request.DB_Prefix#ProdGrpPrice
	WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
	AND Group_ID = <cfqueryparam value="#Session.Group_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>


<cfcatch type="Any">
	<cfset invalid = 1>
</cfcatch>
</cftry>





