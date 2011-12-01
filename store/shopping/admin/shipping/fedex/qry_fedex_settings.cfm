<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to update the FedEx Settings for the store. Called by shopping.admin&shipping=fedex --->

<cfquery name="GetFedEx" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT * FROM #Request.DB_Prefix#FedEx_Settings
</cfquery>

<cfquery name="GetFedExDropoff" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#FedEx_Dropoff
</cfquery>

<cfquery name="GetFedExPackages" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#FedEx_Packaging
</cfquery>


