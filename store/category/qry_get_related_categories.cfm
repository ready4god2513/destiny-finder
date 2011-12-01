
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to retrieve a list of related categories. Called by category.related --->

<!--- 
Parameters:
Detail_Type: The item the category is related to. Options include: Product	
 --->
 
 <cfparam name="attributes.DETAIL_TYPE" type="string" default="Product">


<!--- Related Categories --->
<cfquery name="Request.GetRelatedCats" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT C.Name, C.Category_ID, C.Short_Desc, C.ParentIDs, C.ParentNames
FROM #Request.DB_Prefix#Categories C, #Request.DB_Prefix##attributes.DETAIL_TYPE#_Category DC
WHERE C.Category_ID = DC.Category_ID 
AND DC.#attributes.DETAIL_TYPE#_ID = 
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.DETAIL_ID#"> 
AND C.Display = 1
</cfquery>


