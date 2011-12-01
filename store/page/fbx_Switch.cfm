
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

<cfif CompareNoCase(fusebox.fuseaction, "admin") IS 0>

	<cfinclude template="admin/index.cfm">	


<cfelse>
	<cfif CompareNoCase(fusebox.fuseaction, "display") IS NOT 0>
		<cfset attributes.pageaction = fusebox.fuseaction>
	</cfif>
	<cfinclude template="qry_get_page.cfm">
	
	<!--- Make sure this is a valid page --->
	<cfif not invalid and qry_get_page.recordcount>
	
		<!--- check if page is locked with an access key --->
		<cfparam name="ispermitted" default=1>
		<cfif qry_get_page.AccessKey>
			<cfmodule template="../access/secure.cfm"
			keyname="contentkey_list"		
			requiredPermission="#qry_get_page.AccessKey#" 
			>
		</cfif>
		<cfif ispermitted>	
	
		<!--- update colors if the page uses a custom palette_ID --->
		<cfif isNumeric(qry_get_page.color_id) AND qry_get_page.color_id is not request.appsettings.color_id>
			<cfset request.color_id = qry_get_page.color_id>
			<cfinclude template="../queries/qry_getcolors.cfm">
			<cfinclude template="../customtags/setimages.cfm">
		</cfif>
		
		<!--- set any variables listed in the page's 'passparam' field --->
		<cfset QuerytoUse = qry_get_page>
		<cfinclude template="../includes/parseparams.cfm">
		
		<cfinclude template="dsp_page.cfm">
		
		</cfif>
	
	<cfelseif attributes.pageaction IS NOT "pageNotFound">
		<cfinclude template="../errors/dsp_notfound.cfm">
	<cfelse>
		<br/>There was an error retrieving this page.
	</cfif>

</cfif>
	


	