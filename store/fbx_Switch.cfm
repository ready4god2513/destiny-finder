
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!---
<fusedoc fuse="FBX_Switch.cfm">
	<responsibilities>
		I am the cfswitch statement that handles the fuseaction, delegating work to various fuses.
	</responsibilities>
	<io>
		<string name="fusebox.fuseaction" />
		<string name="fusebox.circuit" />
	</io>	
</fusedoc>
--->


<cfswitch expression = "#fusebox.fuseaction#">


<cfcase value="admin">
	<!--- USERS Permission 2 = access admin menu --->
	<cfmodule template="access/secure.cfm"
	keyname="users"
	requiredPermission="2"
	>	
	<!--- Check for session spoof --->
	<cfinclude template="includes/admin_access_check.cfm">
	<cfif ispermitted>
		<cfinclude template="admin/fbx_Switch.cfm">
	<cfelse>
		<p>User does not have admin menu permissions</p>
	</cfif>
	
</cfcase>

<cfcase value="email">
	<cfinclude template="email/act_mailform.cfm">
</cfcase>

<!--- Allow direct indexing of verity collection, used for scheduling to run automatically --->
<cfcase value="verity">
	<cfinclude template="admin/settings/act_verity.cfm">
</cfcase>

<cfcase value="senderror">
	<cfinclude template="admin/errors/act_submiterror.cfm">
</cfcase>

<cfcase value="test">
	<cfinclude template="test.cfm">
</cfcase>

<cfcase value="nojs">
	Sorry, you cannot access the admin without javascript enabled.
</cfcase>


<cfdefaultcase>
	<cfmodule template="#self#"
	fuseaction="page.pageNotFound">
</cfdefaultcase>
</cfswitch>


	