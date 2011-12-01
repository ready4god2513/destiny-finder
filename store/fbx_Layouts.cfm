
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!---
<fusedoc fuse="FBX_Layouts.cfm">
	<responsibilities>
		this file contains all the conditional logic for determining which layout file, if any, should be used for this circuit. It should result in the setting of the Fusebox public API variables fusebox.layoutdir and fusebox.layoutfile 
	</responsibilities>	
	<io>
		<out>
			<string name="fusebox.layoutDir" />
			<string name="fusebox.layoutFile" />
		</out>
	</io>
</fusedoc>
--->


<!--- default values for layout files ----->
<cfset fusebox.layoutdir="">

<cfif not IsDefined("ThisTag.ExecutionMode")>

	<!--- Blank Layouts ---->
	<cfif fusebox.targetcircuit IS "SHOPPING" and isdefined("attributes.order") AND 
	fusebox.fuseaction IS "history">
		<cfset fusebox.layoutFile="layouts/lay_blank.cfm">
		
	<cfelseif fusebox.targetcircuit IS "SHOPPING" and isdefined("attributes.order") AND 
	attributes.order is "print">
		<cfset fusebox.layoutFile="layouts/lay_printing.cfm">
		
	<cfelseif fusebox.targetcircuit IS "SHOPPING" and isdefined("attributes.shipping") AND 
	attributes.shipping is "upslicense" AND isDefined("attributes.print")>
		<cfset fusebox.layoutFile="layouts/lay_printing.cfm">
		
	<cfelseif fusebox.targetcircuit IS "SHOPPING" and isdefined("attributes.order") AND attributes.order is "printreport">
		<cfset fusebox.layoutFile="layouts/lay_printing.cfm">
		
	<cfelseif attributes.fuseaction IS "users.addressbook" AND isdefined("attributes.order_no")>
		<cfset fusebox.layoutFile="layouts/lay_blank.cfm">	

	<cfelseif attributes.fuseaction IS "shopping.admin" AND isdefined("attributes.order") AND attributes.order is "AddProduct">
		<cfset fusebox.layoutFile="layouts/lay_blank.cfm">		
		
	<cfelseif attributes.fuseaction is "shopping.giftregistry" AND isDefined("attributes.manage") and attributes.manage is "print">
		<cfset fusebox.layoutFile="layouts/lay_printing.cfm">

	<cfelseif attributes.fuseaction IS "shopping.admin" AND isdefined("attributes.giftregistry") AND attributes.giftregistry is "AddProduct">
		<cfset fusebox.layoutFile="layouts/lay_blank.cfm">	
	
	<cfelseif attributes.fuseaction is "home.email">
		<cfset fusebox.layoutFile="layouts/lay_blank.cfm">
		
	<cfelseif attributes.fuseaction is "home.admin" AND isDefined("attributes.error") and attributes.error is "display">
		<cfset fusebox.layoutFile="layouts/lay_printing.cfm">
	
	<cfelseif attributes.fuseaction is "home.admin" AND isDefined("attributes.select")>
		<cfset fusebox.layoutFile="layouts/lay_blank.cfm">
	
	<cfelseif attributes.fuseaction is "users.admin" AND isDefined("attributes.download")>
		<cfset fusebox.layoutFile="layouts/lay_blank.cfm">

	<cfelseif attributes.fuseaction is "access.admin" AND isDefined("attributes.report")>
		<cfset fusebox.layoutFile="layouts/lay_blank.cfm">
	
	<cfelseif attributes.fuseaction is "feature.print">
		<cfset fusebox.layoutFile="layouts/lay_printing.cfm">
		
	<cfelseif attributes.fuseaction is "home.test">
		<cfset fusebox.layoutFile="layouts/lay_blank.cfm">
	
	<cfelseif attributes.fuseaction is "page.cvv2help">
		<cfset fusebox.layoutFile="layouts/lay_blank.cfm">
		
	<!--- Admin layouts --->
	<cfelseif attributes.fuseaction is "home.admin" AND isDefined("attributes.adminmenu")>
		<cfset fusebox.layoutFile="layouts/admin/lay_adminmenu.cfm">
		
	<cfelseif attributes.fuseaction is "home.admin" AND isDefined("attributes.admintopbar")>
		<cfset fusebox.layoutFile="layouts/admin/lay_admintopbar.cfm">
		
	<cfelseif fusebox.fuseaction is "admin" AND isDefined("attributes.inframes")>
		<cfset fusebox.layoutFile="layouts/admin/lay_admincontent.cfm">
		
	<!--- Set Layout by Palette --->	
	<cfelseif len(Request.GetColors.layoutfile)>
		<cfset fusebox.layoutFile = "layouts/#Request.GetColors.layoutfile#">
		
	<!--- Default Layout ----->
	<cfelse>
		<cfset fusebox.layoutFile = "layouts/lay_default.cfm">
	</cfif>	
	
	<!--- Set this if you want to use a different default Admin Layout --->
 	<cfif fusebox.fuseaction is "admin" AND NOT ListFindNoCase("lay_blank.cfm,lay_printing.cfm,lay_admincontent.cfm,lay_adminmenu.cfm,lay_admintopbar.cfm", ListLast(fusebox.layoutFile, "/")) AND NOT isDefined("Request.NotAllowed")>
		<!--- Check for admin menu XML spry file --->
		<cfif isDefined("attributes.adminxml")>
			<cfset fusebox.layoutFile="">
		<!--- If coming from another admin link, use empty layout --->
		<cfelseif FindNoCase(".admin", cgi.HTTP_REFERER) AND NOT isDefined("attributes.newWindow")>
			<cfset fusebox.layoutFile = "layouts/admin/lay_admincontent.cfm">
		<cfelse>
			<!--- Otherwise, load the frameset with the admin menu --->
			<cfset fusebox.layoutFile = "layouts/admin/lay_admin.cfm">
		</cfif>

	</cfif> 

<cfelse>
	<cfset fusebox.layoutFile="">
</cfif>




