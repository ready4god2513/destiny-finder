<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This custom tag is used to display a Purchase Order for printing. Called from act_printing.cfm --->

<!--- 
Parameters:
	Order_NO - the order number to retrieve
	Datasource = database to query
	Password = password for database
	username = username for database
 --->
<cfif isDefined("ThisTag.ExecutionMode") AND ThisTag.ExecutionMode eq "END">
	<cfexit method="EXITTAG">
</cfif>	
	
<cfinclude template="../../qry_get_order_settings.cfm">
 
<cfparam name="Attributes.Order_no" default="0">

<cfset User_ID = Session.User_ID>

<!--- getorder --->
<cfinclude template="qry_order.cfm">


<cfif getorder.RecordCount IS 0>

<p><div class="formtext" align="center"><b>Sorry, there does not appear to be an purchase order with this number in the database.</b></div></p>

<cfelse>

	
		<!--- Output Purchase Order ----->
<cfmodule template="../../../customtags/format_letterhead.cfm">

		<cfoutput>
		
<table width="95%" border="0" cellspacing="4" cellpadding="5" align="center" class="formtext">

	<tr>
		<!--- PO Date, Customer PO --->
		<td valign="top" width="33%">
			<!--- #request.appsettings.merchant# <br/> --->
			<strong>SHIP TO:</strong><br/>

			<cfif getorder.ShipTo IS 0>
				<cfmodule template="../../order/dsp_cust.cfm" Customer_ID="#getorder.Customer_ID#" />

			<cfelse>
				<cfmodule template="../../order/dsp_shipto.cfm" ShipTo="#getorder.ShipTo#" />
			</cfif>
			<br/>
			
		</td> 
		
		<!--- Blank --->
		<td width="33%">&nbsp;</td>
		
		<!--- PO Number, Account--->
		<td valign="top" width="33%">
			<span class="formtitle">PACKING SLIP</span><br/>
			<span class="formtitle">Order No. #(getorder.Order_No + Get_Order_Settings.BaseOrderNum)#</span><br/>
			#LSDateFormat(getorder.dateordered, "mmmm d, yyyy")# <br/>
		</td>
	</tr>

	<tr>
		<!--- Ship To --->
		<td valign="top">
		&nbsp;
			
		</td>

		
		<td valign="top">
		&nbsp;
		</td>
		
		<!--- Shipping info --->
		<td valign="top">
		<cfif len(getorder.datefilled)>
			<i><b>Shipped On:</b></i> #LSDateFormat(getorder.datefilled, "mmmm d, yyyy")#
			<cfif len(getorder.Shipper)><br/>Shipped by #getorder.Shipper#</cfif>
			<cfif len(getorder.Tracking)><br/>Tracking Numbers: #getorder.Tracking#</cfif>
		</cfif>
		</td>
	</tr>
	</cfoutput>
</table>



<!--- Output PO Items getorder_items--->
<table width="94%" border="0" cellspacing="4" cellpadding="0" class="formtext" align="center">

	<!--- Header table --->
	<tr>
		<td>Qty</td>
		<td>Item No.</td>
		<td>Item</td>
		<td>Status</td>
		<!--- <td align="right">Price after Options</td>
		<td align="right">Ext Price</td> --->
	</tr>
	<tr>
		<td colspan="4">
			<cfmodule template="../../../customtags/putline.cfm" linetype="thick"/>
		</td>
	</tr>
	
<!--- List Items in Basket --->
<cfoutput query="GetOrder">
	
	<!--- output only products shipped by company --->
	<cfif Quantity - dropship_qty gt 0>
	<tr>
		<td>#evaluate(Quantity - dropship_qty)#</td>
		<td>#sku#</td>
		<td>#Name#
			<div class="smallformtext">
			<cfif Len(Trim(GetOrder.Options))><i>Options: #GetOrder.Options#</i><br/></cfif>	
			<cfif Len(Trim(GetOrder.Addons))><i>#GetOrder.Addons#</i><br/></cfif>
			<cfif len(dropship_note)>#dropship_note#</cfif></div>
		</td>
		<td>Shipped</td>
		<!--- <td align="RIGHT">#LSCurrencyFormat(GetOrder.Price + GetOrder.OptPrice + AddonMultP - GetOrder.DiscAmount)#</td>
		<cfset Ext = ((GetOrder.Price + GetOrder.OptPrice + AddonMultP - GetOrder.DiscAmount) * (Quantity - dropship_qty))>
		<td align="RIGHT">#LSCurrencyFormat(Ext)#</td> --->
	</tr>
	
	
	<tr>
		<td colspan="4">
			<cfmodule template="../../../customtags/putline.cfm" linetype="thin"/>
		</td>
	</tr>

	</cfif><!--- quantity Check --->
</cfoutput>

	
	<tr>
		<td colspan="4">
			<br/>
<strong>Shipping Method:</strong> <cfoutput>#getorder.shiptype#</cfoutput><br/><br/>

<cfif len(GetOrder.Delivery)>
	<strong>Ship to arrive by:</strong> <cfoutput>#GetOrder.Delivery#</cfoutput><br/><br/>
</cfif>
<cfif len(GetOrder.Giftcard)>
	<strong>Giftcard:</strong> <cfoutput>#GetOrder.Giftcard#</cfoutput><br/><br/>
</cfif>
<cfif len(GetOrder.Comments)>
	<strong>Comments:</strong> <cfoutput>#GetOrder.Comments#</cfoutput><br/><br/>
</cfif>
		</td>
	</tr>
	
</table>


</cfmodule>
</cfif>


