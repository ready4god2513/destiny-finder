

<cfif isDefined('FORM.submit') AND FORM.submit EQ "Post Comment">
<cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
  <cfif Cffp.testSubmission(form)>
		<cfset obj_comments = CreateObject("component","site_modules.blog.cfcs.comments")>
		<cfset VARIABLES.log_comment = obj_comments.log_comment()>
		<!--- <cflocation url="index.cfm" addtoken="no">  --->
	</cfif>
</cfif>


<cfoutput>
<form action="#CGI.SCRIPT_NAME#?blog_id=#URL.blog_id#&comment=1" method="post">
	<cfinclude template="/cfformprotect/cffp.cfm">
	<table width="400" border="0" cellspacing="0" cellpadding="0" class="table_reset">
	  <tr>
		<td width="84" class="form_label">Name:</td>
		<td width="316">
			<input type="text" name="comment_name" size="20">
			<input type="hidden" name="comment_blog_id" value="#URL.blog_id#">
			<input type="hidden" name="comment_date" value="#NOW()#">
		</td>
	  </tr>
	  <tr>
		<td class="form_label" valign="top">Email:</td>
		<td><input type="text" name="comment_email" size="20">
		<Br/><em>Your email will not be shared or visible to the public.</em></td>
	  </tr>
	  <tr>
		<td class="form_label" valign="top">Comment:</td>
		<td>
		<cfscript>
					// Calculate basepath for FCKeditor. It's in the folder right above _samples
				
					basePath = '/editor/';
					fckEditor = createObject("component", "#basePath#fckeditor");
					fckEditor.instanceName	= "comment_content";
					fckEditor.value			= '';
					fckEditor.basePath		= basePath;
					fckEditor.width			= 350;
					fckEditor.height		= 175;
					fckeditor.ToolbarSet = "Basic";
					fckEditor.create(); // create the editor.
				</cfscript>
		</td>
	  </tr>
	  <tr>
	    <td colspan="2">
			<div align="center">
			  
	          </div></td>
      </tr>
	   <tr>
	    <td colspan="2">
			<div align="center">
			  <input type="submit" name="submit" value="Post Comment">
		      </div></td>
      </tr>
	</table>

</form>
</cfoutput>