
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for a standard option. Called by product.admin&stdoption=edit --->

<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<cfquery name="qry_get_StdOption" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#StdOptions
	WHERE Std_ID = #attributes.Std_ID#
	<!--- If not full product admin, filter by user --->
	<cfif not ispermitted>	
	AND User_ID = #Session.User_ID# </cfif>
</cfquery>

<cfquery name="qry_get_StdOpt_Choices" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#StdOpt_Choices
	WHERE Std_ID = #attributes.Std_ID#
	ORDER BY SortOrder
</cfquery>

<!--- Checks if this option is being used for inventory tracking on any orders --->
<cfquery name="CheckInvUse" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT OptChoice FROM #Request.DB_Prefix#Order_Items OI, 
	#Request.DB_Prefix#Products P, #Request.DB_Prefix#Product_Options PO
	WHERE PO.Std_ID = #attributes.Std_ID#
	AND PO.Option_ID = P.OptQuant
	AND P.Product_ID = OI.Product_ID
	AND OI.OptChoice <> 0 
</cfquery>
