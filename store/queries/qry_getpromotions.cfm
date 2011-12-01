
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This query retrieves the promotions for the site. The query is cached for better performance. Used throughout the site to calculate promotions, and is called to refresh the query whenever promotions are modified. --->

<cfquery name="GetPromotions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#"  cachedwithin="#Request.Cache#">
SELECT P.*, Pt.Base_Price AS ProdPrice 
FROM #Request.DB_Prefix#Promotions P
LEFT OUTER JOIN #Request.DB_Prefix#Products Pt ON P.Disc_Product = Pt.Product_ID
ORDER BY QualifyNum 
</cfquery>



