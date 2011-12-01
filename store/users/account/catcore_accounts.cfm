<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the default file used for the 'account directory' page template --->

<!--- 
account_name,rep,directory_live,city,state,country,description
sort,order
displaycount
accountCols
--->
<cfparam name="attributes.thickline" default="1">
<cfparam name="attributes.thinline" default="1">


<cfinclude template="qry_get_accounts.cfm">

<!--- Define URL for pagethrough --->
<cfif isDefined("attributes.category_id")>
	<cfset addedpath="&fuseaction=#attributes.fuseaction#&category_id=#attributes.category_id#">
<cfelse>
	<cfset addedpath="&fuseaction=#attributes.fuseaction#&page_id=#attributes.page_id#">
</cfif>

<cfloop index="namedex" list="account_name,rep,directory_live,city,state,country,description,sort,order">
	<cfif isdefined("attributes.#namedex#") and Evaluate("attributes." & namedex) is not "">
		<cfset addedpath="#addedpath#&#namedex#=" & Evaluate('attributes.' & namedex)>
	</cfif>
</cfloop>

<cfparam name="attributes.displaycount" default= "#Request.AppSettings.maxfeatures#">

<!--- Create the page through links, max records set by the display count --->
<cfmodule template="../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_accounts.recordcount#" 
	currentpage="#attributes.currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="#attributes.displaycount#" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >
	
	
<cfif isDefined("attributes.category_id")>		
<cfif request.qry_get_cat.ProdFirst>
	<!------->
	<cfinclude template="put_searchheader.cfm"> 
	<cfinclude template="dsp_accounts.cfm">
	<cfinclude template="put_searchfooter.cfm">
	
	<cfinclude template="../../category/dsp_subcats_directory.cfm">

<cfelse>
	
	<cfif request.qry_get_subcats.recordcount>
		<cfinclude template="../../category/dsp_subcats_directory.cfm">
		<br/>
	</cfif>

	<!------->
	<cfinclude template="put_searchheader.cfm"> 
	<cfinclude template="dsp_accounts.cfm">
	<cfinclude template="put_searchfooter.cfm">
</cfif>

<cfelse>
	<cfinclude template="put_searchheader.cfm"> 
	<cfinclude template="dsp_accounts.cfm">
	<cfinclude template="put_searchfooter.cfm">
</cfif>
	

	
	

