
<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "site_user_listing.cfm">
<cfset VARIABLES.form_return_page = "site_users.cfm">
<cfset VARIABLES.db_table_name = "Users">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "user_id">
<cfset VARIABLES.table_title_column = "user_username">


<!--- Queries to update database if form has been submitted --->


<cfif isdefined("form.submit") AND form.submit IS "Add this user">


<cfset form.user_password = hash(form.user_password)>


<cfinsert datasource="#APPLICATION.DSN#" tablename="Users" formfields="user_active,user_first_name, user_last_name, user_username, user_password, user_datecreated, user_datemodified, user_last_logged_in, user_phone,user_email,user_type,user_moderate">
<cfset VARIABLES.title = "#form.user_first_name#%20#form.user_last_name#">
<cflocation url="#VARIABLES.listing_page#?memo=new&title=#VARIABLES.title#">
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Update this user">



<cfset VARIABLES.field_list = "user_id,user_active,user_first_name, user_last_name, user_username, user_datecreated, user_datemodified, user_last_logged_in, user_phone,user_email,user_type,user_moderate">

<cfif isdefined('FORM.user_password_reset') AND LEN(FORM.user_password_reset) GT 0>
	<cfset form.user_password = hash(form.user_password_reset)>
	<cfset VARIABLES.field_list = VARIABLES.field_list & ", user_password">
</cfif>

<cfupdate datasource="#APPLICATION.DSN#" tablename="Users" formfields="#VARIABLES.field_list#">
<cfset VARIABLES.title = "#form.user_first_name#%20#form.user_last_name#">
<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#VARIABLES.title#">
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this user">
	<cfoutput><div id="delete_warning">Are you sure you want to delete: #form.user_first_name# #form.user_last_name#?<Br /><br />
	<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
	<input name="submit" type="submit" value="Yes, Confirm Deletion" />&nbsp;
	<input name="submit" type="submit" value="Cancel" />
	<input type="hidden" name="user_id" value="#form.user_id#" />
	<input type="hidden" name="user_first_name" value="#form.user_first_name#" />
	<input type="hidden" name="user_last_name" value="#form.user_last_name#" />
	</cfform>
	</div></cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND #form.submit# IS "Yes, Confirm Deletion">
		<cfquery name="deleteuser" datasource="#APPLICATION.DSN#" dbtype="odbc">
		DELETE FROM Users
		WHERE user_id = #form.user_id#
		</cfquery>

	<cfset VARIABLES.title = "#form.user_first_name#%20#form.user_last_name#">
	<cflocation url="#VARIABLES.listing_page#?memo=deleted&title=#VARIABLES.title#">
	<cfabort>
<cfelseif isdefined("form.submit") AND #form.submit# IS "Cancel">
<cflocation url="#VARIABLES.form_return_page#?user_id=#form.user_id#">
<cfabort>
</cfif>

<!--- query to get values for existing users --->
<cfif isdefined("url.user_id") AND url.user_id NEQ "new">
<cfquery name="getuserinfo" datasource="#APPLICATION.DSN#" dbtype="ODBC">
SELECT * FROM Users
WHERE user_id = #url.user_id#
</cfquery>
</cfif>


<cfif isDefined('URL.testing')>
	<!--- set defaults for errored entries --->
	<cfparam name="getuserinfo.user_active" default="#form.user_active#">
	<cfparam name="getuserinfo.user_first_name" default="#form.user_first_name#">
	<cfparam name="getuserinfo.user_last_name" default="#form.user_last_name#">
	<cfparam name="getuserinfo.user_username" default="#form.user_username#">
	<cfparam name="getuserinfo.user_password" default="">
	<cfparam name="getuserinfo.user_primaryadministrator" default="#form.user_primaryadministrator#">
	<cfparam name="getuserinfo.user_datecreated" default="#DateFormat(Now(), 'mmmm dd, yyyy')#">
	<cfparam name="getuserinfo.user_datemodified" default="#DateFormat(Now(), 'mmmm dd, yyyy')#">
	<cfparam name="getuserinfo.user_last_logged_in" default="#form.user_last_logged_in#">
	<cfparam name="getuserinfo.user_phone1" default="#form.user_phone1#">
	<cfparam name="getuserinfo.user_phone2" default="#form.user_phone2#">
	<cfparam name="getuserinfo.user_email" default="#form.user_email#">	
	<cfparam name="getuserinfo.user_moderate" default="#form.user_moderate#">


<cfelse>

	<!--- set blank defaults for new users --->
	<cfparam name="getuserinfo.user_active" default="1">
	<cfparam name="getuserinfo.user_first_name" default="">
	<cfparam name="getuserinfo.user_last_name" default="">
	<cfparam name="getuserinfo.user_username" default="">
	<cfparam name="getuserinfo.user_password" default="">
	<cfparam name="getuserinfo.user_primaryadministrator" default="0">
	<cfparam name="getuserinfo.user_datecreated" default="#DateFormat(Now(), 'mmmm dd, yyyy')#">
	<cfparam name="getuserinfo.user_datemodified" default="#DateFormat(Now(), 'mmmm dd, yyyy')#">
	<cfparam name="getuserinfo.user_last_logged_in" default="">
	<cfparam name="getuserinfo.user_phone" default="">
	<cfparam name="getuserinfo.user_phone2" default="">
	<cfparam name="getuserinfo.user_type" default="">
	<cfparam name="getuserinfo.user_email" default="">
	<cfparam name="getuserinfo.user_moderate" default="1">

