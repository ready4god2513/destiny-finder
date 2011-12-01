
<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "event_category_listing.cfm">
<cfset VARIABLES.form_return_page = "event_cat.cfm">
<cfset VARIABLES.db_table_name = "Event_Categories">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "event_cat_id">
<cfset VARIABLES.table_title_column = "event_cat_name">
<cfset VARIABLES.fieldslist = "event_cat_name,event_cat_active">

<!--- Queries to update database if form has been submitted --->

<cfif isdefined("form.submit") AND form.submit IS "Add this category">
	
<cfset table_title_column_value = "#form[table_title_column]#">

	
	<cfinsert datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">

<cflocation url="#VARIABLES.listing_page#?memo=new&title=#VARIABLES.table_title_column_value#">
<cfabort>
	
	
<cfelseif isdefined("form.submit") AND form.submit IS "Update this category">
<cfset VARIABLES.fieldslist = "event_cat_id," & VARIABLES.fieldslist>		
		
<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
<cfset table_title_column_value = "#form[table_title_column]#">
<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#VARIABLES.table_title_column_value#"> 
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this category">
	<cfoutput>
#delete_step1(page_return="#VARIABLES.form_return_page#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
	<cfoutput>#delete_step2(DSN="#APPLICATION.DSN#",page_return="#VARIABLES.listing_page#",table_name="#VARIABLES.db_table_name#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>
		    
		<cfset table_title_column_value = "#form[table_title_column]#">
		<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#VARIABLES.table_title_column_value#"> 
		<cfabort>
<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
<cfset table_primkey_value = "#form[table_primkey_name]#">
<cflocation url="#VARIABLES.form_return_page#?#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#">
<cfabort>
</cfif>

<!--- query to get existing values --->
<cfif isdefined("url.event_cat_id") AND url.event_cat_id NEQ "new">
<cfquery name="qCategory" datasource="#APPLICATION.DSN#" dbtype="odbc">
SELECT * FROM Event_Categories
WHERE event_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.event_cat_id#">
</cfquery>
</cfif>

<!--- set blank defaults for new entries --->
<cfparam name="qCategory.event_cat_name" default="">
<cfparam name="qCategory.event_cat_active" default="1">

<cfoutput>

<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="#VARIABLES.listing_page#"><strong>&laquo; Event Category Listing</strong></a> </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="22%" valign="top"><strong>Event Category Name:</strong></td>
<td width="78%"><input type="text" size="20" maxlength="100" name="event_cat_name" value="#qCategory.event_cat_name#" class="form_element">
<cfif URL.event_cat_id NEQ "new">
<br/>{&event_cat=#URL.event_cat_id#}
</cfif>
<input type="hidden" name="event_cat_active" value="1" />
</td></tr>
<cfif isdefined("url.event_cat_id") AND url.event_cat_id EQ "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this category" class="form_element"> <input type="hidden" name="event_cat_id" value="new" /></td></tr>
<cfelse>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this category" class="form_element"><input type="submit" name="submit" value="Delete this category" class="form_element"><input type="hidden" name="event_cat_id" value="#qCategory.event_cat_id#" /></td></tr>
</cfif>
</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">