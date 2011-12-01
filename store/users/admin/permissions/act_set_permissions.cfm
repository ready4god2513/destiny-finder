
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template presents user or group permission key form and processes it.
	IN:
		Type			Set permissions for user | group
		ID				for user_id | group_id 
		XFA_success
	
	This tag has 3 parts: select circut, select permissions, process.
	--->
	
<cfscript>
	function AddList(thelist) {
		var i = 0;
		var theList_len = ListLen(theList);
		var total = 0;
		
		for (i=1; i LTE theList_len; i=i+1) {
			total = total + ListGetAt(thelist, i);
		}

	return total;
	}
</cfscript>

<cfparam name="attributes.type" default=""> 
<cfparam name="attributes.ID" default="">	

<cfif isdefined("attributes.group") and attributes.group is "permissions">
	<cfset attributes.type = "Group">
	<cfset theID = "GID">
	<cfset attributes.ID = attributes.gid>
<cfelseif isdefined("attributes.user") and attributes.user is "permissions">
	<cfset attributes.type = "User">
	<cfset theID = "UID">
	<cfset attributes.ID = attributes.uid>
</cfif>

<cfparam name="attributes.XFA_Success" default="fuseaction=users.admin&#attributes.type#=list"> 

<!--- Get the list of permissions groups --->
<cfinclude template="qry_get_permissions_groups.cfm">
	
<!--- Make sure this is not the admin group and in demo mode --->
<cfif Request.DemoMode AND attributes.type IS "Group" AND attributes.ID IS 1>
	<cflocation url="#self#?fuseaction=users.admin&#attributes.type#=list#Request.Token2#" addtoken="No">

<cfelseif isdefined("attributes.submit_key")>

	<!--- Initialize the permission string --->	
	<cfset Permissions = "">
	
	<cfif attributes.registration_key IS NOT 0>
		<cfset Permissions = ListAppend(Permissions,"registration^#attributes.registration_key#", ";")>
	</cfif>
	
	<cfif isDefined("attributes.contentkey_list")>
		<cfset Permissions = ListAppend(Permissions,"contentkey_list^#attributes.contentkey_list#", ";")>
	</cfif>
	
	<!--- Loop through the list of permissions groups --->
	<cfloop query="qry_get_groups">
		<cfif isDefined("attributes.#qry_get_groups.name#_Bits")>
			<cfset currentPerm = AddList(Evaluate("attributes.#qry_get_groups.name#_Bits"))>
			<cfif len(currentPerm) AND currentPerm IS NOT 0>
				<cfset Permissions = ListAppend(Permissions,"#LCase(qry_get_groups.name)#^#currentPerm#", ";")>
			</cfif>
		</cfif>	
	</cfloop>


	<!--- update table with new permission --->
	<cfquery name="Update_permissions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" >
		UPDATE #Request.DB_Prefix##attributes.type#s
		SET Permissions = '#Permissions#'
		WHERE  #attributes.type#_ID = #attributes.ID#
	</cfquery>
	
	<cfset attributes.box_title="Permission">
	<cfinclude template="../../../includes/admin_confirmation.cfm">

<cfelse><!--- Display form --->

	<!--- Get type_ID.Permission --->	
	<cfinclude template="qry_get_permissions.cfm">
	<cfinclude template="qry_get_type.cfm">
	
	<!--- Permission Form --->
	<cfinclude template="dsp_priv_form.cfm">
	
</cfif>

<!--- </cfif> ---><!--- circuit check --->




