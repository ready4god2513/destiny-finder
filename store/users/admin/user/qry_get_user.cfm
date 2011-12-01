
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves a specific User record for editing. Called by the fuseaction users.admin&user=edit --->

<cfquery name="qry_get_user" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT U.*, F.AffCode, F.AffPercent, A.Account_ID, G.name AS GroupName
	FROM ((#Request.DB_Prefix#Users U 
			LEFT JOIN #Request.DB_Prefix#Groups G ON U.Group_ID = G.Group_ID) 
		LEFT JOIN #Request.DB_Prefix#Affiliates F ON U.Affiliate_ID = F.Affiliate_ID)
	LEFT JOIN #Request.DB_Prefix#Account A on A.User_ID = U.User_ID
	WHERE U.User_ID = #attributes.uid#
</cfquery>

