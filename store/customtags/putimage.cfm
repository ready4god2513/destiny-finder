<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!--- 
filename is the filename of the image
filealt is the text for the alt tag
imglink is a link to be placed around the image. If blank or zero length, no link added

dirBase is an optional parameter for the base directory for images. Be sure to use this when calling the tag from headers and footers

imgBase is an optional parameter for the link to the images. Be sure to use this when calling the tag from headers and footers

Other optional parameters include:
	hspace
	vspace
	align
 --->
 
<cfparam name="attributes.filename" default="">
 
<cfif thistag.ExecutionMode is "start" AND Len(attributes.filename)>

<cfparam name="attributes.return_size" default="0">
<cfparam name="attributes.filealt" default="">
<cfparam name="attributes.imglink" default="">
<cfparam name="attributes.target" default="">
<cfparam name="attributes.border" default="0">
<cfparam name="attributes.align" default="">
<cfparam name="attributes.addbr" default="0">
<cfparam name="attributes.user" default="0">
<cfparam name="attributes.imgclass" default="">
<cfparam name="attributes.style" default="">
<cfparam name="attributes.dirBase" default="#GetDirectoryFromPath(ExpandPath("*.*"))#">
<cfparam name="attributes.imgBase" default="#request.appsettings.defaultimages#">
<!---
<cfif isDefined("CGI.path_info") AND Compare(CGI.path_info, CGI.Script_Name)>
	<cfset attributes.imgBase = Request.StoreURL & "/" & imgbase>
</cfif>
--->

<cfscript>
function doMouseover(str){ 	
	//replace any double-quotes
	var strip = Replace(str, '"', '', 'ALL');
	strip = JSStringFormat(strip);
	returnstring = 'onmouseover="dmim(''' & strip & '''); return document.returnValue;" ';
	returnstring = returnstring & 'onmouseout="dmim(''''); return document.returnValue;"';
	return returnstring;
} 
</cfscript>

<!--- Make sure slashes are in the right direction --->
<cfset attributes.imgBase = Replace(attributes.imgBase, "\", "/", "ALL")>

<!--- Make sure there is a trailing slash --->
<cfif Right(attributes.imgBase, 1) IS NOT "/">
	<cfset attributes.imgBase = attributes.imgBase & "/">
</cfif>

<cfif attributes.user IS NOT 0>
	<cfset subdir = "User#attributes.user#/">
<cfelse>
	<cfset subdir = ''>
</cfif>

<cfoutput><cfif len(attributes.imglink)><a href="#attributes.imglink#" #doMouseover(attributes.filealt)#></cfif><img src="#attributes.imgBase##subdir##attributes.filename#" border="#attributes.border#" alt="#attributes.filealt#"<cfif isDefined("attributes.hspace")> hspace="#attributes.hspace#"</cfif><cfif isDefined("attributes.vspace")> vspace="#attributes.vspace#"</cfif><cfif len(attributes.align)> align="#attributes.align#"</cfif><cfif len(attributes.imgclass)> class="#attributes.imgclass#"</cfif><cfif len(attributes.style)> style="#attributes.style#"</cfif> /><cfif len(attributes.imglink)></a></cfif><cfif attributes.addbr><br/></cfif></cfoutput>

</cfif>

