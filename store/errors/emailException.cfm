<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called when an Exception Error occurs. It automatically emails the site webmaster and displays an error message. This page is defined on fbx_settings.cfm by adding the following bit of code to the Error Handler section:

	<cferror type="EXCEPTION" TEMPLATE="errors/emailException.cfm"
		MAILTO="#request.appsettings.webmaster#"> 

--->

<!--- Replaced by new errorhandler, this can be used when less information is needed. --->

<cfif 
	not findNoCase('NetResearchServer(http://www.look.com)', cgi.http_user_agent) and
	not findNoCase('Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)', cgi.http_user_agent) and
	not findNoCase('SurveyBot/2.3 (Whois Source)', cgi.http_user_agent) and
	not findNoCase('ia_archiver', cgi.http_user_agent) and 
	not findNoCase('Mozilla/2.0 (compatible; Ask Jeeves/Teoma)', cgi.http_user_agent) and 
	not findNoCase('NPBot (http://www.nameprotect.com/botinfo.html)', cgi.http_user_agent) and
	not findNoCase('FAST-WebCrawler', cgi.http_user_agent) and
	not findNoCase('google', cgi.http_user_agent) and
	not findNoCase('msn', cgi.http_user_agent)>
	
	<cfsavecontent variable="myErrorPage">
		<cfoutput>
			<table width="100%" cellpadding="5" cellspacing="0" border="0">
				<tr>
					<td><font face="verdana" size="2"><strong>Diagnostics:</strong><br/>#ERROR.Diagnostics#</font></td>
				</tr>
				<tr>
					<td><font face="verdana" size="2"><strong>Date/Time:</strong><br/>#ERROR.DateTime#</font></td>
				</tr>
				<tr>
					<td><font face="verdana" size="2"><strong>Browser:</strong><br/>#ERROR.Browser#</font></td>
				</tr>
				<tr>
					<td><font face="verdana" size="2"><strong>Remote Address:</strong><br/>#ERROR.RemoteAddress#</font></td>
				</tr>
				<tr>
					<td><font face="verdana" size="2"><strong>HTTP Referrer:</strong><br/>#ERROR.HTTPReferer#</font></td>
				</tr>
				<tr>
					<td><font face="verdana" size="2"><strong>Template:</strong><br/>#ERROR.Template#</font></td>
				</tr>
				<tr>
					<td><font face="verdana" size="2"><strong>Query String:</strong><br/>#ERROR.QueryString#</font></td>
				</tr>
			</table>
		</cfoutput>
		<br/>
		<cfdump var="#cgi#"><br/>
		<cfdump var="#error#"><br/>
	</cfsavecontent>
	
	<cfmail to="#ERROR.MailTo#" from="#ERROR.MailTo#"
	subject="Web Page Exception Error" type="html"
	server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
	#myErrorPage#
	</cfmail>
</cfif>		
	
<cfoutput>
<!--- Display Page ---->
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