
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- The user module allows users to sign up and log in and maintain their registration info.

LOGIN/LOGOUT FUNCTIONS =====================

users.Login  - process user login infomation

users.Logout - log users out	

users.PurgeCooke - a follow-up box when users who selected the 'remember me' option log out
	and press the 'clear form' button. Provides the option of disabling 'remember me'.

users.Loginbox
	The login box is intended to be included on layout templates and toggles between a
	log-in and log-out box. 
	
	Place a login box in a template like this:
	
		<cfmodule template="#self#" 
		fuseaction="users.loginbox"
		format="_box"  						// appended to dsp_login and dsp_logout file name
		user_id="#Session.User_ID#"
		xfa_login_successful 				// defaults to self
		xfa_cookie_login					// defaults to xfa_login_successful
		xfa_logout_successful               // defaults to self
		Use_rememberme
		use_register						// toggles "register now" link on and off
		>

	NOTE: If the login box displays a "register now" link, the actual page/format that the 
	link goes to is set by the variable request.reg_form. There are four different 
	registration pages defined below. ( newUser | register | customer | account )

users.forgot - provides a form for users to enter their email address
	and have their user name and password emailed to them. This is the 
	'password help' link in the login box.

		
ACCOUNT MANAGER =============
		
Users.manager - displays the user's "manager" page where they can update their infomation
	and see thier past orders, etc.

Users.AddressBook - presents the list of customer addresses that a user has created.
	Allows new addresses to be created and addresses to be edited.	

Users.adress			| these forms are
Users.email 			| used to maintain
Users.password 			| registration information
Users.birthdate			| and are called from 
Users.email				| user.manager ('My Account') and
Users.subscribe 		| secure.cfm 

Users.unlock - a form called by secure.cfm to validate a user email address when email 
	verification is enabled. The users.unlock circuit can also be called directly to
	verify an email address. A link can be placed in the confirmation email that a 
	user can click or enter into a web browser: URL or href= "#request.appsettings.siteURL##self#?fuseaction=users.unlock&email=#users.email#&emaillock=#users.emaillock#"
	
	
USER REGISTRATION ===============	
Customers can, of course, register during the checkout process. However, they can also
choose to register before. There are 4 different of registration forms that can be used 
when a new user chooses to register on the site by clicking the 'create account' button.
The default form is set on the fbx_settings.cfm template in root directory:
	
	<CFPARAM NAME="request.reg_form" DEFAULT="register">  

	users.register - The standard sign-up process which takes the user from form to 
	form as required:
	
		login form => customer form => shipto form (if used) => account form (if used)

As an alternative to the standard registration process, several single page forms are
provided to simplify the registration process, depending on the site's needs:
	
	Users.newuser - Creates only a user login. 

	Users.member - Login and customer address on a single form. 

	Users.account - Login, customer and account info on a single form.
	
users.directory - provides a directory page of Accounts. Used, for example, to create 
	a "store locator" directory of wholesale accounts.

USER ADMIN ======================
Users.admin - Administation Menu
Users.kill - A quick way to log out and delete all cookies useful for development
--->


<!------------------ USER LOGIN FUNCTIONS ------------------------------------>

<cfif CompareNoCase(fusebox.fuseaction, "login") IS 0>
	<!--- Presents a standard log-in form. Users.login circuit can be called directly 
	or placed as a custom tag. When the form is submitted successfully, 
	successful logins forward to attributes.xfa_login_successful which defaults to 
	users.manager. --->
	
	<!--- This tag does nothing in end mode - prevents circuit from running twice when called by as custom tag. --->
	<cfif isDefined("ThisTag.ExecutionMode") AND ThisTag.ExecutionMode eq "END">
		<cfexit method="EXITTAG">
	</cfif>	
	
	<cfset Webpage_title = "Login">
	<cfparam name="attributes.xfa_login_successful" default="#self#?fuseaction=users.manager">
	<!--- The format attribute sets what style of box is presented. 
	The default style has a standard input form border --->
	<cfparam name="attributes.format" default="">
	
	<cfinclude template="login/act_login.cfm">
	<cfinclude template="login/dsp_login#attributes.format#.cfm">

