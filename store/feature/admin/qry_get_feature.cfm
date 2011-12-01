
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the selected feature. Called by feature.admin&feature=edit|related|related_prod|copy --->

<cfparam name="uid" default="">

<!--- if user does not have feature editor permission (2) then show only features
that current user created ---->
<cfparam name="ispermitted" default=1>
<cfmodule template="../../access/secure.cfm"
	keyname="feature"
	requiredPermission="2"
	> 
<cfif not ispermitted>
	<cfset uid = Session.User_ID>	
</cfif>



<cfquery name="qry_get_Feature"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT * FROM #Request.DB_Prefix#Features
	WHERE Feature_ID = #attributes.Feature_id#
	<cfif len(uid)>
		AND User_ID = #uid#
	</cfif>
</cfquery>
		


