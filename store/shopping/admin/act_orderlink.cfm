
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to display the correct link for order admins, according to permissions. Called from shopping/admin/dsp_menu.cfm and from lay_default.cfm --->

<!--- Check for order viewing permission level--->
<cfset order_pending = 0>
<cfset order_process = 0>
<cfset order_po = 0>

<cfmodule template="../../access/secure.cfm" keyname="shopping" requiredPermission="8">

<cfif ispermitted>
	<cfset order_pending = 1>
	<cfset linkURL = "#Request.SecureURL##self#?fuseaction=shopping.admin&order=pending#Request.AddToken#">
	
<cfelse>
	<cfmodule template="../../access/secure.cfm" keyname="shopping" requiredPermission="16">
	
	<cfif ispermitted>
		<cfset order_pending = 1>
		<cfset linkURL = "#Request.SecureURL##self#?fuseaction=shopping.admin&order=process#Request.AddToken#">
	
	<cfelse>
		<cfmodule template="../../access/secure.cfm" keyname="shopping" requiredPermission="32">
		
		<cfif ispermitted>
			<cfset order_po = 1>
			<cfset linkURL = "#Request.SecureURL##self#?fuseaction=shopping.admin&po=list#Request.AddToken#">
		</cfif>
		
	</cfif>

</cfif>

