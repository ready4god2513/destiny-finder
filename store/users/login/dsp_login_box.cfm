<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- A style of login box where the login form is framed by a drawn border. This is the default style for the users.loginbox and at 130px wide is appropropriately sized to be placed in a side column on the page layout. 

This template is can be called by users.login, users.loginbox and users.logout circuits. --->
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

<!--- which user circuit is used to 'register now'.
	'None' turnes off the register now link. --->
<cfparam name="request.reg_form" default="none"> 
	
<!--- this box always returns to same page in case of login error. --->

<!----- LINE Box Start -------------->  
	<table cellpadding="0" cellspacing="0" width="130" border="0">
    <tbody>
	<tr><td colspan="3"><img src="images/spacer.gif" alt="" width="1" height="4" border="0" align="middle" /></td></tr>
      <tr valign="top" align="left"> 
        <td width="4"><img src="images/box_TL.gif" width="4" height="5" border="0" alt="" /></td>
        <td width="112" class="LoginBoxTop"><img src="images/box_T.gif" height="5" alt="" width="4" /></td>
        <td width="4"><img src="images/box_TR.gif" height="5" alt="" width="4" /></td>
      </tr>
   
      <tr valign="top" align="left"> 
        <td class="LoginBoxLeft"><img src="images/box_L.gif" height="4" alt="" width="4" /></td>
        <td>
		
<!---- LOGIN Table Start --------------->
		
<cfoutput>
<form name="loginform" action="#XHTMLFormat('#Request.SecureURL##Request.LoginURL##Request.AddToken#')#" method="post" class="nomargins">
<input type="hidden" name="submit_login" value="login"/>	
<table border="0" cellspacing="0" cellpadding="0" class="menu_page">
		
	 <cfif len(Message)>
 		<tr><td class="formerrorsmall" align="center">#Message#</td></tr>
 	</cfif>
				
                <tr> 
                  <td class="FormTextVerySmall" ><cfif get_User_Settings.EmailAsName>email<cfelse>username</cfif><br/> 
				  <input type="text" name="username" value="#HTMLEditFormat(attributes.Username)#" class="formfieldlogin"/>
                    password<br/> <input name="password" type="password" value="#HTMLEditFormat(attributes.password)#"  class="formfieldlogin"/>
<cfif get_User_Settings.UseRememberMe>
<input type="checkbox" name="rememberme"  class="formfieldcheckbox" value="1" #doChecked(attributes.rememberme)# /> 
<span class="FormTextSmall">remember me</span> 
</cfif>
					</td>
                </tr>
                <tr> 
                    <td height="30">
			<!--- Hidden field to keep track of SSL status of page --->
			<input type="hidden" name="Server_Port" value="#CGI.SERVER_PORT#"/>
			<input type="submit" name="name" value="sign in" class="formbutton"/> 
			<input type="button" name="name" value="register" class="formbutton" onclick="window.location='#Request.SecureURL##self#?fuseaction=users.#request.reg_form##Request.AddToken#&amp;xfa_success=#urlEncodedFormat(Request.LoginURL)#';" />
	<!--- Some alternate code to replace the HTML submit button above with an image: 
		<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=users.#request.reg_form##Request.AddToken#')#" #doMouseover('register now')# class="menu_page"><img src="images/button_join.jpg" width="68" height="22" border="0" /></a>
	----->			
					</td>
                </tr>
				
                <tr> 
                  <td align="center">
				  <a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=users.forgot#Request.AddToken#')#" class="menu_page" #doMouseover('password help')#><span class="FormTextSmall">password help</span></a></td>
                </tr>
              </table>
</form>				
</cfoutput>		

<!-------- LINE Box End ----->
		</td>
        <td class="LoginBoxRight"><img src="images/box_R.gif" height="5" alt="" width="4" /></td>
      </tr>
      <tr valign="top" align="left"> 
        <td><img src="images/box_BL.gif" width="4" height="5" alt="" /></td>
        <td class="LoginBoxBottom"><img src="images/box_B.gif" height="5" alt="" width="4" /></td>
        <td><img src="images/box_BR.gif" width="4" height="5" alt="" /></td>
      </tr>
    </tbody>
  </table>
<!----- End Box ---->
