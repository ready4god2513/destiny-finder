<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template displays a product to add it to an order. Uses the orderbox template to display options and addons. Called from dsp_basket_addproduct.cfm --->


<cfparam name="attributes.product_ID" default="0">

<cfinclude template="../../../product/queries/qry_get_product.cfm">

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Add Product to Order" 
	required_fields="0" 
	width="500">

	<cfoutput query="qry_get_products">
	<tr>
	<td valign="top">
	<!--- If there's a small image, get image info and put image in first cell of table row --->	
	<cfif len(Sm_Image)>
		<cfmodule template="../../../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" imgclass="listingimg" User="#qry_get_products.User_ID#">
	</cfif>
		</td>
		<td align="left" valign="top"><h2 class="product">#Name#</a></h2>
		<cfif SKU IS NOT "">
			<span class="prodSKU">Product ID: #SKU#</span><br/>
		</cfif>
		<cfmodule template="../../../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#"  class="cat_text_small" ptag="0"><br/><br/>

		<!--- Set the type of order for the orderbox settings --->
		<cfset typeOrder = "adminorder">
		<cfinclude template="../../../product/listings/put_orderbox.cfm">		
		</td>
	
	</cfoutput>

</cfmodule>

