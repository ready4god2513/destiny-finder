<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for products. Called by product.admin --->

<!--- product permissions 3 = product admin --->
<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="15"
	> 
	
<cfoutput>
	<table width="90%" class="mainpage"><tr><td><strong>Products</strong></td>
		<!--- Product Permission 3 = product edit --->
		<cfmodule template="../../access/secure.cfm"
		keyname="product"
		requiredPermission="3"
		/>
		<cfif ispermitted>
		<form name="productjump" action="#self#?fuseaction=product.admin&do=list#request.token2#" method="post">
		<td align="right"><input type="text" name="string" value="enter Product ID..." size="20" maxlength="100" class="formfield" onfocus="productjump.string.value = '';" onchange="submit();"/>
		</td></form>
		</cfif>
	</tr></table>
<ul>
<cfif ispermitted>
	<li><a href="#self#?fuseaction=product.admin&do=list&CID=0">Products</a>: Maintain the store products.</li>
	<li><a href="#self#?fuseaction=product.admin&stdoption=list#Request.Token2#">Standard Product Options</a>: Define standard product selectbox options that are used for multiple products like size or color.</li>
	<li><a href="#self#?fuseaction=product.admin&stdaddon=list#Request.Token2#">Standard Product Addons</a>: Define other product additions that are used for multiple products like monogramming or accessory items.</li>
</cfif>

<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="4"
	> 
	<li><a href="#self#?fuseaction=product.admin&discount=list#Request.Token2#">Discounts</a>: Create store discounts.</li>
</cfmodule>
<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="4"
	> 
	<li><a href="#self#?fuseaction=product.admin&promotion=list#Request.Token2#">Promotions</a>: Create store promotions.</li>
</cfmodule>
<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="16"
	> 
	<li><a href="#self#?fuseaction=product.admin&do=import#Request.Token2#">Import</a>: Import new products from a .csv file.</li>
	<li><a href="#self#?fuseaction=product.admin&do=export#Request.Token2#">Export</a>: Export products to a .csv file.</li>
</cfmodule>

<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="1"
	> 
	<li><a href="#self#?fuseaction=product.admin&fields=edit#Request.Token2#">Custom Product Fields</a>: Add additional display fields to store products (e.g. "Manufacturer").</li>
	<li><a href="#self#?fuseaction=product.admin&do=froogle&ISBNCustom=2#Request.Token2#">Google Base Data Feed</a>: Download a data feed of current products to export to Froogle.</li>
	<li><a href="#self#?fuseaction=product.admin&do=googleSiteMap#Request.Token2#">Google Sitemap</a>: Download a Google Sitemap XML document for your store.</li>
	<li><a href="#self#?fuseaction=product.admin&do=bizrate#Request.Token2#">Bizrate Data Feed</a>: Download a data feed of current products to export to Bizrate.</li>

	<!--- Product Reviews Upgrade - start custom code --->
	<li><a href="#self#?fuseaction=product.admin&review=settings#Request.Token2#">Product Reviews Settings</a>: Setting for how product reviews work.</li>

	<cfif request.appsettings.productreviews>
		<cfset attributes.display_status = "editor">
		<cfinclude template="review/qry_get_reviews.cfm">
		<li><a href="#self#?fuseaction=product.admin&review=list#Request.Token2#">Product Reviews</a>: Maintain product reviews.</li>
		<cfif qry_get_reviews.recordcount>
		<li><strong><a href="#self#?fuseaction=product.admin&review=listform&display_status=editor&order=DESC#Request.Token2#">Reviews Pending</a>: <span class="formerror">#qry_get_reviews.recordcount# review(s) require editorial approval.</span></strong></li>
		</cfif>
	</cfif>
	<!--- end custom code --->
</cfmodule>
</ul>
</cfoutput>


</cfmodule>