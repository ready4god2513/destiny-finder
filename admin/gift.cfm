
<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfparam name="URL.gift_type_id" default="">
<cfset VARIABLES.gift_type_id = Val(URL.gift_type_id)>
<cfset VARIABLES.listing_page = "gift_listing.cfm">
<cfset VARIABLES.form_return_page = "gift.cfm?gift_type_id=#url.gift_type_id#">
<cfset VARIABLES.db_table_name = "Gifts">

<!--- SET VARIABLES FOR DB FUNCTION --->
<cfset VARIABLES.table_primkey_name = "gift_id">
<cfset VARIABLES.table_title_column = "gift_name">
<cfset VARIABLES.fieldslist = "gift_name,gift_primary,gift_secondary,gift_brief">

<!--- Queries to update database if form has been submitted --->

<cfif isdefined("form.submit") AND form.submit IS "Add this gift">
	
<cfset table_title_column_value = "#form[table_title_column]#">

	
	<cfinsert datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">

<cflocation url="#VARIABLES.listing_page#?gift_type_id=#url.gift_type_id#&memo=new&title=#VARIABLES.table_title_column_value#">
<cfabort>
	
	
<cfelseif isdefined("form.submit") AND form.submit IS "Update this gift">
<cfset VARIABLES.fieldslist = "gift_id," & VARIABLES.fieldslist>		
		
<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
<cfset table_title_column_value = "#form[table_title_column]#">
<cflocation url="#VARIABLES.listing_page#?gift_type_id=#url.gift_type_id#&memo=updated&title=#VARIABLES.table_title_column_value#"> 
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this gift">
	<cfoutput>
#delete_step1(page_return="#VARIABLES.form_return_page#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
	<cfoutput>#delete_step2(DSN="#APPLICATION.DSN#",page_return="#VARIABLES.listing_page#",table_name="#VARIABLES.db_table_name#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>
		    
		<cfset table_title_column_value = "#form[table_title_column]#">
		<cflocation url="#VARIABLES.listing_page#?gift_type_id=#url.gift_type_id#&memo=updated&title=#VARIABLES.table_title_column_value#"> 
		<cfabort>
<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
<cfset table_primkey_value = "#form[table_primkey_name]#">
<cflocation url="#VARIABLES.form_return_page#?gift_type_id=#url.gift_type_id#&#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#">
<cfabort>
</cfif>

<!--- query to get existing values --->
<cfif isdefined("url.gift_id") AND url.gift_id NEQ "new">
<cfquery name="qGift" datasource="#APPLICATION.DSN#" dbtype="odbc">
SELECT * FROM Gifts
WHERE gift_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.gift_id#">
</cfquery>
</cfif>

<!--- set blank defaults for new entries --->
<cfparam name="qGift.gift_name" default="">
<cfparam name="qGift.gift_primary" default="">
<cfparam name="qGift.gift_secondary" default="">
<cfparam name="qGift.gift_brief" default="">
<cfoutput>

<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="#VARIABLES.listing_page#?gift_type_id=#URL.gift_type_id#"><strong>&laquo; Gift Listing</strong></a> </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="22%" valign="top"><strong>Gift Name:</strong></td>
<td width="78%"><input type="text" size="20" maxlength="100" name="gift_name" value="#qGift.gift_name#" class="form_element">
</td></tr>
<tr>
	  <td><strong> Brief Description:</strong></td>
	  <td>&nbsp;</td>
	 </tr>
	<tr>
	  <td colspan="2">

	  <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = '/editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "gift_brief";
			fckEditor.value			= '#qGift.gift_brief#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 240;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
	  </td>
   </tr>
<tr>
	  <td><strong>Primary Result:</strong></td>
	  <td>&nbsp;</td>
	 </tr>
	<tr>
	  <td colspan="2">

	  <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = '/editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "gift_primary";
			fckEditor.value			= '#qGift.gift_primary#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 300;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
	  </td>
   </tr>
   <tr>
	  <td><strong>Secondary Result:</strong></td>
	  <td>&nbsp;</td>
	 </tr>
	<tr>
	  <td colspan="2">

	  <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = '/editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "gift_secondary";
			fckEditor.value			= '#qGift.gift_secondary#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 300;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
	  </td>
   </tr>
   <cfif isdefined("url.gift_id") AND url.gift_id EQ "new">
    <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this gift" class="form_element"> <input type="hidden" name="gift_id" value="new" /></td></tr>
    <cfelse>
    <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this gift" class="form_element"><input type="submit" name="submit" value="Delete this gift" class="form_element"><input type="hidden" name="gift_id" value="#qGift.gift_id#" /></td></tr>
    </cfif>
</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">