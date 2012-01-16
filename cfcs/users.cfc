<cfcomponent displayname="users" output="no" hint="I handle the user functions">

	<cfset obj_admin = CreateObject("component","admin.cfcs.admin")>
	<cfset foxyCart = CreateObject("component", "cfcs.foxycart") />


	<cffunction name="process_user_form" returntype="string" output="true" hint="I process the user form">
		<cfargument name="process" required="yes" type="string">
		<cfargument name="return_url" required="no" type="string">

	
		<cfparam name="VARIABLES.user_image" default="">

		<cfif isDefined("FORM.user_email")>
			<cfset FORM.user_username = FORM.user_email>
	    </cfif>
		<cfset FORM.user_datecreated = DateFormat(NOW(),'yyyy-mm-dd')>
	
		<cfswitch expression="#process#">
	
			<cfcase value="Create Account">	
				
					<cfset FORM.user_password = HASH(FORM.user_password)>
				
					<cfquery name="Check_user" datasource="#APPLICATION.DSN#">
						SELECT user_id
						FROM Users
						WHERE user_username = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_email#">
					</cfquery>

					<cfif check_user.recordcount GT 0>
						<cfset VARIABLES.message = "username exists">
						<cfreturn VARIABLES.message>
					<cfelse>
			
					
						<cfquery name="Insert_User" datasource="#APPLICATION.dsn#">
							INSERT INTO	Users
								(user_first_name,user_last_name,user_username,user_email,user_password,
									user_datecreated,user_type,user_active, marketing_opt_in)
							VALUES
								(<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_first_name#">,
								<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_last_name#">,
								<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_username#">,
								<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_email#">,
								<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_password#">,
								<cfqueryparam cfsqltype="cf_sql_date" value="#FORM.user_datecreated#">,
								2,
								1,
								<cfqueryparam cfsqltype="cf_sql_bit" value="#FORM.marketing_opt_in#">
								)
						</cfquery>
					
						<cfquery name="qUser" datasource="#APPLICATION.DSN#">
							SELECT user_id 
							FROM users
							WHERE user_username = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_email#">
						</cfquery>
									
						<cfif qUser.recordcount GT 0>
							
							<!--- BEGIN ADD TO CONSTANT CONTACT --->
							<!--- We will always add them to the system list--->
							<cfset contactList[1] = "http://api.constantcontact.com/ws/customers/#application.ccUsername#/lists/1">
								
							<!--- Check to see if we should add them to the marketing list --->
							<cfif isDefined("FORM.marketing_opt_in") and #FORM.marketing_opt_in#>
								<cfset contactList[2] = "http://api.constantcontact.com/ws/customers/#application.ccUsername#/lists/9">
							</cfif>
							
							<cfset newUser = createObject("component", "cfcs.constantcontact.Contact").init(emailAddress = #FORM.user_email#, firstName = #FORM.user_first_name#, lastName = #FORM.user_last_name#, contactLists = #contactList#)>
							<cfset result = createObject("component", "cfcs.constantcontact.ContactsCollection").addContact(contact = #newUser#)>
							<!--- END ADD TO CONSTANT CONTACT --->
							
							<cflock scope="session" type="readonly" timeout="30">
								<cfset SESSION.user_id = qUser.user_id>
							</cflock>
						</cfif>
					
						<cfif isDefined('return_url')>
							<cflocation url="#return_url#" addtoken="no">
						<cfelse>
							<!---<cflocation url="index.cfm?new=1" addtoken="no">--->
	                        <cflocation url="#REQUEST.site_url#profile/?page=freesurveyintro" addtoken="no">
						</cfif>
					
					</cfif>
			</cfcase>
		
			<cfcase value="Update Profile">	
				
					<cfif LEN(FORM.user_password) GT 0>
						<cfset FORM.user_password = HASH(FORM.user_password)>
					</cfif>
					
					<cfquery name="u" datasource="#APPLICATION.dsn#">
						SELECT *
						FROM users
						WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">
					</cfquery>
					
					<cfset ccDetails = createObject("component", "cfcs.constantcontact.ContactsCollection").searchByEmail(emailAddress = #u.user_email#) />
                	<cfset ccDetails = #ccDetails[1]# />

					<cfquery name="Update_User" datasource="#APPLICATION.dsn#">
						UPDATE users
							SET 
							<cfif LEN(FORM.user_password) GT 0>
								user_password = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_password#">,
							</cfif>
							marketing_opt_in = <cfqueryparam cfsqltype="cf_sql_bit" value="#FORM.marketing_opt_in#">,
							user_first_name = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_first_name#">,
							user_last_name = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_last_name#">
							WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">
					</cfquery>
					
					<!--- BEGIN ADD TO CONSTANT CONTACT --->
					<!--- We will always add them to the system list--->
					<cfset contactList[1] = "http://api.constantcontact.com/ws/customers/#application.ccUsername#/lists/1">
						
					<!--- Check to see if we should add them to the marketing list --->
					<cfif isDefined("FORM.marketing_opt_in") and #FORM.marketing_opt_in# GT 0>
						<cfset contactList[2] = "http://api.constantcontact.com/ws/customers/#application.ccUsername#/lists/9">
					</cfif>
					
					<cfset ccDetails.contactLists = #contactList# />
					<cfset ccDetails.firstName = #FORM.user_first_name# />
					<cfset ccDetails.lastName = #FORM.user_last_name# />
					<cfset result = createObject("component", "cfcs.constantcontact.ContactsCollection").updateContact(contact = #ccDetails#)>
					<cfset VARIABLES.site_notification = "profile_updated">
			
					<cfreturn VARIABLES.site_notification>						
			</cfcase>
		
			<cfdefaultcase>
			</cfdefaultcase>
	
		</cfswitch>
		
	</cffunction>

</cfcomponent>