
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Runs the admin actions for tax codes: add, edit, delete. Called by shopping.admin&taxes=editcode --->

<cfset TaxRate = iif(isNumeric(attributes.TaxRate), trim(attributes.TaxRate), 0)>

<cfif attributes.submit_code IS "Delete">

	<!--- Make sure this tax code is not currently in use on any orders --->
	<cfquery name="CheckTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">			
		SELECT Order_No FROM #Request.DB_Prefix#OrderTaxes
		WHERE Code_ID = #attributes.Code_ID#
	</cfquery>

	<cfif CheckTaxes.RecordCount>
		<cfset attributes.error_message = "There are still orders in the system using this tax code. They must be removed before you can delete the code.">

	<cfelse>
		<!--- Remove all associated taxes first --->
		<cfquery name="DeleteTaxes1" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#LocalTax
			WHERE Code_ID = #attributes.Code_ID#
		</cfquery>
		
		<cfquery name="DeleteTaxes2" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#StateTax
			WHERE Code_ID = #attributes.Code_ID#
		</cfquery>
		
		<cfquery name="DeleteTaxes3" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Counties
			WHERE Code_ID = #attributes.Code_ID#
		</cfquery>
		
		<cfquery name="DeleteTaxes4" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#CountryTax
			WHERE Code_ID = #attributes.Code_ID#
		</cfquery>
		
		<!--- Remove the tax code --->
		<cfquery name="DeleteCode" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#TaxCodes
			WHERE Code_ID = #attributes.Code_ID#
		</cfquery>
	</cfif>


<cfelseif attributes.Code_ID IS 0>

	<cfquery name="AddCode" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#TaxCodes
		(CodeName, DisplayName, TaxAll, ShowonProds, TaxRate, TaxShipping, TaxAddress, CalcOrder, Cumulative)
	VALUES(
		'#Trim(attributes.CodeName)#',
		'#Trim(attributes.DisplayName)#',
		#attributes.TaxAll#,
		#attributes.ShowonProds#,
		#(TaxRate/100)#,
		#attributes.TaxShipping#,
		'#Trim(attributes.TaxAddress)#',
		<cfif len(attributes.CalcOrder)>#Round(attributes.CalcOrder)#,<cfelse>0,</cfif>
		#attributes.Cumulative#)
	</cfquery>

<cfelse>

	<cfquery name="UpdateCode" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#TaxCodes
	SET CodeName = '#Trim(attributes.CodeName)#',
	DisplayName = '#Trim(attributes.DisplayName)#',
	TaxAll = #attributes.TaxAll#,
	ShowonProds = #attributes.ShowonProds#,
	TaxRate= #(TaxRate/100)#,
	TaxShipping = #attributes.TaxShipping#,
	TaxAddress = '#Trim(attributes.TaxAddress)#',
	CalcOrder = <cfif len(attributes.CalcOrder)>#Round(attributes.CalcOrder)#,<cfelse>0,</cfif>
	Cumulative = #attributes.Cumulative#
	WHERE Code_ID = #attributes.Code_ID#
	</cfquery>

</cfif>

<!--- Update cached products taxes query --->
<cfset Application.objCart.getProdTaxes(reset='yes')>
	


