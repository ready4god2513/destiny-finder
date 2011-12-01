
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the product.admin circuit. It runs all the admin functions for the product circuit --->

<!--- product permissions 3 = product admin --->
<cfmodule template="../../access/secure.cfm"
keyname="product"
requiredPermission="3"
/> 
<cfif ispermitted AND isdefined("attributes.do")>		
			
	<cfset Webpage_title = "Product #attributes.do#">
	
	<cfswitch expression="#attributes.do#">

	<!--- Product list and edit form pages --->
		<cfcase value="list">
			<cfif isdefined("attributes.string")>
				<cfset attributes.prodid=attributes.string>
			</cfif>
			<cfinclude template="product/qry_get_products.cfm">
			<cfif qry_get_products.recordcount is 1 and isdefined("attributes.string")>
				<cflocation url="#self#?fuseaction=product.admin&do=edit&product_id=#qry_get_products.product_ID##request.token2#" addtoken="No">
			</cfif>
			<cfinclude template="product/dsp_products_list.cfm">
		</cfcase>

		<cfcase value="listform">
			<cfinclude template="product/qry_get_products.cfm">
			<cfinclude template="product/dsp_products_list_form.cfm">
		</cfcase>
		
		<cfcase value="actform">
			<cfinclude template="product/act_products_list_form.cfm">	
		</cfcase>			
	
<!--- Product (Display) -------->		
		<cfcase value="add">
			<cfinclude template="product/dsp_product_form.cfm">
		</cfcase>
		
		<cfcase value="edit">
			<cfinclude template="product/qry_get_product.cfm"> 
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#"> 
				<cfinclude template="product/dsp_product_form.cfm">
			</cfmodule>			
		</cfcase>
		
		<cfcase value="copy">
			<cfinclude template="product/act_copy_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#GetProduct.Recordcount#" type="copy"> 
				<cfset attributes.do = "edit">
				<cfinclude template="product/qry_get_product.cfm">
				<cfinclude template="product/dsp_product_form.cfm">
			</cfmodule>
		</cfcase>
					
		<cfcase value="act">
			<!--- Make sure the form was properly submitted --->
			<cfif isDefined("attributes.Priority")>
				<cfinclude template="product/act_product.cfm">
			<cfelse>
				<cfset attributes.message = "Invalid form submission!">
				<cfset attributes.XFA_success = "fuseaction=product.admin&do=list&cid=0">
				<cfinclude template="../../includes/admin_confirmation.cfm">
			</cfif>
		</cfcase>			
		
<!--- Product Price -------->	
		<cfcase value="price">
			<cfinclude template="product/qry_get_product.cfm">	
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#"> 
				<cfinclude template="product/dsp_price_form.cfm">
			</cfmodule>		
		</cfcase>		
	
		<cfcase value="act_price">
			<!--- Make sure the form was properly submitted --->
			<cfif isDefined("attributes.Base_Price")>
				<cfinclude template="product/act_product_price.cfm">
			<cfelse>
				<cfset attributes.message = "Invalid form submission!">
				<cfset attributes.XFA_success = "fuseaction=product.admin&do=list&cid=0">
				<cfinclude template="../../includes/admin_confirmation.cfm">
			</cfif>
		</cfcase>	
		
	<!--- Product Info -------->	
		<cfcase value="info">
			<cfinclude template="product/qry_get_product.cfm"> 
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">
				<cfinclude template="product/dsp_info_form.cfm">			
			</cfmodule>		
		</cfcase>
		
		<cfcase value="act_info">
			<!--- Make sure the form was properly submitted --->
			<cfif isDefined("attributes.frm_submit")>
				<cfinclude template="product/act_product_info.cfm">
			<cfelse>
				<cfset attributes.message = "Invalid form submission!">
				<cfset attributes.XFA_success = "fuseaction=product.admin&do=list&cid=0">
				<cfinclude template="../../includes/admin_confirmation.cfm">
			</cfif>
		</cfcase>	

	<!--- Product Group Prices -------->	
		<cfcase value="Grp_Price">
			<cfinclude template="product/qry_get_product.cfm"> 
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">
				<cfinclude template="product/act_grp_prices.cfm">
				<cfinclude template="product/qry_get_grp_prices.cfm">	
				<cfinclude template="product/dsp_grp_prices_form.cfm">			
			</cfmodule>		
		</cfcase>

