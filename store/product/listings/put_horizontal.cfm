<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfif NOT len(qry_get_products.Long_Desc) AND NOT len(qry_get_products.Lg_Image)>
	<cfset morelink = "no">
<cfelse>
	<cfset morelink = "yes">
</cfif>

<cfinclude template="do_prodlinks.cfm">
<cfinclude template="../queries/qry_get_prod_info.cfm">

<cfparam name="attributes.showicons" default="1">

<cfoutput>

<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="listingtext"><tr>
		<td>
		<cfif len(Sm_Image)>
		<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" prodlink="#XHTMLFormat(prodlink)#" 
			align="left" imgclass="listingimg" User="#qry_get_products.User_ID#">
		</cfif>
		</td>
		<td>
<cfif len(Sm_Title)>
	<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Title#" prodlink="#XHTMLFormat(prodlink)#" 
		filealt="#Name#" User="#qry_get_products.User_ID#">
<cfelse>
	<h2 class="product"><a href="#XHTMLFormat(prodlink)#" #doMouseover(Name)#>#Name#</a></h2>
</cfif>
	<cfif Sale AND attributes.showicons>#request.SaleImage#</cfif> 
	<cfif Highlight AND attributes.showicons>#request.NewImage#</cfif>
	<cfif Hot AND attributes.showicons>#request.HotImage#</cfif>
	
	<cfif len(trim(Short_Desc)) and Short_Desc is not "&nbsp;">
		<br/><cfmodule template="../../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" ptag="no" class="cat_text_small">
	</cfif>
	</td>

<!--- Include rating information if used --->	
<cfif request.appsettings.productreviews>	
	<td >
	<cfif qry_get_products.reviewable AND not listfind(qry_get_products.passparam,'reviews=0')>	
		<cfif IsNumeric(Avg_Rating)>
			<img src="#request.appsettings.defaultimages#/icons/#ceiling(Avg_Rating)#_lg_stars.gif" alt="" />
(<cfif Avg_Rating gt 4>Excellent<cfelseif Avg_Rating gt 3>Very Good<cfelseif Avg_Rating gte 2>Average<cfelseif Avg_Rating gte 1>Below Average<cfelseif Avg_Rating gt 0>Avoid It</cfif>) <br/>
		<cfelse>
			Not Rated<br/>
		</cfif>
	</cfif>
		</td>
</cfif>

	<cfif ShowPrice>
		<td width="20%" align="center">
		<cfset AllPrices = "no">
		<cfinclude template="put_price.cfm">
		</td>
	</cfif>
	
		<td align="right">
<cfif NOT GetProdOpts.RecordCount AND NOT GetProdAddons.RecordCount>
	<cfmodule template="../../customtags/putimage.cfm" filename="#Request.AppSettings.OrderButtonImage#" filealt="#Request.AppSettings.OrderButtonText#" imglink="#XHTMLFormat('#self#?fuseaction=shopping.order&Product_ID=#Product_ID##Request.Token2#')#" align="middle">
</cfif>
		</td>
</tr></table>
</cfoutput>

