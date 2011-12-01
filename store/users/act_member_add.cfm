<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.member, this template processes the dsp_member_form.cfm template and adds a new user and customer record. --->

<cfif isdefined("attributes.submit_member")>

<!--- Check for a blank state in the address --->
<cfif isDefined("attributes.State") AND NOT len(attributes.State)>
	<cfset attributes.State = 'Unlisted'>
</cfif>
	
<cfset attributes.Message="">
<cfparam name="attributes.fax" default="">

<cfif get_User_Settings.UseBirthdate>
	<cfmodule template="../customtags/form/dropdown.cfm"
		mode = "assemble_date"
		year = "#attributes.bday_year#"
		month = "#attributes.bday_month#"
		date = "#attributes.bday_date#">
					
	<cfset attributes.birthdate = assembled_date>
	<!---===== ENTER BIRTHDAY VERIFICATION STUFF HERE =====--->		
<cfelse>
	<cfset attributes.birthdate = "">
</cfif>

<cfif get_User_Settings.EmailAsName>
	<cfset attributes.Username = attributes.email>	
</cfif>

<!--- Verify that required fields are not blank and User is registered. --->
<cfif len(trim(attributes.Username)) AND len(trim(attributes.Password)) AND len(trim(attributes.email)) AND len(trim(attributes.verify)) AND len(trim(attributes.FirstName)) AND len(trim(attributes.LastName)) AND len(trim(attributes.Address1)) AND len(trim(attributes.City)) AND len(trim(attributes.Zip)) AND len(trim(attributes.Country))>
		
	<!--- If UseCCard, make sure credit card fields are not blank ---->
	<cfif NOT get_User_Settings.UseCCard or (len(trim(attributes.CardType)) AND len(trim(attributes.NameOnCard)) AND
		len(trim(attributes.CardNumber)) AND len(trim(attributes.month)) AND len(trim(attributes.year)))>
	
		<cfif NOT get_User_Settings.UseBirthdate OR len(trim(attributes.birthdate))>
			
			<!--- User names must be unique --->
			<cfquery name="Check_User" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
			SELECT User_ID FROM #Request.DB_Prefix#Users
			WHERE Username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Username#">
			</cfquery>
			
			<cfif not Check_User.recordcount>
			
				<!--- FORM is OK, Add to User Table --->
				<cfif not Session.User_ID>
					<cfset add_member_form = "yes">
					<cfinclude template="act_register.cfm">
				</cfif>
		
			<cfelse>
				<cfset attributes.Message = "Sign-in already exists.">
			</cfif>
		
		<cfelse>
			<cfset attributes.Message = "Please enter your birthdate.">
		</cfif>
		
	<cfelse>
		<cfset attributes.Message = "You did not fill out all the required credit card fields!">
	</cfif>

<cfelse>
	<cfset attributes.Message = "You did not fill out all the required fields!">
</cfif>


<!--- If user is logged in and form fields are valid, add customer record --->
<cfif Session.User_ID and not len(attributes.Message)>
	
	<cfinclude template="qry_get_user.cfm">
		
	<!--- Add to Customer Table  --->
	<cfif not qry_get_user.customer_id>
	
		<!--- add a new customer address for the account --->
		<cfset attributes.UID = Session.User_ID>
		<cfset User_Customer_ID = Application.objUsers.AddCustomer(argumentcollection=attributes)>
			
	<cfelse>	
		<cfset User_Customer_ID = qry_get_user.customer_id>
		<cfparam name="attributes.zip" default="">
	</cfif>
	
	<!--- Update User Table --->
	<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Users
	SET Customer_ID = <cfqueryparam value="#User_Customer_ID#" cfsqltype="CF_SQL_INTEGER">,
		CardZip = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.zip#">
		WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	
	<!--- Set User Permissions ---->
	<cfinclude template="act_set_registration_permissions.cfm">

	<!--- If using email notification and this is a new user, send email --->
	<cfif get_User_Settings.MemberNotify>
		<cfinclude template="act_email_member_add.cfm">
	</cfif>
	
	<cflocation url="#attributes.xfa_success##request.token2#" addtoken="no">
	
</cfif>

</cfif><!--- form submit --->