</cfif>

<cfoutput>
<form action="#VARIABLES.form_return_page#" method="post" name="form" >
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
  <td width="28%"><a href="#VARIABLES.listing_page#"><strong>&laquo; Author Listing</strong></a> </td>
  <td width="72%">&nbsp;</td>
</tr>
<cfif isdefined("url.user_id") AND url.user_id NEQ "new">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Date entered: </strong></td>
<td><em>#DateFormat(getuserinfo.user_datecreated,'mmm dd, yyyy')#</em>
<input type="hidden" name="user_datemodified" value="#DateFormat(Now(), 'mmmm dd, yyyy')#">
</td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Date last modified: </strong></td>
<td><em>#DateFormat(getuserinfo.user_datemodified,'mmm dd, yyyy')#</em></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Date of last login: </strong></td>
<td><em>#DateFormat(getuserinfo.user_last_logged_in,'mmm dd, yyyy')#</em></td></tr>
<cfelse>
<input type="hidden" name="user_datecreated" value="#getuserinfo.user_datecreated#">
<input type="hidden" name="user_datemodifed" value="#getuserinfo.user_datemodified#">
<input type="hidden" name="user_last_logged_in" value="#getuserinfo.user_last_logged_in#">
</cfif>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>First Name: </strong></td>
<td><input type="text" size="40" maxlength="50" name="user_first_name" value="#getuserinfo.user_first_name#" class="form"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Last Name: </strong></td>
<td><input type="text" size="40" maxlength="50" name="user_last_name" value="#getuserinfo.user_last_name#" class="form"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Phone number: </strong></td>
<td><input type="text" size="40" maxlength="50" name="user_phone" value="#getuserinfo.user_phone#" class="form"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Email address: </strong></td>
<td><input type="text" size="40" maxlength="50" name="user_email" value="#getuserinfo.user_email#" class="form"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Login username: </strong></td>
<td><input type="text" size="10" name="user_username" value="#getuserinfo.user_username#" class="form"></td></tr>

<cfif isDefined('URL.user_id') AND URL.user_id EQ "new">
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong <cfif isDefined('URL.error') AND URL.error EQ 1>style="color:##ff0000;"</cfif>>Login password: </strong></td>
	<td><input type="password" size="10" maxlength="10" name="user_password" value="#getuserinfo.user_password#" class="form"></td></tr>
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td><strong <cfif isDefined('URL.error') AND URL.error EQ 1>style="color:##ff0000;"</cfif>>Confirm password: </strong></td>
	<td><input type="password" size="10" maxlength="10" name="user_confirm_password" value="#getuserinfo.user_password#" class="form"></td></tr>
<cfelse>
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td valign="top"><strong <cfif isDefined('URL.error') AND URL.error EQ 1>style="color:##ff0000;"</cfif>>Reset Password: </strong></td>
	<td><input type="password" size="10" maxlength="10" name="user_password_reset" value="" class="form">
	  <br>
	  <em>[Leave Blank To Keep Current Password]</em> </td>
	</tr>
	<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td><strong <cfif isDefined('URL.error') AND URL.error EQ 1>style="color:##ff0000;"</cfif>>Confirm Password Reset: </strong></td>
	<td><input type="password" size="10" maxlength="10" name="user_confirm_password_reset" value="" class="form"></td></tr>
</cfif>

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Active: </strong></td>
<td>Yes: <input name="user_active" type="radio" value="Yes" <cfif getuserinfo.user_active IS 1>checked="checked"</cfif> /> No:  <input name="user_active" type="radio" value="No" <cfif getuserinfo.user_active IS 0>checked="checked"</cfif> /> 
 </td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td><strong>User Type: </strong></td>
  <td>
  <select name="user_type">
  	<option value="">-Select-</option>
  	<option value="1" <cfif getuserinfo.user_type EQ 1>selected="selected"</cfif>>Contributor</option>
	<!--- <option value="2" <cfif getuserinfo.user_type EQ 2>selected="selected"</cfif>>Guest Author</option> --->
  </select>
  </td>
</tr> 
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Requires Moderation: </strong></td>
<td>Yes: <input name="user_moderate" type="radio" value="Yes" <cfif getuserinfo.user_moderate IS 1>checked="checked"</cfif> /> No:  <input name="user_moderate" type="radio" value="No" <cfif getuserinfo.user_moderate IS 0>checked="checked"</cfif> /> 
 </td></tr>
<cfif isdefined("url.user_id") AND url.user_id EQ "new">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Add this user" class="form"></td></tr>
<cfelse>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this user" class="form"><input type="submit" name="submit" value="Delete this user" class="form"><input type="hidden" name="user_id" value="#getuserinfo.user_id#"></td></tr>
</cfif>
</table>
</form>

 <SCRIPT language="JavaScript">
	var frmvalidator  = new Validator("form");
	frmvalidator.addValidation("username","req","Username: Cannot Be Blank!");
	<cfif isDefined('URL.user_id') AND URL.user_id EQ "new">
	frmvalidator.addValidation("password","req","Password: Cannot Be Blank!");
	frmvalidator.addValidation("confirm_password","req","Confirm Password: Cannot Be Blank!");
	</cfif>
	
		function DoCustomValidation()
			{
						   
			   <cfif isDefined('URL.user_id') AND URL.user_id EQ "new">

			   
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
