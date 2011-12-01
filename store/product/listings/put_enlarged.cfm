<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page provides a link to the popup DOMinclude image ---->

<!--- Determine the Image link --->

<cfset imagepath = Request.AppSettings.DefaultImages>

<!--- if the product is created by a specific user, add the subdirectory --->
<cfif qry_get_products.User_ID IS NOT 0>
	<cfset imagepath = imagepath & "\User#qry_get_products.User_ID#">
</cfif>

<cfset imagefile = imagepath & "\" & qry_get_products.Enlrg_Image>

<!--- Put DOMInclude files in the header --->
<cfhtmlhead text='<link rel="STYLESHEET" href="includes/dominclude/DOMinclude.css" type="text/css">'>
<cfhtmlhead text='<script type="text/javascript" src="includes/dominclude/DOMinclude_config.js"></script>'>
<cfhtmlhead text='<script type="text/javascript" src="includes/dominclude/DOMinclude.js"></script>'>

<!--- Output the popup link --->
<cfoutput><div align="center"><a href="#imagefile#" class="DOMpop">Enlarge</a></div></cfoutput>