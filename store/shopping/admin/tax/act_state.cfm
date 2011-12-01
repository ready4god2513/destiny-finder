
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for the state tax rates: add, edit and delete. Called by shopping.admin&taxes=state --->

<cfif isdefined("attributes.submit_rate")>

	<cfif attributes.Tax_ID is "0">

		<cfquery name="AddTax" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#StateTax
			(Code_ID, State, TaxRate, TaxShip)
			VALUES (#attributes.code_id#, '#Trim(attributes.State)#', #Evaluate(attributes.TaxRate/100)#, #attributes.TaxShip#)
		</cfquery>
	
	<cfelse>
		
		<cfquery name="UpdateTax" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#StateTax
			SET 
			State = '#Trim(attributes.State)#', 
			TaxRate = #Evaluate(attributes.TaxRate/100)#,
			TaxShip = #attributes.TaxShip#
			WHERE Tax_ID = #attributes.Tax_ID#
		</cfquery>
		
	</cfif>
	
<cfelseif isdefined("attributes.delete")>

	<cfquery name="delete_record"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#StateTax
		WHERE Tax_ID = #attributes.delete#
	</cfquery>
</cfif>

<!----- RESET the cached taxes query ---->
<cfset Application.objCheckout.getStateTaxes('yes')>

