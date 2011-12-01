
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the default file used for the 'features' page template, It outputs the features in a category and any subcategories as well --->
<cfparam name="attributes.thickline" default="1">
<cfparam name="attributes.thinline" default="1">
<cfparam name="attributes.searchform" default="0">
<!--- switch to show the feature_type above name --->
<cfparam name="attributes.showType" default="0">
<cfparam name="attributes.sectionTitle" default="Articles">

<cfset attributes.cat_id = attributes.category_id>
<cfinclude template="qry_get_features.cfm">	

<cfset NumList = NumList + qry_Get_features.RecordCount>

<!--- Define URL for pagethrough --->
<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#&amp;category_id=#attributes.category_id#">
<cfif isdefined("attributes.sort")>
	<cfset addedpath="#addedpath#&amp;sort=#attributes.sort#">
</cfif>

<cfparam name="attributes.displaycount" default= "#Request.AppSettings.maxfeatures#">
<cfif not request.qry_get_cat.prodfirst and attributes.currentpage lt 2>
	<cfset attributes.displaycount = request.qry_get_SubCats.Recordcount + attributes.displaycount>
</cfif>

<!--- Create the page through links, max records set by the display count --->
<cfmodule template="../customtags/pagethru.cfm" 
	totalrecords="#numlist#" 
	currentpage="#attributes.currentpage#"
	templateurl="#self#"
	addedpath="#addedpath#"
	displaycount="#attributes.displaycount#" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >
	
	<cfif request.qry_get_cat.ProdFirst>	
		<!----<cfinclude template="put_searchheader.cfm">--->
		<cfinclude template="dsp_features.cfm">
		<cfinclude template="../category/dsp_subcats.cfm">

	<cfelse>
		<cfset NumList = request.qry_get_subcats.RecordCount>
		<cfinclude template="../category/dsp_subcats.cfm">
		
		<cfset NumList = qry_Get_features.RecordCount>	
		<cfif Numlist>
			<cfif request.qry_get_subcats.RecordCount AND qry_get_features.RecordCount
			AND len(attributes.sectionTitle)>
			<cfoutput><br/>
				<div class="header">&nbsp;#attributes.sectionTitle#</div></cfoutput>
			</cfif>
		
			<!---<cfinclude template="put_searchheader.cfm">--->
			<cfinclude template="dsp_features.cfm">
			<cfif numlist>
				<cfinclude template="put_searchfooter.cfm">
			</cfif>
		</cfif>
	</cfif>


<cfif attributes.searchform>
	<br/><br/>
	<cfinclude template="put_search_form.cfm">
</cfif>


