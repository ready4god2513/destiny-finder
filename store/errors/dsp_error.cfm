<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Page to display to the user when an error is encountered. Used by the default error handler --->	

<!--- Display Page ---->
<cfoutput>
<html>
	<head>
		<title>An error has been encountered.</title>
		<meta http-equiv="Content-Type" content="text/html; charset=request.charset">
		<style type="text/css">
			.title {
				font-family: Verdana, Arial, Helvetica, sans-serif;
				font-size: 16px;
				color: ##003A79;
			}
			.text {
				font-family: Verdana, Arial, Helvetica, sans-serif;
				font-size: 12px;
				line-height: 1.5em;
			}
			a {
				color: ##093765;
				text-decoration: underline;
			}
			a:hover {
				color: ##4690E9;
			}
		</style>
	</head>
	<body>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<table width="500" border="0" cellspacing="1" align="center" cellpadding="3">
			<tr>
				<td class="title">An error has been encountered.</td>
			</tr>
			<tr>
				<td class="text" style="border-top: 1px solid ##999999;">
					<p>The page you were attempting to reach has encountered an error.</p>
		    		<p>The webmaster has been notified of this issue. If the problem persists, please <a href="mailto:#Request.AppSettings.Webmaster#">send us an email</a> to let us know. Thank you.</p>
					<p><a href="javascript:window.history.go(-1)"><< GO BACK </a></p>	
					<p>&nbsp;</p>
				</td>
			</tr>
		</table>
	</body>
</html>
</cfoutput>