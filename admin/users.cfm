
<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "user_listing.cfm">
<cfset VARIABLES.form_return_page = "users.cfm">
<cfset VARIABLES.db_table_name = "AdminUsers">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "admin_id">
<cfset VARIABLES.table_title_column = "admin_username">


<!--- Queries to update database if form has been submitted --->


<cfif isdefined("form.submit") AND form.submit IS "Add this user">


<cfset form.admin_password = hash(form.admin_password)>


<cfinsert datasource="#APPLICATION.DSN#" tablename="AdminUsers" formfields="admin_active,admin_fname, admin_lname, admin_username, admin_password, admin_datecreated, admin_datemodified, admin_lastlogin, admin_phone1, admin_phone2, admin_email,admin_user_type">
<cfset VARIABLES.title = "#form.admin_fname#%20#form.admin_lname#">
<cflocation url="user_listing.cfm?memo=new&title=#VARIABLES.title#">
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Update this user">



<cfset VARIABLES.field_list = "admin_id, admin_active, admin_fname, admin_lname, admin_username,admin_datemodified, admin_lastlogin, admin_phone1, admin_phone2, admin_email,admin_user_type">

<cfif isdefined('FORM.admin_password_reset') AND LEN(FORM.admin_password_reset) GT 0>
	<cfset form.admin_password = hash(form.admin_password_reset)>
	<cfset VARIABLES.field_list = VARIABLES.field_list & ", admin_password">
</cfif>

<cfupdate datasource="#APPLICATION.DSN#" tablename="AdminUsers" formfields="#VARIABLES.field_list#">
<cfset VARIABLES.title = "#form.admin_fname#%20#form.admin_lname#">
<cflocation url="user_listing.cfm?memo=updated&title=#VARIABLES.title#">
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this user">
	<cfoutput><div id="delete_warning">Are you sure you want to delete: #form.admin_fname# #form.admin_lname#?<Br /><br />
	<cfform action="users.cfm" method="post" enctype="multipart/form-data">
	<input name="submit" type="submit" value="Yes, Confirm Deletion" />&nbsp;
	<input name="submit" type="submit" value="Cancel" />
	<input type="hidden" name="admin_id" value="#form.admin_id#" />
	<input type="hidden" name="admin_fname" value="#form.admin_fname#" />
	<input type="hidden" name="admin_lname" value="#form.admin_lname#" />
	</cfform>
	</div></cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND #form.submit# IS "Yes, Confirm Deletion">
		<cfquery name="deleteuser" datasource="#APPLICATION.DSN#" dbtype="odbc">
		DELETE FROM AdminUsers
		WHERE admin_id = #form.admin_id#
		</cfquery>

	<cfset VARIABLES.title = "#form.admin_fname#%20#form.admin_lname#">
	<cflocation url="user_listing.cfm?memo=deleted&title=#VARIABLES.title#">
	<cfabort>
<cfelseif isdefined("form.submit") AND #form.submit# IS "Cancel">
<cflocation url="users.cfm?admin_id=#form.admin_id#">
<cfabort>
</cfif>

<!--- query to get values for existing users --->
<cfif isdefined("url.admin_id") AND url.admin_id NEQ "new">
<cfquery name="getuserinfo" datasource="#APPLICATION.DSN#" dbtype="ODBC">
SELECT * FROM AdminUsers
WHERE admin_id = #url.admin_id#
</cfquery>
</cfif>


