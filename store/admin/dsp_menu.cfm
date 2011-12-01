<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the page used to display the main admin menu. It calls the various submenus according to the permissons of the user, and displays the main site admin functions as well.  Called by fuseaction=home.admin --->

<table border="0" cellspacing="0" cellpadding="10" width="625" align="left">
<tr>
	<td valign="top" class="mainpage">
<!--- <cfoutput>
<p class="cat_title_large"><font color="###Request.GetColors.maintitle#">Admin Menu</font></p>
</cfoutput> --->

<!--- Shopping and Products menus --->
<cfif listfindNoCase(StructKeyList(fusebox.circuits),"PRODUCT")>
	<cfinclude template="../shopping/admin/dsp_menu.cfm">
	<cfinclude template="../product/admin/dsp_menu.cfm">
</CFIF>

<!--- Feature menu --->
<cfif listfindNoCase(StructKeyList(fusebox.circuits),"FEATURE")>
	<cfinclude template="../feature/admin/dsp_menu.cfm">
</cfif>

<!--- Content Access menu --->
<cfinclude template="../access/admin/dsp_menu.cfm">

<!--- Users menu --->
<cfinclude template="../users/admin/dsp_menu.cfm">


<cfmodule template="../access/secure.cfm" keyname="users" requiredPermission="1">	
<cfif ispermitted><cfset siteadmin="yes"></cfif>

<cfmodule template="../access/secure.cfm" keyname="category" requiredPermission="1">	
<cfif ispermitted><cfset catadmin="yes"></cfif>

<cfmodule template="../access/secure.cfm" keyname="page" requiredPermission="1">	
<cfif ispermitted><cfset pageadmin="yes"></cfif>

<cfparam name="siteadmin" default="no">
<cfparam name="catadmin" default="no">
<cfparam name="pageadmin" default="no">

<cfif siteadmin or catadmin or pageadmin>
<b>Site Design</b>
<cfoutput>
<ul>

	<!---- category permission 1 = category admin --->
	<cfif catadmin>		
<li><a href="#self#?fuseaction=category.admin&category=list&pid=0#Request.Token2#">Categories</a>: Create categories and sub-categories to organize your site content.</li>
	</cfif>

	<!---- page permission 1 = page admin --->
	<cfif pageadmin>	
<li><a href="#self#?fuseaction=page.admin&do=list#Request.Token2#">Pages & Menus</a>: Edit text on the site's standard pages like the Home page, Shopping Cart, Search page, etc. and create custom menu options.</li>
	</cfif>

	<!---- users permission 1 = site admin --->
	<cfif siteadmin>	
<li><a href="#self#?fuseaction=home.admin&colors=list#Request.Token2#">Color Palettes</a>: Define different color schemes and layouts that can be applied to the site.</li>
<li><a href="#self#?fuseaction=home.admin&picklists=edit#Request.Token2#">Option Pick Lists</a>: Lists that appear as pull-down menu options on the site.</li>
<li><a href="#self#?fuseaction=home.admin&catcore=list#Request.Token2#">Category &amp; Page Templates</a>: Manage category and page templates.</li>
<!--- Code to display number of current site errors --->
<cftry>
<cfinclude template="../errors/dumps/act_num_errors.cfm">
<cfif variables.FileCount>
	<li><a href="#self#?fuseaction=home.admin&error=list#Request.Token2#"><strong>Site Errors</strong></a>: <span class="formerror"><strong>#variables.FileCount# error report(s) pending.</strong></span> </li>
<cfelse>
	<li><a href="#self#?fuseaction=home.admin&error=list#Request.Token2#">Site Errors</a>: List of current site errors with options to save a copy or remove.</li>
</cfif>
<cfcatch>
<!--- CFDirectory not enabled, or other issue with site error code --->
	<li><strong>Site Errors</strong>: Not available. (#cfcatch.message#)</li>
</cfcatch>
</cftry>
<!--- End site error code --->
<li><a href="#self#?fuseaction=home.admin&schema=view#Request.Token2#">Database Schema</a>: Full list of database tables and columns, for SQL server only.</li>
<li><a href="#self#?fuseaction=home.admin&settings=edit#Request.Token2#">Main Settings</a>: Web site and display settings.</li>
	</cfif>

</ul>
</cfoutput>

</cfif>

	</td>
</tr>
</table>