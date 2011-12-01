
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Clears Expired Gift Registries ---->

<!--- Get all Gift Registries with Event Date older than attributes.Days --->
<cfquery name="GetRegistries"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT GiftRegistry_ID FROM #Request.DB_Prefix#GiftRegistry
	WHERE Expire <= #CreateODBCDate(DateAdd("m", "-1", Now()))#
</cfquery>

<cfloop query="GetRegistries">

	<cfquery name="delete_GiftItems"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#GiftItems 
		WHERE GiftRegistry_ID = #GiftRegistry_ID#
	</cfquery>
	
	<cfquery name="delete_GiftRegistry"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#GiftRegistry 
		WHERE GiftRegistry_ID = #GiftRegistry_ID#
	</cfquery>

</cfloop>