<!--- Product Quantity Discounts -------->	
		<cfcase value="Qty_Discounts">
			<cfinclude template="product/act_qty_discounts.cfm">
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#"> 
				<cfinclude template="product/qry_get_qty_discounts.cfm">	
				<cfinclude template="product/dsp_qty_discounts_form.cfm">
			</cfmodule>						
		</cfcase>	


<!--- Product Options List -------->	
		<cfcase value="options">
			<cfinclude template="product/qry_check_product.cfm">	
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#"> 
				<cfinclude template="product/dsp_options_form.cfm">
			</cfmodule>		
		</cfcase>		
		
<!--- Product Addons List -------->	
		<cfcase value="addons">
			<cfinclude template="product/qry_check_product.cfm">	
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#"> 
				<cfinclude template="product/dsp_addons_form.cfm">
			</cfmodule>		
		</cfcase>	
					
<!--- Product Images -------->	
		<cfcase value="images">
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#"> 
				<cfinclude template="product/dsp_images_form.cfm">
			</cfmodule>		
		</cfcase>		
		
<!--- Related Products -------->	
		<cfcase value="related">
			<cfinclude template="product/act_related.cfm">
			<cfinclude template="product/qry_get_product_item.cfm">
			<cfinclude template="product/qry_get_products.cfm">
			<cfinclude template="product/qry_check_product.cfm">	
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#"> 
				<cfset startpath="fuseaction=product.admin&do=related&product_id=#attributes.product_id#">
				<cfset box_title="Update Product - #qry_get_product.name#">
				<cfset menu="dsp_menu.cfm">							
				<cfinclude template="product/dsp_products_related_form.cfm">
			</cfmodule>
		</cfcase>	

<!--- Froogle Export --->
		<cfcase value="froogle">
		<!--- product permissions 128 = site feeds --->
		<cfmodule template="../../access/secure.cfm"
			keyname="product"
			requiredPermission="128"> 
			<cfinclude template="feeds/act_froogle.cfm">
		</cfmodule>
		</cfcase>	
		
<!--- Google Sitemap Export --->
		<cfcase value="googleSiteMap">
		<!--- product permissions 128 = site feeds--->
		<cfmodule template="../../access/secure.cfm"
			keyname="product"
			requiredPermission="128"> 
			<cfinclude template="feeds/act_google_sitemap.cfm">
		</cfmodule>
		</cfcase>

<!--- Bizrate Export --->
		<cfcase value="Bizrate">
		<!--- product permissions 128 = site feeds --->
		<cfmodule template="../../access/secure.cfm"
			keyname="product"
			requiredPermission="128"> 
			<cfinclude template="feeds/dsp_bizrate.cfm">
		</cfmodule>
		</cfcase>

		<cfcase value="Bizrate_download">
		<!--- product permissions 128 = site feeds --->
		<cfmodule template="../../access/secure.cfm"
			keyname="product"
			requiredPermission="128"> 
			<cfinclude template="feeds/act_bizrate.cfm">
		</cfmodule>
		</cfcase>

		
<!--- Product Import --->
		<cfcase value="import">
		<!--- product permissions 16 = product import --->
		<cfmodule template="../../access/secure.cfm"
			keyname="product"
			requiredPermission="16"> 
			<cfinclude template="import_export/dsp_product_import.cfm">
		</cfmodule>
		</cfcase>
		
		<cfcase value="doimport">
		<!--- product permissions 16 = product import --->
		<cfmodule template="../../access/secure.cfm"
			keyname="product"
			requiredPermission="16"> 
			<cfinclude template="import_export/import_functions.cfm">
			<cfinclude template="import_export/act_product_import.cfm">
			<cfinclude template="import_export/act_do_import.cfm">
			<cfinclude template="import_export/dsp_parse_import.cfm">
		</cfmodule>
		</cfcase>
		
<!--- Product Export --->
		<cfcase value="export">
		<!--- product permissions 16 = product export --->
		<cfmodule template="../../access/secure.cfm"
			keyname="product"
			requiredPermission="16"> 
			<cfinclude template="import_export/dsp_product_export.cfm">
		</cfmodule>
		</cfcase>
		
		<cfcase value="doexport">
		<!--- product permissions 16 = product export --->
		<cfmodule template="../../access/secure.cfm"
			keyname="product"
			requiredPermission="16"> 
			<cfinclude template="import_export/export_functions.cfm">
			<cfinclude template="import_export/act_product_export.cfm">
		</cfmodule>
		</cfcase>
		
		<cfdefaultcase>
			<cfinclude template="product/qry_get_products.cfm">
			<cfinclude template="product/dsp_products_list.cfm">
		</cfdefaultcase>			
				
	</cfswitch>

