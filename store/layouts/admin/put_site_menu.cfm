<!--- CFWebstore®, version 6.31 --->

<!--- CFWebstore® is ©Copyright 1998-2008 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This outputs the accordion menu for the site design area. Called from put_admin_menu.cfm --->

<!--- variable to save the menu to output in the tab --->
<cfparam name="sitemenu" default="">

<cfmodule template="../../access/secure.cfm" keyname="users" requiredPermission="1">	
<cfif ispermitted><cfset siteadmin="yes"></cfif>

<cfmodule template="../../access/secure.cfm" keyname="category" requiredPermission="1">	
<cfif ispermitted><cfset catadmin="yes"></cfif>

<cfmodule template="../../access/secure.cfm" keyname="page" requiredPermission="1">	
<cfif ispermitted><cfset pageadmin="yes"></cfif>

<cfparam name="siteadmin" default="no">
<cfparam name="catadmin" default="no">
<cfparam name="pageadmin" default="no">

<cfsavecontent variable="sitemenu">
<cfif siteadmin or catadmin or pageadmin>
<br/>

<cfoutput>
<cfif siteadmin>
<!--- If page being called is a home admin page, set tabs open on Site menu --->
<cfif (FindNoCase("home.admin", attributes.xfa_admin_link))>
	<cfset tabstart = totaltabs>
</cfif>
<!--- Code to display number of current site errors --->
<cftry>
	<cfset innertext = Application.objMenus.getErrorDumps()>
	<div id="Errors_Div" spry:region="txtPending"><a href="#self#?fuseaction=home.admin&error=list&#Session.URLToken#" onmouseover="return escape(site6)" target="AdminContent"><strong>Site Errors</strong></a><br/> <span style="color: red"><span id="errorcount" spry:content="{Errors}">#innertext#</span> pending.</span></div>

<cfcatch>
<!--- CFDirectory not enabled, or other issue with site error code --->
	<a href="##" onmouseover="return escape('#cfcatch.message#')" target="AdminContent">Site Errors</a><br/>Not available.
</cfcatch>
</cftry>
<!--- End site error code --->
<br/>
</cfif>

	<!---- category permission 1 = category admin --->
	<cfif catadmin>		
	<!--- If page being called is a category admin page, set tabs open on Site menu --->
	<cfif (FindNoCase("category.admin", attributes.xfa_admin_link))>
		<cfset tabstart = totaltabs>
	</cfif>
<a href="#self#?fuseaction=category.admin&category=list&pid=0#Request.Token2#" onmouseover="return escape(site1)" target="AdminContent">Categories</a><br/>
	</cfif>

	<!---- page permission 1 = page admin --->
	<cfif pageadmin>	
	<!--- If page being called is a page admin page, set tabs open on Site menu --->
	<cfif (FindNoCase("page.admin", attributes.xfa_admin_link))>
		<cfset tabstart = totaltabs>
	</cfif>
<a href="#self#?fuseaction=page.admin&do=list#Request.Token2#" onmouseover="return escape(site2)" target="AdminContent">Pages & Menus</a><br/>
	</cfif>

	<!---- users permission 1 = site admin --->
	<cfif siteadmin>	
<a href="#self#?fuseaction=home.admin&colors=list#Request.Token2#" onmouseover="return escape(site3)" target="AdminContent">Color Palettes</a><br/>
<a href="#self#?fuseaction=home.admin&picklists=edit#Request.Token2#" onmouseover="return escape(site4)" target="AdminContent">Option Pick Lists</a><br/>
<a href="#self#?fuseaction=home.admin&catcore=list#Request.Token2#" onmouseover="return escape(site5)" target="AdminContent">Category &amp; Page Templates</a><br/>

<!--- <a href="#self#?fuseaction=home.admin&schema=view#Request.Token2#"onmouseover="return escape(site7)" target="AdminContent">Database Schema</a><br/>  --->
<a href="#self#?fuseaction=home.admin&settings=edit#Request.Token2#"onmouseover="return escape(site8)" target="AdminContent">Main Settings</a><br/><br/>

<strong><a href="#self#?fuseaction=home.admin&cache=reset#Request.Token2#" onmouseover="return escape(site9)">Reset Cache</a></strong>
	</cfif>

</cfoutput>

</cfif>

<cfset totaltabs = totaltabs + 1>
</cfsavecontent>