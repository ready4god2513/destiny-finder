
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for a software download. Called by the access.download fuseaction --->

<cfparam name="attributes.ID" default="0">
<cfset attributes.Membership_id = attributes.ID>

<cfquery name="qry_get_Membership"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT M.*, U.Username, P.Name, P.Prod_Type, P.Content_URL, P.MimeType, P.User_ID AS UID
	FROM ((#Request.DB_Prefix#Memberships M 
	LEFT JOIN #Request.DB_Prefix#Users U ON M.User_ID = U.User_ID) 
	LEFT JOIN #Request.DB_Prefix#Products P ON M.Product_ID = P.Product_ID)
	WHERE M.Membership_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Membership_id#">
	AND M.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">
		AND Valid = 1
		AND (Start <= #CreateODBCDateTime(Now())# OR Start is null)
		AND (Expire >= #CreateODBCDateTime(Now())# OR Expire is null)
		AND M.Access_Used < M.Access_Count
</cfquery>
		


