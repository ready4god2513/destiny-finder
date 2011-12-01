<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.addressbook circuit this template saves a customer record as the user's default billing, shipping, account address, OR updates the billing or shipping address on an order. --->

<cfset ErrorMessage="">
<cfparam name="attributes.selected_id" default="">

<!--- Only allow updates to orders for order managers --->
<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="2"
	/>

<!--- Check that an address has been selected --->
<cfif len(attributes.selected_id)>

	<cfswitch expression = "#attributes.show#">

		<!--- Make selected address the default Customer address (users.customer_id) --->
		<cfcase value="customer">
				
			<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users
			SET Customer_ID = <cfqueryparam value="#attributes.selected_id#" cfsqltype="CF_SQL_INTEGER">
			WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
			
			<cfinclude template="../act_set_registration_permissions.cfm">
	
		</cfcase>

		<!--- Make selected address the default shipping address (users.shipto) --->		
		<cfcase value="ship">
	
			<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users
			SET ShipTo = <cfqueryparam value="#attributes.selected_id#" cfsqltype="CF_SQL_INTEGER">
			WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>	
			
		</cfcase>
		
		<!--- Make selected address the default Account address (account.customer_id) --->
		<cfcase value="bill">
			
			<cfinclude template="../qry_get_user.cfm">
			
			<cfquery name="UpdateAccount" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Account
			SET Customer_ID = <cfqueryparam value="#attributes.selected_id#" cfsqltype="CF_SQL_INTEGER">
			WHERE Account_ID = <cfqueryparam value="#qry_get_user.account_id#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>	
			
		</cfcase>
			
			
		<!--- Make selected address the order's billing address --->
		<cfcase value="billto">
					
			<cfif isdefined("attributes.order_no") AND ispermitted>
			
				<cfquery name="UpdateOrderBillto" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Order_No
				SET Customer_ID = <cfqueryparam value="#attributes.selected_id#" cfsqltype="CF_SQL_INTEGER">
				WHERE Order_No = <cfqueryparam value="#attributes.order_no#" cfsqltype="CF_SQL_INTEGER">
				</cfquery>
				
			<cfelse>
			
				<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Users
				SET Customer_ID = <cfqueryparam value="#attributes.selected_id#" cfsqltype="CF_SQL_INTEGER">
				WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
				</cfquery>
			
			</cfif>

		</cfcase>
		

		<!--- Make selected address the order's shipping address --->
		<cfcase value="shipto">

			<cfif isdefined("attributes.order_no") AND ispermitted>
			
				<cfquery name="UpdateOrderShipto" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Order_No
				SET ShipTo = <cfqueryparam value="#attributes.selected_id#" cfsqltype="CF_SQL_INTEGER">
				WHERE Order_No = <cfqueryparam value="#attributes.order_no#" cfsqltype="CF_SQL_INTEGER">
				</cfquery>
			
			<cfelse>
			
				<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Users
				SET ShipTo = <cfqueryparam value="#attributes.selected_id#" cfsqltype="CF_SQL_INTEGER">
				WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
				</cfquery>	
			
			</cfif>
			
		</cfcase>

	
	</cfswitch>

	<cflocation url="#attributes.xfa_success##Request.Token2#" addtoken="No">

	
<!--- if no address has been selected, redisplay form --->
<cfelseif not isdefined("attributes.order_no")>
	
	<cfset ErrorMessage = "Please select your default address">

<cfelse>
	
	<cflocation url="#attributes.xfa_success##Request.Token2#" addtoken="No">

</cfif>

