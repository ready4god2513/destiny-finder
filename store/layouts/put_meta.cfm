<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to output the meta tags for your store. Be sure to customize for your site! Used on your layout pages. --->

<!--- Set the default metadescription and keywords --->
<cfparam name="metadescription" default="#request.appsettings.metadescription#">
<cfparam name="keywords" default="#request.appsettings.keywords#">

<meta name="Content-Type" content="text/html;CHARSET=iso-8859-1"/>
<meta name="resource-type" content="document"/>
<meta http-equiv="distribution" content="Global"/> 
<meta name="revisit" content="15 days"/>
<meta name="robots" content="index,follow,noarchive"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="-1"/>

<cfoutput>
<meta name="description" content="#metadescription#"/>
<meta name="Keywords" content="#keywords#"/>
</cfoutput>

<!--- disables image toolbar in ie6 ---->	
<meta http-equiv="imagetoolbar" content="no"/>

<!--- Use cftry/cfcatch to prevent BlueDragon errors on some pages --->
<cftry>
<cfheader name="Expires" value="#GetHttpTimeString(Now())#">
<cfheader name="Cache-Control" value="no-cache, must-revalidate">
<cfcatch type="any"></cfcatch>
</cftry>