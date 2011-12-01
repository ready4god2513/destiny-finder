
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the users gift registries. Called by shopping.giftregistry --->

<!--- Used to check for invalid query strings --->
<cfparam name="invalid" default="0">


<cftry>
	<!--- Get registry information --->
	<cfquery name="qry_get_giftregistry" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#GiftRegistry
	WHERE GiftRegistry_ID = <cfqueryparam value="#attributes.GiftRegistry_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>

<cfcatch type="Any">
	<cfset invalid = 1>
</cfcatch>
</cftry>
