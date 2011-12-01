
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for the county tax rates: add, edit and delete. Called by shopping.admin&taxes=county --->

<cfif isdefined("attributes.submit_rate")>

	<!--- Check that this state/county combination does not already exist --->
	<cfquery name="CheckCounty" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT County_ID FROM #Request.DB_Prefix#Counties
			WHERE Name = '#Trim(attributes.Name)#'
			AND State= '#Trim(attributes.State)#'
			AND Code_ID = #attributes.Code_ID#
			AND County_ID <> #attributes.County_ID#
		</cfquery>

	<cfif attributes.County_ID is "0" AND NOT CheckCounty.Recordcount>

		<cfquery name="AddCounty" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#Counties 
			(Code_ID, Name, State, TaxRate, TaxShip)
			VALUES (#attributes.Code_ID#, '#Trim(attributes.Name)#', '#Trim(attributes.State)#',
						#(attributes.TaxRate/100)#, #attributes.TaxShip#)
		</cfquery>
	
	<cfelseif NOT CheckCounty.Recordcount>
		
		<cfquery name="UpdateTax" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Counties
			SET 
			Name = '#Trim(attributes.Name)#',
			State = '#Trim(attributes.State)#', 
			TaxRate = #(attributes.TaxRate/100)#,
			TaxShip = #attributes.TaxShip#
			WHERE County_ID = #attributes.County_ID#
		</cfquery>
		
	<cfelse>
		<cfset error_message = "This county has already been added to the state for this tax rate.<br/> Please edit the existing county instead.">		
	</cfif>
	
<cfelseif isdefined("attributes.delete")>

	<cfquery name="delete_record"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Counties
		WHERE County_ID = #attributes.delete#
	</cfquery>
</cfif>

<!----- RESET the cached taxes query ---->
<cfset Application.objCheckout.getCountyTaxes('yes')>


