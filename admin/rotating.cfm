<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "rotating_listing.cfm">
<cfset VARIABLES.form_return_page = "rotating.cfm">
<cfset VARIABLES.db_table_name = "Rotating">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "rotating_id">
<cfset VARIABLES.table_title_column = "rotating_name">

<cfset VARIABLES.field_list = "rotating_name,rotating_active,rotating_link,rotating_target">
<!--- Queries to update database if form has been submitted --->
<cfif isdefined("form.submit") AND form.submit IS "Add this image">
	
	<cfif LEN(FORM.add_image) GT 0>
		<cfset FORM.rotating_image = FORM.add_image>
		<cfset VARIABLES.field_list = VARIABLES.field_list & ",rotating_image">
	</cfif>

	
<cfinsert datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.field_list#">
<cflocation url="#VARIABLES.listing_page#?memo=new&title=#FORM.rotating_name#">
<cfabort>
<cfelseif isdefined("form.submit") AND form.submit IS "Update this image">
<cfset VARIABLES.field_list = "rotating_id," & VARIABLES.field_list>	
	<cfif LEN(FORM.add_image) GT 0>
		<cfset FORM.rotating_image = FORM.add_image>
		<cfset VARIABLES.field_list =  VARIABLES.field_list & ",rotating_image">
	</cfif>


<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.field_list#">
<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#FORM.rotating_name#">
<cfabort>

<cfelseif isdefined("form.submit") AND #form.submit# IS "Delete this image">
<cfoutput><div id="delete_warning">Are you sure you want to delete this image?<Br /><br />
	<cfform action="rotating.cfm?rotating_id=#form.rotating_id#" method="post" enctype="multipart/form-data">
	<input name="submit" type="submit" value="Yes, Confirm Deletion" />&nbsp;
	<input name="submit" type="submit" value="Cancel" />
	<input type="hidden" name="rotating_id" value="#form.rotating_id#" />
	<input type="hidden" name="rotating_name" value="#form.rotating_name#" />
		</cfform>
	</div></cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND #form.submit# IS "Yes, Confirm Deletion">
		<cfquery name="deleterotating" datasource="#APPLICATION.DSN#" dbtype="odbc">
DELETE FROM Rotating
WHERE rotating_id = #URL.rotating_id#
</cfquery>
	<cflocation url="rotating_listing.cfm?memo=deleted&title=#form.rotating_name#">
	<cfabort>
	
<cfelseif isdefined("form.submit") AND #form.submit# IS "Cancel">
<cflocation url="rotating.cfm?rotating_id=#form.rotating_id#">
<cfabort>
</cfif>


<!--- query to get existing values --->
<cfif isdefined("url.rotating_id") AND #url.rotating_id# NEQ "new">
<cfquery name="getrotating" datasource="#DSN#" dbtype="odbc">
SELECT * FROM Rotating
WHERE rotating_id = #url.rotating_id#
</cfquery>
</cfif>

<!--- set blank defaults for new entries --->

<cfparam name="getrotating.rotating_Image" default="">
<cfparam name="getrotating.rotating_Link" default="">
<cfparam name="getrotating.rotating_Target" default="">
<cfparam name="getrotating.rotating_name" default="">
<cfparam name="getrotating.rotating_active" default="1">

<cfoutput>
<cfform action="rotating.cfm" method="post" enctype="multipart/form-data">
<table border="0" width="98%" cellpadding="0" cellspacing="2" id="admincontent">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td><a href="rotating_listing.cfm"><strong>&laquo; Image Listing</strong></a> </td>
  <td>&nbsp;</td>
</tr>
  <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
    <td valign="top"><span style="font-weight: bold">Name:</span>
</td>
<td><input type="text" name="rotating_name" size="30" maxlength="255" value="#getrotating.rotating_name#"><br />
	<em>For reference purposes only. This will not display to the usser.</em>
</td></tr>
 <tr valign="top" <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td><strong>Active:</strong></td>
  <td> Yes <input type="radio" name="rotating_active" value="1" <cfif getrotating.rotating_active EQ 1>checked</cfif>>&nbsp;No
        <input type="radio" name="rotating_active" value="0" <cfif getrotating.rotating_active EQ 0>checked</cfif>></td>
</tr>
    <tr valign="top" <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td><strong>Image:</strong><br>
  <em>[Dimensions 955 x 289]</em></td>
  <td><cfif LEN(getrotating.rotating_image) GT 0>
<strong>Uploaded: "#getrotating.rotating_image#"</strong><br />
Replace:
</cfif>
 <script type="text/javascript">
  function BrowseServerImage()
   {
    CKFinder.Popup( 'ckfinder/', null, null, SetFileFieldImage ) ;
   }
  
  function SetFileFieldImage( fileUrl )
   {
    document.getElementById( 'add_image' ).value = fileUrl ;
   }
 </script>

<input type="text" id="add_image" name="add_image" size="30" /> <input type="button" value="Browse Server" onclick="BrowseServerImage();" />
</td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><span style="font-weight: bold">Link URL:</span></td>
<td><input type="text" name="rotating_link" size="30" maxlength="255" value="#getrotating.rotating_link#"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><span style="font-weight: bold">Link browser window (target):</span></td>
<td><select name="rotating_Target"><option value="" SELECTED>Same Window</option>
<option value="_blank">Open a new browser window</option></select></td></tr>
<cfif isdefined("url.rotating_id") AND #url.rotating_id# IS "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this image" class="form"></td></tr>
<cfelse>
<input type="hidden" name="rotating_id" value="#getrotating.rotating_id#">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this image" class="form"><input type="submit" name="submit" value="Delete this image" class="form"></td></tr>
</cfif>
</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">