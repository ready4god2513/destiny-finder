
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the home.admin circuit. It runs all the admin functions for the home circuit --->

<!--- Color Palettes --->
<cfif isdefined("attributes.colors")>

	<cfset Webpage_title = "Color palette #attributes.colors#">

	<!---- users permission 1 = site admin --->
	<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<cfif ispermitted>
	
	<cfswitch expression = "#attributes.colors#">		
	
		<cfcase value="list">
			<cfinclude template="colors/qry_get_colors.cfm">
			<cfinclude template="colors/dsp_color_list.cfm">
		</cfcase>
			
		<cfcase value="add">
			<cfinclude template="colors/dsp_color_form.cfm">
		</cfcase>
	
		<cfcase value="edit">
			<cfinclude template="colors/qry_get_color.cfm"> 
			<cfinclude template="colors/dsp_color_form.cfm">
		</cfcase>
			
		<cfcase value="act">
			<cfinclude template="colors/act_colors.cfm">
			<cfset attributes.XFA_success="fuseaction=home.admin&colors=list">
			<cfset attributes.box_title="Color Palettes">
			<cfinclude template="../includes/admin_confirmation.cfm">
		</cfcase>
		
		<cfdefaultcase> 
			<cfoutput>** ERROR ***</cfoutput>
		</cfdefaultcase>
	</cfswitch>

	</cfif>

<!--- Main Site Settings --->
<cfelseif isdefined("attributes.settings")>	

	<cfset Webpage_title = "Site Settings">

	<!---- users permission 1 = site admin --->
	<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<cfif ispermitted>
	
	<cfswitch expression = "#attributes.settings#">			
		<cfcase value="edit">
			<cfinclude template="../queries/qry_getcountries.cfm">
			<cfinclude template="../category/qry_get_allcats.cfm">
			<cfinclude template="colors/qry_get_colors.cfm">
			<cfinclude template="settings/dsp_settings_form.cfm">
		</cfcase>
			
		<cfcase value="save">
			<cfif isdefined("attributes.act_verity")>
				<cfinclude template="settings/act_verity.cfm">
			<cfelse>
				<cfinclude template="settings/act_settings.cfm">				
				<cfset attributes.XFA_success="fuseaction=home.admin">
				<cfset attributes.box_title="Settings">
				<cfinclude template="../includes/admin_confirmation.cfm">	
			</cfif>
		</cfcase>
		
		<cfdefaultcase> 
			<cfoutput>** ERROR *** </cfoutput>
		</cfdefaultcase>
	</cfswitch>
	
	</cfif>
	
<!--- Option Picklists --->	
<cfelseif isdefined("attributes.picklists")>

	<cfset Webpage_title = "Picklist Admin">
	
	<!---- users permission 1 = site admin --->
	<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<cfif ispermitted>
		
	<cfinclude template="../queries/qry_getpicklists.cfm">
	
	<cfparam name="attributes.savelists" default="0">
	<cfset fieldlist = qry_GetPicklists.columnlist>
	<cfset fieldlist = replacenocase(fieldlist, "PICKLIST_ID", "", "all")>
	<cfset fieldlist = replacenocase(fieldlist, ",,", ",", "all")>

	<cfif attributes.savelists is not "0"> 
		<cfinclude template="picklists/act_picklists.cfm">
		<cfset attributes.XFA_success="fuseaction=home.admin">
		<cfset attributes.box_title="Pick Lists">
		<cfinclude template="../includes/admin_confirmation.cfm">
			
	<cfelse> <!--- DISPLAY PICK LIST FORM --->
		<cfinclude template="picklists/dsp_picklists.cfm">
	</cfif>

	</cfif>
	
