
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Send email confirmations to the administrator, affiliates, drop-shippers and user when an order is placed as configured by the store settings. Called from checkout\dsp_receipt.cfm --->

<cfparam name="EmailCDone" default="1">
<cfparam name="EmailADone" default="1">

<!--- Only run if confirmation/s turned on --->
<cfif get_order_settings.EmailAdmin OR get_order_settings.EmailUser>
	
	<cfset SubTotal = 0>
	<cfset Mail = "Yes">
	<cfset NewOrderNum = New_OrderNo + get_Order_Settings.BaseOrderNum>
	
	<cfinclude template="../put_billto.cfm">
	<cfset BillString = String>
	
	<cfif GetShipTo.RecordCount>
		<cfinclude template="../put_shipto.cfm">
		<cfset ShipString = String>
	</cfif>
	
	
	<!--- Initialize the content of the message --->
	<cfset Message = LineBreak & "Items Ordered" & LineBreak & "-----------------" & LineBreak>
	
	
	<!--- Loop through the basket and create a line for each item ordered --->
	
	<cfloop query="qry_Get_Basket">
	
		<cfset Message = Message & qry_get_basket.Name>
		
		<cfif len(qry_get_basket.SKU) AND qry_get_basket.SKU IS NOT 0>
			<cfset Message = Message & " (##" & qry_get_basket.SKU & ")">
		</cfif>
		
		<cfset Message = Message & ": " &  qry_get_basket.Quantity & LineBreak>
		
		<cfif len(qry_get_basket.Options) GT 1>
			<cfset Message = Message & "Options: " & qry_get_basket.Options & LineBreak>
		</cfif>
		
		<cfif len(qry_get_basket.Addons) GT 1>
			<cfset Message = Message & Replace(qry_get_basket.Addons, "<br/>", LineBreak, "All")>
		</cfif>
		
		<cfset ProdPrice = qry_get_basket.Price + qry_get_basket.OptPrice + qry_Get_Basket.AddonMultP>
		
		<cfset Ext = (ProdPrice - qry_Get_Basket.DiscAmount- qry_get_basket.QuantDisc) * qry_Get_Basket.Quantity>
		<cfset Ext = Ext - qry_Get_Basket.PromoAmount>
		
		<cfset Message = Message & "Item Total: " & LSCurrencyFormat(Ext) & LineBreak & LineBreak>
		
		<cfset SubTotal = SubTotal + Ext>
	
	</cfloop>
	
	
	<!--- Print order total --->
	
	<cfset Message = Message & "====================" & LineBreak & LineBreak>
	
	<cfset Message = Message & "Subtotal: " & LSCurrencyFormat(SubTotal) & LineBreak>
	
	<cfif GetTotals.AddonTotal>
		<cfset Message = Message & "Additional Items: " & LSCurrencyFormat(GetTotals.AddonTotal) & LineBreak>
	</cfif>
	
	<cfif GetTotals.OrderDisc>
		<cfset Message = Message & "Discounts: " & LSCurrencyFormat(GetTotals.OrderDisc) & LineBreak>
	</cfif>
	
	<cfif GetTotals.Tax>
		<cfset Message = Message & "Tax: " & LSCurrencyFormat(GetTotals.Tax) & LineBreak>
	</cfif>
	
	<cfset Message = Message & "Shipping (" & GetTotals.ShipType & "): " & LSCurrencyFormat(GetTotals.Shipping) & LineBreak>
	
	<cfif GetTotals.Credits>
		<cfset Message = Message & "Credits: " & LSCurrencyFormat(GetTotals.Credits) & LineBreak>
	</cfif>
	
	<cfset Message = Message & "Total: " & LSCurrencyFormat(GetTotals.OrderTotal) & LineBreak>


</cfif>

<!--- Email copy of order to Merchant --->

<cfif get_order_settings.EmailAdmin and len(get_order_settings.OrderEmail)>

<cftry>
<cfmail to="#get_order_settings.OrderEmail#"
        from="#GetCustomer.Email#"
        subject="Order Received!"
		server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
		<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
		<cfmailparam name="Reply-To" Value="#GetCustomer.Email#">

A new order has been received!

Order Number #NewOrderNum#
-------------------------
#BillString#
<cfif GetShipTo.RecordCount>#ShipString#</cfif>
#Message#
<cfif len(GetTotals.GiftCard)>
Gift card to read: #GetTotals.GiftCard#
</cfif>
<cfif len(GetTotals.Delivery)>
Ship to arrive by: #GetTotals.Delivery#
</cfif>
<cfif len(GetTotals.Comments)>
Customer Comments: #GetTotals.Comments#
</cfif>
<!--- Output Custom Fields --->
<cfloop index="x" from="1" to="3">
	<cfif len(GetTotals["CustomText" & x][1])>
		#get_Order_Settings["CustomText" & x][1]#: #GetTotals["CustomText" & x][1]#
	</cfif>
