
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from dsp_products.cfm and other various pages that output product listings. This outputs a summary product listing with just the teaser image, name, and price, no details. Very useful for gallery styles of product listings. --->

<cfset Product_ID = qry_get_products.Product_ID>
<cfinclude template="do_prodlinks.cfm">

<!--- This parameter can be used on other templates to set if the query-of-queries need to run. 
Set to no if this template is being run after qry_get_product.cfm and set to yes for qry_get_products.cfm  --->
<cfparam name="getinfo" default="yes">
<cfparam name="attributes.showicons" default="0">

<!--- Get this product's info from main products query if not already available --->
<cfif getinfo>
	<cfinclude template="../queries/qry_get_prod_info.cfm">
</cfif>

<!--- Output product's image and name --->

<!--- If there's a small image, get image info and put image in first cell of table row --->	
<cfif len(Sm_Image)>
	<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" imglink="#XHTMLFormat(prodlink)#" imgclass="gallerylistimg" User="#qry_get_products.User_ID#">
<cfelseif len(Sm_Title)>
	<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Title#" imglink="#XHTMLFormat(prodlink)#" filealt="#Name#" User="#qry_get_products.User_ID#">
</cfif>

<cfoutput>
<a name="Prod#Product_ID#"></a>

<cfif Sale AND attributes.showicons>#request.SaleImage#</cfif> 
<cfif Highlight AND attributes.showicons>#request.NewImage#</cfif>
<cfif Hot AND attributes.showicons>#request.HotImage#</cfif>
<br/>

<!--- Output Product Name --->
<a href="#XHTMLFormat(prodlink)#" class="gallerylist" #doMouseover(Name)#>#Name#</a><br/>

</cfoutput>

<cfif ShowPrice>
	<cfset AllPrices = "No">
	<span class="gallerylist">
	<cfinclude template="put_price.cfm">
	</span>
	<br/>
</cfif>