<!--- Category and Page Templates --->	
<cfelseif isdefined("attributes.catCore")>

	<cfset Webpage_title = "Template #attributes.catCore#">
	
	<!---- users permission 1 = site admin --->
	<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<cfif ispermitted>
	
	<cfswitch expression = "#attributes.catCore#">
		<cfcase value="list">
			<cfinclude template="catcore/qry_get_catcores.cfm">
			<cfinclude template="catcore/dsp_catcore_list.cfm">
		</cfcase>
			
		<cfcase value="add">
			<cfinclude template="catcore/dsp_catcore_form.cfm">
		</cfcase>
			
		<cfcase value="edit">
			<cfinclude template="catcore/qry_get_catcore.cfm"> 
			<cfinclude template="catcore/dsp_catcore_form.cfm">
		</cfcase>
		
		<cfcase value="act">
			<cfinclude template="catcore/act_catcore.cfm">
			<cfset attributes.XFA_success="fuseaction=home.admin&catCore=list">
			<cfset attributes.box_title="Category Templates">
			<cfinclude template="../includes/admin_confirmation.cfm">
		</cfcase>
			
		<cfdefaultcase><!--- List --->
			<cfinclude template="catcore/qry_get_catcores.cfm">
			<cfinclude template="catcore/dsp_catcore_list.cfm">
		</cfdefaultcase>
	</cfswitch>		
	</cfif>
	
<!--- Data Dictionary --->	
<cfelseif isdefined("attributes.schema")>

	<cfset Webpage_title = "Database Schema">
	
	<!---- users permission 1 = site admin --->
	<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<cfif ispermitted>
		
	<cfswitch expression = "#attributes.schema#">	
		<cfcase value="view">
			<cftry> 
			<cfinclude template="schema/qry_tables.cfm"> 
			<cfinclude template="schema/dsp_schema.cfm">
			
			<cfcatch type="Database">
			<cfoutput><br/>The database schema view is not supported by your database.</cfoutput>
			</cfcatch>
			</cftry>
		</cfcase>
		
		<cfdefaultcase><!--- List --->
			<cfinclude template="schema/qry_tables.cfm"> 
			<cfinclude template="schema/dsp_schema.cfm">
		</cfdefaultcase>
		
	</cfswitch>	

	</cfif>

<!--- Used by pop-up window to delete images for products --->	
<cfelseif isdefined("attributes.img") and attributes.img is "remove">

	<cfinclude template="../includes/remove_images.cfm">
	
	
<!--- Admin form selectors. --->	
<cfelseif isdefined("attributes.select")>

	<cfswitch expression = "#attributes.select#">	
	
		<cfcase value="image">		
			<cfset Webpage_title = "Image Manager">
			<cfinclude template="imagemanager/act_image_manager.cfm">
		</cfcase>
		
		<cfcase value="color">		
			<cfinclude template="colors/act_selectcolor.cfm">
		</cfcase>		

	</cfswitch>	

	
<!--- View error dumps --->	
<cfelseif isdefined("attributes.error")>
	
	<!---- users permission 1 = site admin --->
	<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<cfif ispermitted>
	
	<cfswitch expression = "#attributes.error#">	
	
		<cfcase value="list">		
			<cfinclude template="../errors/dumps/act_num_errors.cfm">
			<cfinclude template="errors/act_errors_list.cfm">	
			<cfinclude template="errors/dsp_errors_list.cfm">
		</cfcase>
		
		<cfcase value="display">		
			<cfinclude template="errors/dsp_errordump.cfm">
		</cfcase>		

	</cfswitch>	
	
	</cfif>
	
<!--- Reset cached data --->
<cfelseif isdefined("attributes.cache")>
	
	<!---- users permission 1 = site admin --->
	<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<cfif ispermitted>	
		<cfinclude template="reset_cache.cfm">	
	</cfif>
	
<!--- Admin form selectors. --->	
<cfelseif isdefined("attributes.adminmenu")>
	<cfinclude template="../layouts/admin/put_admin_menu.cfm">
	
<cfelseif isdefined("attributes.admintopbar")>
	<cfinclude template="../layouts/admin/put_admin_top.cfm">
		
<cfelseif isdefined("attributes.inframes")>
	<cfinclude template="dsp_admin_home.cfm">
	
<cfelseif isdefined("attributes.adminxml")>
	<cfinclude template="dsp_pending_xml.cfm">

<cfelse><!--- MENU --->	
	<!--- <cfinclude template="dsp_menu.cfm"> --->
	<cfset attributes.newWindow = "Yes">
</cfif>



