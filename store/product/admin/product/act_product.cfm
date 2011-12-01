
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for products: add, update, delete. Called by product.admin&do=act --->

<cfparam name="attributes.cid" default="0">
<cfparam name="attributes.related_products" default="">
<cfparam name="attributes.CID_list" default="">

<!--- Check user's access level --->
<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<!--- if not full product admin, and is not adding a product, make sure they have access to this product --->
<cfif NOT ispermitted AND mode IS NOT "i">
	<cfmodule template="../../../access/useraccess.cfm" ID="#attributes.Product_ID#">
	<cfset editproduct = useraccess>
	<cfset prod_user = Session.User_ID>
<cfelseif NOT ispermitted AND mode IS "i">
	<cfset editproduct = "yes">
	<cfset prod_user = Session.User_ID>
<cfelse>	
	<cfset editproduct = "yes">
	<cfset prod_user = 0>
</cfif>

<cfif editproduct>
	<!---====== Prepare form variables =====--->
	<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
		<cfset attributes.Priority = 9999>
	</cfif>
	
	<!--- Replace double carriage returns with HTML paragraph tags. --->
	<cfset HTMLBreak = Chr(60) & 'br/' & Chr(62)>
	<cfset HTMLParagraph = HTMLBreak & HTMLBreak>
	<cfset LineBreak = Chr(13) & Chr(10)>
	<cfset Long_Desc = Replace(Trim(attributes.Long_Desc), LineBreak & LineBreak, HTMLParagraph & LineBreak & LineBreak, "ALL")>
	<cfset Short_Desc = Replace(Trim(attributes.Short_Desc), LineBreak & LineBreak, HTMLParagraph & LineBreak & LineBreak, "ALL")>
	<cfmodule template="../../../customtags/intlchar.cfm" string="#Short_Desc#">
	<cfset Short_Desc = String>
	
	<!--- Replace any instances of the reserved characters --->
	<cfset Name = Trim(attributes.Name)>
	<!--- <cfset Name = ReplaceList(Name, ":", ";")> --->
	<!----
	<cfset Name = HTMLEditFormat(Name)>
	--->
	
	<cfswitch expression="#mode#">
		<cfcase value="i">
			
			<!--- Set the tax by default to the first tax rate in the store --->
			<cfquery name="GetDefaultTax" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
				SELECT Code_ID FROM #Request.DB_Prefix#TaxCodes
				ORDER BY CalcOrder
			</cfquery>
	
			<cftransaction isolation="SERIALIZABLE">
			
			<cfquery name="Add_Record" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#Products
			(Name, Short_Desc, Long_Desc, Metadescription, Keywords, TitleTag, Sm_Image, Lg_Image, Enlrg_Image, 
			Sm_Title, Lg_Title, PassParam, Color_ID, Display, Priority, AccessKey, Highlight, Sale, Hot, 
			Reviewable, UseforPOTD, Prod_Type, Mfg_Account_ID, TaxCodes, DateAdded, OptQuant, User_ID)
			
			VALUES(
			'#Name#',
			'#short_desc#',
			'#long_desc#',
			'#Trim(attributes.metadescription)#',
			'#Trim(attributes.keywords)#',
			'#Trim(attributes.titletag)#',
			'#Trim(Attributes.sm_image)#',
			'#Trim(Attributes.lg_image)#',
			'#Trim(Attributes.enlrg_image)#',
			'#Trim(Attributes.sm_title)#',
			'#Trim(Attributes.lg_title)#',
			'#Trim(Attributes.passparam)#',
			<cfif isNumeric(Attributes.Color_ID)>#Attributes.Color_ID#,<cfelse>NULL,</cfif>
			 #Attributes.display#,
			 #Attributes.priority#,
			<cfif len(trim(Attributes.AccessKey))>#Trim(Attributes.AccessKey)#,<cfelse>0,</cfif>
			 #Attributes.Highlight#,
			 #Attributes.sale#,
			 #Attributes.hot#,
			 #Attributes.Reviewable#,
			 #Attributes.UseforPOTD#,
			'#Attributes.prod_type#',
			<cfif len(Attributes.mfg_account_id)>#Attributes.mfg_account_id#,<cfelse>NULL,</cfif>
			<cfif GetDefaultTax.RecordCount>'#GetDefaultTax.Code_ID#',<cfelse>NULL,</cfif>
			 #createODBCdate(now())#,
			 0, #prod_user# )
			</cfquery>				
	
			<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				SELECT MAX(Product_ID) AS maxid 
				FROM #Request.DB_Prefix#Products
				</cfquery>
	
			<cfset attributes.Product_id = get_id.maxid>
			
			</cftransaction>
			
			<!--- ADDITIONAL PROCESSING HERE ----->
			
			</cfcase>
				
			<cfcase value="u">
				
				<!--- If changing categories, or deleting product, update the categories --->
				<cfif Compare(attributes.cid_list, attributes.current_cats) IS NOT 0 OR frm_submit is "Delete">
				
					<!--- Delete all current categories ----->		
					<cfquery name="delete_categories"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Product_Category
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
				
				</cfif>							
						
				<cfif frm_submit is "Delete">
				
					<!--- check if product is being used in memberships or orders ---->
					<cfset attributes.error_message = "">			
				
					<cfquery name="checkmemberships" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					SELECT Membership_ID
					FROM #Request.DB_Prefix#Memberships
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
				
					<cfif checkmemberships.recordcount gt 0>
						<cfset attributes.error_message = attributes.error_message &  "<br/>This Product is used in Memberships. Please edit or delete those first.">
					</cfif>
					
					<cfquery name="checkrecur" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					SELECT Product_ID
					FROM #Request.DB_Prefix#Products
					WHERE Recur_Product_ID = #attributes.product_id#
					</cfquery>
				
					<cfif checkrecur.recordcount gt 0>
						<cfset attributes.error_message = attributes.error_message &  "<br/>This Product is used for a recurring product membership. Please edit or delete that first.">
					</cfif>	
					
					<cfquery name="checkpromotion" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					SELECT Promotion_ID
					FROM #Request.DB_Prefix#Promotions
					WHERE Disc_Product = #attributes.product_id#
					</cfquery>
				
					<cfif checkpromotion.recordcount gt 0>
						<cfset attributes.error_message = attributes.error_message &  "<br/>This Product is used as the discounted product in a promotion. Please edit or delete that first.">
					</cfif>	
					
	<!--- 				<cfquery name="checkorders" datasource="#Request.DS#" 
					username="#Request.user#" password="#Request.pass#">
					SELECT Order_No
					FROM #Request.DB_Prefix#Order_Items
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
				
					<cfif checkorders.recordcount gt 0>
						<cfset attributes.error_message = attributes.error_message &  "<br/>This Product is used in Orders. Please edit or delete those first.">
					</cfif> --->		
							
					<cfif len(attributes.error_message) gt 0>			
						
						<cfset attributes.error_message = "This Product could not be deleted for the following reasons:<br/>" &  attributes.error_message >
					
					
					<cfelse><!--- OK to delete --->
					
					<cfquery name="DeleteWishlist"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#WishList
					WHERE Product_ID = #attributes.product_id#
					</cfquery>	
					
					<cfquery name="DeleteRegistryItems"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#GiftItems
					WHERE Product_ID = #attributes.product_id#
					</cfquery>						
					
					<cfquery name="delete_related"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Product_Item
					WHERE Item_ID = #attributes.product_id#
					</cfquery>
	
					<cfquery name="delete_prices"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#ProdGrpPrice
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
							
					<cfquery name="delete_related2"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Product_Item
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
								
					<cfquery name="delete_reviews_helpful"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#ProductReviewsHelpful
					WHERE Product_ID = #attributes.product_id#
					</cfquery>	
	
					<cfquery name="delete_reviews"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#ProductReviews
					WHERE Product_ID = #attributes.product_id#
					</cfquery>

					<cfquery name="delete_related_features"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Feature_Product
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
					
					<cfquery name="DeleteChoices" datasource="#Request.DS#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#ProdOpt_Choices
					WHERE Option_ID IN (SELECT Option_ID FROM #Request.DB_Prefix#Product_Options
										WHERE Product_ID = #attributes.product_id#)
					</cfquery>
					
					<cfquery name="DeleteOptions" datasource="#Request.DS#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Product_Options
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
					
					<cfquery name="DeleteAddons" datasource="#Request.DS#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#ProdAddons
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
					
					<cfquery name="DeleteCustom" datasource="#Request.DS#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Prod_CustInfo
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
					
					<cfquery name="DeleteDisc" datasource="#Request.DS#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#ProdDisc
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
					
					<!--- Delete any assigned discounts --->
					<cfquery name="DeleteDiscounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Discount_Products
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
					
					<!--- Delete any assigned promotions --->
					<cfquery name="DeletePromotions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Promotion_Qual_Products
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
	
					<cfquery name="delete_images"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					SELECT Sm_Image, Lg_Image, Enlrg_Image, Sm_Title, Lg_Title
					FROM #Request.DB_Prefix#Products 
					WHERE Product_ID = #attributes.product_id#
					</cfquery>			
					
					<cfquery name="delete_gallery"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					SELECT Image_File
					FROM #Request.DB_Prefix#Product_Images
					WHERE Product_ID = #attributes.product_id#
					</cfquery>								
									
					<cfquery name="DeleteImages"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Product_Images
					WHERE Product_ID = #attributes.product_id#
					</cfquery>	
									
					<cfquery name="delete_products"  datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Products 
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
					
					</cfif><!--- ok to delete --->
									
				<cfelse>
			
					<cfquery name="Update_products" datasource="#Request.ds#" 
					username="#Request.user#" password="#Request.pass#">
					UPDATE #Request.DB_Prefix#Products
					SET 	
					Name = '#Trim(Name)#',
					Prod_Type = '#Trim(attributes.Prod_type)#',
					TitleTag = '#Trim(titletag)#',
					Mfg_Account_ID = <cfif len(attributes.mfg_account_id)>#attributes.mfg_account_id#,<cfelse>NULL,</cfif>
					Sm_Title = '#Trim(attributes.Sm_Title)#',
					Sm_Image = '#Trim(attributes.Sm_image)#',
					Short_Desc = '#Trim(short_desc)#',
					Lg_Title = '#Trim(attributes.lg_title)#',
					Lg_Image = '#Trim(attributes.lg_image)#',
					Enlrg_Image = '#Trim(attributes.enlrg_image)#',
					Long_Desc = '#Trim(long_desc)#',
					Metadescription = '#Trim(metadescription)#',
					Keywords = '#Trim(keywords)#',
					PassParam = '#Trim(attributes.passparam)#',
					Color_ID = <cfif isNumeric(Attributes.Color_ID)>#Attributes.Color_ID#,<cfelse>NULL,</cfif>
					Display = #attributes.Display#,
					Priority = #attributes.Priority#,
					AccessKey = <cfif len(trim(Attributes.AccessKey))>#Trim(Attributes.AccessKey)#,<cfelse>0,</cfif>
					Highlight = #Trim(attributes.Highlight)#,
					Sale = #Trim(attributes.sale)#,
					Hot = #Trim(attributes.hot)#,
					Reviewable = #attributes.Reviewable#,
					UseforPOTD = #attributes.UseforPOTD#,
					DateAdded = <cfif len(attributes.dateadded)>#createODBCdate(attributes.dateadded)#<cfelse>NULL</cfif>
					WHERE Product_ID = #attributes.product_id#
					</cfquery>
					
				</cfif>
			
			</cfcase>
	
		</cfswitch>	
		
		<!--- Add Category ----->
		<!--- If changing categories, or inserting product, add to the categories --->
		<cfif len(attributes.cid_list) AND Compare(attributes.cid_list, attributes.current_cats) IS NOT 0 
			AND frm_submit is NOT "Delete">
	
			<cfloop index="thisID" list="#attributes.CID_LIST#">
				<cfquery name="Add_Product_Category" datasource="#Request.ds#" 
				username="#Request.user#"  password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#Product_Category
				(Product_ID, Category_ID)
				VALUES(#attributes.Product_ID#, #thisID#)
				</cfquery>
			</cfloop>
			
			<!--- Update product discount list --->
			<cfinvoke component="#Request.CFCMapping#.shopping.discounts" 
				method="updProdDiscounts" Product_ID="#attributes.Product_ID#">
			
		</cfif>	
		
		
	<cfif mode is "i">
	
		<cfset goto="#self#?fuseaction=Product.admin&do=price&product_id=#attributes.product_id#&cid=#attributes.cid#">
		
		<cflocation url="#goto##Request.Token2#" addtoken="NO">
					
	<cfelse>		
		
		<cfif frm_submit is "Delete">
	
			<cfif len(attributes.error_message) is 0>
			
			<cfset attributes.xfa_success = "fuseaction=Product.admin&do=list&cid=" & attributes.cid>
	
			
			<cfset attributes.image_list="">
			<cfif len(delete_images.sm_image)>
				<cfset attributes.image_list = listappend(attributes.image_list,delete_images.sm_image)>
			</cfif>
			<cfif len(delete_images.sm_title)>
				<cfset attributes.image_list = listappend(attributes.image_list,delete_images.sm_title)>
			</cfif>
			<cfif len(delete_images.lg_image)>
				<cfset attributes.image_list = listappend(attributes.image_list,delete_images.lg_image)>
			</cfif>
			<cfif len(delete_images.enlrg_image)>
				<cfset attributes.image_list = listappend(attributes.image_list,delete_images.enlrg_image)>
			</cfif>
			<cfif len(delete_images.lg_title)>
				<cfset attributes.image_list = listappend(attributes.image_list,delete_images.lg_title)>
			</cfif>
			
			<cfloop query="delete_gallery">
				<cfset galleryimage ="products/" & Image_File>
				<cfset attributes.image_list = listappend(attributes.image_list,galleryimage)>
			</cfloop>
			
			<cfif len(attributes.image_list)>
				<cfinclude template="../../../includes/remove_images.cfm">	
			<cfelse>
				<cfinclude template="dsp_act_confirmation.cfm">
			</cfif>
			
			<cfelse> <!--- error deleting --->
				
				<cfset attributes.box_title="Product Manager">
				<cfinclude template="../../../includes/admin_confirmation.cfm">
			
			</cfif>
			
	
		<cfelse>
		
			<cfinclude template="dsp_act_confirmation.cfm">
		
		</cfif>
		
	</cfif>
	
<!--- user did not have access --->
<cfelse>
	<cfset attributes.message = "You do not have access to edit this product.">
	<cfset attributes.XFA_success = "fuseaction=product.admin&do=list&cid=0">
	<cfinclude template="../../../includes/admin_confirmation.cfm">

</cfif>

