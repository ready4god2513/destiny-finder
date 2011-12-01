
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Deletes a standard addon. Removes from any products using it, and then deletes the standard addon. Called by product.admin&stdaddon=delete --->

<!--- Check user's access level --->
<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<!--- if not full product admin, make sure they have access to this option --->
<cfif NOT ispermitted>
	<cfmodule template="../../../access/useraccess.cfm" ID="#attributes.Std_ID#" type="stdaddon">
	<cfset editaddon = useraccess>
<cfelse>
	<cfset editaddon = "yes">
</cfif>

<cfif editaddon>

	<!--- Delete the addons --->
	<cfquery name="DeleteProdaddons" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#ProdAddons
	WHERE Standard_ID = #attributes.Std_ID#
	</cfquery>
	
	<cfquery name="Deleteaddons" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#StdAddons
	WHERE Std_ID = #attributes.Std_ID#
	</cfquery>
	
	
	<cfmodule template="../../../customtags/format_admin_form.cfm"
		box_title="Standard Addon"
		width="400"
		required_fields = "0"
		>
		
		<tr><td align="center" class="formtitle">
			<br/>
		Addon Deleted
		
		<cfoutput>
		<form action="#self#?fuseaction=product.admin&Stdaddon=list#request.token2#" method="post">
		</cfoutput>
		<input class="formbutton" type="submit" value="Back to Addons List"/>
		</form>	
					
		</td></tr>
	</cfmodule> 
				
			
<!--- user did not have access --->
<cfelse>
	<cfset attributes.message = "You do not have access to edit this standard addon.">
	<cfset attributes.XFA_success = "fuseaction=product.admin&stdaddon=list">
	<cfinclude template="../../../includes/admin_confirmation.cfm">

</cfif>
			
