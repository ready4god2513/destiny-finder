
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the category.admin circuit. It runs all the admin functions for the category circuit --->

<!--- Category permission 1 = category admin --->
<cfmodule template="../../access/secure.cfm"
	keyname="category"
	requiredPermission="1"
	>		
	<cfif ispermitted>
	

<cfif isdefined("attributes.category")>

		<cfset Webpage_title = "Category #attributes.category#">
		
		<cfswitch expression="#attributes.category#">
		
			<cfcase value="list">
				<cfinclude template="qry_get_categories.cfm">
				<cfinclude template="dsp_categories_list.cfm">
			</cfcase>

			<cfcase value="listform">
				<cfinclude template="qry_get_categories.cfm">
				<cfinclude template="dsp_categories_list_form.cfm">
			</cfcase>
					
			<cfcase value="add">
				<cfinclude template="dsp_category_form.cfm">
			</cfcase>
			
			<cfcase value="edit">
				<cfinclude template="qry_get_category.cfm"> 
				<cfinclude template="dsp_category_form.cfm">
			</cfcase>
		
			<cfcase value="act">
				<!--- Make sure this is a valid form submission --->
				<cfif isDefined("attributes.Priority")>
					<cfinclude template="act_categories.cfm">
				<cfelse>
					<cfset attributes.message = "Invalid form submission!">
					<cfset attributes.pid = 0>
				</cfif>
				
				<cfif isdefined("attributes.image_list") and len(attributes.image_list)>
				 	<cfset attributes.XFA_success="fuseaction=Category.admin&Category=list&PID=#attributes.pid#">
					<cfinclude template="../../includes/remove_images.cfm">	
				<cfelse>
					<cfset attributes.XFA_success="fuseaction=Category.admin&Category=list&PID=#attributes.pid#">
					<cfset attributes.box_title="Category">
					<cfinclude template="../../includes/admin_confirmation.cfm">		
				</cfif>		
			</cfcase>
			
			<cfcase value="actform">
				<!--- Make sure this is a valid form submission --->
				<cfif isDefined("attributes.CategoryList")>
					<cfinclude template="act_categories_list_form.cfm">
				<cfelse>
					<cfset addedpath="&fuseaction=category.admin&category=list">
					<cfset attributes.message = "Invalid form submission!">
				</cfif>
					
				<cfset attributes.XFA_success= addedpath>
				<cfset attributes.box_title="Categories">
				<cfinclude template="../../includes/admin_confirmation.cfm">	
			</cfcase>
		
			<cfdefaultcase>
				<cfinclude template="qry_get_categories.cfm">
				<cfinclude template="dsp_categories_list.cfm">
			</cfdefaultcase>
			
		</cfswitch>

<cfelse>

	<cflocation url="#self#?fuseaction=category.admin&category=list&pid=0#Request.Token2#" addtoken="No">
			
</cfif>
		
	</cfif><!--- permistted --->
	
	

