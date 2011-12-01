<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- The web page title is set dynamically to match category, page, product or feature name/title. Proper web page titles are important for search engine placement and ranking. --->

<!--- This file must be included at the top of all CFWebstore layout pages! Creates the header section and additional code needed by the software --->	
<cfinclude template="../put_layouthead.cfm">

<!--- Style sheet(s) for the layout --->
<link rel="stylesheet" href="css/adminstyle.css" type="text/css">

<!--- Makes sure this page is not being loaded outside the admin frameset --->
<script type="text/javascript">
<cfoutput>
if( self == top ) { top.location.href = '#request.self#?fuseaction=home.admin#Request.Token2#'; }
</cfoutput>
</script>

<noscript>
	<cfoutput><meta http-equiv="refresh" CONTENT="0; URL=#self#?fuseaction=home.nojs#Request.Token2#"></cfoutput>
</noscript>

<!--- Include color picker color for Color Palette page --->
<cfif isDefined("attributes.Colors") AND isDefined("attributes.Color_ID")>
	<link rel="stylesheet" href="css/default.css" type="text/css">
	<cfinclude template="../../includes/colorpicker/colorpicker_head.cfm">
	</head>
	<body  text="#333333" link="#666699" vlink="#666699" alink="#666699" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="colorinit();">
	
<cfelse>
	</head>
	
	<!--- Creates the body tag with background image and colors set by store. --->
	<body  text="#333333" link="#666699" vlink="#666699" alink="#666699" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

</cfif>
		
		<div class="admincontent">
	
		<!--- THIS IS WHERE ALL GENERATED PAGE CONTENT GOES ---->
		<!-- Compress to remove whitespace -->
		<cfoutput>#HTMLCompressFormat(fusebox.layout)#</cfoutput>
	</div>
	<br/><br/>&nbsp;<br/>
	
</body>
</html>

	