<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to output the listing of accounts. Called by users.directory --->

<cfparam name="attributes.currentpage" default=1>

<!--- Define URL for pagethrough --->
<cfset addedpath="&fuseaction=#attributes.fuseaction#">

<!--- Create the string with the filter parameters --->	
<cfloop index="namedex" list="account_name,rep,directory_live,city,state,country,description,sort,order">
	<cfif isdefined("attributes.#namedex#") and Evaluate("attributes." & namedex) is not "">
		<cfset addedpath="#addedpath#&#namedex#=" & Evaluate('attributes.' & namedex)>
	</cfif>
</cfloop>

<cfparam name="attributes.displaycount" default= "#Request.AppSettings.maxfeatures#">


<cfif qry_get_accounts.recordcount gt 0>

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

	<cfinclude template="put_searchheader.cfm">
	<cfinclude template="dsp_accounts.cfm">
	<cfinclude template="put_searchfooter.cfm">
	
<cfelse>

	<!---------------------->
	<cfif submit >
		<cfoutput>
		<p class="ResultHead">No listings found for #searchheader#. Please try another search...
		<cfmodule template="../../customtags/putline.cfm" linetype="Thick">
		</cfoutput>
	<cfelse>
	
		<cfoutput>
		<p class="resulthead">
		Please enter your search below...
		<cfmodule template="../../customtags/putline.cfm" linetype="thick">
		</cfoutput>
	<!---------------------->
	</cfif>

</cfif>
<p>
