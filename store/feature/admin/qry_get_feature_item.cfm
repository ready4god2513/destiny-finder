
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of features the selected feature is currently related to. Called by feature.admin&feature=related --->

<cfquery name="qry_get_feature_item"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT F.Feature_ID, Name, Author, Copyright
	FROM #Request.DB_Prefix#Feature_Item FI, #Request.DB_Prefix#Features F
	WHERE FI.Feature_ID = F.Feature_ID
	AND FI.Item_ID = #attributes.feature_id#
</cfquery>
		

