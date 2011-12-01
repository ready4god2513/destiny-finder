
<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "gateway_listing.cfm">
<cfset VARIABLES.form_return_page = "gateway.cfm">
<cfset VARIABLES.db_table_name = "Gateway_Pages">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "gateway_id">
<cfset VARIABLES.table_title_column = "gateway_name">
<cfset VARIABLES.fieldslist = "gateway_name,gateway_parent_id,gateway_active,gateway_path,gateway_landing_page">

<!--- Queries to update database if form has been submitted --->

<cfif isdefined("form.submit") AND form.submit IS "Add this gateway">

		<cfif isDefined('FORM.add_image') AND LEN(FORM.add_image) GT 0>
			<cfset FORM.gateway_header_img = FORM.add_image>
			<cfset VARIABLES.fieldslist = VARIABLES.fieldslist & ",gateway_header_img">
		</cfif>
		
<cfset table_title_column_value = "#form[table_title_column]#">

	<cftransaction>
	<cfinsert datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
	
	<cfquery name="qMax" datasource="#APPLICATION.DSN#" maxrows="1">
		SELECT gateway_id
		FROM Gateway_Pages
		ORDER BY gateway_id DESC
	</cfquery>
	
	<cfquery name="InsertMenu" datasource="#APPLICATION.DSN#">
		INSERT INTO 
		Menu_Items
		(menu_type,menu_item_id,menu_gateway_id,menu_sortorder)
		VALUES
		('gateway',#qMax.gateway_id#,#FORM.gateway_parent_id#,0)
	</cfquery>
</cftransaction>

<cflocation url="#VARIABLES.listing_page#?memo=new&title=#VARIABLES.table_title_column_value#">
<cfabort>
	
	
<cfelseif isdefined("form.submit") AND form.submit IS "Update this gateway">
<cfset VARIABLES.fieldslist = "gateway_id," & VARIABLES.fieldslist>

		
		<cfif isDefined('FORM.add_image') AND LEN(FORM.add_image) GT 0>
			<cfset FORM.gateway_header_img = FORM.add_image>
			<cfset VARIABLES.fieldslist = VARIABLES.fieldslist & ",gateway_header_img">
		</cfif>
		
		
<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">
<cfset table_title_column_value = "#form[table_title_column]#">
<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#VARIABLES.table_title_column_value#"> 
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this gateway">
	<cfoutput>
#delete_step1(page_return="#VARIABLES.form_return_page#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
	<cfoutput>#delete_step2(DSN="#APPLICATION.DSN#",page_return="#VARIABLES.listing_page#",table_name="#VARIABLES.db_table_name#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>
		<cfquery name="DeleteMenu" datasource="#APPLICATION.DSN#">
		DELETE FROM
		Menu_Items
		WHERE menu_type = 'gateway' AND menu_item_id = #FORM.gateway_id#
		</cfquery>
    
		<cfset table_title_column_value = "#form[table_title_column]#">
		<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#VARIABLES.table_title_column_value#"> 
		<cfabort>
<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
<cfset table_primkey_value = "#form[table_primkey_name]#">
<cflocation url="#VARIABLES.form_return_page#?#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#">
<cfabort>
</cfif>

<!--- query to get existing values --->
<cfif isdefined("url.gateway_id") AND url.gateway_id NEQ "new">
<cfquery name="getgateway" datasource="#APPLICATION.DSN#" dbtype="odbc">
SELECT * FROM Gateway_Pages
WHERE gateway_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.gateway_id#">
</cfquery>
</cfif>

<!--- set blank defaults for new entries --->
<cfparam name="getgateway.gateway_name" default="">
<cfparam name="getgateway.gateway_active" default="1">
<cfparam name="getgateway.gateway_header_img" default="">
<cfparam name="getgateway.gateway_path" default="">
<cfparam name="getgateway.gateway_landing_page" default="">

<cfoutput>

<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="#VARIABLES.listing_page#"><strong>&laquo; Gateway Listing</strong></a> </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="19%"><strong>Gateway Name:</strong></td>
<td width="81%"><input type="text" size="20" maxlength="100" name="gateway_name" value="#getgateway.gateway_name#" class="form_element"></td></tr>

<tr valign="top" <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td><strong>Default Gateway Header Image:</strong><br>
  </td>
  <td><cfif LEN(getgateway.gateway_header_img) GT 0>
<strong>Uploaded: "#getgateway.gateway_header_img#"</strong><br />
Replace:
</cfif>
  <script type="text/javascript">
	 function BrowseServerImage()
	   {
			var finder = new CKFinder();
			finder.basePath = '/admin/ckfinder/';	// The path for the installation of CKFinder (default = "/ckfinder/").
			finder.selectActionFunction = SetFileFieldImage;
			finder.popup();
	   }
	  
	  function  SetFileFieldImage( fileUrl )
	   {
		document.getElementById( 'add_image' ).value = fileUrl ;
	   }
	 </script>


<input type="text" id="add_image" name="add_image" size="30" /> <input type="button" value="Browse Server" onclick="BrowseServerImage();" /><br />
<em>[Dimensions: 733 x 237]</em>

<cfif isDefined('URL.gateway')>
	<input type="hidden" name="gateway_parent_id" value="#URL.gateway#" />
<cfelse>
	<input type="hidden" name="gateway_parent_id" value="0" />
</cfif>

</td>
</tr>

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	<td width="19%"><strong>Gateway Path:</strong></td>
	<td width="81%"><input type="text" size="20" maxlength="100" name="gateway_path" value="#getgateway.gateway_path#" class="form_element">
</td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	<td width="19%"><strong>Gateway Landing Page:</strong></td>
	<td width="81%"><input type="text" size="20" maxlength="100" name="gateway_landing_page" value="#getgateway.gateway_landing_page#" class="form_element">
</td>
</tr>
 <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Active:</strong></td><td>Yes: <input type="radio" name="gateway_active" value="1" <cfif Val(getgateway.gateway_active) EQ 1>checked</cfif>>&nbsp;No:<input type="radio" name="gateway_active" value="0" <cfif Val(getgateway.gateway_active) EQ 0>checked</cfif>> 
  (If yes, this gateway will be be visible in the menu.)</td>
</tr> 
<input type="hidden" name="gateway_active" value="1">
<cfif isdefined("url.gateway_id") AND url.gateway_id EQ "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this gateway" class="form_element"> <input type="hidden" name="gateway_id" value="new" /></td></tr>
<cfelse>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this gateway" class="form_element"><input type="submit" name="submit" value="Delete this gateway" class="form_element"><input type="hidden" name="gateway_id" value="#getgateway.gateway_id#" /></td></tr>
</cfif>
</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">