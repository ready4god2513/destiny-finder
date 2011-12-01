<cfset objAdmin = CreateObject("component","admin.cfcs.admin")>
<cfset objAssessment  = CreateObject("component","admin.cfcs.assessment")>

<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "assessment_listing.cfm">
<cfset VARIABLES.form_return_page = "assessment.cfm?assessment_id=#URL.assessment_id#">
<cfset VARIABLES.db_table_name = "assessments">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "assessment_id">
<cfset VARIABLES.table_title_column = "assessment_name">
<cfset VARIABLES.fieldslist = "assessment_name,assessment_active,assessment_access_key,assessment_intro_text,assessment_closing_text">

<!--- Queries to update database if form has been submitted --->

<cfif isdefined("form.submit") AND form.submit IS "Add new item">

	<cflocation url="assessment_item.cfm?item_type=#FORM.item_type#&assessment_id=#FORM.assessment_id#&gift_type_id=#form.gift_type_id#" addtoken="no">
	<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Add this assessment">
	
<cfset table_title_column_value = "#form[table_title_column]#">

	
	<cfinsert datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">

<cflocation url="#VARIABLES.listing_page#?memo=new&title=#VARIABLES.table_title_column_value#">
<cfabort>
	
	
<cfelseif isdefined("form.submit") AND form.submit IS "Update this assessment">
<cfset VARIABLES.fieldslist = "assessment_id," & VARIABLES.fieldslist>		
		
<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
<cfset table_title_column_value = "#form[table_title_column]#">
<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#VARIABLES.table_title_column_value#&gift_type_id=#form.gift_type_id#"> 
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this assessment">
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
<cflocation url="#VARIABLES.form_return_page#?#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#&gift_type_id=#form.gift_type_id#">
<cfabort>

<cfelseif isDefined("form.submit") AND form.submit IS "Update Sort Order">
	<cfset VARIABLES.update_sort = objAdmin.sort_order(
		divOrder="#FORM.divOrder#",
		sort_id_list="#FORM.sort_id_list#",
		table_name="assessment_items",
		sort_column="item_sortorder",
		primary_key="item_id")>
	<cflocation url="#VARIABLES.form_return_page#&sort_update=1&gift_type_id=#form.gift_type_id#"> 
	
</cfif>

<!--- query to get existing values --->
<cfif isdefined("url.assessment_id") AND url.assessment_id NEQ "new">
<cfquery name="qassessment" datasource="#APPLICATION.DSN#" dbtype="odbc">
SELECT * FROM assessments
WHERE assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.assessment_id#">
</cfquery>
</cfif>

<!--- set blank defaults for new entries --->
<cfparam name="qAssessment.assessment_name" default="">
<cfparam name="qAssessment.assessment_active" default="1">
<cfparam name="qAssessment.assessment_access_key" default="">
<cfparam name="qAssessment.assessment_intro_text" default="1">
<cfparam name="qAssessment.assessment_closing_text" default="">

<cfif isDefined("url.memo")>
	<cfoutput>#listing_memo(action=url.memo, title=url.title)#</cfoutput>
<cfelseif isDefined("url.sort_update")>
	<div class="memo_box">
		The Assessment Items Have Been Resorted
	</div>
</cfif>

<cfoutput>
<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data" onSubmit="populateHiddenVars();">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="#VARIABLES.listing_page#"><strong>&laquo; Assessment Listing</strong></a> </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="22%" valign="top"><strong>Assessment Name:</strong></td>
<td width="78%"><input type="text" size="20" maxlength="100" name="assessment_name" value="#qassessment.assessment_name#" class="form_element">
</td></tr>
  <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
    <td width="30%" valign="top"><strong>Active: </strong></td>
    <td width="70%"> Yes <input type="radio" name="assessment_active" value="1" <cfif qAssessment.assessment_active EQ 1>checked</cfif> style="border:none;">&nbsp;No
        <input type="radio" name="assessment_active" value="0" <cfif qAssessment.assessment_active EQ 0>checked</cfif> style="border:none;"></td>
  </tr>
 <tr valign="top" <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="22%"><strong>Access Key:</strong></td>
<td width="78%"><input type="text" size="2" maxlength="3" name="assessment_access_key" value="#qassessment.assessment_access_key#" class="form_element">
  <br>
  [If defined this assessment will only be available to users who have purchased the corresponding membership in the store.] </td>
</tr>
<tr>
  <td><strong> Intro Text:</strong></td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td colspan="2">
    <cfscript>
	// Calculate basepath for FCKeditor. It's in the folder right above _samples

	basePath = '/editor/';
	fckEditor = createObject("component", "#basePath#fckeditor");
	fckEditor.instanceName	= "assessment_intro_text";
	fckEditor.value			= '#qassessment.assessment_intro_text#';
	fckEditor.basePath		= basePath;
	fckEditor.width			= "100%";
	fckEditor.height		= 240;
	fckeditor.ToolbarSet = "Default";
	fckEditor.create(); // create the editor.
    </cfscript>
  </td>
