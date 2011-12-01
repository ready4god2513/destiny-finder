<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template emails the dropshippers of an order.

	1) PURCHASE ORDERS ARE EMAILED: First it looks at the order and determines if there are "outside dropshippers". These are the dropshippers assigned on a per-product basis on the Price page of the Product Manager. If there are products that are delivered by and outside dropshipper, then Purchase Orders are emailed to these accounts IF an email address is filled in the 'dropshipper email' field in the company's record (Account Manger).

	2) A PACKING SLIP IS EMAILED: A "Packing Slip" is emailed to the store's default dropshipper for remaining products. 

----->

<!--- Called in the admin area from act_order.cfm and act_order_shipping.cfm and during checkout from shopping\checkout\post_processing\act_mailorder.cfm --->

<!--- By default, send the emails --->
<cfparam name="EmailDropShip" default="Yes">

<!--- Get the full order information --->
<cfquery name="GetOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#Order_No
WHERE Order_No = #attributes.Order_No# 
</cfquery>

<cfquery name="GetBasket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT O.*, P.Name 
FROM #Request.DB_Prefix#Order_Items O, #Request.DB_Prefix#Products P
WHERE O.Order_No = #attributes.Order_No# 
AND O.Product_ID = P.Product_ID
</cfquery>

<cfquery name="GetCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
SELECT * FROM #Request.DB_Prefix#Customers 
WHERE Customer_ID = #GetOrder.Customer_ID#
</cfquery>

<cfquery name="GetShipTo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
SELECT * FROM #Request.DB_Prefix#Customers 
WHERE Customer_ID = #GetOrder.ShipTo#
</cfquery>

<cfset SubTotal = 0>
<cfset Mail = "Yes">

<cfinclude template="../../checkout/put_billto.cfm">
<cfset BillString = String>


<cfif GetShipTo.RecordCount>
<cfinclude template="../../checkout/put_shipto.cfm">
<cfset ShipString = String>
</cfif>


<!--- Look at the products and create a list of dropshipper Accounts that products are assigned to ---->
<cfset basket_dropshipper_list = "">
<cfloop query="GetBasket">
	<cfif len(dropship_Account_ID) AND not listfind(basket_dropshipper_list,dropship_Account_ID)>
		<cfset basket_dropshipper_list = listappend(basket_dropshipper_list,dropship_Account_ID)>
	</cfif>
</cfloop> 

<!--- if there are accounts on this order... --->
<cfif len(basket_dropshipper_list)>

<!--- Loop through the list of dropshippers. First, get the purchase Order record number (adding if
necessary). Then check if the account has a dropshipper email address defined - if it does we'll 
email them a purchase order.  --->

<cfloop index="attributes.account_ID" list="#basket_dropshipper_list#">

	<!-- Get attributes.Order_PO_id - adding one if necessary --->
	<cfset po = "add">
	<cfinclude template="../po/act_po.cfm">

	<!--- Check to see if this account has a dropshipper email --->
	<cfquery name="Check_Account" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" maxrows=1>
	SELECT Dropship_Email FROM #Request.DB_Prefix#Account
	WHERE Account_ID = #attributes.account_ID#
	</cfquery>

	<cfif len(Check_Account.dropship_email) AND EmailDropShip>
	
		<cfquery name="qry_get_po" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#" maxrows="1">
		SELECT PrintDate, PO_No, Notes FROM #Request.DB_Prefix#Order_PO 
		WHERE Order_PO_ID = #attributes.order_po_ID#
		</cfquery>
		
		<!--- Initialize the content of the message  --->
		<cfset Message = LineBreak & "Items Ordered" & LineBreak & "-----------------" & LineBreak>

		<!--- Loop through the basket and create a line for each item ordered --->
		<cfloop query="GetBasket">

			<!--- Add basket item to the message if it is assigned to this account --->
			<cfif GetBasket.dropship_account_id is attributes.account_ID>	
	
				<cfset Message = Message & GetBasket.Name>
	
				<cfif len(GetBasket.dropship_sku) and GetBasket.dropship_sku IS NOT 0>
					<cfset Message = Message & " (##" & GetBasket.dropship_sku & ")">
				<cfelseif len(GetBasket.SKU) AND GetBasket.SKU IS NOT 0>
					<cfset Message = Message & " (##" & GetBasket.SKU & ")">
				</cfif>
		
				<cfset Message = Message & ": " &  GetBasket.dropship_qty & LineBreak>

				<cfif len(GetBasket.Options) GT 1>
					<cfset Message = Message & "Options: " & GetBasket.Options & LineBreak>
				</cfif>		

				<cfif len(GetBasket.Addons) GT 1>
					<cfset Message = Message & Replace(GetBasket.Addons, "<br/>", LineBreak, "All")>
				</cfif>		
		
				<cfif len(GetBasket.dropship_note)>
					<cfset Message = Message & "Note: " & GetBasket.dropship_note & LineBreak>
				</cfif>		
				
				<cfset Ext = (GetBasket.dropship_cost * GetBasket.dropship_qty)>
		
				<cfset Message = Message & "Item Total: " & LSCurrencyFormat(Ext) & LineBreak & LineBreak>
				
			</cfif>

		</cfloop>

		<cfset Message = Message & "Shipping: " & Getorder.ShipType & LineBreak & LineBreak>
		
		<cfif len(qry_get_po.notes)>
			<cfset Message = Message & "Additional Info: " & qry_get_po.notes & LineBreak>
		</cfif>	

		<!--- Send Purchase Order Email ---->
		<cfmail to="#Check_Account.dropship_email#"
        from="#request.appsettings.merchantemail#"
        subject="#request.appsettings.SiteName# Purchase Order #qry_get_po.po_no#"
		server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
		<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
		<cfmailparam name="Reply-To" Value="#request.appsettings.merchantemail#">

