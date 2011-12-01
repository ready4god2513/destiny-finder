<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieve selected state tax rate(s). Called by shopping.admin&taxes=state--->

<cfquery name="GetTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#StateTax
WHERE Code_ID = #attributes.code_ID#
ORDER BY State
</cfquery>