<cfif isDefined('URL.testing')>
	<!--- set defaults for errored entries --->
	<cfparam name="getuserinfo.admin_active" default="#form.admin_active#">
	<cfparam name="getuserinfo.admin_fname" default="#form.admin_fname#">
	<cfparam name="getuserinfo.admin_lname" default="#form.admin_lname#">
	<cfparam name="getuserinfo.admin_username" default="#form.admin_username#">
	<cfparam name="getuserinfo.admin_password" default="">
	<cfparam name="getuserinfo.admin_primaryadministrator" default="#form.admin_primaryadministrator#">
	<cfparam name="getuserinfo.admin_datecreated" default="#DateFormat(Now(), 'mmmm dd, yyyy')#">
	<cfparam name="getuserinfo.admin_datemodified" default="#DateFormat(Now(), 'mmmm dd, yyyy')#">
	<cfparam name="getuserinfo.admin_lastlogin" default="#form.admin_lastlogin#">
	<cfparam name="getuserinfo.admin_phone1" default="#form.admin_phone1#">
	<cfparam name="getuserinfo.admin_phone2" default="#form.admin_phone2#">
	<cfparam name="getuserinfo.admin_email" default="#form.admin_email#">


<cfelse>

	<!--- set blank defaults for new users --->
	<cfparam name="getuserinfo.admin_active" default="1">
	<cfparam name="getuserinfo.admin_fname" default="">
	<cfparam name="getuserinfo.admin_lname" default="">
	<cfparam name="getuserinfo.admin_username" default="">
	<cfparam name="getuserinfo.admin_password" default="">
	<cfparam name="getuserinfo.admin_primaryadministrator" default="0">
	<cfparam name="getuserinfo.admin_datecreated" default="#DateFormat(Now(), 'mmmm dd, yyyy')#">
	<cfparam name="getuserinfo.admin_datemodified" default="#DateFormat(Now(), 'mmmm dd, yyyy')#">
	<cfparam name="getuserinfo.admin_lastlogin" default="">
	<cfparam name="getuserinfo.admin_phone1" default="">
	<cfparam name="getuserinfo.admin_phone2" default="">
	<cfparam name="getuserinfo.admin_user_type" default="">
	<cfparam name="getuserinfo.admin_email" default="">

</cfif>

<cfoutput>
<form action="users.cfm" method="post" name="user_form" >
<cfif isDefined('URL.error')>
	<div style="margin:10px;color:##ff0000;font-weight:bold;font-size:14px;" align="center">
	<cfif URL.error EQ 1>
	I'm sorry your passwords did not match.  Please try again.
	<cfelseif URL.error EQ 2>
	I'm sorry you must select a User Type.
	</cfif>
	</div>	
</cfif>

<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td width="28%"><a href="user_listing.cfm"><strong>&laquo; User Listing</strong></a> </td>
  <td width="72%">&nbsp;</td>
</tr>
<cfif isdefined("url.userID") AND url.userID NEQ "new">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Date entered: </strong></td>
<td><em>#getuserinfo.admin_datecreated#</em>
<input type="hidden" name="admin_datemodified" value="#DateFormat(Now(), 'mmmm dd, yyyy')#">
</td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Date last modified: </strong></td>
<td><em>#getuserinfo.admin_datemodified#</em></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Date of last login: </strong></td>
<td><em>#getuserinfo.admin_lastlogin#</em></td></tr>
<cfelse>
<input type="hidden" name="admin_datecreated" value="#getuserinfo.admin_datecreated#">
<input type="hidden" name="admin_datemodifed" value="#getuserinfo.admin_datemodified#">
<input type="hidden" name="admin_lastlogin" value="#getuserinfo.admin_lastlogin#">
</cfif>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>First Name: </strong></td>
<td><input type="text" size="40" maxlength="50" name="admin_fname" value="#getuserinfo.admin_fname#" class="form"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Last Name: </strong></td>
<td><input type="text" size="40" maxlength="50" name="admin_lname" value="#getuserinfo.admin_lname#" class="form"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Primary phone number: </strong></td>
<td><input type="text" size="40" maxlength="50" name="admin_phone1" value="#getuserinfo.admin_phone1#" class="form"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Secondary phone number: </strong></td>
<td><input type="text" size="40" maxlength="50" name="admin_phone2" value="#getuserinfo.admin_phone2#" class="form"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Email address: </strong></td>
<td><input type="text" size="40" maxlength="50" name="admin_email" value="#getuserinfo.admin_email#" class="form"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Login username: </strong></td>
<td><input type="text" size="10" maxlength="10" name="admin_username" value="#getuserinfo.admin_username#" class="form"></td></tr>

