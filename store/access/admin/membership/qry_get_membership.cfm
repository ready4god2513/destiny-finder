
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves a specific membership record for editing. Called by the fuseaction access.admin&membership=edit --->

<cfquery name="qry_get_Membership"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT M.*, U.Username, U.User_ID, P.Name, P.Prod_Type, P.Content_URL
	FROM ((#Request.DB_Prefix#Memberships M 
			LEFT JOIN #Request.DB_Prefix#Users U ON M.User_ID = U.User_ID) 
			LEFT JOIN #Request.DB_Prefix#Products P ON M.Product_ID = P.Product_ID)
	WHERE M.Membership_ID = #attributes.Membership_id#
</cfquery>
		
	

	
