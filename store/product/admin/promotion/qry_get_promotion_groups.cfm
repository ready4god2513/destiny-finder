
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of user groups the selected promotion is currently assigned to. Called by product.admin&promotion=groups --->

<cfquery name="qry_get_disc_groups" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT G.Name, G.Group_ID
	FROM #Request.DB_Prefix#Promotion_Groups PG, #Request.DB_Prefix#Groups G
	WHERE PG.Group_ID = G.Group_ID
	AND PG.Promotion_ID = #attributes.promotion_id#
</cfquery>
		


