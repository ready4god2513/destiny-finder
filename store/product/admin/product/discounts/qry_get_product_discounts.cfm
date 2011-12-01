
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of product-level discounts and discounts for the selected product. Called by dsp_price_form.cfm to display for the selectbox for discounts --->

<cfquery name="qry_Get_Discounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Discount_ID, Name
FROM #Request.DB_Prefix#Discounts
WHERE Type3 = 0
ORDER BY Name, MinOrder
</cfquery>

<cfparam name="attributes.Product_ID" default="0">

<cfquery name="qry_Get_Prod_Discounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Discount_ID FROM #Request.DB_Prefix#Discount_Products
WHERE Product_ID = #attributes.Product_ID#
ORDER BY Discount_ID
</cfquery>

<cfset DiscountList = ValueList(qry_Get_Prod_Discounts.Discount_ID)>




