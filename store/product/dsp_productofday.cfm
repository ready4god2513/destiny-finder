<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page runs the Product of the Day feature. It is called by product.prodofday. Checks if a product is currently selected for today, if not selects one at random from the database. The information is stored in application variables so all visitors to the site will see the same product. 

Different Products of the Day can be created and stored by Category (undercat).

--->

<!--- The parameter listing=short|standard|vertical is used to determine the type of product display to use --->

<cfparam name="PickProd" default="No">
<cfparam name="attributes.listing" default="standard">
<cfparam name="attributes.UnderCategory_id" default="">

<cfif NOT isDefined("Application.ProdofDay#attributes.UnderCategory_id#.DayofYear") OR IsDefined("URL.Refresh") OR Application["ProdofDay#attributes.UnderCategory_id#"]["DayofYear"] IS NOT DayofYear(Now())>
	<cfset PickProd = "Yes">
</cfif>

<cfif PickProd>
	
	<cfif len(attributes.UnderCategory_id) And attributes.UnderCategory_id IS NOT 0>
	
		<cfquery name="CountProds" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT P.Product_ID
		FROM #Request.DB_Prefix#Products P 
		INNER JOIN #Request.DB_Prefix#Product_Category PCat ON P.Product_ID = PCat.Product_ID
		WHERE P.Display = 1
		AND P.AccessKey = 0
		AND P.UseforPOTD = 1
		AND (P.Sale_Start IS NULL OR P.Sale_Start <= #createODBCdate(now())#)
		AND (P.Sale_End IS NULL OR P.Sale_End > #createODBCdate(now())#)
		<cfif Request.AppSettings.InvLevel IS NOT "None" AND NOT Request.AppSettings.OutOfStock>
			AND P.NumInStock > 0</cfif>
		AND ( PCat.Category_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.UnderCategory_id#">
				OR PCat.Category_ID IN (SELECT Category_ID FROM Categories
					WHERE Parent_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.UnderCategory_id#">
					OR ParentIDs LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%,#attributes.UnderCategory_id#">
					OR ParentIDs LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.UnderCategory_id#,%">
					OR ParentIDs LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%,#attributes.UnderCategory_id#,%"> ) )
		</cfquery>
		
	<cfelse>
	
		<cfquery name="CountProds" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Product_ID FROM #Request.DB_Prefix#Products
		WHERE Display = 1
		AND AccessKey = 0
		AND UseforPOTD = 1
		AND (Sale_Start IS NULL OR Sale_Start <= #createODBCdate(now())#)
		AND (Sale_End IS NULL OR Sale_End > #createODBCdate(now())#)
		<cfif Request.AppSettings.InvLevel IS NOT "None" AND NOT Request.AppSettings.OutOfStock>
			AND NumInStock > 0</cfif>
		</cfquery>
	
	</cfif>

	<!--- No products found! --->
	<cfscript>
		if (NOT CountProds.RecordCount) 
			ProdDayID = 0;
		else {
			r = Randomize(Minute(now())&Second(now()));
			ProdID = RandRange(1, CountProds.Recordcount);
			ProdDayID = CountProds.Product_ID[ProdID];
		}
		
		newProdofDay = StructNew();
		StructInsert(newProdofDay, "ProdDay", ProdDayID);
		StructInsert(newProdofDay, "DayofYear", DayofYear(Now()));		
	</cfscript>

	<cflock scope="APPLICATION" type="EXCLUSIVE" timeout="20">
		<cfset "Application.ProdofDay#attributes.UnderCategory_id#" = Duplicate(newProdofDay)>
	</cflock>
	
</cfif>

<cfset attributes.Product_ID = Application["ProdofDay#attributes.UnderCategory_id#"]["ProdDay"]>

<cfif attributes.product_id gt 0>
	<cfinclude template="queries/qry_get_product.cfm">
	
	<cfoutput><div class="header">&nbsp;Product of the Day!</div><br/></cfoutput>
	
	<cfloop query="qry_get_products">

	<cfset getinfo = "no">
	<cfinclude template="listings\put_#attributes.listing#.cfm">
		
	</cfloop>
</cfif>

