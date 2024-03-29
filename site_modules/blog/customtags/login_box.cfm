<cfparam name="ATTRIBUTES.processing_url" default="index.cfm">
<cfparam name="ATTRIBUTES.destination_url" default="index.cfm">
<cfparam name="ATTRIBUTES.create_account_option" default="0">

<cfset obj_login = CreateObject("component","site_modules.blog.cfcs.login")>

<cfif isDefined('FORM.user_name')>
	<!--- RUN THE LOGIN FUNCTION --->
	<cfset VARIABLES.process_login = obj_login.login_form_action()>
	
	<cfif VARIABLES.process_login EQ "login_fail">
		<cfset VARIABLES.login_message = "I'm sorry your username and password did not match.">
	<cfelse>
		<cflocation url="#ATTRIBUTES.destination_url#" addtoken="no">
		<cfabort>
	</cfif>
</cfif>

<cfif isDefined('VARIABLES.login_message')>
	<cfoutput>#VARIABLES.login_message#</cfoutput>
</cfif>

<cfoutput>
	<form name="form" action="#ATTRIBUTES.processing_url#" method="post">
		<table width="280" border="0" cellspacing="0" align="center" cellpadding="3" class="table_reset" style="margin-left:auto;margin-right:auto;">
		 <tr>
		 	<td colspan="2">
				Please Login </td>
            <td></td>
		 </tr>
         <tr>
          	<td>&nbsp;</td>
            <td></td>
            <td></td>
          </tr>
		  <tr>
			<td width="70">Username:</td>
			<td width="160"><input type="text" name="user_name"></td>
            <td width="50"></td>
		  </tr>
		  <tr>
			<td>Password:</td>
			<td> <input type="password" name="password"/></td>
            <td></td>
		  </tr>
		  		  <tr>
			<td colspan="2"><div align="right">
			  <a href="javascript: document.form.submit();" style="text-decoration: none;">Login</a><!--- <input type="image" src="/assets/images/login_arrow.gif" name="submit" style="border: none; margin: 2px 10px 2px 10px;" align="absmiddle"> --->
		    </div></td>
            <td></td>
		  </tr>
          <tr>
          	<td>&nbsp;</td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td colspan="3">
				<cfif ATTRIBUTES.create_account_option EQ 1>
					<div align="left">Not an author? <a href="index.cfm?page=blog&newuser=1">Click here to create a free account.</a></div> 
				</cfif>
			</td>
          </table>
          </form>
          
    <p>&nbsp;</p>
    <p>&nbsp;</p>
</cfoutput>
	
