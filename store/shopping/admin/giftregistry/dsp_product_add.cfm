<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to select a product to add to an order. This form appears inside a pop-up window.

0) required:
		Order No.
		
1) presents a form
	- type ---
	Quantity (1) ..... SKU ...... Product Name  [go]
	
2) When Submitted

	Look up product
	
	if multiple
		present list of products for single choice
	elseif 1
		Process: Add Product to Order
		Message: Success!
		Close window; refresh opener
	else
		reshow form with message "sorry, not found"
	/if
	
--->

<!--- A variable to determine what is displayed --->
<cfset message = "">

<cfparam name="attributes.product_ID" default="">
<cfparam name="attributes.sku" default="">
<cfparam name="attributes.name" default="">
<cfparam name="attributes.Quantity_Requested" default="">

<cfif not isdefined("attributes.GiftRegistry_ID")>
	<cfset message = "Error: No Gift Registry Selected">
</cfif>


<!--- Process if form submitted --->
<cfif isdefined("attributes.submit_form") or len(attributes.product_ID)>

	<cfquery name="LookupProduct" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Product_ID, SKU, Name
	FROM #Request.DB_Prefix#Products
	WHERE 
	<cfif attributes.product_ID gt 0>
		Product_ID = #attributes.product_ID#
	<cfelse>
		1=1
		<cfif len(attributes.SKU)>
			AND SKU LIKE '%#attributes.sku#%'
		</cfif>
		<cfif len(attributes.Name)>
			AND Name LIKE '%#attributes.Name#%'
		</cfif>
		ORDER BY SKU, Name
	</cfif>
	</cfquery>
	
	
	<!--- if one found, Process: Display product order form  --->
	<cfif NOT LookupProduct.recordcount>
		
		<cfset message = "Sorry, no products found.">
		
	<cfelseif LookupProduct.recordcount IS 1>
	
		<cfset attributes.product_id = LookupProduct.product_id>
		<cfinclude template="put_product_addform.cfm">
	
	</cfif>

</cfif>

<cfif NOT isDefined("LookupProduct.RecordCount") OR LookupProduct.RecordCount IS NOT 1>
<br/>
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Add Product to Registry" 
	required_fields="0" 
	width="450">

	<cfif len(message)>
		<cfoutput><br/><div class="formerror" align="center">#message#</div></cfoutput>
	</cfif>	

	<!--- form --->
	<cfoutput>
	<form action="#self#?#cgi.query_string#" method="post">
	<tr>
		<td><span class="formtextsmall">prod ID<br/></span>
		<input type="text" name="product_id" size="3" maxlength="3" class="formfield" value="#attributes.product_id#"/></td>
		<td><span class="formtextsmall">sku<br/></span>
		<input type="text" name="sku" size="14" maxlength="25" class="formfield" value="#attributes.sku#"/>
		</td>
		<td><span class="formtextsmall">product name<br/></span>
		<input type="text" name="name" size="40" maxlength="25" class="formfield" value="#attributes.name#"/></td>
		<td><span class="formtextsmall"><br/></span><input type="submit" name="submit_form" value="go" class="formbutton"/></td>
	</tr>
	</form>
	</cfoutput>

	<cfif isdefined('LookupProduct.recordcount')>
	<tr><td colspan="4">
	<cfoutput>#LookupProduct.recordcount# Products Found<br/>&nbsp;</cfoutput>
	</td></tr>
	
	<cfoutput query="LookupProduct">
	<tr>
		<td>#product_id#</td>
		<td>#sku#</td>
		<td>#name#</td>
		<td><a href="#self#?#cgi.query_string#&product_ID=#product_ID#">select</a></td>
	</tr>
	</cfoutput>
	
	</cfif>


</cfmodule>

</cfif>
