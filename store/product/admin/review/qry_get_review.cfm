<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the selected review. Called by product.admin&review=edit|related|related_prod|copy --->

<cfquery name="qry_get_review"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT R.*, U.Username
FROM #Request.DB_Prefix#ProductReviews R 
LEFT JOIN #Request.DB_Prefix#Users U on R.User_ID = U.User_ID
WHERE Review_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Review_ID#">
</cfquery>
		
<!--- Get Item record for header --->
<cfparam name="attributes.product_ID" default="#qry_get_review.product_ID#">
	
<cfquery name="GetDetail"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT Product_ID, Name, Sm_Image, Short_Desc, User_ID FROM #Request.DB_Prefix#Products 
	WHERE Product_ID = #attributes.product_ID# 
</cfquery>		

