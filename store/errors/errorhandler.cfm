<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- A bare bones error handler that displays a form for the user to submit the error to the webmaster. --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>OOPS!</title>
</head>

<body>

<h2>OOPS!</h2>
<blockquote>

An error was encountered when trying to load this page. Click the BACK button on your browser, and try again; usually you will be able to continue without difficulty the second time. If however, you once again find yourself on this page, please fill out the following form to notify us that you had a problem. <p>

Our apologies for any problems you are having; please be patient while we work out any kinks in our new store!<p>

</blockquote>

<h2>Submit an Error Report</h2>

<cfoutput>
<blockquote>
<form action="index.cfm?fuseaction=home.senderror" method="post">
<input type="hidden" name="DateTime" value="#Error.DateTime#"/>
<input type="hidden" name="Browser" value="#Error.Browser#"/>
<input type="hidden" name="HTTPReferer" value="#Error.HTTPReferer#"/>
<input type="hidden" name="Template" value="#Error.Template#"/>
<input type="hidden" name="QueryString" value="#Error.QueryString#"/>
<table>
<tr>
	<td>Your name:</td>
	<td><input type="text" name="Name" size="25"/></td>
</tr>
<tr>
	<td>Your email:</td>
	<td><input type="text" name="Email" size="25"/></td>
</tr>
<tr>
	<td valign="top">Description of what you were trying to do:</td>
	<td><textarea cols=25 rows=5 name="Description" wrap="virtual">
	</textarea></td>
</tr>
<tr>
	<td valign="top">This box contains the error information<br/>
	 from the server, please leave as is.</td>
	<td><textarea cols=20 rows=1 name="Diagnostics" wrap="virtual">#Error.Diagnostics#
	</textarea></td>
</tr>
<tr><td></td><td><input type="submit" value="Submit Error Report"/></td></tr>
</table>
</form>
</cfoutput>

</blockquote>

</body>
</html>
