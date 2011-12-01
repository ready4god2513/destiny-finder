
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Copies a product: Includes records in Products, Product_category, ProdCustom, Product_item, Prod_CustInfo, Product_Options, prodAddons --->

<!--- Product Gallery images are NOT copied --->

<!--- Called by product.admin&do=copy --->

<!--- Check user's access level --->
<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">


<!--- Get the product to copy --->
<cfquery name="GetProduct" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
	SELECT * FROM #Request.DB_Prefix#Products
	WHERE Product_ID = #attributes.dup#
	<!--- If not full product admin, filter by user to check for access --->
	<cfif not ispermitted>	
	AND User_ID = #Session.User_ID# </cfif>
</cfquery>

<cfif GetProduct.RecordCount>

	<cftransaction isolation="SERIALIZABLE">
		<cfquery name="Add_Record" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Products
		(Name, Short_Desc, Long_Desc, Base_Price, Retail_Price, Wholesale, SKU, 
		Vendor_SKU, Weight, Discounts, Promotions, AccessKey, Shipping, TaxCodes, 
		Sm_Image, Lg_Image, Enlrg_Image, Sm_Title, Lg_Title, PassParam, Color_ID, 
		Priority, Display, NuminStock, ShowPrice, ShowDiscounts, ShowPromotions, 
		ShowOrderBox, Highlight, Sale, Hot, Reviewable, UseforPOTD, NotSold, 
		DateAdded, OptQuant, Reorder_Level, Sale_Start, Sale_End, 
		Account_ID, Dropship_Cost, Prod_Type, Mfg_Account_ID, 
		Content_URL, MimeType, Access_Count, Num_Days, Access_Keys, VertOptions, 
		Freight_Dom, Freight_Intl, Pack_Length, Pack_Width, Pack_Height,
		Metadescription, Keywords, TitleTag, Availability, 
		Recur, Recur_Product_ID, GiftWrap, User_ID)
		VALUES( 'Copy of #Trim(GetProduct.Name)#',
		'#GetProduct.Short_desc#',
		'#GetProduct.Long_desc#',
		 #GetProduct.Base_price#,
		 #GetProduct.Retail_price#,
		 #GetProduct.Wholesale#,
		'#GetProduct.SKU#',
		'#GetProduct.Vendor_SKU#', 
		 #GetProduct.Weight#,
		'#GetProduct.Discounts#',
		'#GetProduct.Promotions#',
		'#GetProduct.Accesskey#',
		 #GetProduct.Shipping#,
		 '#GetProduct.TaxCodes#', 
		'#GetProduct.Sm_Image#',
		'#GetProduct.Lg_Image#',
		'#GetProduct.Enlrg_Image#',
		'#GetProduct.Sm_Title#',
		'#GetProduct.Lg_Title#',
		'#GetProduct.Passparam#',
		<cfif isNumeric(GetProduct.Color_ID)>#GetProduct.Color_ID#,<cfelse>NULL,</cfif>
		 #GetProduct.Priority#,
		 0,
		 #GetProduct.NuminStock#,
		 #GetProduct.ShowPrice#,
		 #GetProduct.ShowDiscounts#,
		  #GetProduct.ShowPromotions#,
		 #GetProduct.ShowOrderBox#,
		 #GetProduct.Highlight#,
		 #GetProduct.Sale#,
		 #GetProduct.Hot#,
		 #GetProduct.Reviewable#,
		 #GetProduct.UseforPOTD#,
		 #GetProduct.NotSold#,
		 #createODBCdate(Now())#,
		 0,
		 <cfif len(GetProduct.reorder_level)>#GetProduct.reorder_level#,<cfelse>NULL,</cfif>
		 <cfif len(GetProduct.Sale_start)>#CreateODBCDate(GetProduct.Sale_start)#,<cfelse>NULL,</cfif>
		 <cfif len(GetProduct.sale_end)>#CreateODBCDate(GetProduct.sale_end)#,<cfelse>NULL,</cfif>
		 <cfif len(GetProduct.Account_ID)>#GetProduct.Account_ID#,<cfelse>NULL,</cfif>
		 #GetProduct.dropship_cost#,
		'#GetProduct.prod_type#', 
		 <cfif len(GetProduct.mfg_account_id)>#GetProduct.mfg_account_id#,<cfelse>NULL,</cfif>
		'#GetProduct.Content_URL#',
		'#GetProduct.MimeType#',
		 <cfif len(GetProduct.access_count)>#GetProduct.access_count#,<cfelse>NULL,</cfif>
		 <cfif len(GetProduct.num_days)>#GetProduct.num_days#,<cfelse>NULL,</cfif>
		'#GetProduct.Access_keys#',
		 <cfif len(GetProduct.VertOptions)>#GetProduct.VertOptions#,<cfelse>0,</cfif>
		 #GetProduct.Freight_Dom#, #GetProduct.Freight_Intl#, 
		 #GetProduct.Pack_Length#, #GetProduct.Pack_Width#, #GetProduct.Pack_Height#,
	 	 '#GetProduct.Metadescription#',
		 '#GetProduct.Keywords#',
	 	 '#GetProduct.TitleTag#',
		 '#GetProduct.Availability#',
	  	<cfif len(GetProduct.Recur)>#GetProduct.Recur#,<cfelse>0,</cfif>
	  	<cfif len(GetProduct.Recur_Product_ID)>#GetProduct.Recur_Product_ID#,<cfelse>0,</cfif>
	  	#GetProduct.Giftwrap#, 
		 #GetProduct.User_ID#
		 )
	 </cfquery>	
	 
	<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		SELECT MAX(Product_ID) AS maxid 
		FROM #Request.DB_Prefix#Products
	</cfquery>
	
	<cfset attributes.Product_id = get_id.maxid>
				
	</cftransaction>		
	
	
	<!--- Copy product categories --->
	<cfquery name="GetProductCats" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Category_ID 
		FROM #Request.DB_Prefix#Product_Category
		WHERE Product_ID = #attributes.dup#
	</cfquery>
	
	<cfloop query="GetProductCats">
		<cfquery name="AddProdCat" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Product_Category
		(Product_ID, Category_ID)
		VALUES (#attributes.Product_ID#, #category_ID#)
		</cfquery>
	</cfloop>
	
	<!--- Copy product discounts --->
	<cfquery name="GetProdDiscounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Discount_ID 
		FROM #Request.DB_Prefix#Discount_Products
		WHERE Product_ID = #attributes.dup#
	</cfquery>
	
	<cfloop query="GetProdDiscounts">
		<cfquery name="AddProdDiscount" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Discount_Products
		(Product_ID, Discount_ID)
		VALUES (#attributes.Product_ID#, #GetProdDiscounts.Discount_ID#)
		</cfquery>
	</cfloop>
	
	<!--- Copy product promotions --->
	<cfquery name="GetProdPromotions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Promotion_ID 
		FROM #Request.DB_Prefix#Promotion_Qual_Products
		WHERE Product_ID = #attributes.dup#
	</cfquery>
	
	<cfloop query="GetProdPromotions">
		<cfquery name="AddProdPromotion" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Promotion_Qual_Products
		(Product_ID, Promotion_ID)
		VALUES (#attributes.Product_ID#, #GetProdPromotions.Promotion_ID#)
		</cfquery>
	</cfloop>
	
	<!--- Copy quantity discounts --->
	<cfquery name="GetProdDiscs" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#ProdDisc
		WHERE Product_ID = #attributes.dup#
	</cfquery>
	
	<cfloop query="GetProdDiscs">
		<cfquery name="AddProdDisc" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#ProdDisc
		(ProdDisc_ID, Product_ID, Wholesale, QuantFrom, QuantTo, DiscountPer)
		VALUES (#ProdDisc_ID#, #attributes.Product_ID#, #Wholesale#, #QuantFrom#, #QuantTo#, #DiscountPer#)
		</cfquery>
	</cfloop>
		
	<!--- Copy product group pricing --->
	<cfquery name="GetGrpPrices" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#ProdGrpPrice
		WHERE Product_ID = #attributes.dup#
	</cfquery>
	
	<cfloop query="GetGrpPrices">
		<cfquery name="AddPrice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#ProdGrpPrice
		(GrpPrice_ID, Product_ID, Group_ID, Price)
		VALUES (#GrpPrice_ID#, #attributes.Product_ID#, #Group_ID#, #Price#)
		</cfquery>
	</cfloop>
	
	<!--- Get the product's custom fields --->
	<cfquery name="GetCustom" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#Prod_CustInfo
		WHERE Product_ID = #attributes.dup#
	</cfquery>
	
	<cfloop query="GetCustom">
		<cfquery name="AddCustom" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Prod_CustInfo
		(Custom_ID, Product_ID, CustomInfo)
		VALUES (#Custom_ID#, #attributes.Product_ID#, '#CustomInfo#')
		</cfquery>
	</cfloop>
	
	<!--- Get the product's options --->
	<cfquery name="GetOptions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#Product_Options
		WHERE Product_ID = #attributes.dup#
	</cfquery>
	
	<!--- Initialize OptQuant Number --->
	<cfset NewOptQ = 0>
	
	<cfloop query="GetOptions">
	
	<cftransaction isolation="SERIALIZABLE">
		<cfquery name="AddOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Product_Options
		(Product_ID, Std_ID, Prompt, OptDesc, ShowPrice, 
		Display, Priority, TrackInv, Required)
		VALUES 
		(#attributes.product_ID#, #GetOptions.Std_ID#, 
		<cfif len(GetOptions.Prompt)>'#GetOptions.Prompt#',<cfelse>NULL,</cfif>
		<cfif len(GetOptions.OptDesc)>'#GetOptions.OptDesc#',<cfelse>NULL,</cfif>
		'#GetOptions.ShowPrice#', #GetOptions.Display#, #GetOptions.Priority#,
		#GetOptions.TrackInv#, #GetOptions.Required# )
		</cfquery>
		
		<cfquery name="getNewID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT MAX(Option_ID) AS newid 
			FROM #Request.DB_Prefix#Product_Options
		</cfquery>
				
		<cfset NewID = getNewID.newid>
			
		<!--- Check if this option is the one used for quantity --->
		<cfif GetOptions.Option_ID IS GetProduct.OptQuant>
			<cfquery name="AddOptQ" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Products
			SET OptQuant = #NewID# 
			WHERE Product_ID = #attributes.product_ID#
			</cfquery>
		</cfif>
		
		<!--- Get the product option choices and add them for the new product --->
		<cfquery name="GetChoices" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#ProdOpt_Choices
		WHERE Option_ID = #GetOptions.Option_ID#
		</cfquery>
		
		<cfloop query="GetChoices">
			<cfquery name="InsOptChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#ProdOpt_Choices
				(Option_ID, Choice_ID, ChoiceName, Price, Weight, SKU, NumInStock, SortOrder, Display)
				VALUES (
				#NewID#, #GetChoices.Choice_ID#, 
				<cfif len(GetChoices.ChoiceName)>'#GetChoices.ChoiceName#',<cfelse>NULL,</cfif>
				<cfif len(GetChoices.Price)>#GetChoices.Price#,<cfelse>NULL,</cfif>
				<cfif len(GetChoices.Weight)>#GetChoices.Weight#,<cfelse>NULL,</cfif>
				<cfif len(GetChoices.SKU)>'#GetChoices.SKU#',<cfelse>NULL,</cfif>
				#NumInStock#, #GetChoices.SortOrder#, #Display# )
			</cfquery>
		</cfloop>
	
	</cftransaction>
	
	</cfloop>
	<!--- end product options copy --->
	
	
	<!--- Get the product's addons --->
	<cfquery name="GetAddons" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#ProdAddons
		WHERE Product_ID = #attributes.dup#
	</cfquery>
	
	<cfloop query="GetAddons">
		<cfquery name="AddAddon" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#ProdAddons
		(Product_ID, Standard_ID, Prompt, AddonDesc, AddonType, Display, Priority, Price, Weight, ProdMult, Required)
		VALUES 
		(#attributes.product_ID#, 
		#GetAddons.Standard_ID#, 
		'#GetAddons.Prompt#',
		'#GetAddons.AddonDesc#',
		'#GetAddons.AddonType#',
		#GetAddons.Display#,
		#GetAddons.Priority#,
		<cfif len(GetAddons.Price)>#GetAddons.Price#,<cfelse>null,</cfif>
		<cfif len(GetAddons.Weight)>#GetAddons.Weight#,<cfelse>null,</cfif>
		<cfif len(GetAddons.ProdMult)>#GetAddons.ProdMult#,<cfelse>null,</cfif>
	    <cfif len(GetAddons.required)>#GetAddons.Required#<cfelse>null</cfif>
		)
		</cfquery>
	
	</cfloop>
	

</cfif>

