
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Runs the admin actions for the custom shipping rates table: add, edit, delete. Called by shopping.admin&shipping=custom --->

<cfif isdefined("attributes.submit_rate")>

	<cfif ListFind('Price,Weight,Items', ShipSettings.ShipType)>
		<cfset Amount = attributes.Amount>
	<cfelse>
		<cfset Amount = attributes.Amount / 100>
	</cfif>

	<cfif attributes.ID is "0">
		
		<cfquery name="AddShip" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#Shipping 
			(MinOrder, MaxOrder, Amount)
			VALUES (#attributes.MinOrder#,
			#attributes.MaxOrder#,#Amount#)
		</cfquery>
	
	<cfelse>
		
		<cfquery name="UpdateShip" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Shipping
			SET 
			MinOrder = #attributes.MinOrder#, 
			MaxOrder = #attributes.MaxOrder#, 
			Amount = #Amount#
			WHERE ID = #attributes.ID#
		</cfquery>
		
	</cfif>
	
<cfelseif isdefined("attributes.delete")>

	<cfquery name="DeleteShip" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Shipping
		WHERE ID = #attributes.delete#
	</cfquery>

</cfif>


