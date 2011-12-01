
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from dsp_products.cfm and other various pages that output product listings. This outputs the standard product listing with the teaser image on the left and the product teaser text and orderbox on the right.  --->

<cfif NOT len(qry_get_products.Long_Desc) AND NOT len(qry_get_products.Lg_Image)>
	<cfset morelink = "no">
<cfelse>
	<cfset morelink = "yes">
</cfif>

<!--- This parameter can be used on other templates to set if the query-of-queries need to run. 
Set to no if this template is being run after qry_get_product.cfm and set to yes for qry_get_products.cfm  --->
<cfparam name="getinfo" default="yes">
<cfparam name="attributes.showicons" default="1">

<cfset Product_ID = qry_get_products.Product_ID>
<cfinclude template="do_prodlinks.cfm">

<!--- Get this product's info from main products query if not already available --->
<cfif getinfo>
	<cfinclude template="../queries/qry_get_prod_info.cfm">
</cfif>

<!--- Output product's name and description --->
<cfoutput>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="top">

<!--- If there's a small image, get image info and put image in first cell of table row --->	
<cfif len(Sm_Image)>
	<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" imglink="#XHTMLFormat(prodlink)#" imgclass="listingimg" User="#qry_get_products.User_ID#">
	</td><td align="left" valign="top">
</cfif>

<a name="Prod#Product_ID#"></a>

<cfif len(Sm_Title)>
	<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Title#" imglink="#XHTMLFormat(prodlink)#" filealt="#Name#" User="#qry_get_products.User_ID#">
<cfelse>
	<h2 class="product"><cfif len(prodlink)><a href="#XHTMLFormat(prodlink)#" #doMouseover(Name)#>#Name#</a><cfelse>#Name#</cfif></h2>
</cfif>

<cfif Sale AND attributes.showicons>#request.SaleImage#</cfif> 
<cfif Highlight AND attributes.showicons>#request.NewImage#</cfif>
<cfif Hot AND attributes.showicons>#request.HotImage#</cfif>
<br/>
<cfif SKU IS NOT "">
<span class="prodSKU">Product ID: #SKU#</span><br/>
</cfif>


<!--- Output for custom fields --->
<cfloop query="GetProdCustom">
	<span class="prodSKU"><strong>#GetProdCustom.Custom_Name#:</strong> 					
	#GetProdCustom.CustomInfo#</span><br/>
</cfloop>

<!--- Check for short description --->
<cfif len(Short_Desc)>
	<cfmodule template="../../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" class="cat_text_small" ptag="0">

	<cfif len(prodlink)>
		 <a href="#XHTMLFormat(prodlink)#" class="cat_text_small">More...</a>
	</cfif>

</cfif>

<!--- <cfif not isdefined("attributes.notsold")>
	<cfset attributes.notsold  = notsold>
</cfif> --->

<cfif not notsold>
	<!--- Add price, discount and order box or button --->	
	<cfinclude template="put_orderbox.cfm">
			
	<cfif len(availability)>
	<br/><span class="prodSKU">#availability#</span>
	</cfif>
			
</cfif>

<!--- ADMIN EDIT LINK --->
<!--- Product Permission 1 = product admin --->
<cfmodule  template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="1"
	>	
	<span class="menu_admin"><br/>[<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=product.admin&do=edit&product_id=#qry_get_products.product_id##Request.AddToken#')#" #doAdmin()#>Edit Product #product_id#</a>]<br/></span>
</cfmodule>

</td></tr></table>
</cfoutput>