<cfelseif ispermitted AND isdefined("attributes.option")>		
<!--- Product Options Administration --->			
	<cfset Webpage_title = "Product Options">	
		
	<cfswitch expression="#attributes.option#">

		<cfcase value="change">
			<cfinclude template="product/options/qry_get_option.cfm">
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#" type="option">
				<cfparam name="attributes.action" default="Edit">
				<cfif attributes.action IS "Edit">
					<cfif NOT attributes.StandOpt>
						<cfinclude template="product/options/dsp_cust_option.cfm">
					<cfelse>
						<cfinclude template="product/options/dsp_std_option.cfm">
					</cfif>
				<cfelseif attributes.action IS "Delete">
					<cfinclude template="product/options/dsp_delete.cfm">
				</cfif>
			</cfmodule>

		</cfcase>
		
		<cfcase value="addcust">
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">
				<cfinclude template="product/options/dsp_cust_option.cfm">
			</cfmodule>
		</cfcase>
		
		<cfcase value="addstd">
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">
				<cfinclude template="product/options/dsp_std_option.cfm">
			</cfmodule>
		</cfcase>
	
		<cfcase value="std2"><!--- page 2 of standard option form --->
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">
				<cfinclude template="product/options/dsp_std_option2.cfm">
			</cfmodule>
		</cfcase>
	
	
		<cfcase value="act">		
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">	
				<cfinclude template="product/options/act_option.cfm">
			</cfmodule>
		</cfcase>
		
		<cfcase value="act2"><!--- page 2 of standard option form --->		
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">		
				<cfinclude template="product/options/act_option2.cfm">
			</cfmodule>
		</cfcase>
		
		<cfcase value="delete"><!--- add standard option to product --->
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">	
				<cfset mode="d">
				<cfinclude template="product/options/act_option.cfm">
			</cfmodule>
		</cfcase>
		
		
		<cfdefaultcase>
			<cfinclude template="product/qry_get_products.cfm">
			<cfinclude template="product/dsp_products.cfm">
		</cfdefaultcase>
		
	</cfswitch>
		
		
<cfelseif ispermitted AND isdefined("attributes.stdoption")>		
	<!--- Product Standard Options Administration --->			
	<cfset Webpage_title = "Standard option #attributes.stdoption#">
	
	<cfswitch expression="#attributes.stdoption#">
	
		<cfcase value="list">
			<cfinclude template="stdoptions/qry_get_stdoptions.cfm">
			<cfinclude template="stdoptions/dsp_stdoptions_list.cfm">
		</cfcase>
	
		<cfcase value="add">
			<cfinclude template="stdoptions/dsp_stdoption_form.cfm">
		</cfcase>
		
		<cfcase value="edit">
			<cfinclude template="stdoptions/qry_get_stdoption.cfm"> 
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_StdOption.Recordcount#" type="stdoption"> 
				<cfinclude template="stdoptions/dsp_stdoption_form.cfm">
			</cfmodule>
		</cfcase>
	
		<cfcase value="act">
			<cfinclude template="stdoptions/act_stdoption.cfm">
		</cfcase>
	
		<cfcase value="delete">
			<cfinclude template="stdoptions/act_delete.cfm">
		</cfcase>
	
		<cfdefaultcase>
			<cfinclude template="stdoptions/qry_get_stdoptions.cfm">
			<cfinclude template="stdoptions/dsp_stdoptions_list.cfm">
		</cfdefaultcase>
		
	</cfswitch>
		
