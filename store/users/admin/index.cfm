
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page runs all the administrative functions for the users circuit. It is called by the users.admin fuseaction and uses the additonal parameters to determine the functions to run. These include:

users.admin&group= 		: group management
users.admin&user=		: user management
users.admin&settings=	: user settings
users.admin&customer=	: customer addresses
users.admin&account=	: business accounts
users.admin&email=		: send emails to user
users.admin&automail=	: send system emails
users.admin&mailtext=	: administer standard email texts
users.admin&download=	: download customer addresses

 --->


<cfif isdefined("attributes.group")>
	<!--- Group Administration --->	
	<cfset Webpage_title = "Group #attributes.group#">
	
	<!--- users permission 4 = group admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="4"
	>	
	<cfif ispermitted>
	
	<cfswitch expression = "#attributes.group#">
		<cfcase value="list">
			<cfinclude template="group/qry_get_groups.cfm">
			<cfinclude template="group/dsp_groups_list.cfm">
		</cfcase>
			
		<cfcase value="add">
			<cfinclude template="group/dsp_group_form.cfm">
		</cfcase>
			
		<cfcase value="edit">
			<cfinclude template="group/qry_get_group.cfm"> 
			<cfinclude template="group/dsp_group_form.cfm">
		</cfcase>
			
		<cfcase value="permissions">
			<!--- access permission 1 = assign permissions --->
			<cfmodule template="../../access/secure.cfm"
			keyname="access"
			requiredPermission="1"
			>	
			<cfif ispermitted>	
				<cfparam name="attributes.type" Default="Group">
				<cfparam name="attributes.id" Default="#attributes.GID#">
				<cfinclude template="permissions/act_set_permissions.cfm">
			</cfif>
		</cfcase>
		
		<cfcase value="act">
			<cfinclude template="group/act_group.cfm">
			<cfset attributes.XFA_success="fuseaction=users.admin&group=list">
			<cfset attributes.box_title="Group">
			<cfinclude template="../../includes/admin_confirmation.cfm">	
		</cfcase>
	
		<cfdefaultcase><!--- List --->
			<cfinclude template="group/qry_get_groups.cfm">
			<cfinclude template="group/dsp_group_form.cfm">
		</cfdefaultcase>
	</cfswitch>
			
	</cfif>
			
<cfelseif isdefined("attributes.user")>	
	<!--- User Administration --->	
	<cfset Webpage_title = "User #attributes.user#">

	<!--- users permission 8 = user admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="4"
	>	
	<cfif ispermitted>
	
	<cfswitch expression = "#attributes.user#">
			
		<cfcase value="list">
			<cfif isdefined("attributes.assign")>
				<cfinclude template="user/act_assign_user.cfm">
			</cfif>
			<cfif isdefined("attributes.string")>
				<cfset attributes.un=attributes.string>
			</cfif>
			<cfinclude template="user/qry_get_users.cfm">
			<cfif qry_get_users.recordcount is 1 and isdefined("attributes.string")>
				<cflocation url="#self#?fuseaction=users.admin&user=summary&uid=#qry_get_users.user_ID##request.token2#" addtoken="No">
			</cfif>
			<cfinclude template="user/dsp_users_list.cfm">
		</cfcase>
			
		<cfcase value="add">
			<cfparam name="attributes.XFA_success" default="fuseaction=users.admin&user=list">
			<cfinclude template="user/dsp_user_form.cfm">
		</cfcase>
			
		<cfcase value="edit">
			<cfparam name="attributes.XFA_success" default="fuseaction=users.admin&user=list">
			<cfinclude template="user/qry_get_user.cfm"> 
			<cfinclude template="user/dsp_user_form.cfm">
		</cfcase>
			
		<cfcase value="act">
			<cfinclude template="user/act_user.cfm">
			<cfset attributes.box_title="User">
			<cfinclude template="../../includes/admin_confirmation.cfm">
		</cfcase>			
			
		<cfcase value="resetpw">
			<cfparam name="attributes.email" default="">
			<cfparam name="attributes.uid" default="0">

			<!--- Make sure this is not the admin user and in demo mode --->
			<cfif Request.DemoMode AND attributes.uid IS 1>
				<cfset attributes.box_title="New Password">
				<cfset attributes.error_message = "Password cannot be reset for the admin user while in demo mode">
			<cfelse>
				<cfinclude template="../login/act_forgot_pass.cfm">	
				<cfset attributes.message="New Password has been emailed to user">
			</cfif>			
			
			<cfset attributes.box_title="New Password">			
			<cfset attributes.XFA_success="fuseaction=users.admin&user=edit&uid=#attributes.uid#">
			<cfinclude template="../../includes/admin_confirmation.cfm">	
		</cfcase>
		
		<cfcase value="authorize">
			<!--- tests credit card --->
			<cfinclude template="user/qry_get_user.cfm">
			<cfinclude template="../act_use_ccard.cfm">
			<cfinclude template="user/act_set_registration_permissions.cfm">

			<!--- Goes to user edit form --->
			<cflocation url="#self#?fuseaction=users.admin&user=edit&UID=#attributes.uid##Request.Token2#">
		</cfcase>		
			
		<cfcase value="listform">
			<cfinclude template="user/qry_get_users.cfm">
			<cfinclude template="user/dsp_users_list_form.cfm">
		</cfcase>
			
		<cfcase value="actform">
			<cfinclude template="user/act_users_list_form.cfm">
		</cfcase>	
				

		<cfcase value="permissions">
			<!--- access permission 1 = assign permissions --->
			<cfmodule template="../../access/secure.cfm"
			keyname="access"
			requiredPermission="1"
			>	
			<cfif ispermitted>	
		
				<cfparam name="attributes.type" Default="User">
				<cfparam name="attributes.id" Default="#attributes.UID#">
				<cfinclude template="permissions/act_set_permissions.cfm">
		
			</cfif>	
		</cfcase>
		

		<cfcase value="affiliate">
			<cfif isdefined("attributes.submit_aff")>
				<cfinclude template="user/act_affiliates.cfm">
			<cfelse>
				<cfinclude template="user/dsp_affiliates.cfm">
			</cfif>
		</cfcase>	
		
		<cfcase value="unlock">
			<cfinclude template="user/act_unlock.cfm">
			<cfset attributes.user="edit">
			<cfinclude template="user/qry_get_user.cfm">
			<cfinclude template="user/dsp_user_form.cfm">
		</cfcase>			
		
		<cfcase value="unblock">
			<cfinclude template="user/act_unblock.cfm">
			<cfinclude template="user/qry_get_user.cfm">
			<cfinclude template="user/dsp_user_summary.cfm">
		</cfcase>	
		
		<!---- User Summary Code --->
		<cfcase value="summary">
			<cfparam name="attributes.UID" default="#Session.User_ID#">
			<cfinclude template="user/qry_get_user.cfm"> 
			<cfinclude template="user/dsp_user_summary.cfm">
		</cfcase>	
		
		<cfcase value="loginreport">
			<cfinclude template="user/qry_login_report.cfm">
			<cfinclude template="user/dsp_login_report.cfm">
		</cfcase>	
		<cfdefaultcase><!--- List --->
			<cfinclude template="user/qry_get_users.cfm">
			<cfinclude template="user/dsp_users_list.cfm">
		</cfdefaultcase>	
			
	</cfswitch>
	
	</cfif>
			
