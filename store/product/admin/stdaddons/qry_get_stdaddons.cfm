
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of standard addons. Called by product.admin&stdaddon=list --->

<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<cfloop index="namedex" list="std_name,std_type,std_display,stdrequired,username">
	<cfoutput><cfparam name="attributes.#namedex#" default=""></cfoutput>
</cfloop>
		
<cfquery name="qry_get_Stdaddons" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT SA.*, U.Username FROM #Request.DB_Prefix#StdAddons SA
	LEFT JOIN #Request.DB_Prefix#Users U ON SA.User_ID = U.User_ID
	WHERE 1 = 1
	<cfif trim(attributes.std_name) is not "">
		AND SA.Std_Name Like '%#attributes.std_name#%'	</cfif>
	<cfif trim(attributes.std_type) is not "">
		AND SA.Std_Type Like '%#attributes.std_type#%'	</cfif>
	<cfif trim(attributes.std_display) is not "">
		AND SA.Std_Display = #attributes.std_display# </cfif>
	<cfif trim(attributes.stdrequired) is not "">
		AND SA.Std_Required = #attributes.stdrequired# </cfif>
	<cfif trim(attributes.username) is not "">
		AND U.Username Like '%#attributes.username#%'	</cfif>
	<!--- If not full product admin, filter by user --->
	<cfif not ispermitted>	
		AND SA.User_ID = #Session.User_ID# 
	<cfelseif isDefined("addons_for_product")>
		AND SA.User_ID = #qry_get_product.User_ID#
	</cfif>
</cfquery>
		