<cfelseif ispermitted AND isdefined("attributes.addon")>		
	<!--- Product Addons Administration --->		
	<cfset Webpage_title = "Product Addons">
		
	<cfswitch expression="#attributes.addon#">

		<cfcase value="change">
			<cfinclude template="product/addons/qry_get_addon.cfm">
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#" type="option">
				<cfif attributes.action IS "Edit">
					<cfif NOT attributes.Standaddon>
						<cfinclude template="product/addons/dsp_cust_addon.cfm">
					<cfelse>
						<cfinclude template="product/addons/dsp_std_addon.cfm">
					</cfif>
				<cfelseif attributes.action IS "Delete">
						<cfinclude template="product/addons/dsp_delete.cfm">
				</cfif>
			</cfmodule>

		</cfcase>
		
		<cfcase value="addcust">
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">
				<cfinclude template="product/addons/dsp_cust_addon.cfm">
			</cfmodule>
		</cfcase>
		
		<cfcase value="addstd">
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">
				<cfinclude template="product/addons/dsp_std_addon.cfm">
			</cfmodule>
		</cfcase>
		
		<cfcase value="act">	
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">		
				<cfinclude template="product/addons/act_addon.cfm">
			</cfmodule>
		</cfcase>
			
		<cfcase value="delete">
			<cfinclude template="product/qry_check_product.cfm">
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_product.Recordcount#">
				<cfset mode="d">
				<cfinclude template="product/addons/act_addon.cfm">
			</cfmodule>
		</cfcase>
		
		
		<cfdefaultcase>
			<cfinclude template="product/qry_get_products.cfm">
			<cfinclude template="product/dsp_products.cfm">
		</cfdefaultcase>
		
	</cfswitch>
		
		
<cfelseif ispermitted AND isdefined("attributes.stdaddon")>		
	<!--- Product Standard Addons Administration --->	
	<cfset Webpage_title = "Standard addon #attributes.stdaddon#">
	
	<cfswitch expression="#attributes.stdaddon#">
	
		<cfcase value="list">
			<cfinclude template="stdaddons/qry_get_stdaddons.cfm">
			<cfinclude template="stdaddons/dsp_stdaddons_list.cfm">
		</cfcase>
	
		<cfcase value="add">
			<cfinclude template="stdaddons/dsp_stdaddon_form.cfm">
		</cfcase>
		
		<cfcase value="edit">		
			<cfinclude template="stdaddons/qry_get_stdaddon.cfm"> 
			<cfmodule template="../../access/useraccess.cfm" recordcount="#qry_get_StdAddon.Recordcount#" type="stdaddon"> 
				<cfinclude template="stdaddons/dsp_stdaddon_form.cfm">
			</cfmodule>
		</cfcase>
	
		<cfcase value="act">
			<cfinclude template="stdaddons/act_stdaddon.cfm">
		</cfcase>
	
		<cfcase value="delete">
			<cfinclude template="stdaddons/act_delete.cfm">
		</cfcase>
	
		<cfdefaultcase>
			<cfinclude template="stdaddons/qry_get_stdaddons.cfm">
			<cfinclude template="stdaddons/dsp_stdaddons_list.cfm">
		</cfdefaultcase>
		
	</cfswitch>
	
