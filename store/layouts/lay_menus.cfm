
<!--- CFWebstore�, version 6.43 --->

<!--- CFWebstore� is �Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the layout page for the entire store. Edit it as much as you desire using the components below. Your store can use more than one layout page.  Lay_default.cfm will be the site's default layout. Additional layouts can be created and named. You can attach a custom layout page to a Palette that you create in the Palette Admin. The Palette can then be assigned to an individual Category, Product, Feature, or Page. --->


<!--- This file must be included at the top of all CFWebstore layout pages! Creates the header section and additional code needed by the software --->	
<cfinclude template="put_layouthead.cfm">

<!--- Style sheet(s) for the layout --->	
<link rel="stylesheet" href="css/default.css" type="text/css" />

</head>

<!--- Code to create the DHTML menus --->
<cfinclude template="do_dhtml_menus.cfm">

<!--- Creates the body tag with background image and colors set by the palette. --->
<cfinclude template="put_body.cfm">
<table border="0" cellspacing="0" cellpadding="0" width="620">

<!--- The page has three columns: left menu, spacer, and body 
The column widths are set in this first row. Change the spacer.gif width to adjust columns.----->
<tr>  
	<td><img src="images/spacer.gif" height="1" alt="" width="120" border="0" /></td>
	<td><img src="images/spacer.gif" height="1" alt="" width="30" border="0" /></td>
	<td><img src="images/spacer.gif" height="1" alt="" width="575" border="0" /></td>
</tr>

<!--- Logo/Store title row ------------------------------->
<tr>
 <td colspan="3">
 
 <table width="100%" border="0">
  <tr>
 
  <td align="left" width="50%">
  <span style="font-size: large;">
  <cfinclude template="put_sitelogo.cfm">
  </span>
  </td>
  <td align="right" width="50%" valign="bottom">
  <!--- Output the storewide discounts and shopping cart totals --->
	<cfinclude template="put_topinfo.cfm">  

  </td> 
 </tr>
 </table>
 
 </td> 
</tr> 

<tr>
	<td colspan="3" class="menu_trail">		
	<cfoutput>#Session.TopMenus#</cfoutput>
	</td>
</tr>
<!--- Breadcrumb Trail Menu Row--------------->
<tr>
	<td rowspan="2" valign="top">
		<cfoutput>#Session.VertMenus#</cfoutput>
			<!--- Links for admins --->		
		<cfinclude template="put_adminlinks.cfm">	
		
		<!--- An optional persistent search box --->		
		<cfinclude template="put_searchbox.cfm">	
		
		<!--- An optional persistent log-in box -- the site works perfectly well without --->
		<cfinclude template="put_loginbox.cfm">	
	</td>
	<td colspan="2" class="menu_trail" valign="top">		
	<cfinclude template="put_breadcrumb.cfm"><br/>
	</td>
</tr>

<!---- Main Body Row -------->
<tr>

	<!---- SPACER COLUMN between menu and content ------->
	<td>&nbsp;</td>
	
	<!---- PAGE CONTENT ------->
	<td valign="top" class="mainpage">
	
		<!--- THIS IS WHERE ALL GENERATED PAGE CONTENT GOES ---->
		<!-- Compress to remove whitespace -->
		<cfoutput>#HTMLCompressFormat(fusebox.layout)#</cfoutput>
	
	</td>
</tr>

<!---- Footer Menus ------->
<tr>
	<td valign="top" align="right"></td>
	<td colspan="2" align="center">
		
		<p>&nbsp;</p>
		
		<!--- horizontal category and page menus --->
		<!--- <cfinclude template="put_bottommenus.cfm"> --->
		
		<!--- copyright/merchant line --->	
		<cfinclude template="put_copyright.cfm">

		
	</td>	
</tr>
</table>
		
<!--- Allow debug variables list to display only for Administrators when &debug=1 is included in URL. --->
<cfinclude template="put_debug.cfm">

</body>
</html>

	