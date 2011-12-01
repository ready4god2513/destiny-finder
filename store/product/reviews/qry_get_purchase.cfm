<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Query for summary information about reviews for a particular product --->

<cfparam name="attributes.Product_ID" default="0">
<!--- Used to check for invalid query strings --->
<cfparam name="invalid" default="0">

<cftry>
	<cfquery name="qry_get_purchase" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT O.Item_ID FROM #Request.DB_Prefix#Order_No N, #Request.DB_Prefix#Order_Items O
	WHERE N.Order_No = O.Order_No
	AND N.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">
	AND O.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
	</cfquery>

<cfcatch type="Any">
	<cfset invalid = 1>
</cfcatch>
</cftry>