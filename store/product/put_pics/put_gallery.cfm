<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!-----
This template puts the PRODUCT IMAGES into the products detail page. Called from dsp_product.cfm

Attributes: 
	Product_ID 		= Product_ID
	gallery			= User_images.gallery 	- Private | Public
------>

<cfparam name="attributes.Product_ID" default="">
<cfparam name="attributes.gallery" default="">
<cfparam name="attributes.Prod_User" default="0">

<cfset dirBase = GetDirectoryFromPath(ExpandPath("*.*"))>
<cfset self=caller.self>

<!--- if the product is created by a specific user, add the subdirectory --->
<cfif attributes.Prod_User IS NOT 0>
	<cfset subdir = "User#attributes.Prod_User#/">
<cfelse>
	<cfset subdir = "">
</cfif>

<!--- Get Images ---->

<cfquery name="qry_Get_photos" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT *
	FROM #Request.DB_Prefix#Product_Images
	WHERE Product_ID = <cfqueryparam value="#attributes.Product_ID#" cfsqltype="CF_SQL_INTEGER">
	<cfif attributes.gallery is not "">
		AND Gallery = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.gallery#">
	</cfif>
	ORDER BY Priority
</cfquery>


<cfif qry_get_photos.recordcount>

<div id="showimage"></div>


	<cfparam name="attributes.SectionTitle" default="#attributes.gallery# Gallery">

	<cfif len(attributes.SectionTitle)>
		<cfmodule template="../../customtags/putline.cfm" linetype="thin">
				
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<tr>
			<td class="section_title"><cfoutput>#attributes.SectionTitle#</cfoutput></td>
			<td align="right" class="FormTextVerySmall">(click photo to enlarge)</td>
		</tr>
		<tr><td colspan="2"><img src="images/spacer.gif" height="10" alt="" /></td></tr>
		</table>

	</cfif>


<cfloop query="qry_get_photos">
	
	<!--- Check for subdirectory --->
	<cfif ListLen(image_file,"/") GT 1>
		<cfset imagename = ListLast(image_file,"/")>
		<cfset smimagename = ListSetat(image_file, ListLen(image_file,"/"), "sm_#imagename#", "/")>
	<cfelse>
		<cfset smimagename = "sm_#image_file#">
	</cfif>

	<cfoutput><a href="#request.appsettings.defaultimages#/#subdir#products/#image_file#" rel="thumbnail" title="#Caption#" onmouseover=" window.status='Click to open picture in new window'; return true" onmouseout="window.status=' '; return true"><img src="#request.appsettings.defaultimages#/#subdir#products/#smimagename#" alt="" border="0" class="gallery_img" /></a></cfoutput>

</cfloop>
<br/><br/>
</cfif><!--- recordcount --->