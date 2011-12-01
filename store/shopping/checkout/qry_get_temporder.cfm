
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the current order information from the temporary table. Called by from do_checkout.cfm --->

<cfquery name="GetTempOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#TempOrder
WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>



