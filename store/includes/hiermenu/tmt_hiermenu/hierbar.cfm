<cfsetting enablecfoutputonly="true">
<!--- Ensure this file gets compiled using iso-8859-1 charset --->
<cfprocessingdirective pageencoding="iso-8859-1">
<!--- 
/**
* ColdFusion custom tag: "hierbar"
  Must be used as a container for the "hiermenu" and "hieritem" tags.
  Display a minimalist, CSS based, menu. 
  The output is fully XHTML complainant and works fine if served using an XHTML mime-type.
  The tag requires ColdFusion Server 6.1 or more. 
  The menu has been tested with IE 5+ (Win), Mozilla 1.x and Safari 1.x
* Copyright © 2004 Massimocorner.com 
* @author       Massimo Foti (massimo@massimocorner.com)
* @version      1.1, 2005-04-05
* @param        css       Optional. The name of CSS file. Default to "flat_blue.css"
* @param        class     Optional. The class attribute of the <div> tag. Default to "tmtHierbar"
* @param        id        Optional. The id attribute of the <div> tag. Default to none
* @param        target    Optional. This attribute affects all the child menu items, unless child tags overwrite it. 
  If you want to specify a target attribute for the whole menu you may consider using a base tag like: <base target="myTarget" />. 
  Default to none
* @param        width     Optional. The width in pixel of menu. 
  It's better practice to avoid using this attribute and define dimensions inside the CSS file instead.
  Default to none
 */
--->

<cfif thisTag.executionMode IS "start">
	
	<cfinclude template="getRelativePath.cfm">
	
	<cfparam name="attributes.css" type="string" default="flat_blue.css">
	<cfparam name="attributes.class" type="string" default="tmtHierbar">
	<cfparam name="attributes.id" type="string" default="">
	<cfparam name="attributes.width" type="numeric" default="0">
	<cfparam name="attributes.target" type="string" default="">
	
	<cfscript>
	// Paths
	localPath = GetDirectoryFromPath(getRelativePath(GetBaseTemplatePath(),GetCurrentTemplatePath()));
	cssPath = localPath & "css/" & attributes.css;
	jsPath = localPath & "tmt_hiermenu.js";
	jsTag = '<script src="#jsPath#" type="text/javascript"></script>';
	cssTag = chr(13) & chr(10) & '<link href="#cssPath#" rel="stylesheet" type="text/css" />' & chr(13) & chr(10);
	// HTML attributes
	classStr = "";
	idStr = "";
	styleStr = "";
	if(attributes.class NEQ ""){
		classStr = ' class="#attributes.class#"';
	}
	if(attributes.id NEQ ""){
		idStr = ' id="#attributes.id#"';
	}
	if(attributes.width NEQ 0){
		styleStr = ' style="width: #attributes.width#px;"';
	}	
	// Initialize the struct that contains paths for CSS and JavaScript files
	if(NOT StructKeyExists(request, "tmt_hierMenu")){
		request.tmt_hierMenu = StructNew();
	}	
	// Initialize the struct that contains paths for CSS files
	if(NOT StructKeyExists(request.tmt_hierMenu, "cssPaths")){
		request.tmt_hierMenu.cssPaths = StructNew();
	}
	</cfscript>

	<!--- CSS file is missing --->
	<cfif NOT FileExists(ExpandPath(cssPath))>
		<cfthrow message="hierbar: unable to locate CSS file at #cssPath#" type="hierbar">
	</cfif>

	<!--- Link to the CSS file directely inside the head just one time --->
	<cfif NOT StructKeyExists(request.tmt_hiermenu.cssPaths, attributes.css)>
		<cfhtmlhead text="#cssTag#">
		<!--- Set a flag inside the request scope --->
		<cfset StructInsert(request.tmt_hiermenu.cssPaths, attributes.css, true)>
	</cfif>

	<!--- Insert the relevant JavaScript code directely inside the head just one time --->
	<cfif NOT StructKeyExists(request.tmt_hiermenu, "jsTag")>
		<cfhtmlhead text="#jsTag#">
		<!--- Set a flag inside the request scope --->
		<cfset request.tmt_hiermenu.jsTag=true>
	</cfif>

	<cfoutput><div#classStr##idStr##styleStr#>
	<ul>#thisTag.generatedContent#</cfoutput>
</cfif>
<cfif thisTag.executionMode IS "end">
	<cfoutput>
	</ul>
</div></cfoutput>
</cfif>
<cfsetting enablecfoutputonly="no">