<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Display the form for editing the order drop-shipping information. Called from dsp_order.cfm --->


<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Edit Drop-Shippers"
	width="500"
	required_Fields="0"
	>
	
	<cfoutput>
	<!--- Output Basket Headers --->
	<tr>
		<td><b>Qty.</b></td>
		<td><b>Item to Purchase</b></td>
		<td><b>Item No.</b></td>
		<td align="RIGHT"><b>Price</b></td>
		<td align="RIGHT"><b>Ext. Price</b></td>
	</tr>

	<form action="#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no##request.token2#" method="post">
	<input type="hidden" name="Orderslist" value="#valuelist(getorder.Item_ID)#"/>

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
				<i>#GetOrder.Addons#</i></cfif></div>
		</td>
		<td><cfif GetOrder.SKU IS NOT 0>#GetOrder.SKU#</cfif>&nbsp;</td>
		<td align="RIGHT">#LSCurrencyFormat(GetOrder.Price + GetOrder.OptPrice + AddonMultP - GetOrder.DiscAmount)#</td>
		<td align="RIGHT"><cfset Ext = ((GetOrder.Price + GetOrder.OptPrice + AddonMultP - GetOrder.DiscAmount) * GetOrder.Quantity)>#LSCurrencyFormat(Ext)#</td>
	</tr>
	
		<!---- Dropship Info --->
		<tr>
			<td><span class="formtextsmall">Qty</span><br/>
			<input type="text" name="dropship_qty#GetOrder.Item_ID#" value="#GetOrder.dropship_Qty#" size="2" class="formfield"/></td>
			<td><span class="formtextsmall">Vendor</span><br/>
				<cfset chosen = GetOrder.dropship_Account_ID>
				<select name="dropship_Account_ID#GetOrder.Item_ID#">
					<option value="" #doSelected(chosen,'')#></option>
				<cfloop query="qry_get_vendors">
					<option value="#Account_ID#" #doSelected(chosen,qry_get_vendors.Account_ID)#>#Account_name#</option>
			 	</cfloop>
			 	</select>
			
			</td>
			<td><span class="formtextsmall">Vendor Part</span><br/>
			<input type="text" name="dropship_SKU#GetOrder.Item_ID#" value="#GetOrder.dropship_SKU#" size="15" class="formfield"/>
			</td>
			<td align="right"><span class="formtextsmall">Vendor Price</span><br/>
			<input type="text" name="dropship_cost#GetOrder.Item_ID#" value="#GetOrder.dropship_cost#" size="6" class="formfield"/>
			</td>
			<td><img src="#request.appsettings.defaultimages#/spacer.gif" alt="" width="1" height="1" /></td>
		</tr>
		<tr>
			<td><img src="#request.appsettings.defaultimages#/spacer.gif" alt="" width="1" height="1" /></td>
			<td colspan="3"><span class="formtextsmall">Note</span><br/>
			<input type="text" name="dropship_note#GetOrder.Item_ID#" value="#GetOrder.dropship_note#" size="63" class="formfield" maxlength="75"/>
			</td>
			<td><img src="#request.appsettings.defaultimages#/spacer.gif" alt="" width="1" height="1" /></td>
		</tr>
</cfloop>
		<tr>
			<td height="45" colspan="5" align="center">
				<input type="submit" name="shipform_submit" value="Update Dropshipping" class="formbutton"/>
				<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			</td>
		</tr>

</form>
</cfoutput>

</cfmodule>