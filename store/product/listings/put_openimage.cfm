<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page provides and alternate way to display the large product photo. It will display the small image and allow customers to click it to view the large image. This can be used on the product detail page OR on any of the product listing pages.

To use on the PRODUCT DETAIL PAGE, just replace the following code (around line 36):

<cfmodule template="../../customtags/putimage.cfm" filename="#qry_get_products.Lg_Image#" filealt="#qry_get_products.Name#">

With:

<cfinclude template="put_openimage.cfm">

----->

<!--- Open Photo in New Layer Code --->

<!--- Output Small Image:
HREF opens large image in a new window. This will be used if the layer code does not work for some reason. ---->

<!--- if the product is created by a specific user, add the subdirectory --->
<cfif qry_get_products.User_ID IS NOT 0>
	<cfset subdir = "User#qry_get_products.User_ID#/">
<cfelse>
	<cfset subdir = "">
</cfif>

<div class="formtextsmall" align="center">
<cfoutput><a href="#request.appsettings.defaultimages#/#subdir##qry_get_products.Enlrg_Image#" rel="thumbnail" title="#JSStringFormat(Replace(qry_get_products.Name, '"', '', 'ALL'))#" onmouseover=" window.status='Click to open picture in new window'; return true" onmouseout="window.status=' '; return true"><img src="#request.appsettings.defaultimages#/#subdir##prodImage#" alt="" border="0" /></a></cfoutput>
<br/>click for larger view</div>

