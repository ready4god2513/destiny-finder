<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to save the USPS Settings for the store. Called by shopping.admin&shipping=usps --->

<cfquery name="UpdUSPS" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#USPS_Settings
SET UserID = '#Trim(attributes.Userid)#',
Server = '#Trim(attributes.Server)#',
MerchantZip = '#attributes.MerchantZip#',
MaxWeight = #attributes.MaxWeight#,
UseAV = #attributes.UseAV#,
Logging = #attributes.Logging#,
Debug = #attributes.Debug#
</cfquery>

<!--- Update Cached Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfset Application.objShipping.getUSPSSettings()>

