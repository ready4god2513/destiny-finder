<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- The web page title is set dynamically to match category, page, product or feature name/title. Proper web page titles are important for search engine placement and ranking. --->

<!--- This layout is used for pages where no menus or other page elements are desired, generally for printable pages. You can customize this page with your own header or footer --->

<!--- This file must be included at the top of all CFWebstore layout pages! Creates the header section and additional code needed by the software --->	
<cfinclude template="put_layouthead.cfm">

<!--- Style sheet(s) for the layout --->
<cfif fusebox.fuseaction is "admin">
	<link rel="stylesheet" href="css/adminstyle.css" type="text/css"/>
<cfelse>
	<link rel="stylesheet" href="css/default.css" type="text/css"/>
</cfif>
	
</head>

<!--- Creates the body tag with background image and colors set by store. --->
<cfinclude template="put_body.cfm">

	
		<!--- THIS IS WHERE ALL GENERATED PAGE CONTENT GOES ---->
		<!-- Compress to remove whitespace -->
		<cfoutput>#HTMLCompressFormat(fusebox.layout)#</cfoutput>
	
	
</body>
</html>

	