<cfif isDefined('URL.admin_id') AND URL.admin_id EQ "new">
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong <cfif isDefined('URL.error') AND URL.error EQ 1>style="color:##ff0000;"</cfif>>Login password: </strong></td>
	<td><input type="password" size="10" maxlength="10" name="admin_password" value="#getuserinfo.admin_password#" class="form"></td></tr>
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td><strong <cfif isDefined('URL.error') AND URL.error EQ 1>style="color:##ff0000;"</cfif>>Confirm password: </strong></td>
	<td><input type="password" size="10" maxlength="10" name="admin_confirm_password" value="#getuserinfo.admin_password#" class="form"></td></tr>
<cfelse>
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td valign="top"><strong <cfif isDefined('URL.error') AND URL.error EQ 1>style="color:##ff0000;"</cfif>>Reset Password: </strong></td>
	<td><input type="password" size="10" maxlength="10" name="admin_password_reset" value="" class="form">
	  <br>
	  <em>[Leave Blank To Keep Current Password]</em> </td>
	</tr>
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td><strong <cfif isDefined('URL.error') AND URL.error EQ 1>style="color:##ff0000;"</cfif>>Confirm Password Reset: </strong></td>
	<td><input type="password" size="10" maxlength="10" name="admin_confirm_password_reset" value="" class="form"></td></tr>
</cfif>

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Active: </strong></td>
<td>Yes: <input name="admin_active" type="radio" value="Yes" <cfif getuserinfo.admin_active IS 1>checked="checked"</cfif> /> No:  <input name="admin_active" type="radio" value="No" <cfif getuserinfo.admin_active IS 0>checked="checked"</cfif> /> 
 </td></tr>
<!--- <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td><strong>User Type: </strong></td>
  <td>
  <select name="admin_user_type">
  	<option value="">-Select-</option>
  	<option value="1" <cfif getuserinfo.admin_user_type EQ 1>selected="selected"</cfif>>Full Admin</option>
	<option value="2" <cfif getuserinfo.admin_user_type EQ 2>selected="selected"</cfif>>Dream Interpreter</option>
  </select>
  </td>
</tr> --->
<cfif isdefined("url.admin_id") AND url.admin_id EQ "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this user" class="form"></td></tr>
<cfelse>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this user" class="form"><input type="submit" name="submit" value="Delete this user" class="form"><input type="hidden" name="admin_id" value="#getuserinfo.admin_id#"></td></tr>
</cfif>
</table>
</form>

 <SCRIPT language="JavaScript">
	var frmvalidator  = new Validator("user_form");
	frmvalidator.addValidation("username","req","Username: Cannot Be Blank!");
	<cfif isDefined('URL.userid') AND URL.userid EQ "new">
	frmvalidator.addValidation("password","req","Password: Cannot Be Blank!");
	frmvalidator.addValidation("confirm_password","req","Confirm Password: Cannot Be Blank!");
	</cfif>
	
		function DoCustomValidation()
			{
						   
			   <cfif isDefined('URL.userid') AND URL.userid EQ "new">

			   
			   if ( frm.password.value != frm.confirm_password.value)
			   { 
				alert("Your passwords do not match.  Please correct.");
				return false;
			   }
			   
			   <cfelse>
			   					   
			    if ( frm.password_reset.value != frm.confirm_password_reset.value)
			   { 
				alert("Your passwords do not match.  Please correct.");
				return false;
			   }
			   
			   </cfif>
			   
			   
		  }
			
		frmvalidator.setAddnlValidationFunction("DoCustomValidation");	
	</script>
	
</cfoutput>

</body>
</html>
