
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called from the users.register switch and takes the user from one form to the next through the full new user sign-up process:

	1) login form => 
	2) billing/customer information form => 
	3) shipto form if used => 
	4) account information form if used => 
	5) Return to XFA_Success (defaults to users.manager)
	
The registration form will reflect the current values in UserSettings.
--->

<!--- Process any forms submitted --->
<cfif isdefined("attributes.act")>
	<cfswitch expression = "#attributes.act#">

		<cfcase value="login">
			<cfset attributes.UseCCard = 0> 
			<cfinclude template="act_register.cfm">
		</cfcase>

		<cfcase value="customer">
			<cfinclude template="act_customer.cfm">
		</cfcase>
		
		<cfcase value="shipto">
			<cfinclude template="act_customer.cfm">
		</cfcase>
		
		<cfcase value="account">
			<cfinclude template="qry_get_user.cfm">
			<cfinclude template="act_account_add.cfm">
		</cfcase>

	</cfswitch>
</cfif>


<!--- Determine if we're done or what needs to be displayed next --->
<cfset done = 0>

<!--- Display LOGIN if needed (if user_id is 0) --->
<cfif Session.User_ID is 0> 

	<cfset attributes.xfa_submit_login="fuseaction=users.register&act=login">
	<cfif isdefined("attributes.xfa_success")>
		<cfset attributes.xfa_submit_login="#attributes.xfa_submit_login#&xfa_success=#URLEncodedFormat(attributes.xfa_success)#">
	</cfif>
	
	<cfinclude template="dsp_registration_form.cfm">
	
<cfelse><!--- We're logged in... --->

	<cfinclude template="qry_get_user.cfm">
	
	<cfif qry_get_user.recordcount>
		<cfset attributes.customer_id = qry_get_User.customer_ID>
	<cfelse>
		<cfparam name="attributes.customer_id" default="0">
	</cfif>
	
	<!--- Display CUSTOMER form if customer record doesn't exist --->
	<cfif not attributes.customer_id>
		<cfset attributes.xfa_submit_customer="fuseaction=users.register&act=customer">
		<cfif isdefined("attributes.xfa_success")>
			<cfset attributes.xfa_submit_customer="#attributes.xfa_submit_customer#&xfa_success=#URLEncodedFormat(attributes.xfa_success)#">
		</cfif>
		<cfinclude template="dsp_customer_form.cfm">	
	
	<cfelse><!--- We have a customer record... --->
	
		<!--- Display SHIPPING form if used and needed --->
		<cfif get_User_Settings.UseShipTo and not qry_get_User.shipto> 
			<cfset attributes.xfa_submit_customer="fuseaction=users.register&act=shipto">
			<cfif isdefined("attributes.xfa_success")>
				<cfset attributes.xfa_submit_customer="#attributes.xfa_submit_customer#&xfa_success=#URLEncodedFormat(attributes.xfa_success)#">
			</cfif>
			<cfset attributes.mode = "shipto">
			<cfinclude template="dsp_customer_form.cfm">
			
		<cfelse><!--- We have shipping or don't use it --->
		
			<!--- Display the ACCOUNT form if used and needed --->
			<cfif get_User_Settings.UseAccounts and (qry_get_User.account_id is '' OR qry_get_User.account_id is 0)>
				<cfset attributes.xfa_submit_account="fuseaction=users.register&act=account">
				<cfif isdefined("attributes.xfa_success")>
					<cfset attributes.xfa_submit_account="#attributes.xfa_submit_account#&xfa_success=#URLEncodedFormat(attributes.xfa_success)#">
				</cfif>
				<cfinclude template="dsp_account_form.cfm">
			
			<cfelse><!--- Account complete or not used... --->
		
				<cfset done = 1>

			</cfif><!--- account check --->
		
		</cfif><!--- shipping check --->
	
	</cfif><!--- customer check --->

</cfif><!--- login check --->


<!--- registration process complete --->
<cfif done>

	<cfinclude template="act_set_registration_permissions.cfm">
	
	<cflocation url="#attributes.xfa_success##request.token2#" addtoken="no">
	
</cfif>
	

