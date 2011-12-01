<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.purgecookie circuit, this template displays the 'Disable Auto-Login' box when a user clicks the 'Clear Form' button on logout. Users are given the choice to 'Log out Completely' or save their 'remember me'	information --->

<!--- this box always returns to same page in case of login error. --->
<cfparam name="attributes.xfa_LoginAction" default="#Request.query_string#">
	
<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Disable Auto-Login"
width="300"
required_fields="0"
>	
<!--- inner table with header and login info --->
<cfoutput>	
		<tr>
			<td class="formtext">
			You enabled the Automatic Login (remember me) feature when you logged in. By logging out completely now, you will disable the auto-login for your next visit.
			</td>
		</tr>		
		<tr>
         	<td align="center" class="formtitle"><a href="#XHTMLFormat('#self#?fuseaction=users.purgecookie&purgecookie=1&xfa_logout=#HTMLEditFormat(attributes.xfa_logout)##Request.Token2#')#">Log Out Completely</a>

			</td>
 		</tr>
		<tr>
         	<td align="center" class="formtitle"><a href="javascript:window.history.go(-1);">Keep Remember Me</a>
			</td>
 		</tr>
</cfoutput>	

</cfmodule>
