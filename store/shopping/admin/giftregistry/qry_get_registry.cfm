
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of category templates, must be set for use with categories. Used on the list pages for filter and for the category form page --->

<cfquery name="qry_get_giftregistry" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT * FROM #Request.DB_Prefix#GiftRegistry
	Where GiftRegistry_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.giftregistry_ID#">
</cfquery>
		

