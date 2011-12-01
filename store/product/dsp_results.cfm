
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to list the results of a product search. Called by product.list|search --->

<!--- searchheader = 1; searchform = 1 ---->
<cfparam name="attributes.searchheader" default="1">
<cfparam name="attributes.searchform" default="1">
<cfparam name="attributes.searchfooter" default="1">
<cfparam name="attributes.thickline" default="1">
<cfparam name="attributes.thinline" default="1">
<cfparam name="attributes.listing" default="">	
<cfparam name="attributes.productCols" default="#request.appsettings.PColumns#">

<!--- Define URL for pagethrough --->
<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#">
<cfif isdefined("attributes.category_id")>
	<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#&amp;category_id=#attributes.category_id#">
</cfif>
<!--- Create the string with the search parameters --->	
<cfloop list="search_string,name,mfg_account_id,displaycount,alphaSearch,sort,order" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&amp;#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>

<cfparam name="attributes.displaycount" default="#Request.AppSettings.maxprods#">

<!--- Create the page through links, max records set by the display count --->	
<cfmodule template="../customtags/pagethru.cfm" 
	totalrecords="#qry_get_products.recordcount#" 
	currentpage="#attributes.currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="#attributes.displaycount#" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >
	

<cfif qry_get_products.recordcount gt 0>

	<cfif attributes.searchheader is "form">
		<cfinclude template="put_search_header_form.cfm">
	<cfelseif attributes.searchheader IS NOT 0>
		<cfinclude template="put_search_header.cfm">
	</cfif>
			
	<cfinclude template="dsp_products.cfm">
	<cfif attributes.searchfooter IS NOT 0>
	<cfinclude template="put_search_footer.cfm">
	</cfif>

<cfelse>

	<cfif isDefined("qry_Get_subCats.recordcount") and qry_get_subCats.recordcount>
		<cfoutput>
		<p>
		Select a category to browse.
		<p>
		<cfmodule template="../customtags/putline.cfm" linetype="Thin"><p>
		</cfoutput>
		
	<cfelseif trim(searchheader) is not "<b>All Products</b>" AND attributes.searchform is "1">
		<cfoutput>
		<p class="ResultHead">No listings found for #searchheader#.<br/><br/>Please try another search...</p>
		</cfoutput>
		
	<cfelseif attributes.searchform is "1">
		<cfoutput>
		<p class="ResultHead">Please enter your search below...</p>
		</cfoutput>
	</cfif>	

</cfif>

<cfif attributes.searchform is "1">
	<cfinclude template="put_search_form.cfm">
</cfif>

 

