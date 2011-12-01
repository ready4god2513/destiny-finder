
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of memberships or downloads. Called by the fuseactions access.memberships and access.download --->

<cfparam name="uid" default="">
<cfparam name="attributes.prod_type" default="">

<cfquery name="qry_get_Memberships"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT M.*, U.Username, P.Name as product, P.Prod_Type
		FROM ((#Request.DB_Prefix#Memberships M 
		LEFT JOIN #Request.DB_Prefix#Users U ON M.User_ID = U.User_ID) 
		LEFT JOIN #Request.DB_Prefix#Products P ON M.Product_ID = P.Product_ID)

		WHERE 1=1
		<cfif uid is not "">
			and	M.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#uid#">
		</cfif>	
		<cfif attributes.prod_type is not "">
			AND P.Prod_Type = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.prod_type#">
		</cfif>	
		
		ORDER BY M.Expire DESC, M.Valid, M.Product_ID
</cfquery>
		