</tr>
<tr>
  <td><strong> Closing Text:</strong></td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td colspan="2">
    <cfscript>
	// Calculate basepath for FCKeditor. It's in the folder right above _samples

	basePath = '/editor/';
	fckEditor = createObject("component", "#basePath#fckeditor");
	fckEditor.instanceName	= "assessment_closing_text";
	fckEditor.value			= '#qassessment.assessment_closing_text#';
	fckEditor.basePath		= basePath;
	fckEditor.width			= "100%";
	fckEditor.height		= 240;
	fckeditor.ToolbarSet = "Default";
	fckEditor.create(); // create the editor.
    </cfscript>
  </td>
</tr>
<cfif isdefined("url.assessment_id") AND url.assessment_id EQ "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this assessment" class="form_element"> <input type="hidden" name="assessment_id" value="new" /></td></tr>
<cfelse>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this assessment" class="form_element"><input type="submit" name="submit" value="Delete this assessment" class="form_element"><input type="hidden" name="assessment_id" value="#qassessment.assessment_id#" /></td></tr>
</cfif>

<cfif URL.assessment_id NEQ "new">
<cfset qTypes = objAssessment.retrieve_types()>

  <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
    <td valign="top">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2" valign="top"><strong>Assessment Items: </strong></td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2" valign="top">
  <cfquery name="qItems" datasource="#APPLICATION.DSN#">
   	SELECT *
	FROM Assessment_Items
	WHERE assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.assessment_id#">
	ORDER BY item_sortorder ASC
   </cfquery>
   
	<cfif URL.assessment_id EQ 1 OR URL.assessment_id EQ 2>
    	<cfset VARIABLES.gift_type_id = 1>
    <cfelseif URL.assessment_id EQ 3>
    	<cfset VARIABLES.gift_type_id = 2>
    <cfelseif URL.assessment_id EQ 4>
    	<cfset VARIABLES.gift_type_id = 3>
    </cfif>

	<cfset VARIABLES.divcount = 0>
	<cfset VARIABLES.sortids = "">
	<div><img src="images/action_add.gif" />&nbsp;
    	<input name="gift_type_id" type="hidden" value="#VARIABLES.gift_type_id#" />
		<select name="item_type" class="form_element">
			<option value="">-Select Type-</option>
			<cfloop query="qTypes">
				<option value="#qTypes.type_id#">#qTypes.type_name#</option>
			</cfloop>
		</select>&nbsp;<input type="submit" name="submit" value="Add New Item" /></div> 
	<div id="sortContainer">
	
	<cfloop query="qItems">
	<cfswitch expression="#qItems.item_type#">
		<cfcase value="1">
			<cfquery name="qSort" datasource="#APPLICATION.DSN#">
				SELECT *
				FROM Sort
				WHERE sort_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qItems.item_type_id#">
			</cfquery>
			<cfset VARIABLES.item_page = "word_sort.cfm?sort_id=#qItems.item_type_id#&assessment_id=#URL.assessment_id#&gift_type_id=#qAssessment.gift_type_id#">
			<cfset VARIABLES.item_name = qSort.sort_name>
			<cfset VARIABLES.item_active = qSort.sort_active>
			
		</cfcase>
		<cfcase value="2">
			<cfquery name="qAgree" datasource="#APPLICATION.DSN#">
				SELECT *
				FROM Agree
				WHERE agree_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qItems.item_type_id#">
			</cfquery>
			<cfset VARIABLES.item_page = "agree.cfm?agree_id=#qItems.item_type_id#&assessment_id=#URL.assessment_id#&gift_type_id=#qAssessment.gift_type_id#">
			<cfset VARIABLES.item_name = qAgree.agree_name>
			<cfset VARIABLES.item_active = qAgree.agree_active>
		</cfcase>
		<cfdefaultcase></cfdefaultcase>
	</cfswitch>
	
	
	<div id="div_#VARIABLES.divcount#" style="cursor:move;border:1px solid ##D8D8D8; margin-bottom:2px;padding:2px;">
		
			
			<div id="name_column" style="width:350px">
			<a href="#VARIABLES.item_page#" style="cursor:hand;"><img src="images/edit.gif" />&nbsp;#VARIABLES.item_name#</a></div>
			<div id="column" style="width:10px;">
			&nbsp;
			</div>
			<div id="column" style="width:100px;"><cfif VARIABLES.item_active EQ 1><img src="images/action_check.gif" /><cfelse><img src="images/action_disabled.gif" /></cfif></div>
				<div style="clear:both;"></div>
		
		</div>
		
	<cfset VARIABLES.divcount = VARIABLES.divcount + 1>
	<cfset VARIABLES.sortids = ListAppend(VARIABLES.sortids,qItems.item_id)>
	</cfloop>
	</div>

	
	<input type="hidden" name="sort_id_list" value="#VARIABLES.sortids#"/>
	<input type="hidden" name="divOrder" id="divOrder" />
    	
	<div align="right" style="margin-right:30px;padding-top:8px;"><input type="submit" name="submit" value="Update Sort Order"></div>
	<br />
	<br />
	<script type="text/javascript">
		// <![CDATA[
						
			Sortable.create('sortContainer',{tag:'div'});
								
							// ]]>
	</script>
</td>
  </tr>
  </cfif>
</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">