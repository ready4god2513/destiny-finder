<cfquery name="getgateways" datasource="#APPLICATION.DSN#">
SELECT * FROM Gateway_Pages
ORDER BY gateway_name
</cfquery>

<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "content_listing.cfm">
<cfset VARIABLES.form_return_page = "content.cfm">
<cfset VARIABLES.db_table_name = "Content">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "content_pageid">
<cfset VARIABLES.table_title_column = "content_name">
<cfset VARIABLES.field_list = "content_name,content_action, content_active, content_includefunction, content_content, content_datemodified,content_lastmodifiedby, content_html_title, content_meta_desc,content_gateway,content_external_link,content_external_link_target,content_additional_url_var,content_module">

<!--- 
 <cfif isdefined('form.content_pageid')>
	<!--- GET THE PRIMARY KEY & TITLE VALUES TO PASS TO THE DELETE FUNCTION --->
	<cfset VARIABLES.table_primkey_value = "#form.content_pageid#">
	<cfset VARIABLES.table_title_column_value = "#form.content_name#">
</cfif>

--->


<!--- Queries to update database if form has been submitted --->
<cfif isdefined("form.submit") AND form.submit IS "Add this page">
	<cfset form.content_action = LCASE(REReplace(form.content_name, "[^0-9a-zA-Z_]", "", "ALL"))>
	<cfquery name="checkaction" datasource="#APPLICATION.DSN#" dbtype="ODBC">
	SELECT content_action FROM Content
	WHERE content_action = '#form.content_action#'
	</cfquery>
	<cfif checkaction.recordcount GT 0>
		<cfset VARIABLES.random_num = Randrange(1,1000)>
		<cfset form.content_action = "#FORM.content_action##VARIABLES.random_num#">
	</cfif>
	
	 <cfif isDefined('FORM.add_image') AND LEN(FORM.add_image) GT 0>
		<cfset FORM.content_header_img = FORM.add_image>
		<cfset VARIABLES.field_list = VARIABLES.field_list & ",content_header_img">
	</cfif>

	<cfset VARIABLES.field_list = VARIABLES.field_list & ", content_datecreated">
<cfset table_title_column_value = "#form[table_title_column]#">
<cfinsert datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.field_list#">

<cfquery name="qMax" datasource="#APPLICATION.DSN#" maxrows="1">
	SELECT content_pageid
	FROM Content
	ORDER BY content_pageid DESC
</cfquery>

