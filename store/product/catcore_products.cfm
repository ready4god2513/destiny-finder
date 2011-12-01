
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the default file used for the 'products' page template, it outputs the products in a category and any subcategories as well. --->

<!--- 
Parameters accepted: 
listing=vertical|short|horizontal|standard : style of product listing
	standard -- full product listing with order button
	short -- same as standard without order button
	horizontal -- photo, title & description, price listed in a row; no order button
	vertical -- photo, title & description, price listed in a column; no order button

alpha=1 : turns on alpha search header 
search_header=1 : Outputs the search header on the page, useful if using the search form
	0 = turns search header off meaning text search criteria.
	1 = standard search header on. OFF by default in categories/ON in search results.
	form = search form header is used.	
searchform=1 : adds search form to the bottom of the page. Off by default on category pages.

thickline=1 : Setting to 0 will turn off the thick line at the top and bottom of 
		product listings. This does NOT affect the thick line that separates the 
		category or page header from the listings. That is controlled by entering 
		"noline=1" in the page or category parameter field.
thinline=1 : Setting to 0 will turn off the thin line separating rows.

displaycount=x : Used to override the default number of products per page from main settings
productcols=x : Used to override the default columns setting

--->

<cfparam name="attributes.alpha" default="0">
<cfparam name="attributes.searchheader" default="0">
<cfparam name="attributes.searchform" default="0">
<cfparam name="attributes.listing" default="">
<cfparam name="attributes.thickline" default="1">
<cfparam name="attributes.thinline" default="1">

<cfinclude template="queries/qry_get_products.cfm">	

<cfparam name="attributes.search_form_header" default="0">		
<!----- This template can accept a passparam attribute of = standard | short  ----------------------->

<!----- Set this product page for Keep Shopping button ------->
<cfset Session.Page="#Request.currentURL#">

<!--- Define URL for pagethrough --->
<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#&amp;category_id=#attributes.category_id#">
<cfloop list="sortby,order,availability,name,search_string,alphaSearch" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&amp;#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>

<!--- Old code used when displaying subcats and products together
<cfif not request.qry_get_cat.prodfirst and attributes.currentpage is "1">
	<cfset DISPLAYCOUNT = request.qry_get_SubCats.Recordcount + Request.AppSettings.maxprods>
<cfelse>
	<cfset DISPLAYCOUNT = Request.AppSettings.maxprods>
</cfif>
----->
<cfparam name="attributes.displaycount" default= "#Request.AppSettings.maxprods#">

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


	
<!--- output listings --->
<cfif NumList IS 0>

	<cfif attributes.alpha>
		<cfinclude template="put_search_header_alpha.cfm">
	<cfelseif attributes.searchheader is "form">
		<cfinclude template="put_search_header_form.cfm">
	<cfelse>
		<cfinclude template="put_search_header.cfm">
	</cfif>
		
	<cfoutput>
	<div><br/>Currently, there are no listings in this category. Check back soon for new additions!</div>
	</cfoutput>

<cfelse>
	<cfif request.qry_get_cat.ProdFirst>
		
		<cfif attributes.alpha>
			<cfinclude template="put_search_header_alpha.cfm">
		<cfelseif attributes.searchheader is "form">
			<cfinclude template="put_search_header_form.cfm">
		<cfelse>
			<cfinclude template="put_search_header.cfm">
		</cfif>
		
		<cfinclude template="dsp_products.cfm">
		
		<cfinclude template="put_search_footer.cfm">
		
		<cfinclude template="../category/dsp_subcats.cfm">

	<cfelse>
		<cfif attributes.currentpage is 1>
			<cfinclude template="../category/dsp_subcats.cfm">
		</cfif>
		
		<cfif attributes.alpha>
			<cfinclude template="put_search_header_alpha.cfm">
		<cfelseif attributes.searchheader is "form">
			<cfinclude template="put_search_header_form.cfm">
		<cfelse>
			<cfinclude template="put_search_header.cfm">
		</cfif>
		
		<cfinclude template="dsp_products.cfm">
			
		<cfinclude template="put_search_footer.cfm">
					
	</cfif>
</cfif>


<cfif attributes.searchform is "1">
<cfinclude template="put_search_form.cfm">
</cfif>
