<cfcomponent displayname="users" output="no" hint="I handle the user functions">

	<cfset obj_admin = CreateObject("component","admin.cfcs.admin")>
	<cfset foxyCart = CreateObject("component", "cfcs.foxycart") />
	
	
	<cffunction name="findUserByEmail" returntype="query" output="false" hint="I find users by their e-mail address">
		<cfargument name="email" type="string" required="true" />
		
		<cfquery name="u" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM Users
			WHERE user_username = <cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.email#">
		</cfquery>
		
		<cfreturn u>
	</cffunction>
	
	
	<cffunction name="findById" returntype="query" ouput="false" hint="I find the user by their id">
		<cfargument name="id" type="any" required="true" />
		
		<cfquery name="u" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM Users
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_int" value="#ARGUMENTS.id#">
		</cfquery>
		
		<cfreturn u>
	</cffunction>
	
	<cffunction name="findUserByIdAndResetKey" returntype="query" output="false" hint="I find users by their id and reset key">
		<cfargument name="key" type="string" required="true" />
		<cfargument name="id" type="string" required="true" />
		
		<cfquery name="u" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM Users
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_int" value="#ARGUMENTS.id#">
			AND user_password = <cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.key#">
		</cfquery>
		
		<cfreturn u>
	</cffunction>
	
	
	<cffunction name="sendResetInstructions" returntype="boolean" output="false" hint="I lookup users and send them reset instructions">
		<cfargument name="email" type="string" required="true" />
		
		<cfset user = this.findUserByEmail(email = #ARGUMENTS.email#) />
		
		<cfif user.recordcount EQ 1>
			<cfmail 
				to="#user.user_username#" 
				from="#APPLICATION.contact_email#" 
				subject="Destiny Finder Password Reset" 
				type="html">
				
				<p>Dear #user.user_first_name#,</p>
				<p>Your password reset is almost complete.</p>
				<p>
					To finish changing your password, click the link below. You'll be taken to a page where you can securely reset your password.
				</p>

				<p>
					<a href="#REQUEST.site_url#auth/password-reset/?reset=true&amp;key=#user.user_password#&amp;id=#user.user_id#">Change your Password</a>
				</p>
				
				<p>
					If you didn't contact Destiny Finder to change your password, please delete this email.
				</p>
				
				<p>
					If clicking the button above doesn't work, copy and paste the following link 
					into your Internet browser:
				</p>
				
				<p>
					<a href="#REQUEST.site_url#auth/password-reset/?reset=true&key=#user.user_password#&id=#user.user_id#">#REQUEST.site_url#auth/password-reset/?reset=true&key=#user.user_password#&id=#user.user_id#</a>
				</p>
				
			</cfmail>
		</cfif>
			
		<cfreturn user.recordcount EQ 1>
	</cffunction>


	<cffunction name="process_user_form" returntype="string" output="true" hint="I process the user form">
		<cfargument name="process" required="yes" type="string">
		<cfargument name="return_url" required="no" type="string">
		
		<cfparam name="VARIABLES.user_image" default="">
		<cfparam name="FORM.marketing_opt_in" default="0">

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
						WHERE user_username = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_email#" />
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
							
							<cftry>
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
								
								<cfcatch type="any"></cfcatch>
							</cftry>
							
							<cflock scope="session" type="readonly" timeout="30">
								<cfset SESSION.user_id = qUser.user_id>
							</cflock>
						</cfif>
					
						<cfif isDefined('return_url')>
							<cflocation url="#return_url#" addtoken="no">
						<cfelse>
	                        <cflocation url="#REQUEST.site_url#auth/account/" addtoken="no">
						</cfif>
					
					</cfif>
			</cfcase>
		
			<cfcase value="Update Account Settings">	
				
					<cfif LEN(FORM.user_password) GT 0>
						<cfset FORM.user_password = HASH(FORM.user_password)>
					</cfif>
					
					<cfquery name="u" datasource="#APPLICATION.dsn#">
						SELECT *
						FROM users
						WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">
					</cfquery>

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
					
					<cftry>
						
						<!--- BEGIN ADD TO CONSTANT CONTACT --->
						<cfset ccDetails = createObject("component", "cfcs.constantcontact.ContactsCollection").searchByEmail(emailAddress = #u.user_email#) />
	                	<cfset ccDetails = #ccDetails[1]# />
	
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
						
						<cfcatch type="any"></cfcatch>
					</cftry>
					
					<cfset VARIABLES.site_notification = "profile_updated">
			
					<cfreturn VARIABLES.site_notification>						
			</cfcase>
		
			<cfdefaultcase>
			</cfdefaultcase>
	
		</cfswitch>
		
	</cffunction>

</cfcomponent>