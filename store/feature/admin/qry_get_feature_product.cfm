
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of products the selected feature is currently related to. Called by feature.admin&feature=related_prod --->

<cfquery name="qry_get_Product_item"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT P.Product_ID, P.Name, P.SKU, P.Short_Desc
	FROM #Request.DB_Prefix#Feature_Product FP, #Request.DB_Prefix#Products P 
	WHERE FP.Product_ID = P.Product_ID
	AND FP.Feature_ID = #attributes.feature_id#
</cfquery>
		


