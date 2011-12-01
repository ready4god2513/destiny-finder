
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!---- page permission 1 = page admin --->
<cfmodule template="../../access/secure.cfm"
	keyname="page"
	requiredPermission="1"
	>	
	<cfif ispermitted>

<cfif isdefined("attributes.do")>

	<cfset Webpage_title = "Page #attributes.do#">

	<cfswitch expression="#attributes.do#">
		
		<cfcase value="list">
			<cfinclude template="qry_get_pages.cfm">
			<cfinclude template="dsp_pages_list.cfm">
		</cfcase>
		
		<cfcase value="add">
			<cfinclude template="dsp_page_form.cfm">
		</cfcase>
			
		<cfcase value="edit">
			<cfinclude template="qry_get_page.cfm"> 
			<cfinclude template="dsp_page_form.cfm">
		</cfcase>
		
		<cfcase value="copy">
			<cfinclude template="act_copy_page.cfm"> 
			<cfinclude template="qry_get_page.cfm"> 
			<cfinclude template="dsp_page_form.cfm">
		</cfcase>				
				
		<cfcase value="act">
			<cfinclude template="act_page.cfm">
			
			<cfif isdefined("attributes.image_list") and len(attributes.image_list)>
				<cfset attributes.XFA_success="fuseaction=Page.admin&do=list">
				<cfinclude template="../../includes/remove_images.cfm">	
			<cfelse>
				<cfset attributes.XFA_success="fuseaction=Page.admin&do=list">
				<cfset attributes.box_title="Pages">
				<cfinclude template="../../includes/admin_confirmation.cfm">		
			</cfif>	
		
		</cfcase>
		
		<cfcase value="listform">
			<cfinclude template="qry_get_pages.cfm">
			<cfinclude template="dsp_pages_list_form.cfm">
		</cfcase>		
		
		<cfcase value="actform">
			<cfinclude template="act_pages_list.cfm">
	
			<cfset attributes.XFA_success="fuseaction=page.admin&do=list">
			<cfset attributes.box_title="Page">
			<cfinclude template="../../includes/admin_confirmation.cfm">
				
		</cfcase>		
	
		<cfdefaultcase>
			<cfinclude template="qry_get_pages.cfm">
			<cfinclude template="dsp_pages_list.cfm">
		</cfdefaultcase>
			
	</cfswitch>

<cfelse>

	<cflocation url="#self#?fuseaction=page.admin&do=list#Request.Token2#" addtoken="No">
			
</cfif>

</cfif>



