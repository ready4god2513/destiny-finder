
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!---
products: 
	List (all)
	Quickorder 
	Category (category_id)
	Display (product_id)
	search
	related - custom tag to put related products
--->

<cfif CompareNoCase(fusebox.fuseaction, "list") IS 0>
	<!--- searchheader = 1; searchform = 1 ---->
	<cfinclude template="queries/qry_get_products.cfm">	
	<cfinclude template="dsp_results.cfm">	
	
<!--- list products in the shopping.Quickorder format. 
	Will not work with products with options! ---->	
<cfelseif CompareNoCase(fusebox.fuseaction, "quickorder") IS 0>
	<cfinclude template="dsp_quickorder.cfm">	

	
<cfelseif CompareNoCase(fusebox.fuseaction, "search") IS 0>
	<cfparam name="attributes.product_searchsubmit" default="1">
	<cfinclude template="queries/qry_get_products.cfm">	
	<cfinclude template="dsp_results.cfm">	

	
<cfelseif CompareNoCase(fusebox.fuseaction, "display") IS 0>

	<cfinclude template="queries/qry_get_product.cfm">
	
	<!--- Make sure a product was found --->
 	<cfif not invalid AND qry_get_products.recordcount>
	
		<!--- update colors if custom palette --->
		<cfif isNumeric(qry_get_products.color_id) AND qry_get_products.color_id is not request.appsettings.color_id>
			<cfset request.color_id = qry_get_products.color_id>
			<cfinclude template="../queries/qry_getcolors.cfm">
			<cfinclude template="../customtags/setimages.cfm">
		</cfif>
		
		 <!--- set any variables listed in the product's 'passparam' field --->
		 <cfset QuerytoUse = qry_get_products>
		 <cfinclude template="../includes/parseparams.cfm">
	
		<!--- check if product, or any assigned categories are locked with an access key --->
		<cfparam name="ispermitted" default=1>
		<cfif qry_check_accesskey.recordcount>
			<cfmodule template="../access/secure.cfm"
			keyname="contentkey_list"		
			requiredPermission="#qry_check_accesskey.AccessKey#" 
			>
		<cfelseif qry_get_products.AccessKey gt 0>
			<cfmodule template="../access/secure.cfm"
			keyname="contentkey_list"		
			requiredPermission="#qry_get_products.AccessKey#" 
			>
		</cfif>
		<cfif ispermitted>	
			<cfinclude template="dsp_product.cfm">
		</cfif>
		
 	<cfelse>
		<cfmodule template="../#self#" fuseaction="page.pageNotFound">
	</cfif> 

<cfelseif CompareNoCase(fusebox.fuseaction, "qty_discount") IS 0>
	<!--- requires product_id and wholesale --->
	<cfinclude template="queries/qry_qty_discounts.cfm">
	<cfif qry_Qty_Discounts.recordcount>
		<cfinclude template="dsp_qty_discounts.cfm">	
	</cfif>

<cfelseif CompareNoCase(fusebox.fuseaction, "productofday") IS 0>
	<cfinclude template="dsp_productofday.cfm">	

<cfelseif CompareNoCase(fusebox.fuseaction, "tease") IS 0>
	<!--- Outputs a highlight box with products
	attributes.box_title
	attributes.more
	attributes.category_id
	attributes.name
	attributes.type
	attributes.mfg_account_id
	attributes.highlight
	attributes.sale
	attributes.hot
	attributes.maxrows default="10"
	--->
	<cfinclude template="queries/qry_get_products_tease.cfm">	
	<cfinclude template="dsp_featured_box.cfm">	

<cfelseif CompareNoCase(fusebox.fuseaction, "related") IS 0>
	<!--- attributes.section_title ---->
	<cfparam name="attributes.listing" default="">
	<cfif attributes.listing is "quickorder">
		<cfinclude template="dsp_quickorder.cfm">		
	<cfelse>
	<cfinclude template="queries/qry_get_related_products.cfm">	
	<cfinclude template="dsp_related_products.cfm">	
	</cfif>	

<cfelseif CompareNoCase(fusebox.fuseaction, "admin") IS 0>
	<!--- Product Permission 3 = show product admin menu --->
	<cfmodule template="../access/secure.cfm"
	keyname="product"
	requiredPermission="3"
	>
	<cfif ispermitted>
		<cfinclude template="admin/index.cfm">	
	</cfif>

<!--- Product Reviews Code --->
<cfelseif CompareNoCase(fusebox.fuseaction, "reviews") IS 0>
	<cfinclude template="reviews/index.cfm">

<!--- no valid fuseaction found --->
<cfelse>
	<cfmodule template="../#self#" fuseaction="page.pageNotFound">

</cfif>