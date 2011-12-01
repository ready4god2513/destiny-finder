<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Default page to display when the user tries to access the wishlist and is not logged in. Called by the fuseaction shopping.wishlist --->

<cfset attributes.xfa_success = request.loginURL>

<cfmodule template="../customtags/puttitle.cfm" TitleText="Wish List" class="page">

<br/>

<table width="100%" cellpadding="0" cellspacing="3" class="mainpage">
	<tr>
		<td valign="top" width="55%">
		<span class="formtitle">Please log in to view or add items to your wish list. </span>
	<br/><br/>
	If you don't have an account, it only takes a moment to create one.
	
		<cfoutput>
		<br/><br/><input type="button" name="create" value="Create Account" class="formbutton" onclick="javascript:self.location.href ='#Request.SecureURL##request.self#?fuseaction=users.#request.reg_form#&amp;xfa_success=#urlEncodedFormat(attributes.xfa_success)##Request.AddToken#'"/></li></cfoutput>
	</ul>

		</td>
		
<cfoutput><td bgcolor="###request.GetColors.linecolor#"><img src="#request.appsettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		<td><img src="#request.appsettings.defaultimages#/spacer.gif" alt="" height="1" width="8" /></td>
</cfoutput>
		<td valign="top" >
		<span class="formtitle">Please Sign In	</span><br/><br/>
		<!--- USER Box 	--->
		<cfmodule template="../#request.self#" 
			fuseaction="users.loginbox"
			xfa_login_successful = "#Request.LoginURL#"
			use_register = "0"
			format="_nobox"
			> 
		</td>
	</TR>
</table>