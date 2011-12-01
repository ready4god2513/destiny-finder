<cfinclude template="templates/adminheader.cfm"> 
<cfparam name="url.status" default="">
<table align="center"><tr><td>
<div align="center">
<span class="adminerror">
<cfif url.status eq "loginfailed">
<strong>LOGIN FAILED</strong> - Incorrect password<br><br>
<cfelseif url.status eq "inactive">
<strong>LOGIN FAILED</strong> - Your login has be deactivated by the site administrator.<br><br>
<cfelseif url.status eq "nouser">
<strong>LOGIN FAILED</strong> - Incorrect username<br><br>
</cfif>
</span>
<span class="admincontent">
Enter your password and press the Admin Login button.
<br><br>
<cfform action="validate_login.cfm" method="POST" enablecab="Yes">
<table width="200" border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td width="50%"><div align="right">Username:</div></td>
    <td width="50%">&nbsp;
      <cfinput type="text" name="Username" size="10" maxlength="10" class="form_element"></td>
  </tr>
  <tr>
    <td colspan="2" height="5"></td>
    </tr>
  <tr>
    <td><div align="right">Password:</div></td>
    <td>&nbsp;
      <cfinput type="Password" name="LoginPassword" size="10" maxlength="10" class="form_element"></td>
  </tr>
</table>
  <br>
<input type="submit" value="Admin Login" style="font-size: 8pt;">
</cfform>

<strong>Please Note:</strong> Your password is case sensitive.</div>
</span>
</td></tr></table>
<cfinclude template="templates/adminfooter.cfm">