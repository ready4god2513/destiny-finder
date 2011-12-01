<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>

<cfset obj_story = CreateObject("component","cfcs.story")>

<cfif isDefined('FORM.submit') AND FORM.submit EQ "Post Story">
	<cfset VARIABLES.log_story = obj_story.log_story()>
	<!--- <cflocation url="index.cfm" addtoken="no">  --->
</cfif>

<cfoutput>
<form action="write_story.cfm" method="post">
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="60">Title:</td>
    <td width="540">
		<input type="text" name="story_title" size="20">
		<input type="hidden" name="story_date" value="#DateFormat(NOW(),'yyyy-mm-dd')#">
	</td>
  </tr>
  <tr>
    <td>Story:</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">
		<cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = '/editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "story_content";
			fckEditor.value			= '';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 500;
			fckeditor.ToolbarSet = "Basic";
			fckEditor.create(); // create the editor.
		</cfscript>
	</td>
  </tr>
  <tr>
    <td colspan="2">
		<input type="submit" name="submit" value="Post Story">
	</td>
  </tr>
</table>
</form>
</cfoutput>


</body>
</html>