Purchase Order ###qry_get_po.po_no#
PO Date: #LSDateFormat(qry_get_po.printdate)#

Bill to: #request.appsettings.sitename#
Customer Order Number #Evaluate(attributes.Order_No + get_order_settings.BaseOrderNum)#
-------------------------
#BillString#

<cfif GetShipTo.RecordCount>#ShipString#</cfif>

#Message#
<cfif len(Getorder.GiftCard)>
Gift card to read: #Getorder.GiftCard#
</cfif>
<cfif len(Getorder.Delivery)>
Ship to arrive by: #Getorder.Delivery#
</cfif>
<cfif len(Getorder.Comments)>
Customer Comments: #Getorder.Comments#
</cfif>

</cfmail>
		
		<!--- Update the purchase order record to show the PO was emailed --->
		<cfquery name="Update_PO" datasource="#Request.ds#" 
		username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Order_PO
				SET 	
				PO_Status = 'emailed',
				PO_Open = 1
				WHERE Order_PO_ID = #attributes.Order_PO_ID#
				</cfquery>
	
	</cfif>
	
</cfloop>


</cfif> <!-- accounts exist --->


<cfif EmailDropShip>
<!--- Email Packing Slip to dropshipper ---------------->

<cfset Message = "">

<!---- Loop through the basket and see if there are any products left to include in Packing Slip email --->

<cfloop query="GetBasket">

	<!--- Add basket item if not assigned to account OR if not all quantity is assigned --->
	<cfif GetBasket.dropship_account_id is "" OR (GetBasket.Quantity - GetBasket.dropship_qty) gt 0>	
	
		<cfset Message = Message & GetBasket.Name>

		<cfif len(GetBasket.SKU) AND GetBasket.SKU IS NOT 0>
			<cfset Message = Message & " (##" & GetBasket.SKU & ")">
		</cfif>

		<cfset Message = Message & ": " &  (GetBasket.Quantity - GetBasket.dropship_qty)  & LineBreak>

		<cfif len(GetBasket.Options) GT 1>
			<cfset Message = Message & "Options: " & GetBasket.Options & LineBreak>
		</cfif>

		<cfif len(GetBasket.Addons) GT 1>
			<cfset Message = Message & Replace(GetBasket.Addons, "<br/>", LineBreak, "All")>
		</cfif>		
				
		<cfif len(GetBasket.dropship_note)>
			<cfset Message = Message & "Note: " & GetBasket.dropship_note & LineBreak>
		</cfif>				
		
		<cfset Ext = ((GetBasket.Price + GetBasket.OptPrice + GetBasket.AddonMultP - GetBasket.DiscAmount) * 
		(GetBasket.Quantity - GetBasket.dropship_qty) - GetBasket.PromoAmount)>

		<cfset Message = Message & "Item Total: " & LSCurrencyFormat(Ext) & LineBreak & LineBreak>

		<cfset SubTotal = SubTotal + Ext>

	</cfif>
	
</cfloop>


<!---- If the Message is not blank, send the email ----->
<cfif len(message)>

	<cfset Message = LineBreak & "Items Ordered" & LineBreak & "-----------------" & LineBreak & Message>

	<cfset Message = Message & "====================" & LineBreak & LineBreak>

	<cfset Message = Message & "Subtotal: " & LSCurrencyFormat(SubTotal) & LineBreak>

	
	<!--- Email Packing Slip to Drop-Shipper --->
	<cfmail to="#get_Order_Settings.DropEmail#"
        from="#GetCustomer.Email#"
        subject="Received Order Number #Evaluate(attributes.Order_No + get_order_settings.BaseOrderNum)#"
		server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
		<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
		<cfmailparam name="Reply-To" Value="#GetCustomer.Email#">
		
Please ship the following order:

Order Number #(attributes.Order_No + get_order_settings.BaseOrderNum)#
-------------------------
#BillString#

<cfif GetShipTo.RecordCount>#ShipString#</cfif>

#Message#
<cfif len(Getorder.GiftCard)>
Gift card to read: #Getorder.GiftCard#
</cfif>
<cfif len(Getorder.Delivery)>
Ship to arrive by: #Getorder.Delivery#
</cfif>
<cfif len(Getorder.Comments)>
Customer Comments: #Getorder.Comments#
</cfif>

</cfmail>
		
</cfif>


</cfif>