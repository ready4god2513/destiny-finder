
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<cfif CompareNoCase(fusebox.fuseaction, "secure") IS 0>
	<cfinclude template="secure.cfm">	

<cfelseif CompareNoCase(fusebox.fuseaction, "admin") IS 0>
		<!--- USERS Permission 2 = access admin menu --->
		<cfmodule template="secure.cfm"
		keyname="users"
		requiredPermission="2"
		>
		<cfif ispermitted>
			<cfinclude template="admin/index.cfm">
		</cfif>
	
	<!--- list memberships  --->
<cfelseif CompareNoCase(fusebox.fuseaction, "memberships") IS 0>

	<cfmodule template="../access/secure.cfm"
	keyname="login"
	requiredPermission="1"
	>
	<cfif ispermitted>
		<cfset uid = Session.User_ID>
		<cfinclude template="qry_get_memberships.cfm">
		<cfinclude template="dsp_membership_list.cfm">
		
	</cfif>	

<!--- cancel recurring membership --->
<cfelseif CompareNoCase(fusebox.fuseaction, "cancelrecur") IS 0>
	<cfmodule template="../access/secure.cfm"
	keyname="login"
	requiredPermission="1"
	>
	<cfif ispermitted>
		<!--- if this is a form submission from the membership list, check if user is renewing instead --->
		<cfif isDefined("attributes.do_renew")>
			<cfinclude template="../shopping/basket/act_add_item.cfm">
			<cfinclude template="../shopping/basket/act_recalc.cfm">
			<cflocation url="#self#?fuseaction=shopping.basket#Request.Token2#" addtoken="No">
			
		<cfelse>
			<cfinclude template="act_cancel_recur.cfm">
				
			<cfset attributes.XFA_success="fuseaction=access.memberships">
			<cfset attributes.box_title="Membership">
			<cfset attributes.message="Auto-renew has been cancelled for this membership.">
			<cfinclude template="../includes/form_confirmation.cfm">	
		
		</cfif>		
		
	</cfif>	

<!--- file downloads --->
<cfelseif CompareNoCase(fusebox.fuseaction, "download") IS 0>

	<!--- LOGIN Permission 0 = login required --->	
	<cfmodule template="../access/secure.cfm"
	keyname="login"
	requiredPermission="0"
	>
	<cfif ispermitted>
		<!---- download if there is an ID ---->
		<cfif isdefined("attributes.ID")>
			<cfinclude template = "qry_get_membership.cfm">
			<cfinclude template="act_download_file.cfm">
			<cfinclude template="dsp_download_file.cfm">
		
		<!---- list available downloads if no ID ---->
		<cfelse>
			<cfset uid = Session.User_ID>
			<cfset attributes.prod_type = "download">
			<cfinclude template="qry_get_memberships.cfm">
			<cfinclude template="dsp_download_list.cfm">
		</cfif>		
	</cfif>	

	
<!--- FOR DEBUGGING: uncomment this to use fuseaction=access.test to display the current
user's session.userpermissions structure.--->
<cfelseif CompareNoCase(fusebox.fuseaction, "test") IS 0>

	<cfinclude template="dsp_user_privileges.cfm">

<!--- no valid fuseaction --->
<cfelse>
	<cfmodule template="../#self#"
		fuseaction="page.pageNotFound">

</cfif>


