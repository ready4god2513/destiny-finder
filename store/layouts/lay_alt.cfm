<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This file must be included at the top of all CFWebstore layout pages! Creates the header section and additional code needed by the software --->	
<cfinclude template="put_layouthead.cfm">

<!--- Style sheet(s) for the layout --->
<link rel="stylesheet" href="css/alt.css" type="text/css"/>
	
</head>


<cfinclude template="put_body.cfm">


<table border="0" cellspacing="0" cellpadding="0" width="620">

<tr> 
	<td><img height="1" alt="" src="images/spacer.gif" width="70" border="0" /></td>
	<td><img height="1" alt="" src="images/spacer.gif" width="130" border="0" /></td>
	<td><img height="1" alt="" src="images/spacer.gif" width="20" border="0" /></td>
	<td><img height="1" alt="" src="images/spacer.gif" width="570" border="0" /></td>
</tr>

<!--- Logo/Store title row ------------------------------->
<tr>
	<td></td>
	<td height="50" colspan="3">
		<a href="<cfoutput>#self##Request.Token1#</cfoutput>">
		<img src="images/cfwebstore_hand.gif" alt="" border="0" /></a>
	</td>
</tr>

<!--- Breadcrumb Trail Menu Row--------------->
<tr>
	<td></td>
	<td></td>
	<td colspan="2">
	<cfinclude template="put_breadcrumb.cfm">
	</td>
</tr>

<!---- SPACER ROW below trail menu ------->
<tr> 
    <td colspan="4"><img height="20" src="images/spacer.gif" alt="" width="1" border="0" /></td>
</tr>

<tr>
	<!---- MENU COLUMN------->
	<td></td>
	<td valign="top" align="left" class="menu_page">
				
		<!--- Menu of Top Level Categories and Pages ---->
		<cfinclude template="put_sidemenus.cfm">
				
		<!--- Links for admins --->		
		<cfinclude template="put_adminlinks.cfm">			
			
	</td>
	
	<!---- SPACER COLUMN------->
	<td>&nbsp;</td>
	
	<!---- PAGE CONTENT ------->
	<td valign="top" class="mainpage">
	
		<!-- Compress to remove whitespace -->
		<cfoutput>#HTMLCompressFormat(fusebox.layout)#</cfoutput>	
	
	</td>
</tr>

<!---- Footer Menus ------->
<tr>
	<td></td>
	<td valign="top"></td>
	<td colspan="2" align="center">
		
		<p>&nbsp;</p>
		
		<!--- horizontal category and page menus --->
		<cfinclude template="put_bottommenus.cfm">
			
			<!--- copyright/merchant line --->	
			<cfinclude template="put_copyright.cfm">
			
	</td>	
</tr>
</table>
		
<!--- Allow debug variables list to display only for Administrators when &debug=1 is included in URL. --->
<cfinclude template="put_debug.cfm">
	
</body>
</html>

	