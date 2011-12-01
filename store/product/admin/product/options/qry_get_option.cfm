
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information on a product option. Called by product.admin&option=change --->

<cfparam name="attributes.Option_ID" default="0">

<cfquery name="qry_get_Option"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
SELECT PO.*, SO.Std_Name, SO.Std_Prompt, SO.Std_ShowPrice, SO.Std_Display
FROM #Request.DB_Prefix#Product_Options PO 
LEFT JOIN #Request.DB_Prefix#StdOptions SO ON PO.Std_ID = SO.Std_ID
WHERE PO.Option_ID =  #attributes.Option_ID#
</cfquery>

<!--- Multiple queries needed to get standard and custum options, and to handle Access bugs with outer joins with mutliple fields --->
<cfquery name="qry_get_Opt_Choices" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT PO.Option_ID, SC.SortOrder, SC.Choice_ID, SC.ChoiceName, SC.Price, SC.Weight, SC.Display,
	PC.SKU, PC.NumInStock, PC.Display AS ItemDisplay 
	FROM #Request.DB_Prefix#StdOpt_Choices SC, 
		#Request.DB_Prefix#Product_Options PO,
		#Request.DB_Prefix#ProdOpt_Choices PC
	WHERE PO.Option_ID =  <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Option_ID#">
	AND PO.Std_ID = SC.Std_ID
	AND SC.Choice_ID = PC.Choice_ID
	AND PC.Option_ID = PO.Option_ID
	
	UNION 
	
	SELECT PO.Option_ID, SC.SortOrder, SC.Choice_ID, SC.ChoiceName, SC.Price, SC.Weight, SC.Display,
	'' AS SKU, 0 AS NumInStock, 1 AS ItemDisplay 
	FROM #Request.DB_Prefix#StdOpt_Choices SC, #Request.DB_Prefix#Product_Options PO
	WHERE PO.Option_ID =  <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Option_ID#">
	AND PO.Std_ID = SC.Std_ID
	AND NOT EXISTS (SELECT * FROM #Request.DB_Prefix#ProdOpt_Choices PC
					WHERE Option_ID = PO.Option_ID
					AND Choice_ID = SC.Choice_ID)
	
	UNION
	
	SELECT PO.Option_ID, PC.SortOrder, PC.Choice_ID, PC.ChoiceName, PC.Price, PC.Weight, PC.Display,
	PC.SKU, PC.NumInStock, 1 AS ItemDisplay
	FROM #Request.DB_Prefix#ProdOpt_Choices PC 
	INNER JOIN #Request.DB_Prefix#Product_Options PO ON PO.Option_ID = PC.Option_ID
	WHERE PO.Option_ID =  <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Option_ID#">
	AND PO.Std_ID = 0
	
	ORDER BY 2
</cfquery>

<!--- Checks if this option is being used for inventory tracking on any orders --->
<cfquery name="CheckInvUse" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT OptChoice FROM #Request.DB_Prefix#Order_Items OI, 
	#Request.DB_Prefix#Products P, #Request.DB_Prefix#Product_Options PO
	WHERE PO.Option_ID =  <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Option_ID#">
	AND PO.Option_ID = P.OptQuant
	AND P.Product_ID = OI.Product_ID
	AND OI.OptChoice <> 0 
</cfquery>

<!--- Checks if any other options on this product currently tracking inventory --->
<cfquery name="CheckOtherInv" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT Option_ID FROM #Request.DB_Prefix#Product_Options
	WHERE Option_ID <> <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Option_ID#">
	AND Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
	AND TrackInv <> 0
</cfquery>

<!--- Checks if any other options on this product currently used for SKUs --->
<cfquery name="CheckOtherSKUs" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT Choice_ID FROM #Request.DB_Prefix#ProdOpt_Choices PC, #Request.DB_Prefix#Product_Options PO
	WHERE PC.Option_ID <> <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Option_ID#">
	AND PO.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
	AND PO.Option_ID = PC.Option_ID
	AND PC.SKU IS NOT NULL
	AND PC.SKU <> ''
</cfquery>
