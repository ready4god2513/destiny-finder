
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the default layout page for the store admin. Edit it as much as you desire using the components below. The default admin page includes a cascading menu using Ajax components. --->

<cfparam name="attributes.xfa_admin_link" default="">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>

<title>CFWebstore: Admin</title>

<cfinclude template="../put_meta.cfm">	

<!--- This is used to keep the user's session alive --->
<script SRC="includes/keepalive.js"></script>

<!--- Makes sure this page is not being loaded outside the admin frameset --->
<script type="text/javascript">
<cfoutput>
if( self == top ) { top.location.href = '#request.self#?fuseaction=home.admin#Request.Token2#'; }
</cfoutput>
</script>

<link href="css/adminstyle.css" rel="stylesheet" type="text/css">
	
</head>

<body  text="#333333" link="#666699" vlink="#666699" alink="#666699" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0">

<!--- THIS IS WHERE ALL GENERATED PAGE CONTENT GOES ---->
<!-- Compress to remove whitespace -->
<cfoutput>#fusebox.layout#</cfoutput>

</body></html>

