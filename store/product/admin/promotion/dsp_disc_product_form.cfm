
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used by promotions to select the product to discount for the promotion. It presents a list of categories with buttons to view subcategories and update the product list. Called by product.admin&promotion=disc_product --->

<!---
From Discounts:
<cfset startpath="fuseaction=product.admin&discount=groups&discount_id=#attributes.discount_id#">
<cfset box_title="Update Discount - #qry_get_discount.name#">
<cfparam name = "menu" default="../../shopping/admin/discount/dsp_menu.cfm">

---->

<cfset startpath="fuseaction=product.admin&promotion=disc_product&promotion_id=#attributes.promotion_id#">

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&#startpath#">
<!--- 	<cfloop list="cid,pid" index="counter">
		<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
			<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
		</cfif>
	</cfloop> --->
	
<cfprocessingdirective suppresswhitespace="No">
<script type="text/javascript">
function SubmitForm (theaction) {
	document.forms['pickcat'].Action.value = theaction;
	document.forms['pickcat'].submit();			
}
</script>
</cfprocessingdirective>
	
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Update Promotion - #qry_get_Promotion.name#"
	Width="600"
	menutabs="yes">
	
<cfinclude template="dsp_menu.cfm">
	
<cfset currentID = qry_get_promotion.disc_product>	

<cfoutput>

<cfif currentID IS NOT 0>
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext">	
	<tr>
	<td align="left">
<strong>Current Discounted Product:</strong> #qry_get_promotion.ProdName#<br/>&nbsp;
</td></tr></table>
</cfif>


<form action="#self#?#addedpath##request.token2#" method="post" name="pickcat" id="pickcat">
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext">	
	<tr>
	<td align="center">
	<strong>Select Category</strong><br/>
	<select name="CID" size="20" class="formfield" style="width: 300px;">
	<cfif attributes.pid IS NOT 0>
	<option value="#attributes.parent#" onclick="SubmitForm('view_parent')">..</option>
	</cfif>
	<cfloop query="qry_get_categories">
	<option value="#Category_ID#" #doSelected(attributes.cid,Category_ID)# onclick="SubmitForm('view_prods')">#Name#</option>
	</cfloop>
	</select><br/>
	<input type="hidden" name="pid" value="#attributes.pid#"/>
	<input type="button" value="View Subcats" class="formbutton" onclick="SubmitForm('view_subcats')"/>
	</td>
	<td align="center">
	<strong>Products</strong><br/>
	<select name="Product_ID" size="20" class="formfield" style="width: 300px;">
		<cfif NOT qry_get_products.RecordCount>
			<option disabled>No Products</option>
		<cfelse>
			<cfloop query="qry_get_products">
			<option value="#Product_ID#" #doSelected(currentID,Product_ID)#>#Name#</option>
			</cfloop>
		</cfif>
	</select>
	<br/>
	<input type="button" value="Select Product" class="formbutton" onclick="SubmitForm('select_product')"/>
	</td>
	</tr>
	
</table>
<input type="hidden" name="parent" value="#attributes.parent#"/>
<input type="hidden" name="Action" value=""/>
</form>
	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext">	
	<tr>
	<td align="center">
<cfif isDefined("attributes.promotion")>
	<form action="#self#?fuseaction=product.admin&promotion=list#request.token2#" method="post">
	<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/><br/>	
	<input type="submit" name="DONE" value="Back to Promotion List" class="formbutton"/>
	</form>	
</cfif>
		</td>
    </tr>
	</table> 
</cfoutput>
<!---- CLOSE MODULE ----->
</cfmodule>

		
