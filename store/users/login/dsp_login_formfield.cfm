<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- A style of login box for inclusion in a standard 3 column form. This style is used in checkout's customer information form. 

This template is can be called by users.login, users.loginbox and users.logout circuits. --->
<cfparam name="Message" default="">
<cfparam name="attributes.Username" default="">
<cfparam name="attributes.password" default="">
<cfparam name="attributes.rememberme" default=0>
<cfparam name="attributes.errormess" default="0">

<cfif attributes.errormess IS 1>
	<cfset Message = "Password was incorrect!">
<cfelseif attributes.errormess IS 2>
	<cfset Message = "Username was not found!">
<cfelseif attributes.errormess IS 3>
	<cfset Message = "Too many failed login attempts!">
<cfelseif attributes.errormess IS 4>
	<cfset Message = "Max logins for today exceeded!">
</cfif>

<!--- this box always returns to same page in case of login error. --->
<tr><td colspan="3" align="center" class="formtext">
<cfoutput>
<form name="login" action="#XHTMLFormat('#Request.SecureURL##Request.LoginURL##Request.AddToken#')#" method="post">
<input type="hidden" name="rememberme" value="#attributes.rememberme#"/>
<table width="100%" border="0" cellpadding="0" cellspacing="3" class="formtext">
	
	<tr>
		<td colspan="3" class="formtitle">
		Returning Customers, Please Sign In
		</td>
	</tr>
	<tr>
		<td colspan="3" class="formtext" align="center">
			<cfif len(Message)>
 				<span class="formerror">#Message#</span><br/>
 	 		<cfelse>
			Returning customers should sign in to auto-fill this form.	
	 		</cfif>
		</td>
	</tr>
	<tr>
    	<td align="right">
			<cfif get_User_Settings.EmailAsName>
				Email Address:
			<cfelse>
				Username: 
			</cfif>
		</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td><input type="text" name="Username" size="30" maxlength="50" value="#HTMLEditFormat(attributes.Username)#" class="formfield"/></td>
	</tr>
 	<tr>
       	<td align="right">Password:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
       	<td><input type="password" name="password" size="30" maxlength="50" value="#HTMLEditFormat(attributes.password)#" class="formfield"/></td>
 	</tr>
	<tr>
	<td colspan="2">&nbsp;</td>
	<td><a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=users.forgot#Request.AddToken#')#">Password Help</a></td>
	</tr>
	<tr align="left">
       	<td colspan="2">&nbsp;</td>
       	<td>
		<!--- Hidden field to keep track of SSL status of page --->
		<input type="hidden" name="Server_Port" value="#CGI.SERVER_PORT#"/>
		<input type="submit" name="submit_login" value="Login" class="formbutton"/></td>
 	</tr>
</cfoutput>
	</table>	
  	</form>
	
	<cfprocessingdirective suppresswhitespace="no">
	<script type="text/javascript">
	<!--
	objForm = new qForm("login");
	
	objForm.required("Username,password");
	
	objForm.Username.focus();
	
	qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
	//-->
	</script>
	</cfprocessingdirective>

	</td></tr>
