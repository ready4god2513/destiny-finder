
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for the local tax rates: add, edit and delete. Called by shopping.admin&taxes=local --->

<cfif isdefined("attributes.submit_rate")>

	<cfif attributes.Local_ID is "0">

		<cfquery name="AddTax" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#LocalTax 
			(Code_ID, Zipcode, EndZip, Tax, TaxShip)
			VALUES (#attributes.code_id#, '#Trim(attributes.zipcode)#', 
			<cfif len(Trim(attributes.endzip))>'#Trim(attributes.endzip)#', <cfelse>Null,</cfif>
			#Evaluate(attributes.tax/100)#, #attributes.TaxShip#)
		</cfquery>
	
	<cfelse>
		
		<cfquery name="UpdateTax" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#LocalTax
			SET 
			ZipCode = '#Trim(attributes.ZipCode)#', 
			EndZip = <cfif len(Trim(attributes.endzip))>'#Trim(attributes.endzip)#', <cfelse>Null,</cfif>
			Tax = #Evaluate(attributes.Tax/100)#,
			TaxShip = #attributes.TaxShip#
			WHERE Local_ID = #attributes.Local_ID#
		</cfquery>
			
	</cfif>
	
<cfelseif isdefined("attributes.delete")>

	<cfquery name="delete_record"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#LocalTax
		WHERE Local_ID = #attributes.delete#
	</cfquery>
	
</cfif>

<!----- RESET the cached taxes query ---->
<cfset Application.objCheckout.getLocalTaxes('yes')>

