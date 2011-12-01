
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called by put_order.cfm to display the customer's order --->

<cfparam name="Attributes.Order_No" default="0">
<cfparam name="Attributes.Customer_ID" default="0">

<!--- Get the full order information --->
<cfquery name="GetOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#Order_Items O, #Request.DB_Prefix#Order_No N
WHERE O.Order_No = <cfqueryparam value="#Attributes.Order_No#" cfsqltype="CF_SQL_INTEGER"> 
AND O.Order_No = N.Order_No
</cfquery>

<cfquery name="GetCust" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
SELECT * FROM #Request.DB_Prefix#Customers 
WHERE Customer_ID = <cfqueryparam value="#Attributes.Customer_ID#" cfsqltype="CF_SQL_INTEGER"> 
</cfquery>

<!--- Get Shipping Settings --->
<cfinclude template="../qry_ship_settings.cfm">
<cfinclude template="../qry_get_order_settings.cfm">


<cfif thistag.ExecutionMode is "Start">

<table width="92%" border="0" cellspacing="6" cellpadding="0" class="formtext" align="center">

	<!--- Header table --->
	<tr>
		<td>Item No.</td>
		<td>Item</td>
		<td>Qty</td>
		<td align="right">Unit&nbsp;Price</td>
		<td align="right">Ext.&nbsp;Price</td>
	</tr>
	<tr>
		<td colspan="5">
			<cfmodule template="../../customtags/putline.cfm" linetype="thick"/>
		</td>
	</tr>
	
<cfset SubTotal = 0>
<cfset PromoTotal = 0>

<!--- List Items in Basket --->
<cfoutput query="GetOrder">

<!--- Output Information for Current Basket Item --->
<tr>
<td valign="top"><cfif SKU IS NOT 0>#SKU#</cfif>&nbsp;</td>
<td valign="top">#Name#
<div class="smallformtext">
<cfif Len(Trim(Options))><i>Options: #Options#</i><br/></cfif>
<cfif Len(Trim(Addons))><i>#Addons#</i><br/></cfif>
</div>
</td>

<td valign="top">#Quantity#</td>

	<cfset ItemPrice = Price + OptPrice + AddonMultP - DiscAmount>
	<cfset Ext = ItemPrice * Quantity>
	<cfset PromoTotal = PromoTotal + PromoAmount>
	
	<td align="right" valign="top">#LSCurrencyFormat(ItemPrice)#</td>
	<td align="right" valign="top">#LSCurrencyFormat(Ext)#</td>
</tr>

	<tr>
		<td colspan="5">
			<cfmodule template="../../customtags/putline.cfm" linetype="thin" />
		</td>
	</tr>
<cfset SubTotal = SubTotal + Ext>
</cfoutput>

<cfoutput>
<cfif GetOrder.AddonTotal>
<tr>
	<td colspan="4" align="right"><b>Additional Items:</b></td>
	<td align="right"><div class="formtext">+#LSCurrencyFormat(GetOrder.AddonTotal)#</div></td>
</tr>
</cfif>

<cfif GetOrder.OrderDisc>
<tr>
	<td colspan="4" align="right"><b>Discounts:</b></td>
	<td align="right">-#LSCurrencyFormat(GetOrder.OrderDisc)#</td>
</tr>
</cfif>
<cfif PromoTotal>
<tr>
	<td colspan="4" align="right"><b>Promotions:</b></td>
	<td align="right"><div class="formtext">-#LSCurrencyFormat(PromoTotal)#</div></td>
</tr>
</cfif>

<!--- Output Basket Total --->
	<tr><td colspan="4" align="right"><b>Subtotal:</b></td>
	<td align="right"><div class="formtext">#LSCurrencyFormat(SubTotal+GetOrder.AddonTotal-GetOrder.OrderDisc-PromoTotal)#</div></td>
</tr>

<cfif GetOrder.Tax>
<tr>
	<td colspan="4" align="right"><b>Total Tax:</b></td>
	<td align="right">#LSCurrencyFormat(GetOrder.Tax)#</td>
</tr>
</cfif>

