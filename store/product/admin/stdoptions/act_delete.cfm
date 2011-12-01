
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Deletes a standard option. Removes from any products using it, and then deletes the standard option. Called by product.admin&stdoption=delete --->

<!--- Check user's access level --->
<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<!--- if not full product admin, make sure they have access to this option --->
<cfif NOT ispermitted>
	<cfmodule template="../../../access/useraccess.cfm" ID="#attributes.Std_ID#" type="stdoption">
	<cfset editoption = useraccess>
<cfelse>
	<cfset editoption = "yes">
</cfif>

<cfif editoption>
	<!--- Delete the Product Choices for this Option --->
	<cfquery name="DeleteProdChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#ProdOpt_Choices		
		WHERE Option_ID IN (SELECT Option_ID FROM #Request.DB_Prefix#Product_Options 
								WHERE Std_ID = #attributes.Std_ID#)
	</cfquery>
					
	<cfquery name="DeleteProdOpts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Product_Options
		WHERE Std_ID = #attributes.Std_ID#
	</cfquery>
	
	<!--- Delete the Standard Choices for this Option --->
	<cfquery name="DeleteStdChoices" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#StdOpt_Choices
		WHERE Std_ID = #attributes.Std_ID#
	</cfquery>
	
	<cfquery name="DeleteOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#StdOptions
		WHERE Std_ID = #attributes.Std_ID#
	</cfquery>
	
	
	
	
	<cfmodule template="../../../customtags/format_admin_form.cfm"
		box_title="Standard Option"
		width="400"
		required_fields = "0"
		>
		
		<tr><td align="center" class="formtitle">
			<br/>
		Option Deleted
		
		<cfoutput>
		<form action="#self#?fuseaction=product.admin&StdOption=list#request.token2#" method="post">
		</cfoutput>
		<input class="formbutton" type="submit" value="Back to Options List"/>
		</form>	
					
		</td></tr>
	</cfmodule> 
		
<!--- user did not have access --->
<cfelse>
	<cfset attributes.message = "You do not have access to delete this standard option.">
	<cfset attributes.XFA_success = "fuseaction=product.admin&stdoption=list">
	<cfinclude template="../../../includes/admin_confirmation.cfm">

</cfif>
		
			
				
