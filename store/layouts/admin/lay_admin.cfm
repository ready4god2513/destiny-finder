
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the layout page for the store admin section. It uses a frameset to load a cascading menu on the left and the main admin content on the right. --->

<!--- Prevents adding session vars twice --->
<cfif FindNoCase("CFID=", cgi.query_string)>
	<cfset AddToken = "">
<cfelse>
	<cfset AddToken = Request.Token2>
</cfif>


<html>

<head>
<cfoutput>
<title>#request.AppSettings.siteName# Administration</title>

<!--- This is used to keep the user's session alive --->
<script type="text/javascript" src="includes/keepalive.js"></script>

<noscript>
	<meta http-equiv="refresh" CONTENT="0; URL=#self#?fuseaction=home.nojs#Request.Token2#">
</noscript>

</head>
<!-- frames -->
<frameset rows="88,*" border="0" frameborder="0" framespacing="0">
  <frame name="Top" src="#self#?fuseaction=home.admin&admintopbar=display#Request.Token2#" title="Upper_Nav" marginwidth="0" marginheight="0" scrolling="no" frameborder="0">
  <frameset cols="195,*">
    <frame name="AdminMenu" src="#self#?fuseaction=home.admin&adminmenu=display&xfa_admin_link=#URLEncodedFormat(cgi.query_string)##Request.Token2#" title="AdminMenu" marginwidth="0" marginheight="0" scrolling="auto" frameborder="0">
    <frame name="AdminContent" src="#self#?#cgi.query_string#&inframes=Yes#AddToken#" title="AdminContent" marginwidth="0" marginheight="0" scrolling="auto" frameborder="0">
  </frameset>
  <noframes>
	  <body>Frames not enabled.</body>
  </noframes>
</frameset>

</cfoutput>

</html>