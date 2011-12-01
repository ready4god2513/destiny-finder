
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of credit cards accepted by the store. Called by users\formfields\put_ccard.cfm --->

<cfquery name="GetCards" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT CardName FROM #Request.DB_Prefix#CreditCards
WHERE USED = 1
</cfquery>



