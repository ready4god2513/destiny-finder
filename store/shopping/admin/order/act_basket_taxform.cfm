<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates Orders tax information from put_taxes_update.cfm template. Called by shopping.admin&order=display --->

<!--- Calculate the tax total --->

<cfset ProductTotal = iif(isNumeric(attributes.ProductTotal), attributes.ProductTotal, 0)>
<cfset AllUserTax = iif(isNumeric(attributes.AllUserTax), attributes.AllUserTax, 0)>
<cfset LocalTax = iif(isNumeric(attributes.LocalTax), attributes.LocalTax, 0)>
<cfset CountyTax = iif(isNumeric(attributes.CountyTax), attributes.CountyTax, 0)>
<cfset StateTax = iif(isNumeric(attributes.StateTax), attributes.StateTax, 0)>
<cfset CountryTax = iif(isNumeric(attributes.CountryTax), attributes.CountryTax, 0)>

<!--- Get the total Tax --->
<cfif NOT AllUserTax>
	<cfset TotalTax = LocalTax + CountyTax + StateTax + CountryTax>
<cfelse>
	<cfset TotalTax = AllUserTax>
</cfif>

<cfset AddTax = TotalTax - attributes.OrderTaxes>

<!--- Check if there is already a record for this order's taxes --->
<cfquery name="CheckTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">			
	SELECT Order_No FROM #Request.DB_Prefix#OrderTaxes
	WHERE Order_No = #attributes.Order_No#
</cfquery>

<cfif CheckTaxes.RecordCount>
	<!--- Update Taxes --->
	<cfquery name="UpdTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">			
		UPDATE #Request.DB_Prefix#OrderTaxes
		SET Code_ID = #ListGetAt(attributes.TaxCode, 1, "^")#,
		CodeName = '#ListGetAt(attributes.TaxCode, 2, "^")#',
		AddressUsed = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.AddressUsed#" null="#YesNoFormat(AllUserTax)#">,
		ProductTotal = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#ProductTotal#">, 
		AllUserTax = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#AllUserTax#">, 
		StateTax = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(AllUserTax, 0, StateTax)#">,
		CountyTax = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(AllUserTax, 0, CountyTax)#">,
		LocalTax = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(AllUserTax, 0, LocalTax)#">,
		CountryTax = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(AllUserTax, 0, CountryTax)#">
		WHERE Order_No = #attributes.Order_No#
	</cfquery>


<cfelse>
<!--- Add Taxes --->
<cfquery name="InsTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">			
	INSERT INTO #Request.DB_Prefix#OrderTaxes
	(Order_No, Code_ID, CodeName, ProductTotal, AddressUsed, 
		AllUserTax, StateTax, CountyTax, LocalTax, CountryTax)
	VALUES (#attributes.Order_No#, #ListGetAt(attributes.TaxCode, 1, "^")#, '#ListGetAt(attributes.TaxCode, 2, "^")#',
		<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#ProductTotal#">, 
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.AddressUsed#" null="#YesNoFormat(AllUserTax)#">,
		<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#AllUserTax#">,
		<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(AllUserTax, 0, StateTax)#">,
		<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(AllUserTax, 0, CountyTax)#">,
		<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(AllUserTax, 0, LocalTax)#">,
		<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(AllUserTax, 0, CountryTax)#"> )
</cfquery>

</cfif>

<!--- Update Order_No Table ---->
<cfquery name="UpdateOrderNo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
	UPDATE #Request.DB_Prefix#Order_No
	SET Tax = #TotalTax#,
	OrderTotal = OrderTotal + #AddTax#,
	Admin_Name = '#Session.Realname#',
	Admin_Updated = #createODBCdatetime(now())#
	WHERE Order_No = #attributes.Order_No#
</cfquery>

