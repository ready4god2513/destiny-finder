<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.account circuit, this template is only called when a user already has an account. It either initializes the values for the dsp_account_form.cfm form fields or updates the Account record. --->

<cfparam name="attributes.message" default="">

<!--- Initialize form field values from the user's account. --->
<cfif NOT isdefined("attributes.submit_account")>

	<cfinclude template="qry_get_account.cfm">
	
	<!--- populate form --->
	<cfset attributes.fieldlist="Customer_ID,account_name,type1,Description,Policy,Rep,web_url,map_url,terms,lastused">
	<cfloop list="#attributes.fieldlist#" index="counter">
		<cfset "attributes.acc_#counter#" = evaluate("qry_get_account." & counter)>
	</cfloop>
	
	<cfif qry_get_account.customer_ID gt 0>
		<cfset attributes.customer_ID = qry_get_account.customer_ID>
	<cfelseif qry_get_user.customer_ID gt 0>
		<cfset attributes.customer_ID = qry_get_user.customer_ID>
	<cfelse>
		<cfset attributes.customer_ID =0>
	</cfif>
	
 	<cfinclude template="qry_get_customer.cfm">
	
	<cfset attributes.fieldlist="Customer_ID,FirstName,LastName,Company,Address1,Address2,City,County,State,State2,Zip,Country,Phone,Phone2,Fax,Email,Residence">
	<cfloop list="#attributes.fieldlist#" index="counter">
		<cfset "attributes.#counter#" = evaluate("qry_get_customer." & counter)>
	</cfloop>

	
<!--- Process the Account form if submitted--->			
<cfelse>

	<!--- Initialize parameters which possibly could not be passed from form --->
	<cfset attributes.fieldlist="Acc_Description,Acc_Policy,Acc_type1,Acc_rep,Acc_web_url,Acc_map_url,Acc_terms">
		
	<cfloop list="#attributes.fieldlist#" index="counter">
		<cfparam name="attributes.#counter#" default="">
	</cfloop>   
	
	<!--- Check for a blank state in the address --->
	<cfif isDefined("attributes.State") AND NOT len(attributes.State)>
		<cfset attributes.State = 'Unlisted'>
	</cfif>	

	<!--- Verify that required field is not blank ---->
	<cfif len(trim(attributes.Acc_Account_Name))>
		
		<!--- Add to Customer Table if needed. --->
		<cfif isdefined("attributes.firstname")>
		
			<!--- add a new customer address for the account --->
			<cfset attributes.UID = Session.User_ID>
			<cfset NewCustID = Application.objUsers.AddCustomer(argumentcollection=attributes)>
		
			<cfset attributes.Acc_Customer_ID = NewCustID>
		
			<!--- Update user record if no customer ----->
			<cfinclude template="qry_get_user.cfm">
			<cfif not qry_get_user.customer_id>
			
				<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Users
				SET Customer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#NewCustID#">
				WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
				</cfquery>
		
			</cfif>
		</cfif>			
	
		<!--- Update the account record --->
		<cfset attributes.Acc_Account_ID = qry_get_user.accountID>
		<cfset Application.objUsers.UpdateAccount(argumentcollection=attributes)>
		
		<cfinclude template="act_set_registration_permissions.cfm">

		<!--- Update Confirmation --->
		<cfset attributes.box_title="Account">
		<cfset attributes.Message = "Account Updated!">
		<cfinclude template="../includes/form_confirmation.cfm">
		
	<cfelse>
		<cfset attributes.Message = "You did not fill out all the required fields!">
	</cfif>
	
</cfif><!--- process or fill --->
	