</cfloop>
<cfloop index="x" from="1" to="2">
	<cfif len(GetTotals["CustomSelect" & x][1])>
		#get_Order_Settings["CustomSelect" & x][1]#: #GetTotals["CustomSelect" & x][1]#
	</cfif>
</cfloop>
<!--- <cfif isDefined("attributes.CVV2") AND get_Order_Settings.CCProcess IS "None">
Card Code: #attributes.CVV2#
</cfif> --->
</cfmail>

<cfcatch type="ANY">
	<cfset EmailADone = 0>
</cfcatch>
</cftry>

</cfif>



<!--- Email copy of order to customer --->

<cfif get_order_settings.EmailUser>

	<cfset mergeContent="Order Number #NewOrderNum#" & linebreak & "-------------------------" 
	& linebreak & BillString>

	<cfif GetShipTo.RecordCount>
	<cfset mergeContent= mergeContent & ShipString>
	</cfif>

	<cfset mergeContent= mergeContent & Message>

	<cfif len(GetTotals.GiftCard)>
		<cfset mergeContent= mergeContent & "Gift card to read: " & GetTotals.GiftCard>
	</cfif>
	<cfif len(GetTotals.Delivery)>
		<cfset mergeContent= mergeContent & "Ship to arrive by: " & GetTotals.Delivery>
	</cfif>
	<cfif len(GetTotals.Comments)>
		<cfset mergeContent= mergeContent & "Customer Comments: " & GetTotals.Comments>
	</cfif>
	<cfif membership_valid AND Session.CheckoutVars.Download>
		<cfset mergeContent= mergeContent & "Access to your purchased files is available immediately. Log on to the web site and go to the My Account page to access the downloads.">
	<cfelseif membership_valid AND Session.CheckoutVars.Membership>
		<cfset mergeContent= mergeContent & "You now have immediate access to our membership area. Log on to the web site and go to the My Account page to view the status of your membership at any time.">
	<cfelseif NOT membership_valid AND Session.CheckoutVars.Download>
		<cfset mergeContent= mergeContent & "Access to your purchased content will be available when your order has been completed. Log on to the web site and check the My Account page for details.">
	<cfelseif NOT membership_valid AND Session.CheckoutVars.Membership>
		<cfset mergeContent= mergeContent & "Access to the membership area of our site will be available when your order has been completed. Log on to the web site and check the My Account page for details.">
	</cfif>

	
	<cftry>

	<cfinvoke component="#Request.CFCMapping#.global" 
		method="sendAutoEmail" Email="#GetCustomer.Email#" 
		MailAction="OrderRecvdCustomer" MergeContent="#mergeContent#">

	<cfcatch type="ANY">
		<cfset EmailCDone = 0>
	</cfcatch>
	</cftry>

</cfif>

<!--- Email copy of order to Affiliate --->
<cfif get_order_settings.EmailAffs>

	<cfquery name="GetAffiliate" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT U.User_ID 
		FROM #Request.DB_Prefix#Users U, #Request.DB_Prefix#Affiliates A
		WHERE A.AffCode = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetTotals.Affiliate#"> 
		AND A.Affiliate_ID = U.Affiliate_ID
	</cfquery>


	<cfif GetAffiliate.RecordCount>

		<cfset mergeContent="Order Number #NewOrderNum#" & linebreak & "-------------------------" 
			& linebreak & linebreak & Message>
	
		<cftry>
		
			<cfinvoke component="#Request.CFCMapping#.global" 
				method="sendAutoEmail" UID="#GetAffiliate.User_ID#" 
				MailAction="OrderRecvdAffiliate" MergeContent="#mergeContent#">
	
		<cfcatch type="ANY">
		</cfcatch>
		
		</cftry>
	</cfif>
</cfif>


<!--- Email copy of order to Drop-Shipper and create purchase orders --->
<cfif get_order_settings.EmailDrop and len(get_order_settings.DropEmail) AND get_order_settings.EmailDropWhen IS "Placed">
	<cfset EmailDropShip = "yes">
<cfelse>
	<cfset EmailDropShip = "no">
</cfif>

<cfset attributes.Order_No = New_OrderNo>
<cfinclude template="../../admin/order/act_maildrop.cfm">