<cfelseif CompareNoCase(fusebox.fuseaction, "logout") IS 0>
	<!--- logs a user out --->
	<cfparam name="attributes.xfa_logout_successful" default="#self#?fuseaction=users.manager">
	
	<cfif get_User_Settings.UseRememberMe>
		<cfif isDefined("cookie.#request.ds#_Username")>			
			
			<!--- clear only if submit_login has been pressed [clear button]--->
			<cfif isdefined("attributes.submit_logout")>
				<cfinclude template="login/act_logout.cfm">
				
			<!--- If users checked the 'remember me' box when logging in, 
			their login	information is stored in a browser cookie. Don't log
			these users out but display a login form pre-filled with their 
			user information with the option to 'clear form' --->
			<cfelse>
				<cfset attributes.Username = cookie[request.ds & '_Username']>
				<cfset attributes.password = cookie[request.ds & '_password']>
				<cfset attributes.xfa_LoginAction = "fuseaction=users.login">
				<cfinclude template="login/dsp_login.cfm">
			</cfif>
		<cfelse>
			<cfset attributes.submit_logout = 1>
			<cfinclude template="login/act_logout.cfm">
		</cfif>
	<cfelse>
		<cfset attributes.submit_logout = 1>
		<cfinclude template="login/act_logout.cfm">
	</cfif>

	
<cfelseif CompareNoCase(fusebox.fuseaction, "loginbox") IS 0>
	<!--- This is used to display a log/logout box which is always on the page --->
	<cfparam name="attributes.format" default="_box"><!--- default box or sidebar --->
	<cfparam name="fuseaction" default=""> 
	
	<cfif Session.User_ID or isdefined("attributes.submit_logout")>
	
		<cfparam name="attributes.xfa_logout_successful" default="#Request.LoginURL#">
		
		<!--- if logging out and "remember me" is enabled, forward to warning screen --->
		<cfif isdefined("attributes.submit_logout") AND get_User_Settings.UseRememberMe 
			AND isDefined("cookie.#request.ds#_Username") AND NOT isdefined("attributes.purgecookie")>
			<cflocation url="#Request.SecureURL##self#?fuseaction=users.purgecookie&amp;xfa_logout=#attributes.xfa_logout_successful##Request.AddToken#" addtoken="No">
		</cfif>				
		
		<cfinclude template="login/act_logout.cfm">
		
		<cfif fuseaction is "users.purgecookie" AND isDefined("cookie.#request.ds#_Username")>
			<cfset attributes.Username = cookie[request.ds & '_Username']>
			<cfset attributes.password = cookie[request.ds & '_password']>
			<cfparam name="attributes.xfa_LoginAction" default="index.cfm?fuseaction=users.manager">

			<cfinclude template="login/dsp_login#attributes.format#.cfm">
		<cfelseif Session.User_ID >
			<cfinclude template="login/dsp_logout#attributes.format#.cfm">
		</cfif>

	<cfelse>
		<!--- intended for margin, default success to same page --->
		<cfparam name="attributes.xfa_login_successful"	default="#Request.LoginURL#">
			
		<cfif get_User_Settings.UseRememberMe AND isDefined("cookie.#request.ds#_Username") AND NOT isDefined("attributes.errormess")>
			<cfparam name="attributes.xfa_cookie_login" default="#attributes.xfa_login_successful#">
			<cfset attributes.Username = cookie[request.ds & '_Username']>
			<cfset hashed_password = cookie[request.ds & '_password']>
			<cfset attributes.password = "">
			<cfset attributes.submit_login = "login">
			<cfset attributes.rememberme = "1">
			<cfset attributes.xfa_login_successful = attributes.xfa_cookie_login>
		</cfif>
		
		<cfif fuseaction is not "users.purgecookie">		
			<cfinclude template="login/act_login.cfm">
		</cfif>
		
		<cfinclude template="login/dsp_login#attributes.format#.cfm">
	
	</cfif>
	

<cfelseif CompareNoCase(fusebox.fuseaction, "purgecookie") IS 0>
	<!--- Displays the 'Disable Auto-Login' box when a user clicks the 'Clear Form'
	button on logout. Users can 'Log out Completely' or save their 'remember me' 
	information --->
	<cfparam name="attributes.purgecookie" default=0>
	<cfparam name="attributes.xfa_logout" default="#self#?">
	<cfparam name="attributes.xfa_logout_successful" default="#attributes.xfa_logout#">
	<cfif attributes.purgecookie>
		<cfset attributes.submit_logout = 1>
		<cfinclude template="login/act_logout.cfm">
	<cfelse>
		<cfinclude template="login/dsp_purge_cookie.cfm">
	</cfif>


