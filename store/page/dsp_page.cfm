
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to display a store page. Outputs the title and text for the page and includes any page template that was selected. Called by page.display --->

<!--- Set Metatags for this page ----------->
<cfif len(qry_get_page.metadescription)>
	<cfset metadescription = qry_get_page.metadescription>
</cfif>

<cfif len(qry_get_page.keywords)>
	<cfset keywords = qry_get_page.keywords>
</cfif>

<cfif len(qry_get_page.titletag)>
	<cfset Webpage_title = qry_get_page.titletag>
<cfelse>
	<cfset Webpage_title = qry_get_page.Page_Title>
</cfif>

<cfparam name="attributes.currentpage" default=1>

<!--- Display large image --->
<cfif len(qry_get_page.Lg_Image)>
 <cfmodule template="../customtags/putimage.cfm" filename="#qry_get_page.Lg_Image#" align="left" hspace="8">
</cfif>

<cfif not isdefined("attributes.notitle")>
	<!--- Output title --->
	<cfif len(qry_get_page.Lg_Title)>
		<cfmodule template="../customtags/putimage.cfm" filename="#qry_get_page.Lg_Title#" filealt="#qry_get_page.Page_Name#">
	<cfelse>
		<cfmodule template="../customtags/puttitle.cfm" TitleText="#qry_get_page.Page_Title#" class="page">
	</cfif>
</cfif>

<!--- Check for page text --->
<!--- Only show if this is not an action page --->
<cfif len(qry_get_page.PageText) AND NOT isDefined("attributes.ActionPage")>
<cfmodule template="../customtags/puttext.cfm" Text="#qry_get_page.PageText#" Token="#Request.Token1#" class="cat_text_large" ptag="yes">
</cfif>

<!--- Page Permission 1 = edit page ---->
<cfmodule  template="../access/secure.cfm"
	keyname="page"
	requiredPermission="1"
	>	
	<cfoutput><span class="menu_admin">[ <a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=page.admin&do=edit&page_ID=#qry_get_page.page_id##Request.AddToken#')#" #doAdmin()#>EDIT PAGE</a> ]</span></cfoutput>
</cfmodule>

<!--- Check for file include--->
<cfif len(qry_get_page.template)>
	
	<cfif not isdefined("attributes.noline")>
		<cfmodule template="../customtags/putline.cfm" linetype="Thick">
	</cfif>
		
	<cfinclude template="../#qry_get_page.template#">
</cfif>
 
