
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is called from users.login and users.loginbox circuits to processes the login form --->

<cfparam name="attributes.xfa_login_successful" default="#self#?fuseaction=users.manager">

<cfparam name="attributes.submit_login" default="">
<cfparam name="attributes.rememberme" default="0">
<cfparam name="Message" default="">

<!--- Clear any error message on the URL --->
<cfset errormess = 0>

<!--- if we have a user ID and the form is not being submitted, we're done! --->
<cfif Session.User_ID and NOT Len(attributes.submit_login)>
	<cfif len(trim(attributes.xfa_login_successful))>
		<!--- Redirect user back to the page they were on --->
		<cfinclude template="dsp_result.cfm">
	</cfif>
</cfif>

<cfif attributes.submit_login is "login">

	<!--- Get user information --->
	<cfquery name="qry_get_user" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" maxrows=1>
		SELECT U.User_ID, U.Password, U.Username, U.Group_ID, U.Permissions, C.FirstName, C.LastName, CardisValid, 
			Basket, CardExpire, CardNumber, EmailIsBad, LastLogin, LoginsDay, FailedLogins, LastAttempt
		FROM #Request.DB_Prefix#Users U
		LEFT JOIN #Request.DB_Prefix#Customers C On C.Customer_ID = U.Customer_ID
		WHERE U.Username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.UserName#">
		AND U.Disable = 0
	</cfquery>

	<cfif qry_get_user.RecordCount>
	
		<!--- compare to hashed password if read from "remember me cookie" --->
		<cfparam name="hashed_password" default="">	
			
		<!--- Make sure user is not locked out due to failed login attempts --->
		<cfif qry_get_user.FailedLogins GTE get_user_settings.MaxFailures AND 
				DateCompare(qry_get_user.lastattempt, DateAdd("h", -1, now())) GTE 0>
				
				<cfset errormess = 3>
				<cfinclude template="dsp_result.cfm">

		<!--- passwords are case-sensitive (Compare() is also, "IS" is not) --->
		<cfelseif Compare(qry_get_user.Password, Hash(attributes.Password)) IS 0 
				OR Compare(qry_get_user.Password, hashed_password) IS 0>
		
			<!--- CODE TO PREVENT MULTIPLE LOGINS OF A SINGLE USER 
			Calculate number of logins for today, to see if they exceed maximum login setting --->
			<cfif get_user_settings.MaxDailyLogins GT 0 AND DateCompare(qry_get_user.lastlogin, now(), "d") is 0>
				
				<cfset LoginsDay = qry_get_user.LoginsDay + 1>	
			
				<!--- Send Alert Email to site Admin if user has logged in more than half the maximum. --->	
				<cfif loginsDay GT (get_user_settings.MaxDailyLogins/2) AND qry_get_user.Group_ID IS NOT 1>
					<cfmail to="#request.appsettings.merchantemail#" from="#request.appsettings.merchantemail#"
					subject="#request.appsettings.sitename# Alert - #qry_get_user.username# login ## #loginsDay#"
					server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
					User #qry_get_user.username# ID (User ID #qry_get_user.user_id#)
					has now logged in #loginsDay# times today.
					</cfmail>
				
					<!--- C) Abort login if user has logged in more than the maximum allowed today. --->
					<cfif loginsDay GT get_user_settings.MaxDailyLogins>
						<cfset errormess = 4>
					</cfif>
				
				</cfif>
			
			<cfelse>	
				<cfset LoginsDay = 1>
			</cfif>
			<!--- end maximum logins code --->	
					
			<cfquery name="lastlogin" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Users 
				SET LastLogin = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
					FailedLogins = 0,
					LastAttempt = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
					LoginsTotal = LoginsTotal + 1,
					LoginsDay = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#LoginsDay#">
				WHERE User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_user.User_ID#">
			</cfquery>
			
			<!--- If no error so far, continue logging in --->
			<cfif errormess IS 0>
			
				<!--- Get the user's previous shopping cart and if no items currently in the cart, use it instead --->
				<cfif len(qry_get_user.Basket) AND qry_get_user.Basket IS NOT Session.BasketNum AND NOT FindNoCase('shopping.checkout',attributes.xfa_login_successful)>
					<cfset qry_Get_Basket = Application.objCart.getBasket()>
					<cfif NOT qry_Get_Basket.RecordCount>
						<cfset Session.BasketNum = qry_get_user.Basket>
					<!--- <cfset temp = Application.objCart.copyBasketItems(qry_get_user.Basket)> --->
					</cfif>
				</cfif>
			
				<!--- Refresh the basket query --->
				<cfset qry_Get_Basket = Application.objCart.getBasket()>
				
				<!--- Update basket cookie --->
				<cfcookie name="#request.DS#_Basket" value="#Session.BasketNum#" expires="60">
				
				<!--- If the site is using SSL set the random security cookie --->
				<cfif Request.secure_cookie>
					<cfset Session.SpoofCheck = CreateUUID()>
					<cfheader name="Set-Cookie" value="SiteID=#Hash(Session.SpoofCheck)#;secure=true;path=#Request.StorePath#;HTTPOnly">
				</cfif>
			
				<cfinclude template="act_set_login_permissions.cfm">
				
				<!--- If user has a coupon in the session, recheck it --->
				<cfif len(Session.Coup_code)>
					<cfset attributes.Coupon = Session.Coup_code>
				</cfif>
				
				<!--- Recalculate the shopping cart --->
				<cfinclude template="../../shopping/basket/act_recalc.cfm">
								
				<!--- Enter basket number in User record --->
				<cfquery name="AddBasket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Users 
				SET Basket = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
				WHERE User_ID = #qry_get_user.User_ID#
				</cfquery>

				<!--- Delete any customer records --->
				<cfquery name="ClearCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#TempCustomer
				WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
				</cfquery>

				<cfquery name="ClearShip" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#TempShipTo 
				WHERE TempShip_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
				</cfquery>
			
				<!--- process REMEMBER ME --->	
				<cfif get_User_Settings.UseRememberMe>	
					<!--- check to see if RememberMe was checked in the form. --->
					<cfif attributes.rememberme AND NOT isDefined("cookie.#request.ds#_Username")>
						<cfcookie name="#request.DS#_username" value="#attributes.username#" expires="365">	
						<cfcookie name="#request.DS#_password" value="#Hash(attributes.password)#" expires="365">
						
					<cfelseif NOT attributes.rememberme>
					<!--- remember me was not checked, so delete cookie if exists. --->
						<cfif isDefined("cookie.#request.ds#_Username")>
							<cfcookie name="#request.DS#_username" value="0" expires="NOW">
							<cfcookie name="#request.DS#_password" value="0" expires="NOW">	
						</cfif>
					</cfif><!--- act rememberme --->
			
				</cfif><!--- use rememberme --->
				
				<cfif qry_get_user.EmailIsBad is 1>
					<cfhtmlhead text="
	<script language=""JavaScript"" TYPE=""text/javascript"">
	alert('Please update your Email Address.');
	window.location = '#Request.SecureURL##self#?fuseaction=users.email&redirect=1#Request.AddToken#';
	</script>
					">		
				</cfif>
				
				<cfif get_User_Settings.UseCCard AND len(qry_get_user.CardNumber) AND DateCompare(qry_get_user.CardExpire,now(),'m') is 0 >
					<cfhtmlhead text="
	<script language=""JavaScript"" TYPE=""text/javascript"">
	alert('Your Credit Card will expire this month. Please take a moment to update your information.');
	window.location = '#Request.SecureURL##self#?fuseaction=users.ccard&redirect=1#Request.AddToken#';
	</script>			
					">
				</cfif>
				
				<cfif get_User_Settings.UseCCard AND len(qry_get_user.CardNumber) AND DateCompare(qry_get_user.CardExpire,now(),'m') lt 0 >
					<cfhtmlhead text="
	<script language=""JavaScript"" TYPE=""text/javascript"">
	alert('Your Credit Card on file has expired. Please take a moment to update your information.');
	window.location = '#Request.SecureURL##self#?fuseaction=users.ccard&redirect=1#Request.AddToken#';
	</script>
					">		
				</cfif>
			
			</cfif>
			<!--- end error check --->
					
		<!--- Redirect user back to the page they were on --->
		<cfinclude template="dsp_result.cfm">
	
	<cfelse>
		<cfset errormess = 1>
		<cfinclude template="dsp_result.cfm">
		<cfquery name="failedlogin" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users 
			SET FailedLogins = FailedLogins + 1,
				LastAttempt = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
			WHERE Username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.UserName#">
		</cfquery>
		<!--- clear any saved cookies, invalid information --->
		<cfcookie name="#request.DS#_username" value="0" expires="NOW">
		<cfcookie name="#request.DS#_password" value="0" expires="NOW">
	</cfif>
	
<cfelse>
	<cfset errormess = 2>
	<cfinclude template="dsp_result.cfm">
	<cfquery name="failedlogin" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Users 
		SET FailedLogins = FailedLogins + 1,
			LastAttempt = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
		WHERE Username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.UserName#">
	</cfquery>
	<!--- clear any saved cookies, invalid information --->
	<cfcookie name="#request.DS#_username" value="0" expires="NOW">
	<cfcookie name="#request.DS#_password" value="0" expires="NOW">
</cfif>

</cfif>

<cfif attributes.submit_login is "logout">

	<cfinclude template="act_logout.cfm">

</cfif>	