<!------------------ ADMIN FUNCTIONS ------------------------------------>
<cfelseif CompareNoCase(fusebox.fuseaction, "admin") IS 0>
	<!--- User Administration ---->
	<cfinclude template="admin/index.cfm">
	
<!------------------ ACCOUNT DIRECTORY ------------------------------------>
<cfelseif CompareNoCase(fusebox.fuseaction, "directory") IS 0>
	<cfset Webpage_title = "Store Directory">
	<cfparam name="attributes.thickline" default="1">
	<cfinclude template="account/qry_get_accounts.cfm">
	<cfinclude template="account/dsp_results.cfm">

	
<!------------------ MY ACCOUNT PAGE ------------------------------------>
<cfelseif CompareNoCase(fusebox.fuseaction, "manager") IS 0>
	<!-----------------------------------------------------------
	To require that specific user information, update the required permissions below.
	Users will not be able to access thier My Account page without passing this security
	check. You can list multiple items (eg: requiredPermissions="1,2,4").
	0:  		   - login only (used alone; it is implied with the others)
	1:	email_ok   - email not known to be bad	
	2:	email_conf - email address confirmed
	4:	customer   - customer record exists
	8:	account    - account record exists			
	16:	adult      - birthdate is over 18	
	32:	cc_ok      - cc validated                 ---------->
	<cfset Webpage_title = "My Account">
	<cfif get_User_Settings.UseEmailConf>
		<cfset defaultPerm = 2>
	<cfelse>
		<cfset defaultPerm = 1>
	</cfif>
	<cfparam name="attributes.xfa_login_successful" default="#self#?fuseaction=users.manager">

		<cfmodule template="../access/secure.cfm"
		keyname="login"			
		requiredPermission="#defaultperm#" 
		xfa_login_successful="#attributes.xfa_login_successful#">
		<cfif ispermitted>
			<cfinclude template="manager/dsp_manager.cfm">
		</cfif>		
	
	
<!------------------ USER REGISTRATION FUNCTIONS ------------------------------------>
<cfelseif CompareNoCase(fusebox.fuseaction, "register") IS 0>
	<!--- The standard sign-up process which takes the user from form to form as required:
		1) login form 
		2) customer form 
		3) shipto form (if shipping addresses allowed in User Settings) 
		4) account form (if accounts are set to be required in User Settings)
	 --->
	<cfset Webpage_title = "User Registration">
	<!--- Successful registration ends in User Manager by default --->
	<cfparam name="attributes.xfa_success" default="#self#?fuseaction=users.manager">
	<cfinclude template="do_register.cfm">
	

<!--- An alternate registration form for login information ONLY. --->
<cfelseif CompareNoCase(fusebox.fuseaction, "newuser") IS 0>
	<cfset Webpage_title = "User Registration">
	<cfparam name="attributes.xfa_success" default="#self#?fuseaction=users.manager">
	
	<cfif isdefined("attributes.addlogin")>
		<cfset attributes.UseCCard = 0> 
		<cfinclude template="act_register.cfm">
	</cfif>
	
	<cfif Session.User_ID is 0> 
		<cfparam name="attributes.xfa_submit_login" default="#Request.query_string#">
		<cfinclude template="dsp_registration_form.cfm">
	<cfelse>
		<cflocation url="#attributes.xfa_success##Request.Token2#" addtoken="No">
	</cfif>


<!--- An alternate registration form has login and customer address info on one page. --->
<cfelseif CompareNoCase(fusebox.fuseaction, "member") IS 0>
	<cfset Webpage_title = "User Registration">
	
	<cfinclude template="qry_get_user.cfm">	
	<cfparam name="attributes.xfa_success" default="#self#?fuseaction=users.manager">
	
	<cfif isdefined("attributes.submit_member") and attributes.submit_member is "Submit">	
		<cfinclude template="act_member_add.cfm">
	</cfif>

	<cfif isdefined("attributes.submit_member") and attributes.submit_member is "Update Information">
		<cfif attributes.customer_id is "0">
			<cfset attributes.submit_customer = "Add">
			<cfinclude template="act_customer.cfm">
		</cfif>
		
		<cfif get_User_Settings.UseCCard and NOT attributes.CardisValid>	
			<cfinclude template="act_register.cfm">
		</cfif>
	</cfif>
		
	<cfset attributes.xfa_submit_member = "fuseaction=users.member">
	<cfinclude template="dsp_member_form.cfm">
	
	
<!--- An alternate registration form that has login, customer and account information on a single form. 
	Can also be called directly to create an account for a user who is already registered. --->
