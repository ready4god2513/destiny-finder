
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the default file used for the 'highlights (new & on sale)' page template --->

<!--- Also used to output highlighted items on the home page template --->

<!--- 
Parameters that can be set for this page:
	new: display items marked as new
	onsale: display items marked as on sale
	notsold: display products marked as not for sale (information only items)
	listing=vertical|short : type of display to use for the products
	columns=x : Used to override the default columns setting
 --->

<!--- set any variables listed in the page's 'passparam' field --->	
<cfif fusebox.fuseaction is "page.display">	
	<cfset QuerytoUse = qry_get_page>
	<cfinclude template="../includes/parseparams.cfm">
</cfif>

<cfparam name="attributes.notsold" default="0">
<cfparam name="attributes.new" default="0">
<cfparam name="attributes.onsale" default="0">
<cfset attributes.highlight = attributes.new>
<cfset attributes.onsale = attributes.onsale>
<cfparam name="attributes.thickline" default="1">
<cfparam name="attributes.thinline" default="1">
<cfparam name="attributes.showicons" default="1">


<cfinclude template="qry_highlight.cfm">

<cfset HList = qry_get_Hcats.RecordCount>
	
<cfset attributes.category_id="">
<cfinclude template="../feature/qry_get_features.cfm">
<cfset HList = HList + qry_get_features.RecordCount>

<cfinclude template="../product/queries/qry_get_products.cfm">
<cfset HList = HList + qry_get_products.RecordCount>



<!--- Initialize output values --->
<cfset PColumns = Request.AppSettings.PColumns>
<cfset CurrentNum = 1>
<cfset TotalNum = HList>

<cfif isDefined("attributes.columns") AND isNumeric(attributes.columns) AND attributes.columns GT 0>
	<cfset PColumns = attributes.columns>
</cfif>

<cfif HList GT 0>

<!----------------- Output Categories ----------------->
<cfloop query="qry_get_Hcats">

<cfif Request.AppSettings.UseSES>
	<cfset catlink = "#Request.SESindex#category/#qry_get_Hcats.Category_ID#/#SESFile(qry_get_Hcats.Name)##Request.Token1#">
<cfelse>
	<cfset catlink = "#self#?fuseaction=category.display&category_ID=#qry_get_Hcats.Category_ID##Request.Token2#">
</cfif>

<cfif PColumns LTE 1 OR CurrentNum MOD PColumns IS 1>
	<cfoutput><table cellspacing="2" cellpadding="2" border="0" width="95%"><tr></cfoutput>
</cfif> 

<cfoutput>
	<td valign="top" width="#(100/PColumns)#%">
	<table class="cat_text_small"><tr><td valign="top">
</cfoutput>

<cfif len(Sm_Title)>

	<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Title#" filealt="#Name#" imglink="#XHTMLFormat(catlink)#">
	<cfoutput>
	<cfif Sale and attributes.showicons>#Request.SaleImage#</cfif> 
	<cfif Highlight and attributes.showicons>#Request.NewImage#</cfif>
	</cfoutput>
<cfelse>

<cfoutput>
	<a class="cat_title_small" href="#catlink#" #doMouseover(Name)#>#Name#</a>
	<cfif Sale and attributes.showicons>#Request.SaleImage#</cfif> 
	<cfif Highlight and attributes.showicons>#Request.NewImage#</cfif>
</cfoutput>
</cfif>

<cfoutput><br/></cfoutput>

<cfif len(Short_Desc)>
	<cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" class="cat_text_small">
</cfif>

<!--- Category Permission 1 = category admin --->
<cfmodule template="../access/secure.cfm"
	keyname="category"
	requiredPermission="1"
	>	
	<cfoutput><span class="menu_admin">[<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=Category.admin&Category=edit&CID=#category_id##Request.AddToken#')#" #doAdmin()#>EDIT CAT #category_id#</a>]</span></cfoutput></cfmodule>


<cfoutput></td></tr></table></td></cfoutput>

<cfset HList = HList - 1>

<cfif PColumns LTE 1 OR CurrentNum MOD PColumns IS 0>
	<cfoutput></tr></table></cfoutput>

	<cfif HList IS NOT 0>
		<cfmodule template="../customtags/putline.cfm" linetype="Thin">
	</cfif>

<cfelseif CurrentNum IS TotalNum>
	<cfloop index = "num" from="1" to="#Evaluate(PColumns - CurrentNum MOD PColumns)#">
		<cfoutput><td>&nbsp;</td></cfoutput>
	</cfloop>
	<cfoutput></tr></table> </cfoutput>
</cfif>

<cfset CurrentNum = CurrentNum + 1>
</cfloop>

<!----------------- Output Products ----------------->
<cfset optcount = 0>
<cfset addoncount = 0>

<cfloop query="qry_get_products">

<cfif PColumns LTE 1 OR CurrentNum MOD PColumns IS 1>
	<cfoutput><table cellspacing="2" cellpadding="2" border="0" width="95%"><tr></cfoutput>
</cfif> 

<!--- Output product's name and description --->
<cfoutput>
	<td valign="top" width="#Evaluate(100/PColumns)#%">
	
	<table><tr><td valign="top">
</cfoutput>

	<cfif isdefined("attributes.listing")>
		<cfinclude template="../product/listings/put_#attributes.listing#.cfm">
	<cfelse>
		<cfinclude template="../product/listings/put_standard.cfm">
	</cfif>

<cfoutput></td></tr></table>

			
			</td></cfoutput>

<cfset HList = HList - 1>

<cfif PColumns LTE 1 OR CurrentNum MOD PColumns IS 0>
<cfoutput></tr></table></cfoutput>

<cfif HList IS NOT 0>
	<cfmodule template="../customtags/putline.cfm" linetype="Thin">
</cfif>

<cfelseif CurrentNum IS TotalNum>
	<cfloop index = "num" from="1" to="#Evaluate(PColumns - CurrentNum MOD PColumns)#">
		<cfoutput><td>&nbsp;</td></cfoutput>
	</cfloop>

<cfoutput></tr></table> </cfoutput>

</cfif>

<cfset CurrentNum = CurrentNum + 1>
</cfloop>

 
<!----------------- Output Features ----------------->

<cfloop query="qry_get_features">

<cfif PColumns LTE 1 OR CurrentNum MOD PColumns IS 1>
	<cfoutput><table cellspacing="2" cellpadding="2" border="0" width="95%"><tr></cfoutput>
</cfif> 

<!--- Output feature's name and description --->
<cfoutput>
	<td valign="top" width="#Evaluate(100/PColumns)#%">
	
	<table><tr><td valign="top">
</cfoutput>

	<cfinclude template="../feature/put_feature_listing.cfm">

<cfoutput></td></tr></table>

			
			</td></cfoutput>

<cfset HList = HList - 1>

<cfif PColumns LTE 1 OR CurrentNum MOD PColumns IS 0>
<cfoutput></tr></table></cfoutput>

<cfif HList IS NOT 0>
	<cfmodule template="../customtags/putline.cfm" linetype="Thin">
</cfif>

<cfelseif CurrentNum IS TotalNum>
	<cfloop index = "num" from="1" to="#Evaluate(PColumns - CurrentNum MOD PColumns)#">
		<cfoutput><td>&nbsp;</td></cfoutput>
	</cfloop>

<cfoutput></tr></table> </cfoutput>

</cfif>

<cfset CurrentNum = CurrentNum + 1>
</cfloop>


 </cfif>
 


