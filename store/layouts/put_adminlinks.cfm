
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to create the admin links for the site. Call from your layout pages --->

<cfsavecontent variable="adminmenu">	
	<div class="menu_page">	
	<!--- Users Permission 2 = show admin menu --->	
	<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="2">
	<cfoutput><a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=home.admin#Request.AddToken#')#">Admin</a></cfoutput>
	<br/>
	</cfmodule>	
	
	<!--- Shopping Permission 8, 16 or 32 --->	
	<!--- Use shopping admin page to determine the link for order editing --->
	<cfmodule template="../access/secure.cfm" keyname="shopping" requiredPermission="56">
		<cfinclude template="admin/act_orderlink.cfm">
		<cfif len(linkURL)>
		<cfoutput><a href="#XHTMLFormat(linkURL)#">Order Fullfillment</a></cfoutput>
		</cfif>
	<br/><br/>	
	</cfmodule>	
	</div>

</cfsavecontent>	
			

<cfoutput>#HTMLCompressFormat(variables.adminmenu)#</cfoutput>
		
			