<cfelseif CompareNoCase(fusebox.fuseaction, "account") IS 0>
	<cfinclude template="qry_get_user.cfm">
	<cfset attributes.xfa_success = "#self#?fuseaction=users.manager">

	<!--- If the user has an account, get the account info. --->
	<cfif qry_get_user.recordcount and qry_get_user.accountID neq '' and qry_get_user.accountID neq 0>
		<cfinclude template="act_account_update.cfm">
	<cfelse>
		<cfinclude template="act_account_add.cfm">
	</cfif>
		
	<cfset attributes.xfa_submit_account = "fuseaction=users.account">
	<cfinclude template="dsp_account_form.cfm">
	
	
<!------------------ USER ACCOUNT MANAGEMENT FUNCTIONS ------------------------------------>


<!--- Emails password to users who forgot theirs.  --->
<cfelseif CompareNoCase(fusebox.fuseaction, "forgot") IS 0>
	<cfparam name="attributes.email" default="">
	<cfset Webpage_title = "Password Help">
	<cfif len(attributes.email)>
		<cfinclude template="login/act_forgot_pass.cfm">
		<cfinclude template="login/dsp_forgot_pass_results.cfm">
	<cfelse>
		<cfinclude template="login/dsp_forgot_pass.cfm">
	</cfif>		

<!--- lists all the addresses (customer records) that a user has created ---->
<cfelseif CompareNoCase(fusebox.fuseaction, "AddressBook") IS 0>
	<cfmodule template="../access/secure.cfm"
	 keyname="login"
 	requiredPermission="0">
 	<cfif ispermitted>
  
  	<!--- The 'show' parameter sets which address is shown as chosen. 
	show = (defaults to customer)
		customer - update default customer address (users.customer_ID) from user.manager
		ship - update default shiping to address (users.shipto) from user.manager
		bill - update default account address (account.customer_ID) from user.manager
		billto - selects a billing address during checkout
		shipto - select a shipping address during checkout 
	--->
  	<cfparam name="attributes.show" default="customer">
	<cfset Webpage_title = "Address Book">
 
  	<cfif not isdefined("attributes.xfa_success")>
    	<cfif attributes.show is "billto" or attributes.show is "shipto">
   			<cfset attributes.xfa_success = "#self#?fuseaction=shopping.checkout">
  		<cfelse>
     		<cfset attributes.xfa_success = "#self#?fuseaction=users.manager">
  		</cfif>
  	</cfif>
  
  	<cfif isdefined("attributes.submit_addressbook")>
   		<cfinclude template="manager/act_addressbook.cfm">
  	</cfif>
  	<cfinclude template="manager/dsp_addressbook.cfm">
 </cfif>

<!--- Customer address update --->
<cfelseif CompareNoCase(fusebox.fuseaction, "Address") IS 0>
	<cfmodule template="../access/secure.cfm"
	 keyname="login"
 	requiredPermission="0">
 	<cfif ispermitted>
	
		<!--- The address edit form --->
		<cfset Webpage_title = "Contact Information">
		<cfif isdefined("attributes.submit_customer")>
			<cfparam name="attributes.xfa_customer_success" default= "fuseaction=users.addressbook&amp;show=#attributes.show#">
			<cfinclude template="act_customer.cfm">
		</cfif>
		
		<cfparam name="attributes.mode" default="address">
		<cfset attributes.xfa_submit_customer="fuseaction=users.address">
		<cfinclude template="dsp_customer_form.cfm">
	
	</cfif>

<!--- Form to update the user's email address --->
<cfelseif CompareNoCase(fusebox.fuseaction, "email") IS 0>
	<cfmodule template="../access/secure.cfm"
	 keyname="login"
 	requiredPermission="0">
 	<cfif ispermitted>
		<!--- The email editing form ---->
		<cfset Webpage_title = "Update Email Address">
		<cfif isdefined("attributes.submit_email")>
			<cfinclude template="manager/act_email_update.cfm">
		</cfif>
		<cfinclude template="manager/dsp_email_update.cfm">
	</cfif>

