
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to temporarily save the shipping information entered in the address form. Called by shopping.checkout (step=address) --->

<!--- Remove any current shipping record --->

<cfquery name="RemoveRecord" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#TempShipTo
	WHERE TempShip_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>

<!--- if shipping to a separate address, enter into the temporary table ---->
<cfif attributes.shiptoyes is "0">

	<!--- Copy the form variables into a new structure --->
	<cfset ShipInfo = StructNew()>
	<cfloop collection="#attributes#" item="thefield">
		<cfif ListLen(thefield, "_") GT 1>
			<cfset newname = ListGetAt(thefield, 1, "_")>
			<cfset ShipInfo[newname] = attributes[thefield]>	
		</cfif>
	</cfloop>
	
	<!--- Check for blank state field --->
	<cfif NOT len(attributes.State_shipto)>
		<cfset ShipInfo['State'] = "Unlisted">
	</cfif>
	
	<!--- Add the shipping record --->
	<cfset ShipInfo.TableName = "TempShipTo">
	<cfset TempShip_ID = Application.objUsers.AddCustomer(argumentcollection=ShipInfo)>
		

</cfif>

