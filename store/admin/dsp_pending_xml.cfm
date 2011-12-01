<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to create an XML file with the pending counts to update the admin menu --->

<cfsetting showdebugoutput="No">

<cftry>
<cfset SpryData = Application.objMenus.doSpryData()>

<cfcontent type="text/xml">
<cfoutput>#SpryData#</cfoutput>
	
<cfcatch type="ANY">
	Store is reloading the CFC objects
</cfcatch>
</cftry>

