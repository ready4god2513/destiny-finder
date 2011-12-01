
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to create the breadcrumb links for the site. Call from your layout pages --->

<cfsavecontent variable="breadcrumb">
	<cfinclude template="../includes/put_parentstring.cfm">
</cfsavecontent>

<cfoutput>#HTMLCompressFormat(variables.breadcrumb)#</cfoutput>
	
