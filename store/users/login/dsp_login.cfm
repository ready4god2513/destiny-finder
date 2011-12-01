<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the default style of login box for users.login circuit. It displays a login form inside a standard input form box. 
This template can be called by users.login, users.loginbox and users.logout circuits. --->
<cfparam name="Message" default="">
<cfparam name="attributes.Username" default="">
<cfparam name="attributes.password" default="">
<cfparam name="attributes.rememberme" default=1>
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

<!--- a parameter passed to turn off the 'register now' link --->
<cfparam name="attributes.use_register" default=1>

<!--- where to go to register now. 'None' turnes off the register now link. --->
<cfparam name="request.reg_form" default="none"> 
	
<!--- this box always returns to same page in case of login error. --->
<cfparam name="attributes.xfa_LoginAction" default="#Request.query_string#">

<cfif len(attributes.xfa_LoginAction)>
	<cfset AddToken = Request.AddToken>
<cfelse>
	<cfset AddToken = "?" & Request.AddToken>
</cfif>


<cfoutput>
<form action="#XHTMLFormat('#Request.SecureURL##request.self#?#attributes.xfa_LoginAction##AddToken#')#" method="post">

<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Please Sign In"
width="350"
required_fields="0"
>

	<cfif len(Message)>
		<tr>
			<td colspan="2" align="CENTER">
				<div align="center" class="formerror"><b>#Message#</b></div><p>
			</td>
		</tr>
	</cfif>
	
		<tr align="left">
    		<td align="right">
				<cfif get_User_Settings.EmailAsName>
					Email Address:
				<cfelse>
					Username: 
				</cfif>
			</td>
			<td><input type="text" name="Username" size="30" maxlength="50" value="#HTMLEditFormat(attributes.Username)#" class="formfield"/></td>
		</tr>
 		<tr align="left">
        	<td align="right">Password:</td>
         	<td><input type="password" name="password" size="30" maxlength="25" value="#HTMLEditFormat(attributes.password)#" class="formfield"/></td>
 		</tr>
		
	<cfif get_User_Settings.UseRememberMe>
		<tr align="left">
		<td align="right">remember me:</td>
	   	<td><input type="checkbox" name="rememberme" value="1" #doChecked(attributes.rememberme)# /></td>
		</tr>
	</cfif>		
		
		<tr align="left">
        	<td>&nbsp;</td>
         	<td>
			<!--- Hidden field to keep track of SSL status of page --->
			<input type="hidden" name="Server_Port" value="#CGI.SERVER_PORT#"/>
			<input type="submit" name="submit_login" value="Login" class="formbutton"/></td>
 		</tr>

 	<tr>
		<td align="center" colspan="2" class="formtext">
	 		<br/>
			<a href="#XHTMLFormat('#Request.SecureURL##request.self#?fuseaction=users.forgot#Request.AddToken#')#">forgot your login?</a>
			<cfif attributes.use_register and request.reg_form is not "none">
				<br/>
		 		<a href="#XHTMLFormat('#Request.SecureURL##request.self#?fuseaction=users.#request.reg_form##Request.AddToken#&xfa_success=#URLEncodedFormat(attributes.xfa_LoginAction)#')#">register now!</a>						
			</cfif>
		</td>
	</tr>
</cfmodule>

</form>
</cfoutput>

	

