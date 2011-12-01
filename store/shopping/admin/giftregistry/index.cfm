
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfset Webpage_title = "Gift Registry Admin">

<cfswitch expression = "#attributes.giftregistry#">

	<cfcase value="list">
		<cfinclude template="qry_get_registries.cfm">
		<cfinclude template="dsp_registries_list.cfm">
	</cfcase>
						
	<cfcase value="add">
		<cfinclude template="dsp_registry_form.cfm">
	</cfcase>
									
	<cfcase value="edit">
		<cfinclude template="qry_get_registry.cfm">
		<cfinclude template="dsp_registry_form.cfm">
	</cfcase>
		
	<cfcase value="act">
		<cfinclude template="act_registry.cfm">
			
		<cfset attributes.XFA_success="fuseaction=shopping.admin&giftregistry=list">
		<cfset attributes.box_title="Regstry">
		<cfinclude template="../../../includes/admin_confirmation.cfm">				
	</cfcase>

	<!--- View Registry & add Items --->
	<cfcase value="listitems">

		
		<!--- if order number submitted from admin order search --->
		<cfif isdefined("attributes.string")>
			<cfif isNumeric(attributes.string)>
				<cfset attributes.giftregistry_ID = attributes.string>
			<cfelse>
				<cfset attributes.giftregistry_ID = 0>
			</cfif>
		</cfif>
							
		<cfinclude template="qry_get_registry.cfm">					

		<cfif qry_get_giftregistry.recordcount neq 1>
			<cflocation URL="#request.self#?fuseaction=shopping.admin&giftregistry=list&name=#attributes.string##request.token2#" addtoken="No">
		</cfif>
					
		<cfinclude template="../../giftregistry/qry_get_items.cfm">
		<cfinclude template="dsp_items_list.cfm">

	</cfcase>
		
	<cfcase value="actitems">
		<cfinclude template="act_items.cfm">			
		<cfset attributes.XFA_success="fuseaction=shopping.admin&giftregistry=listitems&giftregistry_ID=#attributes.giftregistry_ID#">
			
		<cfset attributes.box_title="Gift Registry">
		<cfinclude template="../../../includes/admin_confirmation.cfm">			
	</cfcase>
	
	<cfcase value="addproduct">
		<!--- <cfinclude template="act_product_add.cfm"> --->
		<cfif isdefined("attributes.AddtoRegistry")>
			<cfinclude template="act_product_add.cfm">
		<cfelse>
			<cfinclude template="dsp_product_add.cfm">
		</cfif>
	</cfcase>
	
	<cfcase value="clear">
		<cfinclude template="act_giftregistry_clear.cfm">
		<cfset attributes.XFA_success="fuseaction=home.admin">
		<cfset attributes.box_title="Gift Registries">
		<cfinclude template="../../../includes/admin_confirmation.cfm">		
	</cfcase>	
		
	<cfdefaultcase>
		<cfinclude template="qry_get_registries.cfm">
		<cfinclude template="dsp_registries_list.cfm">	
	</cfdefaultcase>

</cfswitch>
	
	
