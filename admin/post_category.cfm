
<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "post_category_listing.cfm">
<cfset VARIABLES.form_return_page = "post_category.cfm">
<cfset VARIABLES.db_table_name = "Categories">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "category_id">
<cfset VARIABLES.table_title_column = "category_title">
<cfset VARIABLES.fieldslist = "category_title">

<!--- Queries to update database if form has been submitted --->

<cfif isdefined("form.submit") AND form.submit IS "Add this category">

<cfset table_title_column_value = "#form[table_title_column]#">
<cfinsert datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
<cflocation url="#VARIABLES.listing_page#?memo=new&title=#VARIABLES.table_title_column_value#">
<cfabort>
	
	
<cfelseif isdefined("form.submit") AND form.submit IS "Update this category">
<cfset VARIABLES.fieldslist = "category_id," & VARIABLES.fieldslist>
		
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
			
<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
<cfset table_primkey_value = "#form[table_primkey_name]#">
<cflocation url="#VARIABLES.form_return_page#?#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#">
<cfabort>
</cfif>

<!--- query to get existing values --->
<cfif isdefined("url.category_id") AND url.category_id NEQ "new">
<cfquery name="qCategory" datasource="#APPLICATION.DSN#" dbtype="odbc">
SELECT * FROM Categories
WHERE category_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.category_id#">
</cfquery>
</cfif>

<!--- set blank defaults for new entries --->
<cfparam name="qCategory.category_title" default="">

<cfoutput>

<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="#VARIABLES.listing_page#"><strong>&laquo; Category Listing</strong></a> </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="19%"><strong>Category Title:</strong></td>
<td width="81%"><input type="text" size="20" maxlength="100" name="category_title" value="#qCategory.category_title#" class="form_element"></td></tr>

<cfif isdefined("url.category_id") AND url.category_id EQ "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this category" class="form_element"> <input type="hidden" name="category_id" value="new" /></td></tr>
<cfelse>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this category" class="form_element"><input type="submit" name="submit" value="Delete this category" class="form_element"><input type="hidden" name="category_id" value="#qCategory.category_id#" /></td></tr>
</cfif>
</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">