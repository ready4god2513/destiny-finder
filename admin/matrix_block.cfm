<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "home_matrix_listing.cfm">
<cfset VARIABLES.form_return_page = "matrix_block.cfm">
<cfset VARIABLES.db_table_name = "Home_Matrix">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "matrix_block_id">
<cfset VARIABLES.table_title_column = "matrix_block_name">

<cfset VARIABLES.field_list = "matrix_block_name,matrix_block_active,matrix_block_content">
<!--- Queries to update database if form has been submitted --->
<cfif isdefined("form.submit") AND form.submit IS "Add this block">
	
<cfinsert datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.field_list#">
<cflocation url="#VARIABLES.listing_page#?memo=new&title=#FORM.matrix_block_name#">
<cfabort>
<cfelseif isdefined("form.submit") AND form.submit IS "Update this block">
<cfset VARIABLES.field_list = "matrix_block_id," & VARIABLES.field_list>	
	
<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.field_list#">
<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#FORM.matrix_block_name#">
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this block">
	<cfoutput>#delete_step1(page_return="#VARIABLES.form_return_page#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#",additional_form_fields="content_gateway")#</cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
	<cfoutput>#delete_step2(dsn="#DSN#",page_return="#VARIABLES.listing_page#",table_name="#VARIABLES.db_table_name#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#",additional_url_vars="&gateway=#FORM.content_gateway#")#</cfoutput>
		
	<cflocation url="#VARIABLES.listing_page#?memo=deleted&title=#table_title_column_value##additional_url_vars#">
	<cfabort>
	
<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
<cfset table_primkey_value = "#form[table_primkey_name]#">
<cflocation url="#VARIABLES.form_return_page#?#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#&gateway=#FORM.content_gateway#">
<cfabort>
</cfif>


<!--- query to get existing values --->
<cfif isdefined("url.matrix_block_id") AND url.matrix_block_id NEQ "new">
<cfquery name="qBlock" datasource="#DSN#" dbtype="odbc">
SELECT * FROM Home_Matrix
WHERE matrix_block_id = #url.matrix_block_id#
</cfquery>
</cfif>

<!--- set blank defaults for new entries --->
<cfparam name="qBlock.matrix_block_name" default="">
<cfparam name="qBlock.matrix_block_content" default="">
<cfparam name="qBlock.matrix_block_active" default="1">

<cfoutput>
<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
<table border="0" width="98%" cellpadding="0" cellspacing="2" id="admincontent">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td><a href="#VARIABLES.listing_page#"><strong>&laquo; Block Listing</strong></a> </td>
  <td>&nbsp;</td>
</tr>
  <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
    <td valign="top"><span style="font-weight: bold">Name:</span>
</td>
<td><input type="text" name="matrix_block_name" size="30" maxlength="255" value="#qBlock.matrix_block_name#"><br />
	<em>For reference purposes only. This will not display to the user.</em>
</td></tr>
 <tr valign="top" <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td><strong>Active:</strong></td>
  <td> Yes <input type="radio" name="matrix_block_active" value="1" <cfif qBlock.matrix_block_active EQ 1>checked</cfif>>&nbsp;No
        <input type="radio" name="matrix_block_active" value="0" <cfif qBlock.matrix_block_active EQ 0>checked</cfif>></td>
</tr>
    <tr valign="top" <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><strong>Content:</strong><br>
  <em>[Dimensions 216 x 102]</em></td>
  </tr>
  <tr>
  <td colspan="2">  
 	 <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = '/editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "matrix_block_content";
			fckEditor.value			= '#qBlock.matrix_block_content#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 250;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
</td>
</tr>

<cfif isdefined("url.matrix_block_id") AND url.matrix_block_id IS "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this block" class="form"></td></tr>
<cfelse>
<input type="hidden" name="matrix_block_id" value="#URL.matrix_block_id#">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this block" class="form"><input type="submit" name="submit" value="Delete this block" class="form"></td></tr>
</cfif>
</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">