<cfquery name="InsertMenu" datasource="#APPLICATION.DSN#">
	INSERT INTO 
	Menu_Items
	(menu_type,menu_item_id,menu_gateway_id,menu_sortorder)
	VALUES
	('page',#qMax.content_pageid#,#FORM.content_gateway#,0)
</cfquery>

<cflocation url="#VARIABLES.listing_page#?memo=new&title=#VARIABLES.table_title_column_value#&gateway=#FORM.content_gateway#">
<cfabort>
	
	
<cfelseif isdefined("form.submit") AND form.submit IS "Update this page">

<cfset VARIABLES.field_list = "content_pageid," & VARIABLES.field_list>

<cfif isDefined('FORM.add_image') AND LEN(FORM.add_image) GT 0>
		<cfset FORM.content_header_img = FORM.add_image>
		<cfset VARIABLES.field_list = VARIABLES.field_list & ",content_header_img">
</cfif>

<cfif isDefined('FORM.remove_image') AND FORM.remove_image EQ 1>
		<cfset FORM.content_header_img = "">
		<cfset VARIABLES.field_list = VARIABLES.field_list & ",content_header_img">
</cfif>

<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.field_list#">

<cfquery name="UpdateMenu" datasource="#APPLICATION.DSN#">
	UPDATE Menu_Items
	SET
	menu_gateway_id = #FORM.content_gateway#
	WHERE menu_type = 'page' AND menu_item_id = #FORM.content_pageid#
</cfquery>

<cfset table_title_column_value = "#form[table_title_column]#">
<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#VARIABLES.table_title_column_value#&gateway=#FORM.content_gateway#"> 
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this page">
	<cfoutput>#delete_step1(page_return="#VARIABLES.form_return_page#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#",additional_form_fields="content_gateway")#</cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
	<cfoutput>#delete_step2(dsn="#APPLICATION.DSN#",page_return="#VARIABLES.listing_page#",table_name="#VARIABLES.db_table_name#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#",additional_url_vars="&gateway=#FORM.content_gateway#")#</cfoutput>
	
	<cfquery name="DeleteMenu" datasource="#APPLICATION.DSN#">
		DELETE FROM
		Menu_Items
		WHERE menu_type = 'page' AND menu_item_id = #FORM.content_pageid#
	</cfquery>
	
	<cflocation url="#VARIABLES.listing_page#?memo=deleted&title=#table_title_column_value#&gateway=#FORM.content_gateway#">
	<cfabort>
	
<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
<cfset table_primkey_value = "#form[table_primkey_name]#">
<cflocation url="#VARIABLES.form_return_page#?#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#&gateway=#FORM.content_gateway#">
<cfabort>
</cfif>

<!--- query to get existing values --->
<cfif isdefined("url.content_pageID") AND url.content_pageID NEQ "new">
<cfquery name="getpage" datasource="#APPLICATION.DSN#" dbtype="odbc">
SELECT * FROM Content
WHERE content_pageID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.content_pageID#">
</cfquery>
</cfif>

<!--- set defaults for errored entries --->
<cfif isdefined("form.content_action") IS 'True'>
<cfset form.content_pageID = "new">
	<cfparam name="getpage.content_name" default="#form.content_name#">
	<cfparam name="getpage.content_action" default="">
	<cfparam name="getpage.content_active" default="#form.content_active#">
	<cfparam name="getpage.content_includefunction" default="#form.content_includefunction#">
	<cfparam name="getpage.content_content" default="#form.content_content#">
	<cfparam name="getpage.content_datecreated" default="#form.content_datecreated#">
	<cfparam name="getpage.content_datemodified" default="content_datemodified">
	<cfparam name="getpage.content_lastmodifiedby" default="#form.content_lastmodifiedby#">
	<cfparam name="getpage.content_html_title" default="#form.content_html_title#">
	<cfparam name="getpage.content_meta_desc" default="#form.content_meta_desc#">
	
	<cfparam name="getpage.content_gateway" default="#form.content_gateway#">


	
</cfif>

<!--- set blank defaults for new entries --->
<cfparam name="getpage.content_name" default="">
<cfparam name="getpage.content_action" default="">
<cfparam name="getpage.content_BannerImage" default="">
<cfparam name="getpage.content_active" default="1">
<cfparam name="getpage.content_includefunction" default="none">
<cfparam name="getpage.content_content" default="">
<cfparam name="getpage.content_datecreated" default="#DateFormat(Now(), 'mmmm dd, yyyy')#">
<cfparam name="getpage.content_datemodified" default="">
<cfparam name="getpage.content_lastmodifiedby" default="">
<cfparam name="getpage.content_html_title" default="">
<cfparam name="getpage.content_meta_desc" default="">
<cfparam name="getpage.content_gateway" default="#URL.gateway#">
<cfparam name="getpage.content_first_column" default="">
<cfparam name="getpage.content_third_column" default="">
<cfparam name="getpage.content_external_link" default="">
<cfparam name="getpage.content_external_link_target" default="">
<cfparam name="getpage.content_header_img" default="">
<cfparam name="getpage.content_additional_url_var" default="">
<cfparam name="getpage.content_module" default="">


<cfquery name="qGateway" datasource="#APPLICATION.DSN#">
	SELECT gateway_header_img
	FROM Gateway_Pages
	WHERE gateway_id = #getpage.content_gateway#
</cfquery>

<cfoutput>

<form action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data" onSubmit='populateHiddenVars();'>
<cfif isDefined("url.memo")>
	#listing_memo(action=url.memo, title=url.title)#	
</cfif>

<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">
<input type="hidden" name="content_datemodified" value="#DateFormat(Now(), 'mmmm dd, yyyy')#">
<input type="hidden" name="content_lastmodifiedby" value="#session.name#">




<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="#VARIABLES.listing_page#?gateway=#URL.gateway#"><strong>&laquo; <cfloop query="getgateways">
  <cfif getgateways.gateway_id EQ getpage.content_gateway>
  #getgateways.gateway_name#&nbsp;
  </cfif>
  </cfloop>Page Listing</strong></a> </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Page name:</strong></td>
<td><input type="text" size="20" maxlength="100" name="content_name" value="#getpage.content_name#" class="form_element"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td><span style="font-weight: bold">Module:</span></td>
  <td>
  	<cfquery name="qModules" datasource="#APPLICATION.DSN#">
		SELECT * 
		FROM Modules
	</cfquery>
	<select name="content_module" class="form_element">
		<option value="">- NONE -</option>
		<cfloop query="qModules">
			<option value="#qModules.module_id#" <cfif qModules.module_id EQ getpage.content_module>selected="selected"</cfif>>#qModules.module_name#</option>
		</cfloop>
	</select>
  </td>
</tr>
<cfif session.username IS "wvadmin">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Additional URL Variables:</strong></td>
<td><input type="text" size="20" maxlength="100" name="content_additional_url_var" value="#getpage.content_additional_url_var#" class="form_element"></td></tr>
<cfelse>
<input type="hidden" name="content_additional_url_var" value="#getpage.content_additional_url_var#" />
</cfif>
<cfif URL.content_pageid NEQ "new">
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td><strong>URL Identifier: </strong></td>
	
	<cfif session.username IS "wvadmin">
	  <td><input type="text" size="20" maxlength="100" name="content_action" value="#getpage.content_action#" class="form_element"></td>
	<cfelse>
		<td><em>index.cfm?page=#getpage.content_action#</em><input type="hidden" name="content_action" value="#getpage.content_action#" /></td>
    </cfif> 
	</tr>
</cfif>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td><span style="font-weight: bold">Assign To Gateway:</span></td>
  <td>
  <select name="content_gateway" class="form_element">
  <cfloop query="getgateways">
  <option value="#getgateways.gateway_id#" <cfif getpage.content_gateway EQ getgateways.gateway_id>selected</cfif>>#getgateways.gateway_name#</option>
  </cfloop>
  </select>
  </td>
</tr>
<cfif isdefined("url.content_pageID") AND #url.content_pageID# NEQ "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><input type="hidden" name="content_pageID" value="#getpage.content_pageID#"><strong>Date Created:</strong></td>
<td><em>#getpage.content_datecreated#</em></td></tr>
	<cfif getpage.content_datemodified NEQ "">
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Last modified by:</strong></td>
	<td><em>#getpage.content_lastmodifiedby#</em></td></tr>
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Date last modified:</strong></td>
	<td><em>#getpage.content_datemodified#</em></td></tr>
	</cfif>
<cfelse>
<input type="hidden" name="content_datecreated" value="#DateFormat(Now(), 'mmmm dd, yyyy')#">
</cfif>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td valign="top"><strong>HTML Title:</strong></td>
  <td><input type="text" size="20" maxlength="100" name="content_html_title" value="#getpage.content_html_title#" /></td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td valign="top"><strong>META Description: </strong></td>
  <td><input type="text" size="30" maxlength="200" name="content_meta_desc" value="#getpage.content_meta_desc#" /></td>
</tr>

<!--- <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>URL identifier:</strong></td>
<td><cfif isdefined("error") IS 'True'><cfoutput><span class="wvadminerror" style="color:##ff0000;">#error#</span></cfoutput><br></cfif>
	<input type="text" size="20" maxlength="100" name="content_action" value="#getpage.content_action#" class="form_element"> (A-Z only, no spaces)</td></tr> --->
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Active:</strong></td><td>Yes: <input type="radio" name="content_active" value="1" <cfif getpage.content_active IS 1>checked</cfif>>&nbsp;No:<input type="radio" name="content_active" value="0" <cfif getpage.content_active IS 0>checked</cfif>> 
  (If yes, this page will be accessible to website visitors.)</td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Link To External Page:</strong><br /></td><td>http://<input type="text" size="30" name="content_external_link" value="#getpage.content_external_link#" />
&nbsp;Target: 
  &nbsp;
  <input type="radio" name="content_external_link_target" value="_self" <cfif getpage.content_external_link_target EQ "_self">checked</cfif> style="border:none;"> Self
  &nbsp;
  <input type="radio" name="content_external_link_target" value="_blank" <cfif getpage.content_external_link_target EQ "_blank">checked</cfif> style="border:none;"> New Window
</td>
</tr>

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td valign="top"><strong>Header Image:</strong>
  <br>
  <em>[Dimensions: 959 x 268]</em></td>
  <td>
  <cfquery name="qGateway" datasource="#APPLICATION.DSN#">
  	SELECT gateway_header_img
	FROM Gateway_Pages
	WHERE gateway_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getpage.content_gateway#">
  </cfquery>
  <strong><em>Gateway Default: <cfif LEN(qGateway.gateway_header_img) GT 0>#qGateway.gateway_header_img#<cfelse>- Undefined -</cfif></em></strong><br>
  <cfif LEN(getpage.content_header_img) GT 0>
		<em>Uploaded image:<br/></em>
			<img src="#getpage.content_header_img#" width="276" height="90">
		<br>
		Remove Header Image: <input type="checkbox" name="remove_image" value="1" />
		<br>
		Replace file: 
	  </cfif>
	  <script type="text/javascript">
	  function BrowseServerA()
	   {
			var finder = new CKFinder();
			finder.basePath = '/admin/ckfinder/';	// The path for the installation of CKFinder (default = "/ckfinder/").
			finder.selectActionFunction = SetFileFieldA;
			finder.popup();
	   }
	  
	  function SetFileFieldA( fileUrl )
	   {
		document.getElementById( 'add_image' ).value = fileUrl ;
	   }
	 </script>
	
	<input type="text" id="add_image" name="add_image" size="30" /> <input type="button" value="Browse Server" onclick="BrowseServerA();" />
	
  </td>
</tr>
<cfif session.username IS "wvadmin">
	<tr><td><strong>Include module:</strong>:</td>
	<td>
	<select name="content_includefunction" class="form_element">
		<option value="none" <cfif lcase(getpage.content_includefunction) EQ 'none'>selected</cfif>>None</option>
		<option value="above" <cfif lcase(getpage.content_includefunction) EQ 'above'>selected</cfif>>Above</option>
		<option value="below" <cfif lcase(getpage.content_includefunction) EQ 'below'>selected</cfif>>Below</option>
		<option value="full" <cfif lcase(getpage.content_includefunction) EQ 'full'>selected</cfif>>Full</option>
	</select>
	</td>
	</tr>
<cfelse>
	<input type="hidden" name="content_includefunction" value="#getpage.content_includefunction#">
</cfif> 
	<tr>
	  <td><strong>Content:</strong></td>
	  <td>&nbsp;</td>
	 </tr>
	<tr>
	  <td colspan="2">

	  <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = '/editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "content_content";
			fckEditor.value			= '#getpage.content_content#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 500;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
	  </td>
	  </tr>
<cfif isdefined("url.content_pageID") AND #url.content_pageID# EQ "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this page" class="form_element"> <input type="hidden" name="content_pageid" value="new" /></td></tr>
<cfelse>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this page" class="form_element"><input type="submit" name="submit" value="Delete this page" class="form_element"></td>
</tr>
</cfif>
</table>
</form>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">