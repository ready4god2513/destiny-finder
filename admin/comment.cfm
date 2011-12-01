
<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "comments_listing.cfm">
<cfset VARIABLES.form_return_page = "comment.cfm">
<cfset VARIABLES.db_table_name = "Comments">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "comment_id">
<cfset VARIABLES.table_title_column = "comment_name">
<cfset VARIABLES.fieldslist = "comment_approved,comment_content,comment_name">

<!--- Queries to update database if form has been submitted --->


<cfif isdefined("form.submit") AND form.submit IS "Update this comment">
<cfset VARIABLES.fieldslist = "comment_id," & VARIABLES.fieldslist>		
<cfoutput>#VARIABLES.fieldslist#</cfoutput>
<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
<cfset table_title_column_value = "#form[table_title_column]#">
<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#VARIABLES.table_title_column_value#"> 
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this comment">
	<cfoutput>
#delete_step1(page_return="#VARIABLES.form_return_page#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
	<cfoutput>#delete_step2(DSN="#APPLICATION.DSN#",page_return="#VARIABLES.listing_page#",table_name="#VARIABLES.db_table_name#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>
	<cflocation url="#VARIABLES.listing_page#?memo=deleted&title=#VARIABLES.table_title_column_value#"> 

			
<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
<cfset table_primkey_value = "#form[table_primkey_name]#">
<cflocation url="#VARIABLES.form_return_page#?#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#">
<cfabort>
</cfif>

<!--- query to get existing values --->
<cfif isdefined("url.comment_id")>
<cfquery name="qComment" datasource="#APPLICATION.DSN#" dbtype="odbc">
SELECT * FROM Comments
WHERE comment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.comment_id#">
</cfquery>
</cfif>


<cfoutput>

<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="#VARIABLES.listing_page#"><strong>&laquo;Comment Listing</strong></a> </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="19%"><strong>Comment Name:</strong></td>
<td width="81%"><input type="text" size="20" name="comment_name" value="#qComment.comment_name#" class="form_element">&nbsp;&nbsp;IP: #qComment.comment_ip#</td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="19%"><strong>Comment Date:</strong></td>
<td width="81%"><em>#DateFormat(qComment.comment_date,'mm-dd-yyyy')# #TimeFormat(qComment.comment_date,'h:dd tt')#</em></td></tr>
 <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Approved:</strong></td><td>Yes: <input type="radio" name="comment_approved" value="1" <cfif qComment.comment_approved IS 1>checked</cfif>>&nbsp;No:<input type="radio" name="comment_approved" value="0" <cfif qComment.comment_approved IS 0>checked</cfif>> 
  (If yes, this comment will be for public viewing.)</td>
</tr>
 <tr>
	  <td><strong>Comment:</strong></td>
	  <td>&nbsp;</td>
	 </tr>
	<tr>
	  <td colspan="2">
	
	  <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = 'editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "comment_content";
			fckEditor.value			= '#qComment.comment_content#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 300;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
	  </td>
	  </tr>

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this comment" class="form_element"><input type="submit" name="submit" value="Delete this comment" class="form_element"><input type="hidden" name="comment_id" value="#qComment.comment_id#" /></td></tr>

</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">