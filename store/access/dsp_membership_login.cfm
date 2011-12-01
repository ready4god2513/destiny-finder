<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used for sites that do not have a persistent login box. 

It appears on Members Only protected pages if the User is NOT logged in.

This form displays BOTH a login box and list of memberhip products they can purchase. Called from secure.cfm

--->

<cfset Session.Page = Request.CurrentURL>

<cfmodule template="../#request.self#"
	fuseaction="page.membersOnly"
	>
	

	<!--- Sign-in box ---->
<table width="100%" border="0" cellspacing="3" cellpadding="0" align="left" class="mainpage">
	<tr>

	<cfif not Session.User_ID>

		<td valign="top" width="40%">
		<span class="formtitle">Members Please Sign In	</span><br/><br/>
		<!--- USER Box 		format="_nobox"	--->
		<cfmodule template="../#request.self#" 
			fuseaction="users.loginbox"
			use_register = "0"
			format="_nobox"
			> 
		</td>

<cfoutput><td bgcolor="###request.GetColors.linecolor#"><img src="#request.appsettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		<td><img src="#request.appsettings.defaultimages#/spacer.gif" alt="" height="1" width="8" /></td>
</cfoutput>		

	</cfif>
		<td width="60%" valign="top">
		<span class="formtitle">OR Get <i>Instant Access</i> by Joining Now!</span><br/><br/>
		<!--- insert a list of membership products --->
<cfmodule template="../#request.self#"
	fuseaction="product.list"
	category_id=""
	type="membership"
	searchheader="0"
	searchform="0"
	searchfooter="0"
	listing="membership">
		
		
		</td>
	</tr>	
</table>
