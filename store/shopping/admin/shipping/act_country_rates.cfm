
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates the country shipping information and resets the cached query for countries. Called by shopping.admin&shipping=country --->

<!--- Set all the country rates --->
<cfif isdefined("attributes.AddAll") AND attributes.AddAll IS "yes">
	<cfquery name="DoAll" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Countries	
		SET Shipping = 1,
		AddShipAmount = #Evaluate(attributes.AllRate/100)#
	</cfquery>

<!--- Set an individual country rate --->
<cfelseif isdefined("attributes.submit_rate")>

	<cfif attributes.ID is "0">
		
		<cfquery name="AddShip" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Countries	
		SET Shipping = 1,
		AddShipAmount = #Evaluate(attributes.AddShipAmount/100)#
		WHERE Abbrev = '#ListGetAt(attributes.Country,1,"^")#'
		</cfquery>
	
	<cfelse>
	
		<cfquery name="UpdateShip" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Countries
			SET 
			AddShipAmount = #Evaluate(attributes.AddShipAmount/100)#
			WHERE ID = #attributes.ID#
		</cfquery>
		
	</cfif>
	
<cfelseif isdefined("attributes.delete")>

	<cfquery name="DeleteShip" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Countries
	SET Shipping = 0, AddShipAmount = 0
	WHERE ID = #attributes.delete#
	</cfquery>
	
</cfif>

<!--- Reset cached countries query --->
<cfquery name="GetCountries" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" 
cachedwithin="#CreateTimeSpan(0, 0, 0, 0)#">
SELECT * FROM #Request.DB_Prefix#Countries
ORDER BY Name
</cfquery>


