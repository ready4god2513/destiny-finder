<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Inserts login form fields. Called during user registration from the users\dsp_account_form.cfm, users\dsp_member_form.cfm and users\dsp_registration_form.cfm templates. ---->


<cfoutput>
<cfif get_User_Settings.EmailAsName>	
	<tr align="left">
		<td align="right" valign="baseline">Email Address:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td><input type="text" size="30" name="email" value="#HTMLEditFormat(attributes.email)#" class="formfield"/>
		<cfif get_User_Settings.UseEmailConf><br/><span class="formtextsmall">Your account unlock key will be emailed to this address.</span></cfif>
		</td></tr>
		<input type="hidden"  size="30" name="Username" value="name_is_email"/>
<cfelse>
	<tr align="left">
		<td align="right">Username:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text"  size="30" name="Username" value="#HTMLEditFormat(attributes.Username)#" maxlength="50" class="formfield"/></td></tr>
</cfif>
		
		
	<tr align="left">
		<td align="right">Password:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="password" size="30" name="password" class="formfield"/></td></tr>

	<tr align="left">
		<td align="right" nowrap="nowrap">Re-enter&nbsp;Password:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="password"  size="30" name="Verify" class="formfield"/></td></tr>
	
<cfif NOT get_User_Settings.EmailAsName>
	<tr align="left">
		<td align="right" valign="baseline">Email Address:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" size="30" name="email" value="#HTMLEditFormat(attributes.email)#" class="formfield"/>
		<cfif get_User_Settings.UseEmailConf><br/><span class="formtextsmall">Your account unlock key will be emailed to this address.</span></cfif>
		</td></tr>
</cfif>
</cfoutput>