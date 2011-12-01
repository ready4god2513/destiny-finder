<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Default page used when the user tries to access an area of the site requiring them to be logged in. Called by secure.cfm  --->

<cfparam name="attributes.xfa_login_successful" default = "#Request.LoginURL#">
<cfparam name="attributes.xfa_success" default = "#attributes.xfa_login_successful#">

<cfif NOT isDefined("XHTMLFormat")>
	<cfinclude template="../includes/cfw_functions.cfm">
</cfif>

<!--- If this is an admin page, redirect to the top of the frameset --->
<cfif FindNoCase(".admin", attributes.xfa_success)>
	<cfprocessingdirective suppresswhitespace="no">
	<script type="text/javascript">
	<!--		
	if (top !=self)
		<cfif isDefined("attributes.cache")>
			top.location=<cfoutput>'#Request.SecureURL##request.self#?fuseaction=home.admin#Request.AddToken#&redirect=yes';</cfoutput>
		<cfelse>
			top.location=self.location;
		</cfif>		
	//-->
	</script>
	</cfprocessingdirective>
</cfif>

<!----	----->
<cfmodule template="../customtags/puttitle.cfm" TitleText="My Account" class="page">

<br/>
<table width="100%" cellpadding="0" cellspacing="3" class="mainpage">
	<tr>
		<td valign="top" width="55%">
		<cfoutput>
		<form action="#XHTMLFormat('#Request.SecureURL##request.self#?fuseaction=users.#request.reg_form#&xfa_success=#urlEncodedFormat(attributes.xfa_success)##request.token2#')#" method="post"></cfoutput>
		<span class="formtitle">Create a New Account</span><br/>
	Creating an account takes only a moment.<br/>
	<ul>
		<li>Save your billing and shipping information for faster checkout.</li>
		<li>Quick access to your Order History.</li>
		<li>Save items in your shopping bag between visits.</li>
		<li>Sign-up for email updates on news and promotions.</li>
		<li>Open a professional, wholesale or distributor account.</li>
		<li>Become a store affiliate and earn commission for referrals.</li>
	</ul>
	<br/><br/>
	<div align="center"><input type="submit" name="create" value="Create Account" class="formbutton"/></div>
	</form>
	</td>
		
<cfoutput><td bgcolor="###request.GetColors.linecolor#"><img src="#request.appsettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		<td><img src="#request.appsettings.defaultimages#/spacer.gif" alt="" height="1" width="8" /></td>
</cfoutput>
		<td valign="top" >
		<span class="formtitle">Please Sign In</span><br/><br/>
		<!--- USER Box 	--->
		<cfmodule template="../#request.self#"
			fuseaction="users.loginbox"
			use_register = "0"
			format="_nobox"
			>  
		</td>
	</tr>
</table>



<br/><br/>