<cfif NOT ShipSettings.ShowFreight AND GetOrder.Freight IS NOT 0>
<tr>
	<td colspan="4" align="right"><b>Shipping (#GetOrder.ShipType#):</b></td>
	<td align="right"><div class="formtext">#LSCurrencyFormat(GetOrder.Shipping+GetOrder.Freight)#</div></td>
</tr>

<cfelseif GetOrder.Shipping IS NOT 0 OR NOT ListFindNoCase("No Shipping,Freight", GetOrder.ShipType)>
<tr>
	<td colspan="4" align="right"><b>Shipping (#GetOrder.ShipType#):</b></td>
	<td align="right"><div class="formtext">#LSCurrencyFormat(GetOrder.Shipping)#</div></td>
</tr>
</cfif>

<cfif ShipSettings.ShowFreight AND GetOrder.Freight IS NOT 0>
<tr>
	<td colspan="4" align="right"><b>Freight Charges:</b></td>
	<td align="right"><div class="formtext">#LSCurrencyFormat(GetOrder.Freight)#</div></td>
</tr>
</cfif>


<cfif GetOrder.Credits>
<tr>
	<td colspan="4" align="right"><b>Credits:</b></td>
	<td align="right">-#LSCurrencyFormat(GetOrder.Credits)#</td>
</tr>
</cfif>

<cfif GetOrder.AdminCredit>
	<tr>
		<td colspan="4" align="right"><b>#GetOrder.AdminCreditText#:</b></td>
		<td align="right">-#LSCurrencyFormat(GetOrder.AdminCredit)#</td>
	</tr>
</cfif>

<tr>
	<td colspan="4" align="right"><b>Total:</b></td>
	<td align="right">#LSCurrencyFormat(GetOrder.OrderTotal)#</td>
</tr>

	
	<tr>
		<td colspan="5">
<br/>		
<cfif len(GetOrder.Coup_Code)>
<strong>Coupon used on this Order:</strong> #GetOrder.Coup_Code#<br/><br/>
</cfif>

<cfif len(GetOrder.Cert_Code)>
<strong>Gift Certificate used on this Order:</strong> #GetOrder.Cert_Code#<br/><br/>
</cfif>

<cfif len(GetOrder.Giftcard)>
<strong>Giftcard:</strong> #GetOrder.Giftcard#<br/><br/>
</cfif>

<!--- Output custom checkout fields --->
<cfloop index="x" from="1" to="3">
	<cfif len(Evaluate('GetOrder.CustomText' & x))>
	<strong>#Evaluate('get_Order_Settings.CustomText' & x)#: </strong> 
	#Evaluate('GetOrder.CustomText' & x)#<br/><br/>
	</cfif>
</cfloop>
<cfloop index="x" from="1" to="2">
	<cfif len(Evaluate('GetOrder.CustomSelect' & x))>
	<strong>#Evaluate('get_Order_Settings.CustomSelect' & x)#: </strong> 
	#Evaluate('GetOrder.CustomSelect' & x)#<br/><br/>
	</cfif>
</cfloop>

<cfif len(GetOrder.Comments)>
<strong>Comments:</strong> #GetOrder.Comments#<br/><br/>
</cfif>
		</td>
	</tr>
	
	<tr>
		<td colspan="5">
	<p><strong>Shipping Method:</strong> #getorder.shiptype#<br/>

<cfif len(GetOrder.Delivery)>
	<strong>Ship to arrive by:</strong> #GetOrder.Delivery#<br/>
</cfif>
	
	<cfif GetOrder.Filled AND NOT GetOrder.Void>
	<b>Order Shipped:</b> #LSDateFormat(GetOrder.DateFilled, "mmmm d, yyyy")# <br/>
		<cfif len(GetOrder.Shipper)>#GetOrder.Shipper#</cfif>
		<cfif len(GetOrder.Tracking)>Tracking Numbers: #GetOrder.Tracking#</cfif>
		<br/><br/>
	</cfif>
	</p>
		</td>
	</tr>
</cfoutput>
	
</table>

</cfif>