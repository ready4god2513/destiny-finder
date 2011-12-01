
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from dsp_products.cfm and other various pages that output product listings. This outputs the vertical product listing with the teaser image on the top and the product teaser text is below. No orderbox is displayed. This layout works nicely if you are displaying lots of images with short descriptions on a page, like an product gallery page. --->

<cfset Product_ID = qry_get_products.Product_ID>
<cfinclude template="do_prodlinks.cfm">

<cfparam name="attributes.showicons" default="1">

<!--- Output product's name and description --->
<cfoutput><table cellspacing="0" cellpadding="0" border="0"></cfoutput>

<!--- If there's a small image, get image info and put image in first cell of table row --->	
<cfif len(Sm_Image)>
	<tr>
		<td align="center"><cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" imglink="#XHTMLFormat(prodlink)#" hspace="0" vspace="0" User="#qry_get_products.User_ID#">
		</td>
	</tr>
</cfif>

<!----- Row for product name ---->
	<tr>
		<td align="center" valign="top">
		<!--- provide anchor point for link --->
		<cfoutput><a name="Prod#Product_ID#"></a>

		
		<cfif len(Sm_Title)>
			<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Title#" imglink="#XHTMLFormat(prodlink)#" filealt="#Name#">
		<cfelse>
			<h3 class="product"><a href="#XHTMLFormat(prodlink)#" #doMouseover(Name)#>#Name#</a></h3>
		</cfif>
		<cfif Sale AND attributes.showicons>#request.SaleImage#</cfif> 
		<cfif Highlight AND attributes.showicons>#request.NewImage#</cfif>
		<cfif Hot AND attributes.showicons>#request.HotImage#</cfif>
		</cfoutput>
	</td></tr>
	<tr><td align="center">
	
	<cfif ShowPrice>
		<!--- Uncomment this section to show the base user price for the item
		<cfset AllPrices = "no">
		<cfinclude template="../queries/qry_get_prod_info.cfm">
		<cfinclude template="put_price.cfm">
		<br/> --->
	</cfif>

		<!--- Check for short description --->
		<cfif len(Short_Desc) and attributes.listing is "vertical">
			<cfmodule template="../../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" ptag="no"><br/>
		</cfif>
<cfoutput></td></tr></table></cfoutput>


<!--- ADMIN EDIT LINK --->
<!--- Product Permission 1 = product admin --->
<cfmodule  template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="1"
	>	
	<cfoutput>
	<span class="menu_admin"><br/>[<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=product.admin&do=edit&product_id=#product_id##Request.AddToken#')#" #doAdmin()#>Edit Product #product_id#</a>]<br/></span>
	</cfoutput>
</cfmodule>



