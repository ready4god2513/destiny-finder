
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the main page used to display the product detail page. Called by the product.display fuseaction --->

<!--- Set Metatags for this page ----------->
<cfif len(qry_get_products.metadescription)>
	<cfset metadescription = qry_get_products.metadescription>
</cfif>

<cfif len(qry_get_products.keywords)>
	<cfset keywords = qry_get_products.keywords>
</cfif>

<cfif len(qry_get_products.titletag)>
	<cfset Webpage_title = qry_get_products.titletag>
<cfelse>
	<cfset Webpage_title = qry_get_products.Name>
</cfif>

<cfparam name="attributes.RelatedFeatTitle" default="Read More...">
<cfparam name="attributes.RelatedProdTitle" default="May we also suggest">
<cfparam name="attributes.PubImagesTitle" default="More Images">

<!--- This is the product detail page. --->

<!--- Add scripts and styles for popups --->
<cfhtmlhead text='
	<link rel="stylesheet" href="css/thumbnailviewer.css" type="text/css" />
	<script type="text/javascript" src="includes/openwin.js"></script>
	<script type="text/javascript" src="includes/thumbnailviewer.js">
	/***********************************************
	* Image Thumbnail Viewer Script- © Dynamic Drive (www.dynamicdrive.com)
	* This notice must stay intact for legal use.
	* Visit http://www.dynamicdrive.com/ for full source code
	***********************************************/
	</script>
	'>

<!----- Set this product page for Keep Shopping button ------->
<cfset Session.Page="#Request.currentURL#">


<table width="100%" class="mainpage">
	<tr>
	
		<!----- The first cell for large image if it exists ------>
		<td valign="top">
		
		<!--- Multiple large images, show slideshow --->
		<cfif ListLen(qry_get_products.Lg_Image) GT 1>
			<cfset Lg_Images = qry_get_products.Lg_Image>
			<cfinclude template="listings/lg_image_slideshow.cfm">
			<div align="center">Click image for more views.</div>
		
		<cfelse>
			<cfif len(qry_get_products.Lg_Image)>
				<cfset prodImage = qry_get_products.Lg_Image>
			<cfelse>
				<cfset prodImage = qry_get_products.Sm_Image>		
			</cfif>
			
			<!--- Enlarged image available --->
			<cfif len(qry_get_products.Enlrg_Image)>
				<cfinclude template="listings/put_openimage.cfm">
			<cfelseif len(prodImage)>
				<cfmodule template="../customtags/putimage.cfm" filename="#prodImage#" filealt="#qry_get_products.Name#"
						imgclass="listingimg" User="#qry_get_products.User_ID#" />
			</cfif>
			
		</cfif>

		</td>
		
		
		<!---- Second cell for product information ---->
		<td valign="top" width="99%">		
		
		<!--- Insert vendor Logo or name --->
		<cfif len(qry_get_products.logo)>
			<cfmodule template="../customtags/putimage.cfm" filename="#qry_get_products.logo#" filealt="#qry_get_products.Account_Name#">
		<cfelseif len(qry_get_products.account_name)>
			<cfoutput>#qry_get_products.account_name#</cfoutput> 
		</cfif>
		
		
		<!---- Title ----->		
		<cfif len(qry_get_products.Lg_Title)>
<cfmodule template="../customtags/putimage.cfm" filename="#qry_get_products.Lg_Title#" filealt="#qry_get_products.Name#" User="#qry_get_products.User_ID#">
		<cfelse>
<cfmodule template="../customtags/puttitle.cfm" TitleText="#qry_get_products.Name#" class="product">
		</cfif>

