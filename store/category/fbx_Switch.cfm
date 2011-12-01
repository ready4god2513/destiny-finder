
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

category.display - displays the category (requires a category_id)
category.topcatmenu - menu of top level categories (0 as parent_id)
category.subcatmenu - menu of sub categories of a category number
category.related - custom tag called from feature or product display page to list related categories
category.admin - administrative functions for categories
--->

<cfif CompareNoCase(fusebox.fuseaction, "display") IS 0>

	<!--- get the category and its sub-categories --->
	<cfinclude template="qry_get_cat.cfm">
	
	<!--- Make sure a category was found --->
	<cfif not invalid and request.qry_get_cat.recordcount>
	
		<cfset attributes.parent_id = request.qry_get_cat.category_id>
		<cfinclude template="qry_get_subcats.cfm">
			
		<!--- update colors if the category uses a custom palette_ID --->
		<cfif isNumeric(request.qry_get_cat.color_id) AND request.qry_get_cat.color_id is not request.appsettings.color_id>
			<cfset request.color_id = request.qry_get_cat.color_id>
			<cfinclude template="../queries/qry_getcolors.cfm">
			<cfinclude template="../customtags/setimages.cfm">
		</cfif>
		
		<!--- set any variables listed in the category's 'passparam' field --->
		<cfset QuerytoUse = request.qry_get_cat>
		<cfinclude template="../includes/parseparams.cfm">
		
		<!--- check that the user has the required permission to access this category
		if an access key is defined in the category's 'accesskey' field --->
		<cfparam name="ispermitted" default="1">
		<cfif request.qry_get_cat.accesskey>
			<cfmodule template="../#self#"
			fuseaction="access.secure"
			keyname="contentkey_list"			
			requiredPermission="#request.qry_get_cat.AccessKey#" 
			>
		</cfif>
		
		<cfif ispermitted>
			<!--- display category header, a line, then the category's core template ---->
			<cfinclude template="dsp_catheader.cfm">
			<cfif not isdefined("attributes.noline")>
				<cfmodule template="../customtags/putline.cfm" linetype="Thick">
			</cfif>
			<!--- Set ParentCat to use for Product Listings --->
			<cfset attributes.ParentCat = attributes.category_id>
			<cfinclude template="../#request.qry_get_cat.template#">	
		</cfif>
	
	<cfelse>
		<cfinclude template="../errors/dsp_notfound.cfm">
	</cfif>

<cfelseif CompareNoCase(fusebox.fuseaction, "related") IS 0>
	<cfparam name="attributes.DETAIL_TYPE" default="Product">
	<cfparam name="attributes.DETAIL_ID" default="0">
	<cfinclude template="qry_get_related_categories.cfm">
	<cfinclude template="dsp_related_categories.cfm">	
	
<!--- <cfelseif CompareNoCase(fusebox.fuseaction, "topcatmenu") IS 0>
	<!--- attributes: rootcat --->
	<cfparam name="attributes.menu_orientation" default="horizontal">
	<cfparam name="attributes.menu_align" default="center">
	<cfparam name="attributes.menu_text" default="0">
	<cfparam name="attributes.menu_class" default="menu_category">
	 <cfparam name="attributes.menu_type" default="normal">
	<cfinclude template="qry_get_topcats.cfm">
	<cfinclude template="dsp_topcat_menu.cfm"> --->

<cfelseif CompareNoCase(fusebox.fuseaction, "subcatmenu") IS 0>
	<cfparam name="attributes.menu_text" default="0">
	<cfinclude template="qry_get_subcats.cfm">
	<cfinclude template="dsp_subcat_menu.cfm">


<!--- ADMIN STUFF ------------------------------------------------------->
<cfelseif CompareNoCase(fusebox.fuseaction, "admin") IS 0>
	<!--- User Permission 2 = admin menu --->
	<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="2"
	>
	<cfif ispermitted>
		<cfinclude template="admin/index.cfm">
	</cfif>

<!--- No valid fuseaction found --->
<cfelse>
	<cfmodule template="../#self#" fuseaction="page.pageNotFound">

</cfif>