<cfelseif isdefined("attributes.customer")>			
	<!--- Customer (address records) Administration --->	
	<cfset Webpage_title = "Customer #attributes.customer#">
	
	<!--- users permission 4 = user admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="4"
	>	
	<cfif ispermitted>
	
	<cfswitch expression = "#attributes.customer#">
		<cfcase value="list">
			<cfinclude template="customer/qry_get_customers.cfm">
			<cfinclude template="customer/dsp_customers_list.cfm">
		</cfcase>
			
		<cfcase value="add">
			<cfparam name="attributes.XFA_success" default="fuseaction=users.admin&customer=list">
			<cfinclude template="customer/dsp_customer_form.cfm">
		</cfcase>
			
		<cfcase value="edit">
			<cfparam name="attributes.XFA_success" default="fuseaction=users.admin&customer=list">
			<cfinclude template="customer/qry_get_customer.cfm"> 
			<cfinclude template="customer/dsp_customer_form.cfm">
		</cfcase>
			
		<cfcase value="act">
			<cfinclude template="customer/act_customer.cfm">
			<cfset attributes.box_title="Customer">
			<cfinclude template="../../includes/admin_confirmation.cfm">	
		</cfcase>			
			
		<cfdefaultcase><!--- List --->
			<cfinclude template="customer/qry_get_customers.cfm">
			<cfinclude template="customer/dsp_customers_list.cfm">
		</cfdefaultcase>	
		
	</cfswitch>

		</cfif>
		
<cfelseif isdefined("attributes.account")>		
	<!--- Account Administration --->	
	<cfset Webpage_title = "Account #attributes.account#">
		
	<!--- users permission 4 = user admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="4"
	>	
	<cfif ispermitted>

	<cfswitch expression = "#attributes.account#">
		<cfcase value="list">
			<cfinclude template="account/qry_get_accounts.cfm">
			<cfinclude template="account/dsp_accounts_list.cfm">
		</cfcase>
			
		<cfcase value="add">
			<cfparam name="attributes.XFA_success" default="fuseaction=users.admin&account=list">
			<cfinclude template="account/dsp_account_form.cfm">
		</cfcase>
			
		<cfcase value="edit">
			<cfparam name="attributes.XFA_success" default="fuseaction=users.admin&account=list">
			<cfinclude template="account/qry_get_account.cfm"> 
			<cfinclude template="account/dsp_account_form.cfm">
		</cfcase>
			
		<cfcase value="act">
			<cfinclude template="account/act_account.cfm">
			<cfset attributes.box_title="Account">
			<cfinclude template="../../includes/admin_confirmation.cfm">	
		</cfcase>			
			
		<cfdefaultcase><!--- List --->
			Error - This is the default Account Fuseaction. I don't understand what you want.
		</cfdefaultcase>	
		
	</cfswitch>	
	</cfif>
	
