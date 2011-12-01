<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to list and update the tax codes. Called by shopping.admin&taxes=codes --->

<cfinclude template="qry_codes.cfm">

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
    function editrates(codeid) {
	<cfoutput>location.href = '#self#?fuseaction=shopping.admin&taxes=state#request.token2#&code_id=' + codeid;</cfoutput>
	}	
	
    function editcode(codeid, action) {
	document.editform.Code_ID.value = codeid;
	document.editform.Action2.value = action;
	document.editform.submit();	
	}
	
	function NoEdit() {
		alert('Rates by location cannot be set for this type of tax.');
		return false;	
	}
</script>
</cfprocessingdirective>

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="TaxCodes"
	Width="640">
	
	<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"	style="color:###Request.GetColors.InputTText#">
	
	<form name="editform" action="#self#?fuseaction=shopping.admin&taxes=editcode#request.token2#" method="post">
	</cfoutput>
	<input type="hidden" name="Code_ID" value=""/>
	<input type="hidden" name="Action" value=""/>
	<input type="hidden" name="Action2" value=""/>
	
	<cfinclude template="../../../includes/form/put_space.cfm">
	
	<tr>
		<th align="left">Description</th>
		<th align="center" nowrap="nowrap">Tax All?</th>
		<th align="center" nowrap="nowrap">Show on<br/>Prods?</th>
		<th align="center" nowrap="nowrap">Tax Rate</th>
		<th align="center">Address<br/>Used</th>
		<th align="center">Calculation<br/>Order</th>
		<th align="center">Cumulative</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>	
	
<cfoutput query="GetCodes">
	<tr>
		<td align="left">#CodeName#</td> 
		<td align="center">#YesNoFormat(TaxAll)#</td>
		<td align="center">#YesNoFormat(ShowonProds)#</td>
		<td align="center"><cfif TaxAll OR ShowonProds>#(TaxRate*100)#%<cfelse>N/A</cfif></td>
		<td align="center"><cfif TaxAll>N/A<cfelse>#TaxAddress#</cfif></td>
		<td align="center" nowrap="nowrap">
		<input type="text" name="CalcOrder#Code_ID#" value="#GetCodes.CalcOrder#" size="4" maxlength="10" class="formfield"/> </td>
		<td align="center">
		<input type="checkbox" name="Cumulative#Code_ID#" value="1" #doChecked(Cumulative)#/></td>
		<td align="center" nowrap="nowrap">
		<input type="button" name="JS" value="Edit" onclick="javascript:editcode(#Code_ID#, 'Edit');" class="formbutton"/></td>
		<td align="center" nowrap="nowrap">
		<cfif TaxAll>
		<input type="button" name="JS" value="Rates" onclick="javascript:NoEdit();" class="formbutton"/>
		<cfelse>
		<input type="button" name="JS" value="Rates" onclick="javascript:editrates('#Code_ID#');" class="formbutton"/>
		</cfif></td>
	</tr>
</cfoutput>

	<tr>
		<td colspan="8" align="center"><br/>
		<input type="submit" name="submit_all" value="Update Codes" class="formbutton"/> 
		<input type="button" name="JS" value="Add New Code" onclick="javascript:editcode(0, this.value);" class="formbutton"/> 
		<br/><br/>
		</td>
	</tr>
	
	<tr>
		<td colspan="8" align="left"><br/>
		<strong>Notes on using tax codes</strong><br/>A tax code can be applied to all customers (if not exempt) or you can define rates according to their location in the rates section. After setting up a tax code, you would apply it to any products taxed on the product's pricing page. You can use as many tax codes as necessary to split out things like luxury taxes or PST/GST taxes. When setting up multiple tax codes, you generally should have only one that taxes shipping per state/zip/county/country. Cumulative tax codes will include any previous taxes in the order when being calculated. Taxes are calculated from the lowest to highest order (i.e. 1, 2, 3, etc.) The first tax in the list will be used as a default tax applied to all products unless turned off. <br/><br/> 

<strong>VAT taxes:</strong> You can easily configure the store to charge and display VAT tax by setting the 'Show on Products' to yes. Define a tax rate for the tax code that will be used on the product page, and then use the Rates section to set up the exact tax for the user's location. You can set up multiple VAT taxes for your store, and define different rates included in the price, but only one VAT tax should be applied to each product, to be displayed on the product pages and in the shopping cart. <br/><br/> 

<strong>IMPORTANT PAYPAL NOTE:</strong> PayPal Pro (Express) does not support county taxes or taxes by billing address.<br/><br/>
		</td>
	</tr>
	
	</form>
	</table>
	
</cfmodule>