<cfelseif CompareNoCase(fusebox.fuseaction, "unlock") IS 0>
<!--- Called by secure.cfm to confirm email addresses. This circuit can also be called directly so it can be used as a link in the confirmation email. The user simply clicks the link to unlock their account: href="#request.appsettings.siteURL##self#?fuseaction=users.unlock&email=#users.email#&emaillock=#users.emaillock#" --->
	<cfset Webpage_title = "Email Confirmation">	
	
	<!--- Process Email Confirmation code if submitted --->
	<cfinclude template="act_unlock.cfm">
	
	<!--- If Confirmation not submitted, email Confirmation or display form. --->
	<cfinclude template="qry_get_user.cfm">
	
	<cfif qry_get_user.recordcount AND qry_get_user.emaillock is ''>
		<cfinclude template="act_email_conf.cfm">
		<cfinclude template="dsp_email_conf.cfm">
	<cfelseif qry_get_user.recordcount>
		<cfinclude template="dsp_unlock_form.cfm">
	<cfelseif len(attributes.error_message)>
		<cfinclude template="../includes/form_confirmation.cfm">
	</cfif>


<!--- Re-sends an email confirmation email to the user --->
<cfelseif CompareNoCase(fusebox.fuseaction, "sendlock") IS 0>
	<cfmodule template="../access/secure.cfm"
	 keyname="login"
 	requiredPermission="0">
 	<cfif ispermitted>
		<cfinclude template="qry_get_user.cfm"> 
		<cfset Webpage_title = "Unlock Account">
		<cfinclude template="act_email_conf.cfm">
		<cfinclude template="dsp_email_conf.cfm">
	</cfif>


<!--- The password update form --->
<cfelseif CompareNoCase(fusebox.fuseaction, "password") IS 0>
	<cfset Webpage_title = "Update Password">
	<cfmodule template="../access/secure.cfm"
	 keyname="login"
 	requiredPermission="0">
 	<cfif ispermitted>
		<cfif isdefined("attributes.submit_password")>
			<cfinclude template="manager/act_password_update.cfm">
		</cfif>
		<cfinclude template="qry_get_user.cfm">
		<cfinclude template="manager/dsp_password_update.cfm">
	</cfif>


<!--- The birthdate update form --->
<cfelseif CompareNoCase(fusebox.fuseaction, "birthdate") IS 0>
	<cfset Webpage_title = "Update Birthdate">
	<cfmodule template="../access/secure.cfm"
	 keyname="login"
 	requiredPermission="0">
 	<cfif ispermitted>
		<cfif isdefined("attributes.submit_birthdate")>
			<cfinclude template="manager/act_birthdate_update.cfm">
		</cfif>
		<cfinclude template="manager/dsp_birthdate_update.cfm">
	</cfif>

<cfelseif CompareNoCase(fusebox.fuseaction, "ccard") IS 0>
	<!--- The credit card information editing form. This is not the credit card information
	used at checkout, but for sites that store credit card information as part of the 
	registration process. --->
	<cfset Webpage_title = "Edit Credit Card Information">
	<cfmodule template="../access/secure.cfm"
	 keyname="login"
 	requiredPermission="0">
 	<cfif ispermitted>
		<cfif isdefined("attributes.submit_ccard")>
			<cfinclude template="manager/act_ccard_update.cfm">
		</cfif>
	<cfinclude template="manager/dsp_ccard_update.cfm">
	</cfif>

<cfelseif CompareNoCase(fusebox.fuseaction, "deleteccard") IS 0>
	<!--- The credit card information deletion request from the editing form. --->
	<cfset Webpage_title = "Delete Credit Card Information">
	<cfmodule template="../access/secure.cfm"
	 keyname="login"
 	requiredPermission="0">
 	<cfif ispermitted>
	<cfinclude template="manager/act_ccard_delete.cfm">
	<cfinclude template="manager/dsp_ccard_update.cfm">
	</cfif>

<!--- Toggles the users.subscribe field on and off. Called from users.manager (My Account) --->
<cfelseif CompareNoCase(fusebox.fuseaction, "subscribe") IS 0>
	<cfinclude template="manager/act_subscribe.cfm">
	
	
<!--- a useful command when developing and testing the shopping cart Users.kill will REALLY log you out completely. --->
<cfelseif CompareNoCase(fusebox.fuseaction, "kill") IS 0>
	<cfcookie name="#request.DS#_basket" value="0" expires="NOW">	
	<cfset attributes.submit_logout = 1>
	<cfparam name="attributes.xfa_logout_successful" default="#Request.LoginURL#">
	<cfinclude template="login/act_logout.cfm">

<!--- no valid fuseaction found --->
<cfelse>
	<cfmodule template="../#self#" fuseaction="page.pageNotFound">
	
</cfif>
