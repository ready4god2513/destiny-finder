<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Order Product Editing Upgrade  - Display the form for editing the order product. Called from dsp_order.cfm --->

<cfset HTMLBreak = Chr(60) & 'br' & Chr(62)>
<cfset LineBreak = Chr(13) & Chr(10)>
	
	
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Edit Order Items"
	width="500"
	required_Fields="0"
	>
	
<cfoutput>
<!--- Output Basket Headers --->
	<tr>
		<td><b>Qty.</b></td>
		<td><b>Item to Purchase</b></td>
		<td><b>Item No.</b></td>
		<td align="center"><b>Price</b></td>
		<td align="center"><b>Discount</b></td>
		<td align="center"><b>Ext.&nbsp;Price</b></td>
	</tr>
	
	<tr>
		<td colspan="6" style="BACKGROUND-COLOR: ###Request.GetColors.linecolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>	
	</tr>

<!--- List Items in Basket --->
<cfloop query="GetOrder">

	<form action="#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&edit=product#request.token2#" method="post" name="order#Item_ID#">
	<input type="hidden" name="Orders_ID" value="#getorder.Item_ID#"/>
	<input type="hidden" name="Order_No" value="#getorder.Order_No#"/>
	<input type="hidden" name="Product_ID" value="#getorder.Product_ID#"/>
	<input type="hidden" name="OptQuant" value="#getorder.OptQuant#"/>
	<input type="hidden" name="OptChoice" value="#getorder.OptChoice#"/>
	<input type="hidden" name="Orig_Quantity" value="#Quantity#"/>
	<!---- Item Description --->
	<tr>
		<td height="45"><input type="text" name="Quantity" value="#Quantity#" size="2" class="formfield"/></td>
		<td width="60%">#GetOrder.Name#</td>
		<td>#SKU#</td>
		<td align="RIGHT">
		<input type="text" name="Price" value="#Price#" size="6" class="formfield"/>		
		</td>
		<td align="RIGHT">
		<input type="text" name="DiscAmount" value="#DiscAmount#" size="6" class="formfield"/>
		</td>
		
		<td align="RIGHT">
		<cfset ItemPrice = GetOrder.Price + GetOrder.OptPrice + GetOrder.AddonMultP - GetOrder.DiscAmount>
		<cfset Ext = ItemPrice * GetOrder.Quantity>#LSCurrencyFormat(Ext)#
		</td>
		
	</tr>
	<!---- Options --->
	
	<tr>
		<td class="formtextsmall" valign="top">Options:</td>
	<cfif not OptChoice>
		<td colspan="2"><input type="text" name="Options" value="#Options#" size="48" class="formfield"/></td>
	<cfelse>
		<td colspan="2"class="formtextsmall">#Options#<br/>(inventory by option; not editable)</td>
		<input type="hidden" name="Options" value="#Options#"/>
	</cfif>	
	<td class="formtextsmall" align="right" valign="top">Price: </td>
	<td colspan="2" valign="top"><input type="text" name="OptPrice" value="#OptPrice#" size="6" class="formfield"/></td>
	</tr>
	
	<!--- See if Product or order has addons --->
	<cfquery name="GetProdAddons" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT PA.Addon_ID
	FROM #Request.DB_Prefix#ProdAddons PA 
	WHERE PA.Product_ID = #product_id#
	</cfquery>	
	
	<cfif GetProdAddons.RecordCount OR Len(GetOrder.Addons)>
	<tr>
		<td class="formtextsmall" valign="top" rowspan="2">Addons:</td>
		<td rowspan="3"><textarea name="Addons" class="formfield" cols="30" rows="3">#Replace(Addons,HTMLBreak,LineBreak,"All")#</textarea></td>
	<td colspan="2" class="formtextsmall" align="right" valign="top">Price (mult.):</td>
	<td colspan="2" valign="top"><input type="text" name="AddonMultP" value="#AddonMultP#" size="6" class="formfield"/></td>
	</tr>
	<tr>		
		<td colspan="2" class="formtextsmall" align="right" valign="top">Price (not mult.): </td>
	<td colspan="2" valign="top"><input type="text" name="AddonNonMultP" value="#AddonNonMultP#" size="6" class="formfield"/></td>
	</tr>
	<tr><td colspan="4">&nbsp;</td></tr>
	
	<cfelse>
	<input type="Hidden" name="Addons" value="">
	<input type="Hidden" name="AddonMultP" value="0">
	<input type="Hidden" name="AddonNonMultP" value="0">
	</cfif>

	<tr>
	
		<td colspan="3">&nbsp;
		</td>
		<td colspan="3" valign="top" align="right">
		<input type="submit" name="productform_submit" value="Update" class="formbutton"/>
<cfif GetOrder.recordcount gt 1>
&nbsp;<input type="submit" name="productform_submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this product?');"/>
</cfif>
</td>
	</tr>

	</form>
	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("order#Item_ID#");

objForm.required("Quantity,Price,OptPrice,AddonMultP,AddonNonMultP,DiscAmount");

objForm.Quantity.validateNumeric();
objForm.Price.validateNumeric();
objForm.OptPrice.validateNumeric();
objForm.AddonMultP.validateNumeric();
objForm.AddonNonMultP.validateNumeric();
objForm.DiscAmount.validateNumeric();

objForm.DiscAmount.description = "Discount Amount";
objForm.OptPrice.description = "Options Price";
objForm.AddonMultP.description = "Addons Price (Multiplied)";
objForm.AddonNonMultP.description = "Addons Price (Not Multiplied)";

qFormAPI.errorColor = "###Request.GetColors.formreqOB#";

</script>
</cfprocessingdirective>


	<tr>
		<td colspan="6" style="BACKGROUND-COLOR: ###Request.GetColors.linecolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>	
	</tr>
</cfloop>

		<!---- Done: Return to Order --->
		<tr>
			<td height="45" colspan="6" align="center">
			<form action="#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no##request.token2#" method="post">
			<input type="submit" value="Return to Order" class="formbutton" onclick="return alert('Be sure to update this orders taxes, shipping and discounts');"/>
			</td>
			</form>
		</tr>
</cfoutput>

</cfmodule>

