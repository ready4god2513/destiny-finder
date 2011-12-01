<!--- 
Updater utility script

Sivan Leoni
Info Grafik, Inc.
www.infografik.com

It is very simple:
1. put script in a ColdFusion accessible directory
2. Input source and destination root path in the form
3. copy and paste files from the changes.txt file
4. preview
5. process
6. review the on screen log

I've only tested this with CFMX6.1.

- Sivan

 --->


<cfparam name="form.do" default="">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Web application upgrade utility</title>
</head>

<body>
<cfswitch expression="#form.do#">
  <cfdefaultcase>
	<h1>Web Application Upgrade Utility</h1>
	<form name="form1" action="updater.cfm" method="post">
	<p>
	<b>1. Destination Application Absolute Root Path (the App you want to Upgrade)</b><br/>
	<input type="text" name="DestinationRootPath" size="80"><br/>
	(i.e.  c:\inetpub\wwwroot\mystore\)
	</p>
	
	<p>
	<b>2. Source Application  Absolute Root Path (the New Version):</b><br/>
	<input type="text" name="SourceRootPath" size="80"><br/>
	(i.e.  c:\inetpub\wwwroot\cfwebstore5.1.1\)
	</p>
	<p>
	<b>Files to update:</b><br/>
	<textarea name="Files" cols="80" rows="20"></textarea><br/>
	(Separate files with a line break)
	</p>
	<p>
	The above files will be copied from Location 2 to Location 1<br/>
	<input type="submit" name="submit" value="Upgrade">
	<input type="hidden" name="do" value="preview">
	</p>
	</form>
  </cfdefaultcase>
  
  <cfcase value="preview">
  	<cfoutput>
	<form action="updater.cfm" name="form1" method="post" onsubmit="return confirm('Are you sure you want to overwrite/copy files from Source to Destination???');">
	<table border="1">
	  <tr>
	  	<td><b>Source</b> (Exists?)</td>
	  	<td><b>Destination</b> (Exists?)</td>
	  	<td><b>Action to perform</b></td>
	  	<td><b>Process?</b></td>
	  </tr>
	<cfloop list="#form.Files#" delimiters="#chr(13)##chr(10)#" index="f">
	  <cfset source = "#form.SourceRootPath##f#">
	  <cfset destination = "#form.DestinationRootPath##f#">
	  <cfset IsSourceExists = FileExists(source)>
	  <cfset IsDestExists = FileExists(Destination)>
	  <tr>
	  	<td>#source# (#IsSourceExists#)</td>
	  	<td>#Destination# (#IsDestExists#)</td>
	  	<td><cfif NOT IsSourceExists><font color="FF0000">Can't find source</font><cfelseif IsSourceExists AND NOT IsDestExists><font color="FF0000">New File</font><cfelse>Overwrite</cfif></td>
		<td><input type="checkbox" name="Files" value="#f#" checked></td>
	  </tr>
	</cfloop>
	  <tr>
	  	<td colspan="4" align="right">
			<input type="button" value="Cancel" onclick="history.go(-1)"> <input type="submit" value="Process!">
			<input type="hidden" name="do" value="process">
			<input type="hidden" name="DestinationRootPath" value="#form.DestinationRootPath#">
			<input type="hidden" name="SourceRootPath" value="#form.SourceRootPath#">
		</td>
	  </tr>
	</table>
	</form>
	</cfoutput>
  </cfcase>
  
  <cfcase value="process">
  	<cfoutput>
	<cfset log = "">
	<cfloop list="#form.files#" delimiters="," index="f">
		<cftry>
			<cffile action = "copy"	source = "#form.SourceRootPath##f#"	destination = "#form.DestinationRootPath##f#">
			<cfset log = log & "<font color=green><b>Success!</b></font> ""#form.SourceRootPath##f#"" copied to ""#form.DestinationRootPath##f#""<hr>">
		<cfcatch type="any"><cfset log = log & "<font color=red><b>ERROR:</b> </font>" & cfcatch.Message & " " & cfcatch.Detail & "<hr>"></cfcatch>
		</cftry>
	</cfloop>
	<h3>Log:</h3><hr>
	#log#
  	</cfoutput>
  </cfcase>
  
</cfswitch>
</body>
</html>
