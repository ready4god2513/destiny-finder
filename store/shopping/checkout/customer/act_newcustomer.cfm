<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Initializes the customer information for the checkout process. Retrieves current customer information for the user, or creates a new blank record. Called by shopping.checkout (step="") --->

<cfparam name="attributes.customer_id" default="0">
<cfparam name="attributes.shipto" default="0">


<!--- Try first to use default addresses from User record. --->
<cfif Session.User_ID IS NOT 0>

	<cfquery name="Find_Default_addresses" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" maxrows=1>
	SELECT Customer_ID, ShipTo FROM #Request.DB_Prefix#Users
	WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	
	<cfset attributes.Customer_ID = Find_Default_addresses.Customer_ID>
	
	<cfif Find_Default_addresses.Customer_ID is NOT Find_Default_addresses.shipto>
		<cfset attributes.shipto = Find_Default_addresses.shipto>
	</cfif>
		
</cfif>

<!--- Check if there is already a temporary record --->
<cfinclude template="qry_get_tempcustomer.cfm">

<!---- if no temp Customer record, create one ---->
<cfif NOT GetCustomer.RecordCount>

	<!--- Load it from the Customer_ID if we have one ---->
	<cfif attributes.Customer_ID IS NOT 0>

		<cfquery name="GetCustInfo" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#" maxrows=1>
		SELECT * FROM #Request.DB_Prefix#Customers
		WHERE Customer_ID = <cfqueryparam value="#attributes.Customer_ID#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>

		<cfif GetCustInfo.RecordCount>
		
			<!--- Move the query into a structure --->
			<cfset CustRecord = queryRowToStruct(GetCustInfo)>
			<cfset CustRecord.TableName = "TempCustomer">
			
			<!--- Add the customer record --->
			<cfset TempCust_ID = Application.objUsers.AddCustomer(argumentcollection=CustRecord)>

			
			<cfquery name="GetShipInfo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
				SELECT * FROM #Request.DB_Prefix#Customers
				WHERE Customer_ID = <cfqueryparam value="#attributes.shipto#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
				
			<cfif GetShipInfo.RecordCount>

				<cfquery name="UpdateCust" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					UPDATE #Request.DB_Prefix#TempCustomer
					SET ShipToYes = 0
					WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
					</cfquery>
					
				<!--- Move the query into a structure --->
				<cfset ShipRecord = queryRowToStruct(GetShipInfo)>
				<cfset ShipRecord.TableName = "TempShipTo">
				<!--- Add the shipping record --->
				<cfset TempShip_ID = Application.objUsers.AddCustomer(argumentcollection=ShipRecord)>
				

			</cfif><!--- shipto record found--->
					
		<cfelse><!--- If no customer record found, enter blank records --->

			<cfset Application.objUsers.AddBlankRecord(TableName="TempCustomer")>

		</cfif><!--- customer recordcount --->

	<cfelse><!--- user.customer_id is 0, enter blank records --->

		<cfset Application.objUsers.AddBlankRecord(TableName="TempCustomer")>

	</cfif><!--- user.customer_id check --->
	
</cfif><!---temp record exists ---> 
