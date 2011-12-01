<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is called by the users.password circuit and used to display the password update form. --->

	<cfparam name="attributes.message" default="">
	<cfparam name="attributes.xfa_submit_password" default="fuseaction=users.password">
	
	<cfparam name="attributes.email" default="#qry_get_user.email#">
	<cfparam name="attributes.username" default="#qry_get_user.username#">
	

<cfoutput>
<form name="editform" action="#XHTMLFormat('#request.self#?#attributes.xfa_submit_password##request.token2#')#" method="post">

<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Update Username &amp; Password"
width="400"
required_fields="0"
>
	
	<cfif len(attributes.Message)>
	<tr>
		<td colspan="3" align="center" class="formerror">#attributes.Message#<br/><br/></td></tr>
	</cfif>
	<tr>
		<th colspan="3">ALL fields are required. You will have to<br/>
						 re-log in if you change your username.</th>
	</tr>
<tr><td colspan="3"><img src="#Request.AppSettings.defaultimages#/spacer.gif" height="3" width="1" alt="" /></td></tr>

<cfif get_User_Settings.EmailAsName>
	
	<tr>
		<td align="right" valign="baseline">Email Address:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td><input type="text" size="30" name="email" value="#HTMLEditFormat(attributes.email)#" class="formfield"/>
		<cfif get_User_Settings.UseEmailConf><br/><span class="formtextsmall">Your account unlock key will be emailed to this address.</span></cfif>
		</td></tr>
		<input type="hidden"  size="30" name="Username" value="name_is_email"/>
<cfelse>
	<tr>
		<td align="right">Username:</td>
		<td style="background-color: ###Request.GetColors.formreq#;">&nbsp;</td>
		<td><input type="text" size="30" name="Username" value="#HTMLEditFormat(attributes.Username)#" maxlength="50" class="formfield"/></td></tr>
</cfif>
	<tr>
		<td align="right">Current Password:</td>
<td style="background-color: ###Request.GetColors.formreq#;">&nbsp;</td>
		<td><input type="password" name="old_password" class="formfield"/></td></tr>
		
	<tr>
		<td align="right">New Password:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="password" size="30" name="password" class="formfield"/></td></tr>

	<tr>
		<td align="right" nowrap="nowrap">Re-enter&nbsp;Password:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="password"  size="30" name="Verify" class="formfield"/></td></tr>
		
	<tr><td colspan="3"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="3" width="1" /></td></tr>
	
	<tr align="left">
	<td></td><td></td>
	<td><input type="submit" name="submit_password" value="Update" class="formbutton"/>
	 <input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/></td></tr>
	<tr>
    	<td></td><td></td>
		<td>
		<table class="formtext" border="0" cellpadding="0" cellspacing="0" style="color: ###Request.GetColors.InputTText#;">
		<tr><td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td>&nbsp;required fields</td></tr></table>
		</td></tr>
		
</cfmodule>


</form>
</cfoutput>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">

objForm = new qForm("editform");

objForm.required("<cfif get_User_Settings.EmailAsName>email<cfelse>Username</cfif>,old_password,password,Verify");

<cfif get_User_Settings.EmailAsName>
objForm.email.validateEmail();
</cfif>

objForm.password.validatePassword('Verify',6,20);

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>	