<!--- Discount Administration --->
<cfelseif isdefined("attributes.discount")>	
	
	<cfset Webpage_title = "Discount #attributes.discount#">

	<!--- Product Permission 4 = discount admin --->
	<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="4"
	>
	<cfif ispermitted>
	
		<cfswitch expression="#attributes.discount#">

			<cfcase value="list">
				<cfinclude template="discount/qry_get_discounts.cfm">
				<cfinclude template="discount/dsp_discounts_list.cfm">
			</cfcase>

			<cfcase value="add">
				<cfinclude template="discount/dsp_discount_form.cfm">
			</cfcase>
			
			<cfcase value="edit">
				<cfinclude template="discount/qry_get_discount.cfm"> 
				<cfinclude template="discount/dsp_discount_form.cfm">
			</cfcase>
			
			<cfcase value="act">
				<cfinclude template="discount/act_discount.cfm">
				<cfparam name="attributes.XFA_success" default="fuseaction=product.admin&discount=list">
				<cfset attributes.box_title="Discounts">
				<cfinclude template="../../includes/admin_confirmation.cfm">					
			</cfcase>	
			
		<!--- Related Products -------->	
			<cfcase value="products">
				<cfinclude template="discount/act_related_prod.cfm">
				<cfinclude template="discount/qry_get_discount.cfm">
				<cfinclude template="discount/qry_get_discount_products.cfm">
				<cfinclude template="product/qry_get_products.cfm">
				<cfset startpath="fuseaction=product.admin&discount=products&discount_id=#attributes.discount_id#">
				<cfset box_title="Update Discount - #qry_get_Discount.name#">
				<cfparam name = "menu" default="../discount/dsp_menu.cfm">
				<cfinclude template="product/dsp_products_related_form.cfm">
			</cfcase>		
			
		<!--- Related Categories -------->	
			<cfcase value="categories">
				<cfinclude template="discount/act_related_cat.cfm">
				<cfinclude template="discount/qry_get_discount.cfm">
				<cfinclude template="discount/qry_get_discount_categories.cfm">
				<cfset attributes.catcore_content = "Products">
				<cfinclude template="../../category/admin/qry_get_categories.cfm">
				<cfset startpath="fuseaction=product.admin&discount=categories&discount_id=#attributes.discount_id#">
				<cfset box_title="Update Discount - #qry_get_Discount.name#">
				<cfparam name = "menu" default="../../product/admin/discount/dsp_menu.cfm">
				<cfinclude template="../../category/admin/dsp_category_related_form.cfm">
			</cfcase>		
			
		<!--- User groups -------->	
			<cfcase value="groups">
				<cfinclude template="discount/act_related_groups.cfm">
				<cfinclude template="discount/qry_get_discount.cfm">
				<cfinclude template="discount/qry_get_discount_groups.cfm">
				<cfinclude template="../../users/admin/group/qry_get_groups.cfm">
				<cfset startpath="fuseaction=product.admin&discount=groups&discount_id=#attributes.discount_id#">
				<cfset box_title="Update Discount - #qry_get_discount.name#">
				<cfparam name = "menu" default="../../../product/admin/discount/dsp_menu.cfm">
				<cfinclude template="../../users/admin/group/dsp_groups_related_form.cfm">
			</cfcase>	
		
			<cfdefaultcase>
				<cfinclude template="discount/qry_get_discounts.cfm">
				<cfinclude template="discount/dsp_discounts_list.cfm">
			</cfdefaultcase>
			
		</cfswitch>

	</cfif>
		
		
<!--- Promotion Administration --->
<cfelseif isdefined("attributes.promotion")>	
	
	<cfset Webpage_title = "Promotion #attributes.promotion#">

	<!--- Product Permission 8 = promotion admin --->
	<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="8"
	>
	<cfif ispermitted>
	
		<cfswitch expression="#attributes.promotion#">

			<cfcase value="list">
				<cfinclude template="promotion/qry_get_promotions.cfm">
				<cfinclude template="promotion/dsp_promotions_list.cfm">
			</cfcase>

			<cfcase value="add">
				<cfinclude template="promotion/dsp_promotion_form.cfm">
			</cfcase>
			
			<cfcase value="edit">
				<cfinclude template="promotion/qry_get_promotion.cfm"> 
				<cfinclude template="promotion/dsp_promotion_form.cfm">
			</cfcase>
			
			<cfcase value="act">
				<cfinclude template="promotion/act_promotion.cfm">
				<cfparam name="attributes.XFA_success" default="fuseaction=product.admin&promotion=list">
				<cfset attributes.box_title="Promotions">
				<cfinclude template="../../includes/admin_confirmation.cfm">					
			</cfcase>	
			
		<!--- Qualifying Products -------->	
			<cfcase value="qual_products">
				<cfinclude template="promotion/act_qual_products.cfm">
				<cfinclude template="promotion/qry_get_promotion.cfm">
				<cfinclude template="promotion/qry_get_promotion_qualproducts.cfm">
				<cfinclude template="product/qry_get_products.cfm">
				<cfset startpath="fuseaction=product.admin&promotion=qual_products&promotion_id=#attributes.promotion_id#">
				<cfset box_title="Update Promotion - #qry_get_promotion.name#">
				<cfparam name = "menu" default="../promotion/dsp_menu.cfm">
				<cfinclude template="product/dsp_products_related_form.cfm">
			</cfcase>		
			
		<!--- Discounted Product -------->	
			<cfcase value="disc_product">
				<cfinclude template="promotion/act_disc_product.cfm"> 
				<cfinclude template="promotion/qry_get_promotion.cfm">
				<cfinclude template="../../category/admin/qry_get_categories.cfm">
				<cfinclude template="promotion/qry_get_cat_products.cfm">
				<cfinclude template="promotion/dsp_disc_product_form.cfm">
			</cfcase>	
			
		<!--- User groups -------->	
			<cfcase value="groups">
				<cfinclude template="promotion/act_related_groups.cfm">
				<cfinclude template="promotion/qry_get_promotion.cfm">
				<cfinclude template="promotion/qry_get_promotion_groups.cfm">
				<cfinclude template="../../users/admin/group/qry_get_groups.cfm">
				<cfset startpath="fuseaction=product.admin&promotion=groups&promotion_id=#attributes.promotion_id#">
				<cfset box_title="Update Promotion - #qry_get_promotion.name#">
				<cfparam name = "menu" default="../../../product/admin/promotion/dsp_menu.cfm">
				<cfinclude template="../../users/admin/group/dsp_groups_related_form.cfm">
			</cfcase>	
		
			<cfdefaultcase>
				<cfinclude template="promotion/qry_get_promotions.cfm">
				<cfinclude template="promotion/dsp_promotions_list.cfm">
			</cfdefaultcase>
			
		</cfswitch>

	</cfif>


