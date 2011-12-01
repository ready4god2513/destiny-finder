
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to list the results of a feature search. Called by feature.list and feature.search --->

<!--- This template is called by the index page and outputs feature listings. --->
<cfparam name="attributes.searchform" default="1">
<cfparam name="attributes.searchfooter" default="1">
<cfparam name="attributes.thickline" default="1">
<cfparam name="attributes.thinline" default="1">
<!--- switch to show the feature_type above name --->
<cfparam name="attributes.showType" default="0">

<!--- Define URL for pagethrough --->
<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#">
<cfif isdefined("attributes.category_id")>
	<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#&category_id=#attributes.category_id#">
</cfif>

<!--- Create the string with the search parameters --->	
<cfloop list="search_string,title,all_words,displaycount" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>
	
<cfset numlist = numlist + qry_get_features.recordcount>

<cfparam name="attributes.displaycount" default="#Request.AppSettings.maxfeatures#">

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
	

<cfif qry_get_Features.recordcount gt 0>

	<cfif attributes.searchfooter>
		<cfinclude template="put_searchheader.cfm">
		<cfinclude template="dsp_features.cfm">
		<cfinclude template="put_searchfooter.cfm">
	<cfelse>
		<cfinclude template="dsp_features.cfm">
	</cfif>
<cfelse>

	<cfif isdefined("request.qry_get_subcats.recordcount") and request.qry_get_subcats.recordcount IS NOT 0>
		<cfif attributes.searchfooter is "1">
			<cfoutput>
			<p class="ResultHead">Select a category to browse.
			</cfoutput>
		</cfif>
	<cfelseif trim(searchheader) is not "<b>all articles</b>">
		<cfoutput>
		<p class="ResultHead">No listings found for #searchheader#. 
		<cfif attributes.searchform><br/><br/>Please try another search...</cfif></p> 
		</cfoutput>
	<cfelse>
		<cfif attributes.searchform><cfoutput>
		<p class="ResultHead">Please enter your search below...</p>
		</cfoutput></cfif>
	</cfif>

</cfif>

<cfif attributes.searchform is "1">
	<cfinclude template="put_search_form.cfm">
</cfif>	


