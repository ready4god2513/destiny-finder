
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the current permission from the user permissions list to set current selected permissions. Called from dsp_priv_form.cfm --->

<!--- Retrieve Key from type_ID.Permission as listindex --->	
<cfset listindex = listContainsNoCase(qry_get_permissions.permissions, attributes.circuit, ";")>

<!--- Get Key value --->
<cfif listindex>
	<cfset keypair = ListGetAt(qry_get_permissions.permissions, listindex, ';')>
	<cfif listlen(keypair,'^') gte 2>
		<cfset keyvalue = ListGetAt(keypair, 2, '^')>
	<cfelse>
		<cfset keyvalue = "0">
	</cfif>
<cfelse>
	<cfset keyvalue = "0">
</cfif>
	
	