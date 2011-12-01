<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.loginbox to display the log out button when the user is logged in. This default style uses the input form box. --->

<!--- this box always returns to same page in case of login error. --->
<cfoutput>
<form action="#XHTMLFormat(Request.CurrentURL)#" method="post">
	
<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Please Login"
width="180"
required_fields="0"
>
		<tr>
        	<td align="center">&nbsp;</td>
         	<td><input type="submit" name="submit_logout" value="Log Out" class="formbutton"/></td>
 		</tr>
</cfmodule>
</form>
</cfoutput>	