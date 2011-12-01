<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This outputs the accordion menu for the import/export menu. Called from put_admin_menu.cfm --->

<!--- variable to save the menu to output in the tab --->
<cfparam name="importexport" default="">
<cfparam name="totaltabs" default="0">
<cfset import_export = 0> 

<cfsavecontent variable="importexport">

<cfoutput>

<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="16"
	> 
	<cfset import_export = import_export + 1>
	<br/><a href="#self#?fuseaction=product.admin&do=import#Request.Token2#" onmouseover="return escape(product4)" target="AdminContent">Product Import</a>
</cfmodule>

<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="32"
	> 
	<cfset import_export = 1>
	<br/><a href="#self#?fuseaction=product.admin&do=export#Request.Token2#" onmouseover="return escape(product5)" target="AdminContent">Product Export</a>
</cfmodule>

<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="128"
	> 
	<cfset import_export = 1>
	<br/><a href="#self#?fuseaction=product.admin&do=froogle&ISBNCustom=2#Request.Token2#" onmouseover="return escape(product7)" target="AdminContent">Google Base Data Feed</a><br/>
	<a href="#self#?fuseaction=product.admin&do=googleSiteMap#Request.Token2#" onmouseover="return escape(product8)" target="AdminContent">Google Sitemap</a><br/>
	<a href="#self#?fuseaction=product.admin&do=bizrate#Request.Token2#" onmouseover="return escape(product9)" target="AdminContent">Bizrate Data Feed</a>
</cfmodule>

<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="128"
	>
	<cfset import_export = 1>
<br/><a href="#self#?fuseaction=shopping.admin&order=download#Request.Token2#" onmouseover="return escape(shopping4)" target="AdminContent">Download Orders</a>
</cfmodule>

	<!--- users permission 8 = user admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="8"
	>	
	<cfset import_export = 1>
	<br/><a href="#self#?fuseaction=users.admin&download=user_cust#Request.Token2#" onmouseover="return escape(user8)" target="AdminContent">Users Export</a>
	</cfmodule>

</cfoutput>

</cfsavecontent>

<cfif import_export>
	<cfset totaltabs = totaltabs + 1>
</cfif>

