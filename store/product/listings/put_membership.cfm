
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Outputs product in table.

Called from dsp_products.cfm and other various pages that output product listings. This outputs the standard product listing with the teaser image on the left and the product teaser text and orderbox on the right.  --->

<cfif NOT len(qry_get_products.Long_Desc) AND NOT len(qry_get_products.Lg_Image)>
	<cfset morelink = "no">
<cfelse>
	<cfset morelink = "yes">
</cfif>

<cfset Product_ID = qry_get_products.Product_ID>
<cfinclude template="do_prodlinks.cfm">	

<cfparam name="attributes.showicons" default="1">

<!--- Output product's name and description --->
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
</cfoutput>

<cfoutput><td valign="top"></cfoutput>

<!--- If there's a small image, get image info and put image in first cell of table row --->	
<cfif len(Sm_Image)>
	<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" prodlink="#XHTMLFormat(prodlink)#" align="left" imgclass="listingimg" User="#qry_get_products.User_ID#">
	<cfoutput></td><td align="left" valign="top"></cfoutput>
</cfif>

<cfoutput><a name="Prod#Product_ID#"></a></cfoutput>

<cfif len(Sm_Title)>
<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Title#" prodlink="#XHTMLFormat(prodlink)#" filealt="#Name#" User="#qry_get_products.User_ID#">
<cfelse>
<cfoutput>
<h2 class="product">
	<cfif len(prodlink)>
	<a href="#XHTMLFormat(prodlink)#" #doMouseover(Name)#><span class="prodname">#Name#</span></a>
	<cfelse>
	<span class="prodname">#Name#</span>
	</cfif>
</h2>
</cfoutput>
</cfif>

<cfoutput>
<cfif Sale AND attributes.showicons>#request.SaleImage#</cfif> 
<cfif Highlight AND attributes.showicons>#request.NewImage#</cfif>
<cfif Hot AND attributes.showicons>#request.HotImage#</cfif>
<br/>
<cfif SKU IS NOT "">
<span class="prodSKU">Product ID: #SKU#</span><br/>
</cfif>
</cfoutput>

<!--- Check for short description --->
<cfif len(Short_Desc)>
<cfmodule template="../../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" class="cat_text_small" ptag="0">

<cfif len(prodlink)>
<cfoutput> <a href="#XHTMLFormat(prodlink)#" class="cat_text_small">More...</a></cfoutput>
</cfif>

</cfif>


<!--- <cfif not isdefined("attributes.notsold")>
	<cfset attributes.notsold  = notsold>
</cfif> --->

<cfif not notsold>
	<!--- Add price, discount and order box or button --->	
	<cfoutput>		
</td>

<td align="right">
<form action="#XHTMLFormat('#self#?fuseaction=shopping.order#request.token2#')#" method="post" name="orderform#Product_ID#" class="nomargins">
<input type="hidden" name="Product_ID" value="#product_id#"/>		
	<input type="image" src="#Request.AppSettings.defaultimages#/#Request.AppSettings.OrderButtonImage#" 	alt="#Request.AppSettings.OrderButtonText#" align="middle"/>
	<cfif len(availability)>
	<br/><span class="prodSKU">#availability#</span>
	</cfif>
</form>
</td>	
	</cfoutput>
<cfelse>
	<cfoutput></td>	</cfoutput>
</cfif>

<cfoutput></tr></table></cfoutput>

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



