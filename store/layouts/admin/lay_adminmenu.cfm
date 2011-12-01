
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the default layout page for the store admin. Edit it as much as you desire using the components below. The default admin page includes a cascading menu using Spry components. --->

<!--- http://labs.adobe.com/technologies/spry/Docs.html --->

<!--- NOTE: see the bottom of the put_admin_menu.cfm page for the init() function for the accordion tags
Tabs are initialized using a setting for which tab menu starts in the open state --->

<cfsetting showdebugoutput="No">

<cfparam name="attributes.xfa_admin_link" default="">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- Copyright (c) 2006. Adobe Systems Incorporated. All rights reserved. -->
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<html>
<head>

<title>CFWebstore: Admin Menu</title>

<!--- Makes sure this page is not being loaded outside the admin frameset --->
<script type="text/javascript">
<cfoutput>
if( self == top ) { top.location.href = '#request.self#?fuseaction=home.admin#Request.Token2#'; }
</cfoutput>
</script>

<cfinclude template="../put_meta.cfm">	
<cfinclude template="put_tooltips.cfm">

<!--- Required to use the whitespace suppression --->
<cfinclude template="../../includes/puthtmlcompress.cfm">

<!--- This is used to keep the user's session alive --->
<script SRC="includes/keepalive.js"></script>

<!-- Begin Spry Includes -->
<script type="text/javascript" src="includes/spry/xpath.js"></script>
<script type="text/javascript" src="includes/spry/SpryData.js"></script>
<script type="text/javascript" src="includes/spry/SpryAccordion.js"></script>
<!-- End Spry Includes -->

<script type="text/javascript">
	<cfoutput>
	var txtPending = new Spry.Data.XMLDataSet("#self#?fuseaction=home.admin&adminxml=do#Request.Token2#&redirect=yes", "PendingItems", { useCache:  false, loadInterval: 10000 });
	</cfoutput>
</script> 
 
<link href="css/SpryAccordion.css" rel="stylesheet" type="text/css" />
<link href="css/adminstyle.css" rel="stylesheet" type="text/css" />

</head>

<body  bgcolor="#68286B" text="#333333" link="#666699" vlink="#666699" alink="#666699" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init();">

<table border="0" CELLSPACING="0" CELLPADDING="0" width="195">
<tr>
<td align="center" valign="top">

<!--- THIS IS WHERE ALL GENERATED PAGE CONTENT GOES ---->
<!-- Compress to remove whitespace -->
<cfoutput>#HTMLCompressFormat(fusebox.layout)#</cfoutput>
	</td>
</tr>
</table>	

<cfprocessingdirective suppresswhitespace="No">
<script type="text/javascript">
////////////////  GLOBAL TOOLTIP CONFIGURATION  /////////////////////
var ttBgColor     = "#ECDEEC";
var ttBorderColor = "#68286B";
var ttFontColor   = "#68286B";
var ttFontFace    = "arial,helvetica,sans-serif";
var ttFontSize    = "10px";
var ttFontWeight  = "normal";     // alternative: "bold";
var ttShadowColor = "#CCCCCC";
var ttShadowWidth = 2;
var ttSticky      = false;        // do NOT hide tooltip on mouseout? Alternative: true
var ttTextAlign   = "left";
var ttWidth       = 165;
////////////////////  END OF TOOLTIP CONFIG  ////////////////////////
</script>

<script type="text/javascript" src="includes/tooltips/wz_tooltip.js"></script>
</cfprocessingdirective>

	</body>
</html>

