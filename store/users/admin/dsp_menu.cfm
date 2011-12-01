<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for Users. Called by users.admin --->
<cfmodule template="../../access/secure.cfm"
keyname="users"
requiredPermission="1,4,8"
>	
<cfoutput>
	<table width="90%" class="mainpage"><tr><td><strong>Users</strong></td>
		<form name="searchform" action="#request.self#?fuseaction=users.admin&User=list&show=All#request.token2#" method="post">
		<td align="right"><input type="text" name="string" value="enter user name..." size="20" maxlength="100" class="formfield" onfocus="searchform.string.value = '';" onchange="submit();" />
		</td></form>
	</tr></table>

	<ul>
	<!--- users permission 4 = group & user admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="4"
	>	
	
	<cfinclude template="../qry_get_user_settings.cfm">
	
<!--- Check for credit cards to verify --->
	<cfif get_User_Settings.UseCCard>
		<cfset attributes.CardisValid = 0>
		<cfset attributes.cardnumber = 1>
		<cfset attributes.show = "all">
		<cfinclude template="user/qry_get_users.cfm">
		<cfif qry_get_users.recordcount>
			<li><a href="#self#?fuseaction=users.admin&user=list&show=all&CardisValid=0&cardnumber=1#Request.Token2#"><strong>Validate Credit Cards</strong></a>: <span class="formerror"><strong>#qry_get_users.recordcount# card(s) require validation.</strong></span></li>
		</cfif>
	</cfif>
	<!--- end credit card verify --->
	<li><a href="#self#?fuseaction=users.admin&User=list#Request.Token2#">Users</a>: Log-in information for site users.</li>
	<li><a href="#self#?fuseaction=users.admin&group=list#Request.Token2#">Groups</a>: Define groups that users can be placed in.</li>
	<li><a href="#self#?fuseaction=users.admin&Customer=list#Request.Token2#">Customer Addresses</a>: Users' billing, shipping and other addresses.</li>
	<li><a href="#self#?fuseaction=users.admin&account=list#Request.Token2#">Accounts</a>: Business account information	</li>
	<li><a href="#self#?fuseaction=users.admin&email=select#Request.Token2#">Send Email</a>: Send an email to subscribed users, affiliates or selected group.</li>
	<li><a href="#self#?fuseaction=users.admin&user=loginReport#Request.Token2#">Recent Logins Report</a>: A listing of user login activity for the last 30 days.</li>
	</cfmodule>

	<!--- users permission 8 = user admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="8"
	>	
	<li><a href="#self#?fuseaction=users.admin&download=user_cust#Request.Token2#">Download Users</a>: Download all user information to an Excel file.</li>
	</cfmodule>
	
	<!--- users permission 1 = site admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<li><a href="#self#?fuseaction=users.admin&settings=edit#Request.Token2#">User Settings</a>: Define how customer accounts and addresses are handled.</li>
	</cfmodule>
	
</cfoutput>
</ul>
</cfmodule>