<br/>

	<!--- ADMIN EDIT LINK --->
	<!--- Shopping Permission 1 = product admin --->
	<cfmodule  template="../access/secure.cfm"
		keyname="product"
		requiredPermission="1"
		>		
		<cfoutput>
		[<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=product.admin&do=edit&product_id=#attributes.product_id##Request.AddToken#')#" #doAdmin()#>Edit Product #attributes.product_id#</a>]<br/></cfoutput>
	</cfmodule>
			
	<cfloop query="qry_get_products">
		<cfoutput>
		
		<!---- SKU ----->	
		<cfif SKU IS NOT ""><span class="prodSKU"><b>Product ##:</b> #SKU#</span><br/></cfif>

		<!--- Output for custom fields --->
		<cfloop query="GetProdCustom">
			<span class="prodSKU"><strong>#GetProdCustom.Custom_Name#:</strong> 					
			#GetProdCustom.CustomInfo#</span><br/>
		</cfloop>
	
		<!--- anchor used for product option error return --->
		<a name="Prod#Product_ID#"></a>		

		<!--- Determine method of ordering --->
		<cfif GetProdOpts.RecordCount OR GetProdAddons.RecordCount OR ShowOrderBox>
		<cfset Type="Table">
		<cfelse>
		<cfset Type="Button">
		</cfif>
		<!--- Check if item Not Sold --->		
		
		<cfif NOT NotSold>
			<!--- Check to see if this product is currently being sold ---->
			<cfif isDate(qry_get_products.sale_end) and DateCompare(qry_get_products.Sale_end, Now()) LT 0>
				<br/><div class="caution">Not Currently Available</div>
			<cfelseif isDate(qry_get_products.sale_start) and DateCompare(qry_get_products.Sale_start, Now()) GT 0>	
				<br/><div class="caution">Sales Start #dateformat(qry_get_products.sale_start,"mm/dd/yy")#</div>			
			<cfelse>				
				<!--- Add price, discount and order box or button --->
				<cfset MoreInfo = "Yes">
				<cfinclude template="listings/put_orderbox.cfm">
			
				<cfif len(availability)><span class="prodSKU">#availability#</span></cfif>
			
			</cfif>
			
		</cfif>
		
		</cfoutput>
		
		</cfloop>
		

		</td>
	</tr>
	
	<tr><td colspan="2">
	<!--- Check for Long Description --->
	<cfif len(Trim(qry_get_products.Long_Desc))>
		<cfset Text = qry_get_products.Long_Desc>
	<cfelse>
		<cfset Text = qry_get_products.Short_Desc>
	</cfif>
	<cfmodule template="../customtags/puttext.cfm" Text="#Text#" Token="#Request.Token1#">

	</td></tr>
</table>
<br/>


	<cfmodule template="put_pics/put_gallery.cfm"
	Product_ID = "#attributes.product_ID#"
	Prod_User="#qry_get_products.User_ID#"
	gallery = "Public"
	SectionTitle="#attributes.PubImagesTitle#"
	>
	
	<!--- Access restrictions can be used to limit user access to product
	gallery images marked as "private". Here we have added a Login check, but
	it could also easily be a particular content access key or group. See the
	access/secure.cfm template for usage instructions.
	--->
	<cfmodule template="../access/secure.cfm"
	keyname="login"
	requiredPermission="0"
	/>
	<cfif ispermitted>
		<cfmodule template="put_pics/put_gallery.cfm"
		Product_ID = "#attributes.product_ID#"
		Prod_User="#qry_get_products.User_ID#"
		gallery = "Private"
		>
	</cfif>

	
<!--- Product Reviews Upgrade - start custom code --->
<cfif request.appsettings.productreviews AND qry_get_products.reviewable>
	<cfset attributes.do = "inline">
	<cfset fusebox.nextaction="product.reviews">
	<cfinclude template="../lbb_runaction.cfm">
</cfif>
<!--- end custom code. --->
	
<!--- For related items --->	
<cfset attributes.detail_id = attributes.product_ID>
	
<!------ Related Features ------>
<cfset attributes.detail_type = "Product">
<cfset attributes.SectionTitle = attributes.RelatedFeatTitle>
<cfset fusebox.nextaction="feature.related">
<cfinclude template="../lbb_runaction.cfm">


<!------ Related Products ------>
<cfparam name="attributes.listing" default="">
<cfset attributes.SectionTitle = attributes.RelatedProdTitle>
<cfset fusebox.nextaction="product.related">
<cfinclude template="../lbb_runaction.cfm">

<br/>
	
<table width="96%" align="center" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td align="left">
		<cfset attributes.detail_type = "Product">
		<cfset fusebox.nextaction="category.related">
		<cfinclude template="../lbb_runaction.cfm">


		</td>
		<td align="right" valign="top" class="section_footer">

<!--- Put Back and Next Item links --->
<cfmodule template="../customtags/nextitems.cfm"
	mode="display"
	type="product"
	ID = "#attributes.product_ID#"
	class="section_footer"
	ParentCat="#attributes.ParentCat#"
	>
		</td>
	</tr>

</table>



