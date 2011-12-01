<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieve selected country tax rate(s). Called by shopping.admin&taxes=country --->

<cfquery name="GetTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT T.*, C.Name 
FROM #Request.DB_Prefix#CountryTax T
INNER JOIN Countries C ON T.Country_ID = C.ID
WHERE Code_ID = #attributes.code_ID#
ORDER BY Name
</cfquery>
