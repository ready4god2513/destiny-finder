
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the default file used for the 'features + product' template page --->

<!--- This template puts features first, then products. --->

<!----- This template can accept a passparam attribute of listing = standard | short --->
<cfparam name="attributes.showType" default="0">
<cfparam name="attributes.listing" default="standard">
<cfparam name="attributes.thickline" default="1">
<cfparam name="attributes.thinline" default="1">

<cfinclude template="../feature/qry_get_features.cfm">	
<cfinclude template="../product/queries/qry_get_products.cfm">	

<cfset numlist = qry_get_features.recordcount + qry_get_products.recordcount + request.qry_get_subcats.recordcount>

<!----- Set this product page for Keep Shopping button ------->
<cfset Session.Page="#Request.currentURL#">

<!--- Define URL for pagethrough --->
<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#&amp;category_id=#attributes.category_id#">
<cfif isdefined("attributes.sort")>
	<cfset addedpath="#addedpath#&amp;sort=#attributes.sort#">
</cfif>

<!-------
<cfif not request.qry_get_cat.prodfirst and attributes.currentpage is "1">
	<cfset DISPLAYCOUNT = request.qry_get_SubCats.Recordcount + Request.AppSettings.maxprods>
<cfelse>
	<cfset DISPLAYCOUNT = Request.AppSettings.maxprods>
</cfif>
----->


<cfparam name="attributes.displaycount" default= "#Request.AppSettings.maxprods#">

<!--- Create the page through links, max records set by the display count --->
<cfmodule template="../customtags/pagethru.cfm" 
	totalrecords="#numlist#" 
	currentpage="#attributes.currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="#attributes.displaycount#" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >




	
<!--- output listings --->
<cfif NumList IS 0>
	<cfoutput>
	<div>Currently, there are no listing for in this category. Check back soon for new additions!</div>
	</cfoutput>

<cfelse>
	<cfif request.qry_get_cat.ProdFirst>
	
		<cfinclude template="../feature/dsp_features.cfm">
		<cfinclude template="../product/dsp_products.cfm">
		<cfinclude template="../category/dsp_subcats.cfm">

	<cfelse>
		<cfif attributes.currentpage is 1>
			<cfinclude template="../category/dsp_subcats.cfm">
		</cfif>
		<cfinclude template="../feature/dsp_features.cfm">
		<cfinclude template="../product/dsp_products.cfm">
			
	</cfif>
</cfif>

<cfoutput><div align="center">#pt_pagethru#</div><br/></cfoutput>


