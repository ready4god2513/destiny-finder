
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called by any of the detail pages to output a list of features that the detail item appears in. The output is a feature Listing. Called by feature.related

REQUIRED: DETAIL_TYPE -- Feature (Item), Product, etc.  --->

<!--- Related Features --->
<cfquery name="GetRelatedFeatures" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT F.Name, F.Feature_ID, F.Short_Desc
FROM #Request.DB_Prefix#Features F, #Request.DB_Prefix#Feature_#attributes.DETAIL_TYPE# FD
WHERE F.Feature_ID = FD.Feature_ID 
AND FD.#attributes.DETAIL_TYPE#_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.DETAIL_ID#">
AND F.Display = 1
AND F.Approved = 1
AND (F.Start <= #createODBCdate(now())# OR F.Start is null)
AND (F.Expire >= #createODBCdate(now())# OR F.Expire is null)
</cfquery>



