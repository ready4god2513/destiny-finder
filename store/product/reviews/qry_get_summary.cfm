<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Query for summary information about reviews for a particular product --->

<cfparam name="attributes.product_ID" default="0">

<cfquery name="qry_get_reviews" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT AVG(R.Rating) AS Avg_Rating, COUNT(R.Rating) AS Total_Ratings
FROM #Request.DB_Prefix#ProductReviews R 
WHERE R.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.product_ID#">
</cfquery>
		
