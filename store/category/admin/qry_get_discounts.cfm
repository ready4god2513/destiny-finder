
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Get the list of discounts for categories, called from dsp_category_form.cfm --->

<cfquery name="qry_Get_Discounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Discount_ID, Name 
FROM #Request.DB_Prefix#Discounts
WHERE Type3 = 1 
ORDER BY Name, MinOrder
</cfquery>




