<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template processes the dsp_registration_form.cfm form fields to create a new user. It is called during the shopping checkout process (shopping\checkout\do_checkout.cfm and shopping\checkout\act_save_order.cfm), user registration (users.register, users.newuser,  users.member and users.account circuits) as well as during affiliate sign-up (shopping\affiliate\index.cfm).
--->

<!--- Registration forms that don't include the option of saving credit card 
information in the user record can skip those fields. ---->
<cfparam name="attributes.UseCCard" default="#get_User_Settings.UseCCard#" > 

<cfparam name="attributes.password" default=""> 
<cfparam name="attributes.verify" default=""> 
<cfparam name="attributes.email" default="">
<cfparam name="attributes.groupcode" default=0>

<cfinclude template="../shopping/qry_get_order_settings.cfm">

<cfif get_User_Settings.EmailAsName>
	<cfset attributes.Username = attributes.email>
</cfif>

<cfset attributes.Message="">

<!--- Make sure required fields are not blank --->
<cfif len(attributes.Password) AND len(attributes.verify) AND len(attributes.Username) AND len(attributes.email)>

<!--- Check if the site is saving credit cards, but not using Shift4 processing --->
<cfif NOT attributes.UseCCard OR get_Order_Settings.CCProcess IS "Shift4OTN">

	<!--- If use_ccard, make sure the required ccard fields are not blank --->
	<cfif NOT attributes.UseCCard or (len(attributes.CardType) AND len(attributes.NameOnCard) AND len(attributes.CardNumber) AND len(attributes.month) AND len(attributes.year))>
	
		<!--- check that email address has correct syntax --->
		<cfmodule template="../customtags/form/validate_email.cfm" email="#attributes.email#">
	
		<cfif ok><!--- the result of validate_email.cfm --->
	
		<!--- check passwords are the same
		(passwords are case-sensitive (Compare() is also, "IS" is not) --->
		<cfif Compare(attributes.Password, attributes.Verify) IS 0>
			
			<!--- Username must be unique, check if already exists --->
			<cfquery name="FindName" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
			SELECT User_ID FROM #Request.DB_Prefix#Users 
			WHERE Username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Username#">
			</cfquery>
	
			<cfif NOT FindName.Recordcount or isdefined("attributes.submit_member")>
				
				<!--- Check if email address already exists --->
				<cfquery name="FindEmail" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
				SELECT User_ID FROM #Request.DB_Prefix#Users 
				WHERE Email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.email#">
				</cfquery>
	
				<cfif NOT FindEmail.Recordcount or isdefined("attributes.submit_member")>
					
					<!--- If birthdate is used, validate --->
					<cfif get_User_Settings.UseBirthdate>
						<cfset datevalid = 0>
					
						<cfif len(attributes.bday_date) AND len(attributes.bday_month) AND 
						len(attributes.bday_year)>
						
							<cfmodule template="../customtags/form/dropdown.cfm"
							mode = "assemble_date"
							year = "#attributes.bday_year#"
							month = "#attributes.bday_month#"
							date = "#attributes.bday_date#">
						
							<cfset attributes.birthdate = assembled_date>
							
							<!--- INSERT OVER-18 CODE HERE IF REQUIRED 
							<cfif DateAdd('yyyy',18,attributes.birthdate) lt now()>
								<cfset datevalid = 1>
							</cfif>--->
						
							<cfset datevalid = 1>
						</cfif>
						<cfelse>
						<cfset datevalid = 1>
						<cfset attributes.birthdate = "">
					</cfif>
	
					<cfif datevalid is 1>
						
						<!--- If Groupcode is used, get group ID of code entered --->
						<cfif get_User_Settings.UseGroupCode>
						
							<cfquery name="GetGroupID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
							SELECT Group_ID FROM #Request.DB_Prefix#Groups
							WHERE Group_Code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.groupcode#">
							</cfquery>
			
							<cfif GetGroupID.recordcount is 1>
								<cfset Session.Group_ID = GetGroupID.Group_ID>
							</cfif>
						</cfif>
					
						<cfparam name="attributes.subscribe" default=0>
					
						<!--- PROCESS UPDATED REGISTRATION --->
						<cfif isdefined("attributes.submit_member") and attributes.submit_member is "Update Information">
							<cfset action = "update">
							<cfif attributes.UseCCard>
								<cfset attributes.CardisValid = 1>
							</cfif>
							
							<!--- Update the user account --->
							<cfset attributes.UID = Session.User_ID>
							<cfset attributes.edittype = "user">
								
							<cfset Application.objUsers.UpdateUser(argumentcollection=attributes)>
								
							<cfinclude template="act_set_registration_permissions.cfm">
								
							<cflocation url="#attributes.xfa_success##request.token2#" addtoken="no">
					
						<cfelse><!--- PROCESS ADD REGISTRATION  --->	
							<cfset action = "insert">	
							
							<!--- Add the user account --->
							<cfset attributes.Group_ID = Session.Group_ID>
							<cfset attributes.admin = false>
							
							<cfset user_id = Application.objUsers.AddUser(argumentcollection=attributes)>
							
							<cfset Session.User_ID = user_id>
	
				
						</cfif>
				
						<cfinclude template="qry_get_user.cfm">
						
						<!--- If  UseCCard, process --->
						<cfif attributes.UseCCard>
							<cfinclude template="act_use_ccard.cfm">
						</cfif>
						
						<!--- If  Email confirmations used, process --->
						<cfif get_User_Settings.UseEmailConf>
							<cfinclude template="act_email_conf.cfm">
						</cfif>
					
				
						<!--- If using email notification and this is a new user, and not the first step of the register process, send email --->
						<cfif attributes.fuseaction IS NOT "users.register" AND get_User_Settings.MemberNotify AND Action IS "insert">
							<cfinclude template="act_email_member_add.cfm">
						</cfif>
					
						<!--- Run if not on the member form --->
						<cfif NOT isDefined("add_member_form")>	
							<cfinclude template="act_set_registration_permissions.cfm">						
						</cfif>
									
						<!--- END PROCESS REGISTER --->	
						<cfelse>
							<cfset attributes.Message = "Please enter your date of birth.">
						</cfif>
						
					<cfelse>
						<cfset attributes.Message = "This email has already been registered.">
					</cfif>
		
				<cfelse>
					<cfset attributes.Message = "This username is already in use!">
				</cfif>
				
			<cfelse>
				<cfset attributes.Message = "You entered two different passwords!">
			</cfif>
		
		<cfelse>
			<cfset attributes.Message = "Invalid email address.">
		</cfif>
	
	<cfelse>
		<cfset attributes.Message = "Please fill out your credit card information.">
	</cfif>
	
	<cfelse>
		<cfset attributes.Message = "This store is not properly configured for taking credit card information.">
	</cfif>

<cfelse>
	<cfset attributes.Message = "Please fill out all the required fields.">
</cfif>
		