<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to edit the shopping cart information: shipping, tax, credits, etc. Called from dsp_order.cfm --->

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Edit Tax Totals"
	width="550"
	required_Fields="0"
	>
	
<!--- Get the list of Tax Codes --->
<cfinclude template="../tax/qry_codes.cfm">
	
<cfquery name="GetTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#OrderTaxes
WHERE Order_No = #GetOrder.Order_No#
</cfquery>
	
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
		<td align="RIGHT">#LSCurrencyFormat(GetOrder.Price + GetOrder.OptPrice + AddonMultP - GetOrder.DiscAmount)#</td>
		<cfset Ext = ((GetOrder.Price + GetOrder.OptPrice + AddonMultP - GetOrder.DiscAmount) * GetOrder.Quantity)>
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

<cfif GetTaxes.RecordCount GT 1>
	<tr>
		<td colspan="3" align="left"><div class="formtext"><b>Multiple tax records found</b><br/>
		Only orders with one set of taxes can be edited.
		</div></td>
		<td align="RIGHT"><div class="formtext"><b>Tax:</b></div></td>
		<td align="RIGHT"><div class="formtext">#LSCurrencyFormat(GetOrder.Tax)#</div></td>
	</tr>
	
<cfelseif GetCodes.RecordCount IS 0>
	<tr>
		<td colspan="3" align="left"><div class="formtext"><b>No tax codes found</b><br/>
		You must set up tax codes to add taxes to an order.
		</div></td>
		<td colspan="2"></td>
	</tr>
	
<cfelse>

	<form action="#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no##request.token2#" method="post" name="editform">
	
	<input type="hidden" name="OrderTaxes" value="#GetOrder.Tax#"/>
<tr>
	<td colspan="2" align="RIGHT"><b>Tax Code:</b></td>
		<td align="left">&nbsp;&nbsp;&nbsp;<select name="TaxCode" class="formfield" size="1">
			<cfloop query="GetCodes">
			<option value="#Code_ID#^#CodeName#" #doSelected(GetTaxes.Code_ID,GetCodes.Code_ID)#>#CodeName#</option>
			</cfloop>
		</select></td>
		<td align="right"><b>Address Used:</b></td>
		<td align="right"><select name="AddressUsed" class="formfield" size="1">
			<option value="Billing" #doSelected(GetTaxes.AddressUsed,'Billing')#>Billing</option>
			<option value="Shipping" #doSelected(GetTaxes.AddressUsed,'Shipping')#>Shipping</option>
		</select>
		</td>
		
		<tr>		
		<td colspan="2" align="right"><b>Taxed Products Total:</b></td>
		<td align="left">&nbsp;&nbsp;&nbsp;<input type="text" name="ProductTotal"  class="formfield" value="#NumberFormat(GetTaxes.ProductTotal, '0.00')#" size="7" maxlength="15"/></td>	
		<td align="RIGHT"><b>Tax (All Users):</div></td>
		<td align="RIGHT"><input type="text" name="AllUserTax"  class="formfield" value="#NumberFormat(GetTaxes.AllUserTax, '0.00')#" size="7" maxlength="15"/></td>	
		</tr>

	<tr><td colspan="2"></td><td colspan="3">
	<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</td></tr>

	<tr>
		<td colspan="2" align="RIGHT"><b>Local Tax:</b></td>
		<td align="left">&nbsp;&nbsp;&nbsp;<input type="text" name="LocalTax"  class="formfield" value="#NumberFormat(GetTaxes.LocalTax, '0.00')#" size="7" maxlength="15"/></td>

		<td align="RIGHT"><b>County Tax:</b></td>
		<td align="RIGHT"><input type="text" name="CountyTax"  class="formfield" value="#NumberFormat(GetTaxes.CountyTax, '0.00')#" size="7" maxlength="15"/></td>
	</tr>
	
	<tr>
		<td colspan="2" align="RIGHT"><b>State Tax</b></td>
		<td align="left">&nbsp;&nbsp;&nbsp;<input type="text" name="StateTax"  class="formfield" value="#NumberFormat(GetTaxes.StateTax, '0.00')#" size="7" maxlength="15"/></td>
	
		<td align="RIGHT"><b>Country Tax</b></td>
		<td align="RIGHT"><input type="text" name="CountryTax"  class="formfield" value="#NumberFormat(GetTaxes.CountryTax, '0.00')#" size="7" maxlength="15"/></td>
	</tr>
	
	<tr>
		<td colspan="4" align="left"><br/><div class="formtext"><b>NOTE ON TAX CODES</b><br/>
		Taxes entered should match the tax codes as set up. An order can have a tax for all users <strong>OR</strong> it can have taxes by location. It should not have a combination of these two types of taxes.
		</div></td>
		<td ></td>
	</tr>


</cfif>
	
<cfif GetOrder.Shipping IS NOT 0 OR NOT ListFindNoCase("No Shipping,Freight", GetOrder.ShipType)>
	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Shipping:</b></div></td>
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
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Store Credit:</b></div></td>
		<td align="RIGHT"><div class="formtext">-#LSCurrencyFormat(GetOrder.AdminCredit)#</div></td>
	</tr>
</cfif>

	<tr>
		<td colspan="4" align="RIGHT"><div class="formtext"><b>Total:</b></div></td>
		<td align="RIGHT"><div class="formtext">#LSCurrencyFormat(GetOrder.OrderTotal)#</div></td>
	</tr>
	
	<tr>
		<td height="45" colspan="5" align="center">
		<cfif GetTaxes.RecordCount LTE 1 AND GetCodes.RecordCount>
			<input type="submit" name="taxes_submit" value="Update Order" class="formbutton"/>
		</cfif>
			<input type="button" value="Cancel" onclick="javascript:location.href='#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&redirect=1#request.token2#'" class="formbutton"/>
		</td>
	</tr>
	</form>	
	
</cfoutput>

</cfmodule>

<cfif GetTaxes.RecordCount LTE 1 AND GetCodes.RecordCount>

	<cfprocessingdirective suppresswhitespace="no">
	<script type="text/javascript">
	objForm = new qForm("editform");
	
	objForm.AllUserTax.validateNumeric();
	objForm.LocalTax.validateNumeric();
	objForm.CountyTax.validateNumeric();
	objForm.StateTax.validateNumeric();
	objForm.CountryTax.validateNumeric();
	
	qFormAPI.errorColor = "###Request.GetColors.formreqOB#";
	
	</script>
	</cfprocessingdirective>

</cfif>

	
