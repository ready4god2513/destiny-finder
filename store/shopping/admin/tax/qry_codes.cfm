<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieve selected tax code(s). Called by shopping.admin&taxes=codes and other tax pages--->

<cfquery name="GetCodes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#TaxCodes
<cfif isDefined("attributes.code_ID")>
WHERE Code_ID = #attributes.code_ID#
</cfif>
ORDER BY CalcOrder, CodeName
</cfquery>
