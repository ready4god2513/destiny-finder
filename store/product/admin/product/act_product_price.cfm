
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates the product pricing information. Called by product.admin&do=act_price --->

<!---====== Prepare form variables =====--->
<cfparam name="attributes.cid" default="">

<!--- These fields may not be passed (they depend on product type) --->
<cfloop list="content_url,Access_Keys,Access_Count,Num_Days,Recur,Recur_Product_ID,TaxCodes,Shipping,Giftwrap,weight,freight_dom,freight_intl,pack_length,pack_width,pack_height" index="counter">
	<cfparam name="attributes.#counter#" default="">
</cfloop>

<!--- Check user's access level --->
<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<!--- if not full product admin, make sure they have access to this product --->
<cfif NOT ispermitted>
	<cfmodule template="../../../access/useraccess.cfm" ID="#attributes.Product_ID#">
	<cfset editproduct = useraccess>
<cfelse>
	<cfset editproduct = "yes">
</cfif>

<cfif editproduct>

	
	
	
	<!--- Prep Numbers --->
	<cfset Min_Order = iif(isNumeric(attributes.Min_Order), trim(attributes.Min_Order), 0)>
	<cfset Base_Price = iif(isNumeric(attributes.Base_Price), trim(attributes.Base_Price), 0)>
	<cfset Retail_Price = iif(isNumeric(attributes.Retail_Price), trim(attributes.Retail_Price), 0)>
	<cfset Wholesale = iif(isNumeric(attributes.Wholesale), trim(attributes.Wholesale), 0)>
	<cfset dropship_cost = iif(isNumeric(attributes.dropship_cost), trim(attributes.dropship_cost), 0)>
	<cfset Weight = iif(isNumeric(attributes.Weight), trim(attributes.Weight), 0)>
	<cfset Shipping = iif(isNumeric(attributes.Shipping), trim(attributes.Shipping), 0)>
	<cfset Giftwrap = iif(isNumeric(attributes.Giftwrap), trim(attributes.Giftwrap), 0)>
	<cfset NuminStock = iif(isNumeric(attributes.NuminStock), trim(attributes.NuminStock), 0)>
	<cfset reorder_level = iif(isNumeric(attributes.reorder_level), trim(attributes.reorder_level), 0)>
	<cfset access_count = iif(isNumeric(attributes.access_count), trim(attributes.access_count), 0)>
	<cfset num_days = iif(isNumeric(attributes.num_days), trim(attributes.num_days), 0)>
	<cfset Freight_Dom = iif(isNumeric(attributes.Freight_Dom), trim(attributes.Freight_Dom), 0)>
	<cfset Freight_Intl = iif(isNumeric(attributes.Freight_Intl), trim(attributes.Freight_Intl), 0)>
	<cfset Pack_Length = iif(isNumeric(attributes.Pack_Length), trim(attributes.Pack_Length), 0)>
	<cfset Pack_Width = iif(isNumeric(attributes.Pack_Width), trim(attributes.Pack_Width), 0)>
	<cfset Pack_Height = iif(isNumeric(attributes.Pack_Height), trim(attributes.Pack_Height), 0)>
	
	<!--- Make changes to discounts --->
	<cfinclude template="discounts/act_update_discounts.cfm">
	
	
	<cfquery name="UpdateProduct" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Products
		SET
		NotSold = #attributes.NotSold#,
		Sale_Start = <cfif len(attributes.sale_start)>#createODBCdate(attributes.sale_start)#,<cfelse>NULL,</cfif>
		Sale_End = <cfif len(attributes.sale_end)>#createODBCdate(attributes.sale_end)#,<cfelse>NULL,</cfif>
		SKU = '#Trim(attributes.SKU)#',
		Vendor_SKU = '#Trim(attributes.Vendor_SKU)#',
		Availability = '#Trim(attributes.availability)#',
		NumInStock = #NuminStock#,
		Reorder_Level = #reorder_level#,
		Min_Order = #Min_Order#,
		Mult_Min = #attributes.Mult_Min#,
		ShowOrderBox = #attributes.ShowOrderBox#,
		VertOptions = #attributes.VertOptions#,
		ShowPrice = #attributes.ShowPrice#,
		TaxCodes = <cfif len(attributes.TaxCodes)>'#attributes.TaxCodes#',<cfelse>NULL,</cfif>
		Base_Price = #Base_Price#,
		Retail_Price = #Retail_Price#,
		Wholesale = #Wholesale#,	
		Shipping = #Shipping#,
		Freight_Dom = #Freight_Dom#,
		Freight_Intl = #Freight_Intl#,
		Pack_Length = #Pack_Length#,
		Pack_Width = #Pack_Width#,
		Pack_Height = #Pack_Height#,
		Weight = #Weight#,
		Giftwrap =  #Giftwrap#,
		ShowDiscounts = #attributes.ShowDiscounts#,
		ShowPromotions = #attributes.ShowPromotions#,
		Discounts = '#DiscountList#',
		Account_ID = <cfif len(attributes.Account_id)>#attributes.Account_id#,<cfelse>0,</cfif>
		Dropship_Cost = #dropship_cost#,
		Access_Keys = <cfif len(attributes.Access_keys)>'#Trim(attributes.Access_keys)#',<cfelse>NULL,</cfif>
		Access_Count = #access_count#,
		Recur = <cfif len(attributes.Recur)>#attributes.Recur#<cfelse>0</cfif>,
		Recur_Product_ID = <cfif len(attributes.Recur_Product_ID)>#attributes.Recur_Product_ID#<cfelse>0</cfif>,
		Num_Days = #num_days#,
		Content_URL = '#attributes.content_url#'
		WHERE Product_ID = #attributes.Product_ID#
	</cfquery>

	
	<cfif NOT Compare(frm_submit, "Edit/Add Options")>
		
		<cflocation url="#self#?fuseaction=Product.admin&do=options&product_id=#attributes.product_id##Request.Token2#" addtoken="No">
	
	<cfelse>
		<cfset mode="u">	
		<cfinclude template="dsp_act_confirmation.cfm">
			
	</cfif>			
				
<!--- user did not have access --->
<cfelse>
	<cfset attributes.message = "You do not have access to edit this product.">
	<cfset attributes.XFA_success = "fuseaction=product.admin&do=list&cid=0">
	<cfinclude template="../../../includes/admin_confirmation.cfm">

</cfif>
