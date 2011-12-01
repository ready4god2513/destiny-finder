
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for the wishlist. Called by shopping.wishlist --->

<!--- Get wishlist items --->
<cfquery name="qry_Get_list" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT W.Product_ID, P.Name, P.Availability, P.Sm_Image, P.Display, P.NotSold, P.User_ID,
W.DateAdded, W.NumDesired, W.Comments
FROM #Request.DB_Prefix#WishList W 
LEFT JOIN #Request.DB_Prefix#Products P ON W.Product_ID = P.Product_ID
WHERE W.User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
AND W.ListNum = 1
ORDER BY W.ItemNum
</cfquery>

<cfparam name="attributes.currentpage" default=1>

<cfset ProdList = ValueList(qry_Get_list.Product_ID)>


