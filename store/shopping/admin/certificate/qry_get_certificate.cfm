
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information on a specific gift certificate. Called by shopping.admin&certificate=edit --->

<cfquery name="qry_get_Certificate"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#"  maxrows="1">
	SELECT * FROM #Request.DB_Prefix#Certificates
	WHERE Cert_ID = #attributes.Cert_ID#
</cfquery>
	


	