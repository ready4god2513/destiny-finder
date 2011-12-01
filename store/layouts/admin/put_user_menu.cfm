<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for Users. Called by users.admin --->

<cfparam name="totaltabs" default="0">
<cfparam name="usermenu" default="">


<cfmodule template="../../access/secure.cfm"
keyname="users"
requiredPermission="13"
>	

<!--- If page being called is a user admin page, set tabs open on User menu --->
<cfif (FindNoCase("users.admin", attributes.xfa_admin_link))>
	<cfset tabstart = totaltabs>
</cfif>

<cfset totaltabs = totaltabs + 1>

<cfsavecontent variable="usermenu">

<cfoutput>

		<form name="searchform" action="#request.self#?fuseaction=users.admin&User=list&show=All#request.token2#" method="post" target="AdminContent" class="nomargins">
		<input type="text" name="string" value="enter user name..." size="20" maxlength="100" class="accordionTextBox" onfocus="searchform.string.value = '';" onchange="submit();" />
		</form>

	<!--- users permission 4 = group & user admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="4"
	>	
	
<!--- Check for credit cards to verify --->
	<cfif get_User_Settings.UseCCard>
		<cfset innertext = Application.objMenus.getValidUserCCs()>
		<div id="Memberships_Div" spry:region="txtPending"><a href="#self#?fuseaction=users.admin&user=list&show=all&cardisvalid=0&cardnumber=1#Request.Token2#" onmouseover="return escape(user1)" target="AdminContent">Approve Credit Cards</a>:<br/> <span style="color: red"><span id="usercount" spry:content="{UserCCs}">#innertext#</span> approval.</span><br/><br/>
		</div>
	</cfif>
	<!--- end credit card verify --->
	<a href="#self#?fuseaction=users.admin&User=list#Request.Token2#" onmouseover="return escape(user2)" target="AdminContent">Users</a><br/>
	<a href="#self#?fuseaction=users.admin&group=list#Request.Token2#" onmouseover="return escape(user3)" target="AdminContent">Groups</a><br/>
	<a href="#self#?fuseaction=users.admin&Customer=list#Request.Token2#" onmouseover="return escape(user4)" target="AdminContent">Customer Addresses</a><br/>
	<a href="#self#?fuseaction=users.admin&account=list#Request.Token2#" onmouseover="return escape(user5)" target="AdminContent">Accounts</a><br/>
	<a href="#self#?fuseaction=users.admin&email=select#Request.Token2#" onmouseover="return escape(user6)" target="AdminContent">Send Emails</a><br/>
	<a href="#self#?fuseaction=users.admin&user=loginReport#Request.Token2#" onmouseover="return escape(user7)" target="AdminContent">Recent Logins Report</a><br/>
	</cfmodule>
	
	<!--- users permission 1 = site admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<a href="#self#?fuseaction=users.admin&settings=edit#Request.Token2#" onmouseover="return escape(user9)" target="AdminContent">User Settings</a><br/>
	</cfmodule>
	
</cfoutput>

</cfsavecontent>

</cfmodule>