<cfelseif isdefined("attributes.fields")>		

	<!--- product permissions 1 = all products admin --->
	<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="1"> 
		<!--- Product Custom Fields Administration --->		
		<cfset Webpage_title = "Custom fields #attributes.fields#">
		
		<cfswitch expression="#attributes.fields#">
			
			<cfcase value="edit">
				<cfinclude template="customfields/qry_get_customfields.cfm">
				<cfinclude template="customfields/dsp_customfields.cfm">
			</cfcase>
		
			<cfcase value="act">
				<cfinclude template="customfields/act_customfields.cfm">
				<cfset attributes.XFA_success="fuseaction=home.admin">
				<cfset attributes.box_title="Custom Fields">
				<cfinclude template="../../includes/admin_confirmation.cfm">	
			</cfcase>
			
		</cfswitch>
	</cfmodule>

<!--- Product Reviews Upgrade - start custom code --->	
<cfelseif isdefined("attributes.review")>		
	<!--- product permissions 64 = product reviews --->
	<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="64"> 
		
		<cfset Webpage_title = "Review #attributes.review#">
		
		<cfswitch expression="#attributes.review#">
		
			<cfcase value="list">
				<cfinclude template="review/qry_get_reviews.cfm">
				<cfinclude template="review/dsp_reviews_list.cfm">
			</cfcase>
		
			<cfcase value="listform">
				<cfinclude template="review/qry_get_reviews.cfm">
				<cfinclude template="review/dsp_reviews_list_form.cfm">
			</cfcase>
			
			<cfcase value="add">
				<cfinclude template="review/dsp_review_form.cfm">
			</cfcase>
			
			<cfcase value="edit">
				<cfinclude template="review/qry_get_review.cfm"> 
				<cfinclude template="review/dsp_review_form.cfm">
			</cfcase>
			
			<cfcase value="delete">
				<cfinclude template="review/dsp_delete.cfm">
			</cfcase>
			
			<cfcase value="act">
				<cfparam name="attributes.XFA_success" default="fuseaction=product.admin&review=list">
				<cfinclude template="review/act_review.cfm">
				<cfset attributes.box_title="review">
				<cfinclude template="../../includes/admin_confirmation.cfm">			
			</cfcase>
			
			<cfcase value="actform">
				<cfinclude template="review/act_review_list.cfm">
				<cfset attributes.XFA_success="#addedpath#">
				<cfset attributes.box_title="review/reviews">
				<cfinclude template="../../includes/admin_confirmation.cfm">	
			</cfcase>
					
			<!--- Product Review Settings --->
			<cfcase value="settings">
				<cfinclude template="review/dsp_review_settings.cfm">
			</cfcase>
			
			<cfcase value="save">
				<cfinclude template="review/act_review_settings.cfm">
				<cfset attributes.XFA_success="fuseaction=product.admin&review=settings&newWindow=Yes">
				<cfset attributes.menu_reload="yes">
				<cfset attributes.box_title="Review Settings">
				<cfinclude template="../../includes/admin_confirmation.cfm">				
			</cfcase>						
						
			<cfdefaultcase>
				<cfinclude template="review/qry_get_reviews.cfm">
				<cfinclude template="review/dsp_reviews_list.cfm">
			</cfdefaultcase>
			
		</cfswitch>
	</cfmodule>
<!--- end custom code. --->

		
		
<cfelse><!--- MENU --->	
	<cfinclude template="dsp_menu.cfm">
</cfif>