
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the current quantity discounts for the product, with links to edit or remove the discount. Provides the form to add new quantity discounts. Called by product.admin&do=Qty_Discounts --->

<cfparam name="attributes.message" default="">

<cfif isdefined("attributes.edit")>
	<cfquery name="GetDiscount" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#ProdDisc
	WHERE ProdDisc_ID = #attributes.edit#
	</cfquery>

	<cfloop list="wholesale,quantfrom,quantto,discountper,proddisc_id" index="counter">
		<cfset "attributes.#counter#" = evaluate("getdiscount." & counter)>
	</cfloop>
	
	<cfset formbutton = "Update">
	
<cfelse><!--- add --->
	<cfset attributes.wholesale = 0>
	<cfset attributes.QuantFrom = 0>
	<cfset attributes.QuantTo = 0>
	<cfset attributes.DiscountPer = 0>
	<cfset attributes.prodDisc_ID = 0>
	<cfset formbutton = "Add Discount">
	
</cfif>


<cfhtmlhead text="
	<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=product.admin&do=list&redirect=yes#request.token2#"";
		}
	</script>
">

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Update Product - #qry_get_product.name#"
	Width="700"
	menutabs="yes">
	
	<cfinclude template="dsp_menu.cfm">
	
	<cfif len(trim(attributes.Message))>
		<cfoutput>
		<p align="center"><span class="formerror"><b>#attributes.Message#</b></span></p>
		</cfoutput>
	</cfif>
	
<cfoutput>		
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#">

<!--- Add form ---->
	<form name="editform" action="#self#?fuseaction=product.admin&do=Qty_Discounts#request.token2#" method="post">
	<input type="hidden" name="prodDisc_ID" value="#attributes.prodDisc_ID#"/>
	<input type="hidden" name="product_ID" value="#attributes.product_ID#"/>
	
	
		<tr>
			<td align="RIGHT" width="30%">Type:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="4">&nbsp;</td>
			<td><input type="radio" name="Wholesale" value="1" #doChecked(attributes.Wholesale)# /> Wholesale 
			&nbsp;&nbsp;<input type="radio" name="Wholesale" value="0" #doChecked(attributes.Wholesale,0)# /> Retail
			
			</td>	
		</tr>
		
		
		<tr>
			<td align="RIGHT" width="30%">Quantity Range:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td >From <input type="text" name="QuantFrom" value="#attributes.QuantFrom#" size="5" class="formfield"/> &nbsp; 
			To <input type="text" name="QuantTo" value="#attributes.QuantTo#" size="5" class="formfield"/> 
			<span class="formtextsmall">(Use 0 for unlimited)</span></td>	
		</tr>

		<tr>
			<td align="RIGHT" width="30%">Discount:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			
				<input type="text" name="DiscountPer" class="formfield" value="#iif(attributes.DiscountPer IS NOT 0, NumberFormat(attributes.DiscountPer, '0.00'), DE(""))#" size="5" /> 
#Request.AppSettings.MoneyUnit# per item</td>	
		</tr>
		
		<cfinclude template="../../../includes/form/put_space.cfm">
		
		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="Submit_discount" value="#formbutton#" class="formbutton"/> 
			</td>	
		</tr>	
		
		</form>

		<cfinclude template="../../../includes/form/put_requiredfields.cfm">
		
		
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">


objForm = new qForm("editform");

objForm.required("QuantFrom,QuantTo,DiscountPer");

objForm.QuantFrom.validateNumeric();
objForm.QuantTo.validateNumeric();
objForm.DiscountPer.validateNumeric();

objForm.QuantFrom.description = "starting quantity";
objForm.QuantTo.description = "ending quantity";
objForm.DiscountPer.description = "discount";

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>
</cfprocessingdirective>

</cfoutput>
	
<cfif qry_get_qty_discounts.RecordCount>	
	<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%" />
	<br/>
	<tr><td colspan="3">
	<table border="0" align="center" cellspacing="10" class="formtext">

	
		<cfoutput query="qry_get_qty_discounts" group="Wholesale">
		
		<tr><td colspan="4" align="center"><cfif wholesale is 1>Wholesale<cfelse>Retail</cfif> Quantity Discounts</td></tr>
		<tr><td colspan="4" style="background-color: ###Request.GetColors.boxhbgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td></tr>

		<tr>
			<th>From</th>
			<th>To</th>
			<th align="right">Discount Per</th>
			<th>&nbsp;</th>
		</tr>
		<cfoutput>
		<tr>
			<td align="center">#QuantFrom#</td>
			<td align="center"><cfif quantto>#QuantTo#<cfelse>And Above</cfif></td>
			<td align="right">-#LSCurrencyFormat(DiscountPer)#</td>
			<td align="right">[<a href="#self#?fuseaction=product.admin&do=Qty_Discounts&product_id=#product_id#&edit=#prodDisc_ID##Request.Token2#">edit</a>] [<a href="#self#?fuseaction=product.admin&do=Qty_Discounts&product_id=#product_id#&delete=#prodDisc_ID##Request.Token2#">delete</a>]</td>
		</tr>
		</cfoutput>

		<tr><td colspan="4" align="center">&nbsp;</td></tr>
		
		</cfoutput>
	</table></td></tr>
<cfelse>
	<!---
	<p align="center" class="formtitle">No Quantity Discounts Entered<p>
	--->
</cfif>	



<cfoutput><form action="#self#?fuseaction=product.admin&do=list#request.token2#" method="post">
	<tr>
		<td align="center" colspan="3">	
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"  width="98%" /><br/>	
		<input type="hidden" name="act" value="choose"/>
		<input type="hidden" name="cid" value="#iif(len(attributes.cid),attributes.cid,0)#"/>
		<input type="submit" name="DONE" value="Back to Product List" class="formbutton"/>
		<br/><br/></cfoutput>
		</td>
    </tr>
</form>	

</table>

<!---- CLOSE MODULE ----->
</cfmodule>

