<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to edit the shopping cart information: shipping, tax, credits, etc. Called from dsp_order.cfm --->

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Edit Order Totals"
	width="500"
	required_Fields="0"
	>
	
	<cfoutput>
	
	<!--- Output Basket Headers --->
	<tr>
		<td><b>Qty.</b></td>
		<td><b>Item to Purchase</b></td>
		<td valign="top"><b>Item No.</b></td>
		<td align="RIGHT"><b>Price</b></td>
		<td align="RIGHT"><b>Ext. Price</b></td>
	</tr>

<cfset SubTotal = 0>
<cfset PromoTotal = 0>

<!--- List Items in Basket --->
<cfloop query="GetOrder">
	
	<!---- Item Description --->
	<tr>
		<td align="CENTER">#GetOrder.Quantity#</td>
		<td>#GetOrder.Name#
			<div class="smallformtext">
			<cfif Len(Trim(GetOrder.Options))>
				<i>Options: #GetOrder.Options#</i><br/></cfif>
			<cfif Len(Trim(GetOrder.Addons))>
				<i>#GetOrder.Addons#</i><br/></cfif></div>
		</td>
		<td><cfif GetOrder.SKU IS NOT 0>#GetOrder.SKU#</cfif>&nbsp;</td>
		<cfset ProdPrice = GetOrder.Price + GetOrder.OptPrice + AddonMultP - GetOrder.DiscAmount>
		<td align="RIGHT">#LSCurrencyFormat(ProdPrice)#</td>
		<cfset Ext = ProdPrice * GetOrder.Quantity>
		<cfset PromoTotal = PromoTotal + PromoAmount>
		<td align="RIGHT">#LSCurrencyFormat(Ext)#</td>
	</tr>
	<cfset SubTotal = SubTotal + Ext>
</cfloop>



<cfif GetOrder.OrderDisc>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Discounts:</b></div></td>
		<td align="RIGHT"><div class="formtext">-#LSCurrencyFormat(GetOrder.OrderDisc)#</div></td>
	</tr>
</cfif>
<cfif PromoTotal>
<tr>
	<td colspan="4" align="RIGHT"><b>Promotions:</b></td>
	<td align="RIGHT"><div class="formtext">-#LSCurrencyFormat(PromoTotal)#</div></td>
</tr>
</cfif>

	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Subtotal:</b></div></td>
		<td align="RIGHT"><div class="formtext">#LSCurrencyFormat(SubTotal-GetOrder.OrderDisc-PromoTotal)#</div></td>
	</tr>

<cfif GetOrder.AddonTotal>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Additional Items:</b></div></td>
		<td align="RIGHT"><div class="formtext">+#LSCurrencyFormat(GetOrder.AddonTotal)#</div></td>
	</tr>
</cfif>

<cfif GetOrder.Tax>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Total Taxes:</b></div></td>
		<td align="RIGHT"><div class="formtext">#LSCurrencyFormat(GetOrder.Tax)#</div></td>
	</tr>
</cfif>


	<form action="#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no##request.token2#" method="post">

	<tr>
		<td colspan="4" align="RIGHT"><b>Freight Charges:</b></td>
		<td align="RIGHT"><input type="text" name="Freight"  class="formfield" value="#NumberFormat(GetOrder.Freight, '0.00')#" size="7" maxlength="15"/></td>
	</tr>

	<tr>
		<td colspan="4" align="RIGHT"><b>Shipping (<input type="text" size="39" name="ShipType" value="#GetOrder.ShipType#" class="formfield"/>):</b></td>
		<td align="RIGHT"><input type="text" name="ShippingTotal"  class="formfield" value="#NumberFormat(GetOrder.Shipping, '0.00')#" size="7" maxlength="15"/></td>
	</tr>



<cfif GetOrder.Credits>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Credits:</b></div></td>
		<td align="RIGHT"><div class="formtext">-#LSCurrencyFormat(GetOrder.Credits)#</div></td>
	</tr>
</cfif>

<!---- Admin Credit ---->
	<tr>
		<td colspan="4" align="RIGHT"><b>Store Credit: <input type="text" size="40" name="AdminCreditText" value="#GetOrder.AdminCreditText#" class="formfield"/>:</b></td>
		<td align="RIGHT">- <input type="text" size="7" name="AdminCredit"  value="#NumberFormat(GetOrder.AdminCredit, '0.00')#" maxlength="15" class="formfield"/></td>
	</tr>


	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Total:</b></div></td>
		<td align="RIGHT"><div class="formtext">#LSCurrencyFormat(GetOrder.OrderTotal)#</div></td>
	</tr>
	
	<tr>
		<td height="45" colspan="5" align="center">
			<input type="submit" name="basket_submit" value="Update Order" class="formbutton"/>
			<input type="button" value="Cancel" onclick="javascript:location.href='#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&redirect=1#request.token2#'" class="formbutton"/>
		</td>
	</tr>
	</form>	
	
</cfoutput>

</cfmodule>


	
