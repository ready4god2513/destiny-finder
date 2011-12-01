
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of options for a product. For the pricing tab, checks for an option with quantities. Called from product\admin\product\dsp_options_form.cfm and dsp_price_form.cfm --->

<cfquery name="qry_Get_Options" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT PO.*, SO.Std_Prompt, SO.Std_Display 
	FROM #Request.DB_Prefix#Product_Options PO 
	LEFT JOIN #Request.DB_Prefix#StdOptions SO ON PO.Std_ID = SO.Std_ID
	WHERE PO.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
 	<cfif isDefined("attributes.do") and attributes.do IS "price">
	AND PO.TrackInv = 1
	</cfif>
	ORDER BY PO.Priority, PO.Option_ID
</cfquery>

<cfquery name="qry_get_Opt_Choices" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT PO.Option_ID, SC.SortOrder, SC.Choice_ID, SC.ChoiceName, SC.Price, SC.Weight, SC.Display,
	PC.SKU, PC.NumInStock, PC.Display AS ItemDisplay 
	FROM #Request.DB_Prefix#StdOpt_Choices SC, 
		#Request.DB_Prefix#Product_Options PO,
		#Request.DB_Prefix#ProdOpt_Choices PC
	WHERE PO.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
	AND PO.Std_ID = SC.Std_ID
	AND SC.Choice_ID = PC.Choice_ID
	AND PC.Option_ID = PO.Option_ID
	
	UNION
	
	SELECT PO.Option_ID, SC.SortOrder, SC.Choice_ID, SC.ChoiceName, SC.Price, SC.Weight, SC.Display,
	'' AS SKU, 0 AS NumInStock, 1 AS ItemDisplay 
	FROM #Request.DB_Prefix#StdOpt_Choices SC, #Request.DB_Prefix#Product_Options PO
	WHERE PO.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
	AND PO.Std_ID = SC.Std_ID
	AND NOT EXISTS (SELECT * FROM #Request.DB_Prefix#ProdOpt_Choices PC
					WHERE Option_ID = PO.Option_ID
					AND Choice_ID = SC.Choice_ID)					
	
	UNION
	
	SELECT PO.Option_ID, PC.SortOrder, PC.Choice_ID, PC.ChoiceName, PC.Price, PC.Weight, PC.Display,
	PC.SKU, PC.NumInStock, 1 AS ItemDisplay
	FROM #Request.DB_Prefix#ProdOpt_Choices PC, #Request.DB_Prefix#Product_Options PO 
	WHERE PO.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
	AND PO.Option_ID = PC.Option_ID	
	AND PO.Std_ID = 0
	
	ORDER BY 1, 2
</cfquery>

