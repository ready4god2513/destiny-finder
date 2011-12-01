<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.loginbox to display the log out button when the user is logged in. This style of login box has a drawn border frame designed to be placed in a side column on the in the page layout. --->

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
<form action="#XHTMLFormat(Request.currentURL)#" method="post" class="nomargins">
<table width="122" border="0" cellspacing="0" cellpadding="0" class="menu_page">
	<tr><td align="center">
		Welcome #session.username#!
  		<br/>
  		<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=users.manager#Request.AddToken#')#" class="menu_page" #doMouseover('go to my account manager')#><strong>My Account</strong></a>
		<br/><br/>
		<input type="submit" name="submit_logout" value="Log Out" class="formbutton"/>
	</td></tr>	
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
