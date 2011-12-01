
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of user groups the selected discount is currently assigned to. Called by product.admin&discount=groups --->

<cfquery name="qry_get_disc_groups" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT G.Name, G.Group_ID
	FROM #Request.DB_Prefix#Discount_Groups DG, #Request.DB_Prefix#Groups G
	WHERE DG.Group_ID = G.Group_ID
	AND DG.Discount_ID = #attributes.discount_id#
</cfquery>
		


