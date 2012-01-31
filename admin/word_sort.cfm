<cfset objAssessment  = CreateObject("component","admin.cfcs.assessment")>
<cfif isDefined("form.gift_type_id")>
	<cfset URL.gift_type_id = form.gift_type_id>
</cfif>
<cfset qGifts = objAssessment.retrieve_gifts(gift_type_id=#URL.gift_type_id#)>

<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "assessment.cfm?assessment_id=#URL.assessment_id#&gift_type_id=#qGifts.gift_type_id#">
<cfset VARIABLES.form_return_page = "word_sort.cfm?assessment_id=#URL.assessment_id#&gift_type_id=#qGifts.gift_type_id#">
<cfset VARIABLES.db_table_name = "sort">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "sort_id">
<cfset VARIABLES.table_title_column = "sort_name">
<cfset VARIABLES.fieldslist = "sort_name,sort_name_alt,sort_words,sort_active">

<!--- Queries to update database if form has been submitted --->

<cfif isdefined("form.submit") AND form.submit IS "Add this word sort">
	<cfset table_title_column_value = "#form[table_title_column]#">
	<cfset FORM.sort_words = objAssessment.prepare_words_for_insert(gift_recordcount=qGifts.recordcount)>
	<cfinsert datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
	<cfquery name="qMax" datasource="#APPLICATION.DSN#" maxrows="1">
		SELECT sort_id 
		FROM sort
		ORDER BY sort_id DESC
	</cfquery>
	<cfset VARIABLES.insert_item = objAssessment.insert_assessment_item(item_type="1",item_type_id="#qMax.sort_id#",assessment_id="#URL.assessment_id#")>
	<cflocation url="#VARIABLES.listing_page#&memo=new&title=#URLEncodedFormat(VARIABLES.table_title_column_value)#">
<cfabort>
	
<cfelseif isdefined("form.submit") AND form.submit IS "Update this word sort">
	<cfset VARIABLES.fieldslist = "sort_id," & VARIABLES.fieldslist>		
	<cfset FORM.sort_words = objAssessment.prepare_words_for_insert(gift_recordcount=qGifts.recordcount)>
	<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
	<cfset table_title_column_value = "#form[table_title_column]#">
	<cflocation url="#VARIABLES.listing_page#&memo=updated&title=#VARIABLES.table_title_column_value#"> 
	<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this word sort">
	<cfoutput>#delete_step1(page_return="#VARIABLES.form_return_page#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>
	<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
	<cfoutput>
		#delete_step2(DSN="#APPLICATION.DSN#",page_return="#VARIABLES.listing_page#",table_name="#VARIABLES.db_table_name#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#
		#objAssessment.delete_assessment_item(item_type_id="#FORM.sort_id#",item_type="1")#
	</cfoutput>

	<cfset table_title_column_value = "#form[table_title_column]#">
	<cflocation url="#VARIABLES.listing_page#&memo=updated&title=#VARIABLES.table_title_column_value#"> 
	<cfabort>
	
<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
	<cfset table_primkey_value = "#form[table_primkey_name]#">
	<cflocation url="#VARIABLES.form_return_page#?#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#">
	<cfabort>

</cfif>

<!--- query to get existing values --->
<cfif isdefined("url.sort_id") AND url.sort_id NEQ "new">
	<cfquery name="qSort" datasource="#APPLICATION.DSN#" dbtype="odbc">
		SELECT * FROM Sort
		WHERE sort_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.sort_id#">
	</cfquery>
</cfif>

<!--- set blank defaults for new entries --->
<cfparam name="qSort.sort_name" default="">
<cfparam name="qSort.sort_name_alt" default="">
<cfparam name="qSort.sort_active" default="1">
<cfparam name="qSort.sort_words" default="">

<cfif LEN(qSort.sort_words) GT 0>
	<cfset qSort.sort_words = DeserializeJSON(qSort.sort_words)>
<cfelse>
	<cfset qSort.sort_words = ArrayNew(2)>
	<cfloop from="1" to="#qGifts.recordcount#" index="i">
		<cfset qSort.sort_words[1][i][1] = "#qGifts.gift_id[i]#">
		<cfset qSort.sort_words[1][i][2] = "">
	</cfloop>
</cfif>

<cfoutput>
<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="#VARIABLES.listing_page#"><strong>&laquo; Return To Assessment</strong></a> </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="22%" valign="top"><strong>Sort Name:</strong></td>
<td width="78%"><input type="text" size="20" maxlength="100" name="sort_name" value="#qSort.sort_name#" class="form_element">
</td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="22%" valign="top"><strong>Sort Name ALT:</strong></td>
<td width="78%"><input type="text" size="20" maxlength="100" name="sort_name_alt" value="#qSort.sort_name_alt#" class="form_element">
</td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
    <td width="30%" valign="top"><strong>Active: </strong></td>
    <td width="70%"> Yes <input type="radio" name="sort_active" value="1" <cfif qSort.sort_active EQ 1>checked</cfif> style="border:none;">&nbsp;No
        <input type="radio" name="sort_active" value="0" <cfif qSort.sort_active EQ 0>checked</cfif> style="border:none;"></td>
  </tr>
<cfloop query="qGifts">
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	<td width="22%" valign="top"><strong>#qGifts.gift_name# Word:</strong></td>
	<td width="78%">
		<input type="text" size="20" maxlength="100" name="sort_word#qGifts.currentrow#" value="#qSort.sort_words[1][qGifts.currentrow][2]#" class="form_element">
		<input type="hidden" name="sort_word#qGifts.currentrow#_gift_id" value="#qSort.sort_words[1][qGifts.currentrow][1]#">
	</td>
	</tr>
</cfloop>

<cfif isdefined("url.sort_id") AND url.sort_id EQ "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this word sort" class="form_element"> <input type="hidden" name="sort_id" value="new" /></td></tr>
<cfelse>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this word sort" class="form_element"><input type="submit" name="submit" value="Delete this word sort" class="form_element"><input type="hidden" name="sort_id" value="#qSort.sort_id#" /></td></tr>
</cfif>
</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">