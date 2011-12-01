<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for the access circuit. Called from the home.admin fuseaction --->

<cfmodule template="../secure.cfm"
keyname="access"
requiredPermission="2"
>  
<cfoutput> 

	<cfmodule template="../secure.cfm"
	keyname="access"
	requiredPermission="4"
	>  
		<cfset attributes.valid = 0>
		<cfset attributes.show = "all">
		<cfinclude template="membership/qry_get_memberships.cfm">
		<br/>
		<cfif qry_get_memberships.recordcount>
			<a href="#self#?fuseaction=access.admin&membership=list&show=all&valid=0#Request.Token2#" onmouseover="return escape(access3)" target="AdminContent">Validate Memberships</a>:<br/> <span style="color: red">#qry_get_memberships.recordcount# Memberships requires validation.</span><br/><br/>
		</cfif> 
		
		<a href="#self#?fuseaction=access.admin&membership=list#Request.Token2#" onmouseover="return escape(access1)" target="AdminContent">Memberships</a><br/>
	</cfmodule>
	
	
	<a href="#self#?fuseaction=access.admin&accesskey=list#Request.Token2#" onmouseover="return escape(access2)" target="AdminContent">Access Keys</a><br/>
	
	</cfoutput> 

</cfmodule>

