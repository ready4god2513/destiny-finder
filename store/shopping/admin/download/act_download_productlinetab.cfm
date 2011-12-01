<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This generates the order download, putting information for one product per line --->

<cfscript>
	function escQuotes(str) {
		return Replace(str,'"','""', 'ALL');
	}	
</cfscript>

<cfset Tab=Chr(9)>
<cfset LineFeed=chr(13) & chr(10)>
<cfparam name="attributes.lastordernumber" default="0">
<!---
<cfset Tab= "|">
<cfset LineFeed= "^CRLF^">
---->

<cfset FilePath = GetDirectoryFromPath(ExpandPath("*.*")) & "shopping#request.slash#admin#request.slash#download">
<cfset theFile = "#FilePath##request.slash#products.csv">
<cfset export_data = "">

<cfset addresslist = "FirstName,LastName,Company,Address1,Address2,City,County,State,Zip,Country,Phone,Phone2,Fax,Email,Resident">

<!--- Set the header row --->
<cfset headers = "Order_No#tab#DateOrdered#tab#AffiliateCode#tab#OrderTotal#tab#Tax#tab#Shipping#tab#ShipType#tab#Shipper#tab#Tracking#tab#Freight#tab#Credits#tab#OrderDisc#tab#AddonTotal#tab#Coupon_Code#tab#Cert_Code#tab#PO_Number#tab#AdminCredit#tab#AdminCreditText#tab#GiftCard#tab#Delivery#tab#Comments#tab#CardType#tab#NameonCard#tab#CardNumber#tab#Expires#tab#AuthNumber#tab#InvoiceNum#tab#TransactNum#tab#Paid#tab#Void#tab#Customer_ID">

<!--- Add address headers --->
<cfloop index="fieldname" list="#addresslist#">
	<cfset headers = headers & tab & "Billto_#fieldname#">
</cfloop>
<cfloop index="fieldname" list="#addresslist#">
	<cfset headers = headers & tab & "Shipto_#fieldname#">
</cfloop>

<cfset headers = headers & "#tab#Product_ID#tab#SKU#tab#Name#tab#Description#tab#Options#tab#Addons#tab#ProdPrice#tab#OptPrice#tab#AddonMultP#tab#AddonNonMultP#tab#Disc_Code#tab#DiscAmount#tab#Promo_Code#tab#PromoQuant#tab#PromoAmount#tab#Quantity#tab#ProdTotal#LineFeed#">

<!--- Write out the file --->
<cffile action="WRITE" file="#theFile#" output="#headers#" nameconflict="OVERWRITE" addnewline="No">

<cfset lastorder = 0>
<cfset BillLine = "">

<cfloop query="GetOrders">
	
	<cfset strShipTo = StructNew()>
	<cfset strBillTo = StructNew()>
	
	<!--- Set billing address structure --->
	<cfloop index="fieldname" list="#addresslist#">
		<cfset strBillTo[fieldname] = GetOrders['Billto_' & fieldname][currentrow]>
	</cfloop>
	
	<!--- If no shipping address, use the billing address --->
	<cfif NOT len(GetOrders.Shipto_FirstName)>
		<cfloop index="fieldname" list="#addresslist#">
			<cfset strShipTo[fieldname] = strBillTo[fieldname]>
		</cfloop>
	
	<cfelse>
		<cfloop index="fieldname" list="#addresslist#">
			<cfset strShipTo[fieldname] = GetOrders['Shipto_' & fieldname][currentrow]>
		</cfloop>
	</cfif>
	
	<cfscript>
		//Start the current order line
		if (NOT len(strBillTo['State']) OR strBillTo['State'] IS "Unlisted") 
			strBillTo['State'] = GetOrders['Billto_State2'][currentrow];
			
		if ((NOT len(strShipTo['State']) OR strShipTo['State'] IS "Unlisted") AND NOT len(GetOrders.Shipto_FirstName))
			strShipTo['State'] = GetOrders['Billto_State2'][currentrow];
		else if (NOT len(strShipTo['State']) OR strShipTo['State'] IS "Unlisted")
			strShipTo['State'] = GetOrders['Shipto_State2'][currentrow];
			
	//	strBillTo['Resident'] = strBillTo[YesNoFormat(strBillTo['Resident'])];
	//	strShipTo['Resident'] = strShipTo[YesNoFormat(strShipTo['Resident'])];
			
		if (GetOrders.ShipType is "No Shipping")
			var_ShipType = "";
		else
			var_ShipType = GetOrders.ShipType;
			
		//This is used to save last processed order number, not looping.
		attributes.lastordernumber = GetOrders.Order_No + Get_Order_Settings.BaseOrderNum;
		
		BillLine = BillLine & '#(Get_Order_Settings.BaseOrderNum+Order_No)##tab##DateFormat(DateOrdered,'mm/dd/yyyy')##tab##Affiliate##tab##OrderTotal##tab##Tax##tab##Shipping##tab#"#escQuotes(var_ShipType)#"#tab#"#escQuotes(Shipper)#"#tab#"#escQuotes(Tracking)#"#tab##Freight##tab##Credits##tab##OrderDisc##tab##AddonTotal##tab#"#escQuotes(Coup_Code)#"#tab#"#escQuotes(Cert_Code)#"#tab#"#escQuotes(PO_Number)#"#tab##AdminCredit##tab#"#escQuotes(AdminCreditText)#"#tab#"#escQuotes(GiftCard)#"#tab#"#escQuotes(Delivery)#"#tab#"#escQuotes(Comments)#"#tab#"#escQuotes(CardType)#"#tab#"#escQuotes(NameonCard)#"#tab#"#escQuotes(CardNumber)#"#tab##Expires##tab#"#escQuotes(AuthNumber)#"#tab#"#escQuotes(InvoiceNum)#"#tab#"#escQuotes(TransactNum)#"#tab##Paid##tab##Void##tab##Customer_ID#';
		
	</cfscript>
	
	<!--- Address Fields --->
	<cfloop index="fieldname" list="#addresslist#">
		<cfset BillLine = BillLine & tab & '"#escQuotes(strBillTo[fieldname])#"'>
	</cfloop>
	<cfloop index="fieldname" list="#addresslist#">
		<cfset BillLine = BillLine & tab & '"#escQuotes(strShipTo[fieldname])#"'>
	</cfloop>	
	

	<cfset ItemPrice = Price + OptPrice + AddonMultP - DiscAmount>
	<cfset Ext = ItemPrice * Quantity>
	<cfset ProdTotal = Ext - AddonNonMultP - PromoAmount>

	<cfset BillLine = BillLine & '#tab##Product_ID##tab##SKU##tab#"#escQuotes(Name)#"#tab#"#escQuotes(Description)#"#tab#"#escQuotes(Options)#"#tab#"#escQuotes(Addons)#"#tab##Price##tab##OptPrice##tab##AddonMultP##tab##AddonNonMultP##tab#"#escQuotes(Disc_Code)#"#tab##DiscAmount##tab#"#escQuotes(Promo_Code)#"#tab##PromoQuant##tab##PromoAmount##tab##Quantity##tab##ProdTotal##LineFeed#'>
	
	<cfset attributes.lastordernumber = Order_No + Get_Order_Settings.BaseOrderNum>
	
</cfloop>

<cffile action="append" file="#theFile#" output="#BillLine#">

<cfset do="set">
<cfinclude template="act_lastordernumber.cfm">


<!--- Send down to the user --->
<cfheader name="Content-Disposition" value="attachment; filename=#request.ds#_Orders_#attributes.lastordernumber#.txt">
<cfcontent type="text/plain" file="#theFile#" deletefile="No" reset="No">

