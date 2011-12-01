<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.account circuit, this template processes the account registration template dsp_account_form.cfm. Updates the customer(billto), account and users tables. --->

<cfset attributes.message = "">

<!--- These forms will create: customer/billto -- location -- account -- User --->
<cfif isdefined("attributes.submit_account")>

	<!--- Check for a blank state in the address --->
	<cfif isDefined("attributes.State") AND NOT len(attributes.State)>
		<cfset attributes.State = 'Unlisted'>
	</cfif>

	<!--- Verify that required user and contact fields are not blank. --->
	<cfif len(trim(attributes.Acc_Account_Name)) AND len(trim(attributes.Acc_Type1))>
		
		<cfif (qry_get_user.recordcount and qry_get_user.customer_id) or
		(len(trim(attributes.FirstName)) AND 
		len(trim(attributes.LastName)) AND len(trim(attributes.Address1))  AND len(trim(attributes.City)) AND len(trim(attributes.Zip)))>
	
			<!--- If the user is not logged in, process registration --->
			<cfif not Session.User_ID>
				<cfset attributes.groupcode = "">
				<cfset Subscribe = 1>
				<cfset add_member_form = "yes">
				<cfinclude template="act_register.cfm">
			<cfelse>
				<cfparam name="attributes.email" default="#qry_get_user.email#">
			</cfif>
		
		<cfelse>
			<cfset attributes.Message = "You did not fill out all the required contact fields!">
		</cfif>

	<cfelse>
		<cfset attributes.Message = "You did not fill out all the required fields!">
	</cfif>


	<!--- Continue to process Customer and Account if logged in and no error message. --->
	<cfif Session.User_ID and not len(attributes.Message)>

		<cfswitch expression = "#attributes.submit_account#">

		<cfcase value="Submit Account">
		
			<cfinclude template="qry_get_user.cfm">
		
			<!--- Add to Customer Table if customer record does not exist. --->
			<cfif not qry_get_user.customer_id>
			
				<!--- add a new customer address for the account --->
				<cfset attributes.UID = Session.User_ID>
				<cfset NewCustID = Application.objUsers.AddCustomer(argumentcollection=attributes)>	
			

				<cfset User_Customer_ID = NewCustID>
				<cfset Account_Customer_ID = NewCustID>
				<cfset attributes.cardzip = attributes.Zip>
				
			<cfelse>
				<cfset User_Customer_ID = qry_get_user.customer_id>
				<cfset Account_Customer_ID = qry_get_user.customer_id>
			</cfif>

		
		<!--- Add to Account Table --->
		<cfset attributes.fieldlist="Acc_Account_Name,Acc_Description,Acc_Policy,Acc_type1,Acc_rep,Acc_web_url,Acc_terms,cardzip">
		
		<cfloop list="#attributes.fieldlist#" index="counter">
			<cfparam name="attributes.#counter#" default="">
		</cfloop>
		
		
		<!--- Add the new account record --->
		<cfset attributes.UID = Session.User_ID>
		<cfset attributes.Acc_Customer_ID = Account_Customer_ID>
		<cfset attributes.account_ID = Application.objUsers.AddAccount(argumentcollection=attributes)>	

						
		<!--- Update User Table with Customer_ID --->
			<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users
			SET Customer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#User_Customer_ID#">,
				Account_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.account_ID#">,
				CardZip= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.cardzip#">
			WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
	
			<cfinclude template="act_set_registration_permissions.cfm">
			
			<!--- If using email notification and this is a new user, send email --->
			<cfif get_User_Settings.MemberNotify>
				<cfinclude template="act_email_member_add.cfm">
			</cfif>
	
			<!--- Send email notification to Admin if used --->
			<cfif get_User_Settings.UseEmailNotif>
						
				<cfmail to="#request.appsettings.merchantemail#" from="#request.appsettings.merchantemail#" 
				subject="New Account Notification for #request.appsettings.sitename#" 
				server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
				<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
				<cfmailparam name="Reply-To" Value="#request.appsettings.merchantemail#">
The following account was created on #request.appsettings.sitename# on #createodbcdate(now())#

#attributes.Acc_Account_Name#'
#attributes.Acc_Description#
#attributes.Acc_rep#
#attributes.Acc_web_url#
				</cfmail>
					
			</cfif>
	
			<!--- Display Confirmation --->
			<cfset attributes.box_title="Account">
			<cfset attributes.message="Account Added!">
			<cfinclude template="../includes/form_confirmation.cfm">
	
		</cfcase>
						
	</cfswitch>
</cfif>

</cfif>