<cfelseif isdefined("attributes.download")>		
	<!--- Download User File --->	
	<cfset Webpage_title = "Download Admin">

	<!--- users permission 16 = download ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="8"
	>	
	<cfif ispermitted>
	
	<cfswitch expression = "#attributes.download#">
		<cfcase value="user_cust">
			<cfinclude template="download/customer_download.cfm">
		</cfcase>
			
		<cfdefaultcase>
			<cfinclude template="customer/qry_get_customers.cfm">
			<cfinclude template="customer/dsp_customers_list.cfm">
		</CFdefaultCASE>	
		
	</cfswitch>
	</cfif>


<cfelseif isdefined("attributes.settings")>	
	<!--- Group Administration --->	
	<cfset Webpage_title = "User Settings">

	<!--- users permission 1 = user setup ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<cfif ispermitted>
	
	<cfswitch expression = "#attributes.settings#">			
		<cfcase value="edit">
			<cfinclude template="settings/dsp_user_settings.cfm">
		</cfcase>
			
			<cfcase value="save">
				<cfinclude template="settings/act_user_settings.cfm">
				<cfset attributes.XFA_success="fuseaction=home.admin">
				<cfset attributes.box_title="User Settings">
				<cfinclude template="../../includes/admin_confirmation.cfm">		
				
			</cfcase>	
			
			<cfdefaultcase>
				<cfinclude template="settings/dsp_user_settings.cfm">
			</cfdefaultcase>
	</cfswitch>
	
	</cfif>	
	
		
<cfelseif isdefined("attributes.email")>		
	<!--- User Email Administration --->	
	<cfset Webpage_title = "Email #attributes.email#">
	
	<!--- users permission 4 = user admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="4"
	>	
	<cfif ispermitted>

	<cfswitch expression = "#attributes.email#">
	
		<cfcase value="select">
			<cfinclude template="email/qry_getemails.cfm">
			<cfinclude template="email/dsp_select_form.cfm">
		</cfcase>
		
		<cfcase value="write">
			<cfparam name="attributes.xfa_success" default="fuseaction=home.admin">
			<cfinclude template="email/qry_getemails.cfm">
			<cfinclude template="email/dsp_email.cfm">
		</cfcase>
		
		<cfcase value="send">
			<cfparam name="attributes.Preview" default="0">
			<cfinclude template="email/qry_getemails.cfm">
			<cfif attributes.Subject is not "" and attributes.body is not "">
				<cfinclude template="email/act_email.cfm">

				<!--- Confirmation --->
				<cfif Attributes.Preview is not "1">
					<cfset attributes.box_title="Send Email">
					<cfinclude template="../../includes/admin_confirmation.cfm">	
				</cfif>

			<cfelse>
				<cfset attributes.message = "Please fill out the form completely.">
				<cfinclude template="email/dsp_email.cfm">
			</cfif>
		</cfcase>

		<cfdefaultcase>
			<cfinclude template="email/qry_getemails.cfm">
			<cfinclude template="email/dsp_select_form.cfm">
		</cfdefaultcase>	
		
	</cfswitch>
	
	</cfif>
	
<cfelseif isdefined("attributes.mailtext")>		

	<cfset Webpage_title = "Email Text">
	
	<!--- users permission 4 = user admin ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="4"
	>	
	<cfif ispermitted>

	<cfswitch expression = "#attributes.mailtext#">
		
		<cfcase value="list">
			<cfinclude template="email/qry_get_mailtexts.cfm">
			<cfinclude template="email/dsp_mailtext_list.cfm">
		</cfcase>
			
		<cfcase value="add">
			<cfinclude template="email/dsp_mailtext_form.cfm">
		</cfcase>
			
		<cfcase value="edit">
			<cfinclude template="email/qry_get_mailtext.cfm"> 
			<cfinclude template="email/dsp_mailtext_form.cfm">
		</cfcase>
		
		<cfcase value="copy">
			<cfinclude template="email/act_copy_mailtext.cfm"> 
			<cfinclude template="email/qry_get_mailtext.cfm"> 
			<cfinclude template="email/dsp_mailtext_form.cfm">
		</cfcase>		
		
		<cfcase value="act">
			<cfinclude template="email/act_mailtext.cfm">
			<cfset attributes.XFA_success="fuseaction=users.admin&mailtext=list">
			<cfset attributes.box_title="Email Text">
			<cfinclude template="../../includes/admin_confirmation.cfm">
		</cfcase>
			
		<cfdefaultcase><!--- List --->
			<cfinclude template="email/qry_get_mailtexts.cfm">
			<cfinclude template="email/dsp_mailtext_list.cfm">
		</cfdefaultcase>
	</cfswitch>
	
	</cfif>
	
<cfelse><!--- MENU --->	
	<cfinclude template="dsp_menu.cfm">
</cfif>


