
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of standard options. Called by product.admin&stdoption=list --->

<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<cfloop index="namedex" list="std_name,std_display,stdrequired,username">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>
		
<cfquery name="qry_get_StdOptions" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT SO.*, U.Username FROM #Request.DB_Prefix#StdOptions SO
	LEFT JOIN #Request.DB_Prefix#Users U ON SO.User_ID = U.User_ID
	WHERE 1 = 1
	<cfif trim(attributes.std_name) is not "">
		AND Std_Name Like '%#attributes.std_name#%'	</cfif>
	<cfif trim(attributes.std_display) is not "">
		AND Std_Display = #attributes.std_display# </cfif>
	<cfif trim(attributes.stdrequired) is not "">
		AND Std_Required = #attributes.stdrequired# </cfif>
	<cfif trim(attributes.username) is not "">
		AND U.Username Like '%#attributes.username#%'	</cfif>
	<!--- If not full product admin, filter by user --->
	<cfif not ispermitted>	
		AND SO.User_ID = #Session.User_ID# 
	<cfelseif isDefined("options_for_product")>
		AND SO.User_ID = #qry_get_product.User_ID#
	</cfif>
</cfquery>
		


