<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template displays a list of products in the "Quickorder" format which creates a list of products with a quantity box and single form submit button. This form can be called directly (fuseaction=product.quickorder) to list all products in the store or included as a catcore to list only products for a specific category. NOTE: Quickorder will not work with products with options! 

Quickorder lists ALL selected products, there is no PAGETHRU.

Quickorder does not allow Sub Categories.

Quickorder lists products in only 1 column.

Can display a list of products or RELATED PRODUCTS

--->

<cfif isdefined("attributes.Detail_type")>
	<!--- Related products - Detail_type = "product" --->
	<cfinclude template="queries/qry_get_related_products.cfm">
	<cfset ProdList = ValueList(qry_Get_Products.Product_ID)>
	<cfinclude template="qry_grp_prices.cfm">
	<cfmodule template="../customtags/putline.cfm" linetype="Thick"/>
<cfelse>
	<!--- Product list or category --->
	<cfinclude template="queries/qry_get_products.cfm">	
</cfif>

<cfscript>
	// Set Parent ID text strings
	if (isDefined("attributes.category_ID") and isNumeric(attributes.category_ID)) {
		PCatSES = "_#attributes.Category_ID#";
		PCatNoSES = "&ParentCat=#attributes.Category_ID#";
	}
	else {
		PCatSES = "";
		PCatNoSES = "";
	}
</cfscript>		

<!--- Form Header --->
<cfoutput>
<form method="post" action="#XHTMLFormat('#self#?fuseaction=shopping.quickact#Request.Token2#')#">
<table cellpadding="0" cellspacing="0" border="0" width="100%" class="formtext">
	<!---
	<tr>
		<td colspan="3"><cfmodule template="../customtags/putline.cfm" linetype="Thick"/></td>
		<td bgcolor="###Request.GetColors.BoxTBgcolor#" style="color:###Request.GetColors.BoxTText#"><cfmodule template="../customtags/putline.cfm" linetype="Thick"/></td>
	</tr>
	--->
	</cfoutput>
	
	<cfoutput query="qry_get_products">
		<!--- Get the Group Price for the product --->
		<cfquery name="GetGroupPrice" dbtype="query">
			SELECT * FROM qry_grp_prices
			WHERE Product_ID = #qry_get_products.Product_ID#
		</cfquery>
		<cfscript>
			Product_ID = qry_get_products.Product_ID;
	
			//set product links	
			if (Request.AppSettings.UseSES AND (len(Long_Desc) OR len(Lg_Image)))
				prodlink = "#Request.SESindex#product/#product_ID##PCatSES#/#SESFile(qry_get_products.Name)##Request.Token1#";
			else if (len(Long_Desc) OR len(Lg_Image))
				prodlink = "#self#?fuseaction=product.display&product_ID=#product_ID##PCatNoSES##Request.Token2#";
			else
				prodlink = "";
		</cfscript>		

	<tr>
		<!--- Photo --->
		<td>
		<cfif len(Sm_Image)>
			<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" 	
			imglink="#XHTMLFormat(prodlink)#" imgclass="listingimg">
		</cfif>
		</td>
		
		<!--- Description --->
		<td>
			<a name="Prod#Product_ID#"></a>
		<cfif len(Sm_Title)>
			<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Title#"  
			imglink="#XHTMLFormat(prodlink)#" filealt="#Name#">
		<cfelse>
			<span class="prodname"><a href="#XHTMLFormat(prodlink)#" class="prodname_list">#Name#</a></span>
		</cfif>

		<cfif Sale>#request.SaleImage#</cfif> 
		<cfif Highlight>#request.NewImage#</cfif>
		<cfif Hot>#request.HotImage#</cfif>
		<br/>

		<!--- Check for short description --->
		<cfif len(Short_Desc)>
			<cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" 
			Token="#Request.Token1#" ptag="no" class="cat_text_small">
			
			<cfif len(Long_Desc) OR len(Lg_Image)>
				<a href="#XHTMLFormat(prodlink)#" class="cat_text_small">More...</a><br/>
			</cfif>
		</cfif>
		
		<!--- ADMIN EDIT LINK --->
		<!--- Product Permission 1 = product admin --->
		<cfmodule  template="../access/secure.cfm"
			keyname="product"
			requiredPermission="1"
			>	
			[<a href="#XHTMLFormat('#self#?fuseaction=product.admin&amp;do=edit&amp;product_id=#product_id##Request.Token2#')#" #doAdmin()#>Edit Product #product_id#</a>]</br>
		</cfmodule>
		</td>
		
		<!--- Price --->
		<td>
		<cfinclude template="listings/put_price.cfm">
		
		<!--- Quantity Discounts --->
		<cfset fusebox.nextaction="product.qty_discount">
		<cfinclude template="../lbb_runaction.cfm">
		</td>		
		
		<!--- Quantity --->
		<td bgcolor="###Request.GetColors.BoxTBgcolor#" style="color:###Request.GetColors.BoxTText#" align="center">
		<input type="hidden" name="item#currentrow#" value=""/>
		<input type="hidden" name="product_ID#currentrow#" value="#product_ID#"/>
		Qty: <input name="quant#currentrow#" type="text" class="formfield" size="5"/>
		<cfif len(availability)>
			<br/><span class="prodSKU">#availability#</span>
		</cfif>
		</td>		
	</tr>
	<cfif currentrow is not recordcount>
	<tr>
		<td colspan="3"><cfmodule template="../customtags/putline.cfm" linetype="Thin"/></td>
		<td bgcolor="###Request.GetColors.BoxTBgcolor#" style="color:###Request.GetColors.BoxTText#"><cfmodule template="../customtags/putline.cfm" linetype="Thin"/></td>
	</tr>
	</cfif>
	</cfoutput>

	<!--- Order Button--->
	<cfoutput>
	<tr>
		<td colspan="3"><cfmodule template="../customtags/putline.cfm" linetype="Thick"/></td>
		<td bgcolor="###Request.GetColors.BoxTBgcolor#" style="color:###Request.GetColors.BoxTText#"><cfmodule template="../customtags/putline.cfm" linetype="Thick"/></td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>	
		<!--- Order Button --->
		<td bgcolor="###Request.GetColors.BoxTBgcolor#" style="color:###Request.GetColors.BoxTText#"
		align="center">
		<input type="hidden" name="product_count" value="#qry_get_products.recordcount#"/></cfoutput>
		<div style="margin-top:8px; margin-bottom:8px;"><input type="submit" value="Add to Cart" class="formbutton"/></div>
		</td>		
	</tr>
</table>
</form>
