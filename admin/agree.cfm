<cfset objAssessment  = CreateObject("component","admin.cfcs.assessment")>
<cfset qGifts = objAssessment.retrieve_gifts(gift_type_id=#URL.gift_type_id#)>

<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "assessment.cfm?assessment_id=#URL.assessment_id#&gift_type_id=#qGifts.gift_type_id#">
<cfset VARIABLES.form_return_page = "agree.cfm?assessment_id=#URL.assessment_id#&gift_type_id=#qGifts.gift_type_id#">
<cfset VARIABLES.db_table_name = "agree">
<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "agree_id">
<cfset VARIABLES.table_title_column = "agree_name">
<cfset VARIABLES.fieldslist = "agree_name,agree_question,agree_gift,agree_active">

<!--- Queries to update database if form has been submitted --->

<cfif isdefined("form.submit") AND form.submit IS "Add this question">
	<cfset FORM.agree_name = HTMLEditFormat(FORM.agree_name)>
	<cfset FORM.agree_question = HTMLEditFormat(FORM.agree_question)>

	<cfset table_title_column_value = "#form[table_title_column]#">
	<cfinsert datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
	<cfquery name="qMax" datasource="#APPLICATION.DSN#" maxrows="1">
		SELECT agree_id 
		FROM agree
		ORDER BY agree_id DESC
	</cfquery>
	<cfset VARIABLES.insert_item = objAssessment.insert_assessment_item(item_type="2",item_type_id="#qMax.agree_id#",assessment_id="#URL.assessment_id#")>
	<cflocation url="#VARIABLES.listing_page#&memo=new&title=#URLEncodedFormat(VARIABLES.table_title_column_value)#">
<cfabort>
	
<cfelseif isdefined("form.submit") AND form.submit IS "Update this question">
	<cfset FORM.agree_name = HTMLEditFormat(FORM.agree_name)>
	<cfset FORM.agree_question = HTMLEditFormat(FORM.agree_question)>
	
	<cfset VARIABLES.fieldslist = "agree_id," & VARIABLES.fieldslist>		
	<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
	<cfset table_title_column_value = "#form[table_title_column]#">
	<cflocation url="#VARIABLES.listing_page#&memo=updated&title=#VARIABLES.table_title_column_value#"> 
	<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this question">
	<cfoutput>#delete_step1(page_return="#VARIABLES.form_return_page#",table_primkey_name="#VARIABLES.table_primkey_name#",table_primkey_value="#form[table_primkey_name]#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>
	<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
	<cfoutput>
		#delete_step2(DSN="#APPLICATION.DSN#",page_return="#VARIABLES.listing_page#",table_name="#VARIABLES.db_table_name#",table_primkey_name="#VARIABLES.table_primkey_name#",table_primkey_value="#form[table_primkey_name]#",table_title_column="#VARIABLES.table_title_column#")#
		#objAssessment.delete_assessment_item(item_type_id="#FORM.agree_id#",item_type="1")#
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
<cfif isdefined("url.agree_id") AND url.agree_id NEQ "new">
	<cfquery name="qAgree" datasource="#APPLICATION.DSN#" dbtype="odbc">
		SELECT * FROM Agree
		WHERE agree_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.agree_id#">
	</cfquery>
</cfif>

<!--- set blank defaults for new entries --->
<cfparam name="qAgree.agree_name" default="">
<cfparam name="qAgree.agree_active" default="1">
<cfparam name="qAgree.agree_question" default="">
<cfparam name="qAgree.agree_gift" default="">

<cfoutput>
<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="#VARIABLES.listing_page#"><strong>&laquo; Return To Assessment</strong></a> </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td width="22%" valign="top"><strong>Question Name:</strong></td>
  <td width="78%"><input type="text" size="20" maxlength="100" name="agree_name" value="#qAgree.agree_name#" class="form_element">
</td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
    <td width="30%" valign="top"><strong>Active: </strong></td>
    <td width="70%"> Yes <input type="radio" name="agree_active" value="1" <cfif qAgree.agree_active EQ 1>checked</cfif> style="border:none;">&nbsp;No
        <input type="radio" name="agree_active" value="0" <cfif qAgree.agree_active EQ 0>checked</cfif> style="border:none;"></td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	<td width="22%" valign="top"><strong>Targeted Gift:</strong></td>
<td width="78%">
	<select name="agree_gift">
	<cfloop query="qGifts">
		<option value="#qGifts.gift_id#" <cfif qGifts.gift_id EQ qAgree.agree_gift>selected</cfif>>#qGifts.gift_name#</option>
	</cfloop>
	</select>
</td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="22%" valign="top"><strong>Question:</strong></td>
<td width="78%"><textarea name="agree_question" class="form_element" rows="3" cols="24">#qAgree.agree_question#</textarea>
</td></tr>
<cfif isdefined("url.agree_id") AND url.agree_id EQ "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this question" class="form_element"> <input type="hidden" name="agree_id" value="new" /></td></tr>
<cfelse>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this question" class="form_element"><input type="submit" name="submit" value="Delete this question" class="form_element"><input type="hidden" name="agree_id" value="#qAgree.agree_id#" /></td></tr>
</cfif>
</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">