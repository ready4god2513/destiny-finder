
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Default file used for the 'items on sale' page template. This page is similar to catcore_highlight.cfm, you can use whichever suits you better. This template only includes categories and products and uses a very simple layout with no orderboxes. --->

<!--- Set default number of columns --->
<cfparam name="attributes.pcolumns" default="#Request.AppSettings.PColumns#">
<cfif isdefined("request.qry_get_cat.pcolumns") and request.qry_get_cat.pcolumns is not "">
	<cfset attributes.pcolumns = request.qry_get_cat.pcolumns>
</cfif>

<cfparam name="attributes.new" default="">
<cfparam name="attributes.hot" default="">
<cfparam name="attributes.onsale" default="1">

<cfinclude template="qry_highlight.cfm">
<cfset attributes.category_ID = "">
<cfinclude template="../product/queries/qry_get_products.cfm">
<cfset NumList = qry_get_Hcats.RecordCount + qry_get_products.RecordCount>

<cfset CurrentNum = 1>
<cfset TotalNum = NumList>

<cfif NumList GT 0>

<!--- ========================================  Ouput any Sale Categories --->
<cfloop query="qry_get_Hcats">

<cfif Request.AppSettings.UseSES>
	<cfset catlink = "#Request.SESindex#category/#qry_get_Hcats.Category_ID#/#SESFile(qry_get_Hcats.Name)##Request.Token1#">
<cfelse>
	<cfset catlink = "#self#?fuseaction=category.display&category_ID=#qry_get_Hcats.Category_ID##Request.Token2#">
</cfif>

<cfif attributes.PColumns LTE 1 OR CurrentNum MOD attributes.PColumns IS 1>
<cfoutput><table cellpadding="6" cellspacing="0" border="0" width="100%"><tr></cfoutput>
</cfif> 

<!--- Output category's name and description --->
<cfoutput>
	<td valign="top" width="#(100/attributes.PColumns)#%">
	<table cellpadding="0" cellspacing="0"><tr><td valign="top">
</cfoutput>

<cfif len(Sm_Image)>
	<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" imglink="#XHTMLFormat(catlink)#">
</cfif>

<cfoutput></td><td align="left" valign="top"></cfoutput>

<cfif len(Sm_Title)>
	<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Title#" filealt="#Name#" imglink="#XHTMLFormat(catlink)#" class="listingimg">
<cfelse>
	<cfoutput>
	<h2 class="product"><a href="#XHTMLFormat(catlink)#" #doMouseover(Name)#>#Name#</a></h2>
	</cfoutput>
</cfif>

<!---
<cfoutput>
<cfif Sale>#Request.SaleImage#</cfif> 
<cfif Highlight>#Request.NewImage#</cfif>
<cfif Hot>#request.HotImage#</cfif>
</cfoutput>----->

<!--- Check for short description --->
<cfif len(Short_Desc)>
<div><cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" class="cat_text_small"></div>
</cfif>

<!--- Category Permission 1 = category admin --->
<cfmodule template="../access/secure.cfm"
	keyname="category"
	requiredPermission="1"
	>	
	<cfoutput><span class="menu_admin">[<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=category.admin&category=edit&CID=#qry_get_Hcats.category_id##Request.AddToken#')#"  #doAdmin()#>EDIT CAT #qry_get_Hcats.category_id#</a>]</span></cfoutput>
</cfmodule>

<cfoutput></td></tr></table></td></cfoutput>

<cfset NumList = NumList - 1>

<cfif attributes.PColumns LTE 1 OR CurrentNum MOD attributes.PColumns IS 0>
	<cfoutput></tr></table></cfoutput>

	<cfif NumList IS NOT 0>
		<cfmodule template="../customtags/putline.cfm" linetype="Thin">
	</cfif>

<cfelseif CurrentNum IS TotalNum>
	<cfset loop_to = (attributes.PColumns - CurrentNum MOD attributes.PColumns)>
	<cfloop index = "num" from="1" to="#loop_to#">
		<cfoutput><td>&nbsp;</td></cfoutput>
	</cfloop>
	<cfoutput></tr></table> </cfoutput>
</cfif>

<cfset CurrentNum = CurrentNum + 1>
</cfloop>


<!--- ========================================  Ouput any Sale Products --->
<cfloop query="qry_get_products">

<cfif Request.AppSettings.UseSES>
	<cfset prodlink = "#Request.SESindex#product/#qry_get_products.product_ID#/#SESFile(qry_get_products.Name)##Request.Token1#">
<cfelse>
	<cfset prodlink = "#self#?fuseaction=product.display&product_ID=#qry_get_products.product_ID##Request.Token2#">
</cfif>

<cfif attributes.PColumns LTE 1 OR CurrentNum MOD attributes.PColumns IS 1>
	<cfoutput><table cellpadding="6" cellspacing="0" border="0" width="100%"><tr></cfoutput>
</cfif> 

<!--- Output category's name and description --->
<cfoutput>
	<td valign="top" width="#(100/attributes.PColumns)#%">
	
	
	<cfinclude template="../product/listings/put_short.cfm">
	
<!------------	
	<table cellpadding="0" cellspacing="0"><tr><td valign="top">
</cfoutput>

<cfif len(Sm_Image)>
	<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" imglink="#XHTMLFormat(prodlink)#" class="listingimg">
</cfif>

<cfoutput></td><td align="left" valign="top"></cfoutput>

<cfif len(Sm_Title)>
	<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Title#" filealt="#Name#" imglink="#XHTMLFormat(prodlink)#">
<cfelse>
	<cfoutput><a href="#XHTMLFormat(prodlink)#" class="prodname">#Name#</a><br/></cfoutput>
</cfif>

<!--- Check for short description --->
<cfif len(Short_Desc)>
	<br/><cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#">


</cfif>

<cfoutput></td></tr></table>
----------->

</td></cfoutput>

<cfset NumList = NumList - 1>

<cfif attributes.PColumns LTE 1 OR CurrentNum MOD attributes.PColumns IS 0>
<cfoutput></tr></table></cfoutput>

<cfif NumList IS NOT 0>
	<cfmodule template="../customtags/putline.cfm" linetype="Thin">
</cfif>

<cfelseif CurrentNum IS TotalNum>
	<cfset loop_to = (attributes.PColumns - CurrentNum MOD attributes.PColumns)>
	<cfloop index = "num" from="1" to="#loop_to#">
		<cfoutput><td>&nbsp;</td></cfoutput>
	</cfloop>

<cfoutput></tr></table> </cfoutput>

</cfif>

<cfset CurrentNum = CurrentNum + 1>
</cfloop>

</cfif>


