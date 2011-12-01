<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the shopping cart details on the order details page. Called from dsp_order.cfm --->

<!------->
<cfmodule template="../../../customtags/format_output_box.cfm"
	box_title=""
	border="0"
	width="600"
	>

<cfoutput>

<table border="0" width="600" cellspacing="0" cellpadding="5" bgcolor="###Request.GetColors.OutputTbgcolor#" align="center" class="formtext" style="color:###Request.GetColors.OutputTText#"> 
<!----
<table border="0" width="500" cellspacing="5" cellpadding="0" align="center" class="formtext" style="color:###Request.GetColors.inputTText#">---->
	
	<!--- Output Basket Headers --->
	<tr>
		<td align="center"><b>Qty.</b></td>
		<td align="left"><b>Item to Purchase</b></td>
		<td align="left" valign="top"><b>Item&nbsp;No.</b></td>
		<td align="RIGHT"><b>Price</b></td>
		<td align="RIGHT"><b>Ext.&nbsp;Price</b></td>
	</tr>
	
	<!---
	<tr>
		<td colspan="5" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>	
	</tr>
	--->
<cfset SubTotal = 0>
<cfset PromoTotal = 0>
<cfset basket_dropshipper_list = "">

<!--- List Items in Basket --->
<cfloop query="GetOrder">
	
	<!---- Item Description <tr>--->
	<cfif CurrentRow MOD 2 IS 0>
		<tr>
	<cfelse>
		<tr bgcolor="###Request.GetColors.outputtaltcolor#">
	</cfif>
	
	
		<td align="CENTER">#GetOrder.Quantity#</td>
		<td align="left">#GetOrder.Name#
			<div class="smallformtext">
			<cfif Len(Trim(GetOrder.Options))>
				<i>Options: #GetOrder.Options#</i><br/></cfif>
			<cfif Len(Trim(GetOrder.Addons))>
				<i>#GetOrder.Addons#</i><br/></cfif></div>
		</td>
		<td align="left"><cfif GetOrder.SKU IS NOT 0>#GetOrder.SKU#</cfif>&nbsp;</td>
		
		<cfset ItemPrice = GetOrder.Price + GetOrder.OptPrice + GetOrder.AddonMultP - GetOrder.DiscAmount>
		<cfset Ext = ItemPrice * GetOrder.Quantity>
		<cfset PromoTotal = PromoTotal + PromoAmount>
		
		<td align="RIGHT">#LSCurrencyFormat(ItemPrice)#</td>
		<td align="RIGHT">#LSCurrencyFormat(Ext)#</td>
	</tr>
	<cfset SubTotal = SubTotal + Ext>

	<!---- Dropship Info --->
	<cfif len(GetOrder.dropship_Account_ID) AND GetOrder.dropship_Account_ID is not 0>
		
		<!---<tr>--->
		<cfif CurrentRow MOD 2 IS 0>
		<tr>
		<cfelse>
		<tr bgcolor="###Request.GetColors.outputtaltcolor#">
		</cfif> 

		<td align="CENTER"></td>
		<td align="left">#GetOrder.dropship_Qty# from #vendors[GetOrder.dropship_Account_ID]#
			<cfif len(getOrder.dropship_note)><br/><i>#getorder.dropship_note#</i></cfif>
		</td>
		<td align="left">#GetOrder.dropship_SKU#	</td>
		<td align="RIGHT">#LSCurrencyFormat(GetOrder.dropship_cost)#</td>
		<td align="RIGHT"><!---
		<cfset dropship_Ext = (GetOrder.dropship_cost * GetOrder.dropship_Qty)>#LSCurrencyFormat(dropship_Ext)# --->
		</td>
	</tr>
		
		<cfif not listfind(basket_dropshipper_list,dropship_Account_ID)>
			<cfset basket_dropshipper_list = listappend(basket_dropshipper_list,dropship_Account_ID)>
		</cfif>
	
	</cfif>
	
	<!---
	<tr>
		<td colspan="5" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>	
	</tr>
	---->
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

<cfif GetOrder.AddonTotal>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Additional Items:</b></div></td>
		<td align="RIGHT"><div class="formtext">+#LSCurrencyFormat(GetOrder.AddonTotal)#</div></td>
	</tr>
</cfif>

	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Subtotal:</b></div></td>
		<td align="RIGHT"><div class="formtext">#LSCurrencyFormat(SubTotal+GetOrder.AddonTotal-GetOrder.OrderDisc-PromoTotal)#</div></td>
	</tr>

<cfif GetOrder.Tax>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Total Taxes:</b></div></td>
		<td align="RIGHT"><div class="formtext">#LSCurrencyFormat(GetOrder.Tax)#</div></td>
	</tr>
</cfif>

<cfif GetOrder.Shipping IS NOT 0 OR NOT ListFindNoCase("No Shipping,Freight", GetOrder.ShipType)>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Shipping (#GetOrder.ShipType#):</b></div></td>
		<td align="RIGHT"><div class="formtext">#LSCurrencyFormat(GetOrder.Shipping)#</div></td>
	</tr>
</cfif>

<cfif GetOrder.Freight IS NOT 0>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Freight Charges:</b></div></td>
		<td align="RIGHT"><div class="formtext">#LSCurrencyFormat(GetOrder.Freight)#</div></td>
	</tr>
</cfif>

<cfif GetOrder.Credits>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Credits:</b></div></td>
		<td align="RIGHT"><div class="formtext">-#LSCurrencyFormat(GetOrder.Credits)#</div></td>
	</tr>
</cfif>

<cfif GetOrder.AdminCredit>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>#GetOrder.AdminCreditText#:</b></div></td>
		<td align="RIGHT"><div class="formtext">-#LSCurrencyFormat(GetOrder.AdminCredit)#</div></td>
	</tr>
</cfif>

	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Total:</b></div></td>
		<td align="RIGHT"><div class="formtext">#LSCurrencyFormat(GetOrder.OrderTotal)#</div></td>
	</tr>
</table>

</cfoutput>

<!------>
</cfmodule> 
