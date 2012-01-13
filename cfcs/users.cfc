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
									user_datecreated,user_type,user_active)
							VALUES
								(<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_first_name#">,
								<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_last_name#">,
								<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_username#">,
								<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_email#">,
								<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_password#">,
								<cfqueryparam cfsqltype="cf_sql_date" value="#FORM.user_datecreated#">,
								2,
								1
								)
						</cfquery>
					
						<cfquery name="qUser" datasource="#APPLICATION.DSN#">
							SELECT user_id 
							FROM users
							WHERE user_username = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_email#">
						</cfquery>
						
						<!--- BEGIN ADD TO CONSTANT CONTACT --->
						<cfset newContact = createObject("component", "cfcs.constantcontact.Contact").init(argumentCollection = {
							emailAddress = #FORM.user_email#,
							firstName = #FORM.user_first_name#,
							lastName = #FORM.user_last_name#,
							id = #qUser.user_id#
						})>
						
						<cfset createObject("component", "cfcs.constantcontact.ContactsCollection").init().addContact(contact = #newContact#)>
						<!--- END ADD TO CONSTANT CONTACT --->
									
						<cfif qUser.recordcount GT 0>
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
                	
					<!--- RETRIEVE STORE USER ID AND INSERT IT INTO OUR DATABASE --->
						<cfquery name="qStoreUser" datasource="#APPLICATION.DSN#">
							SELECT user_store_id
							FROM Users
							WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">
						</cfquery>
					<cfquery name="Update_User" datasource="#APPLICATION.dsn#">
						UPDATE users
							SET 
							<!---user_address1 = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_address1#">,
							user_address2 = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_address2#">,					
							user_city = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_city#">,
							user_state = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_state#">,
							user_zip = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_zip#">,--->
							<cfif LEN(FORM.user_password) GT 0>
								user_password = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_password#">,
							</cfif>
	                        user_first_name = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_first_name#">,
							user_last_name = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_last_name#">
							<!---user_username = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_username#">--->
							<!---user_phone = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_phone#">--->
							WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">
					</cfquery>
				
					<cfif isDefined("qStoreUser.user_store_id") AND LEN(qStoreUser.user_store_id) GT 0>
						<cfif LEN(FORM.user_password) GT 0>
	                        <cfquery name="qUpdateStore" datasource="#APPLICATION.STORE_DSN#">
	                            UPDATE Users
	                            SET password = <cfqueryparam  cfsqltype="cf_sql_char" value="#HASH(FORM.user_password)#">
								<!---username = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_username#">--->
	                            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qStoreUser.user_store_id#">
	                        </cfquery>
						</cfif>
					</cfif>
					<cfset VARIABLES.site_notification = "profile_updated">
			
					<cfreturn VARIABLES.site_notification>						
			</cfcase>
		
			<cfdefaultcase>
			</cfdefaultcase>
	
		</cfswitch>
		
	</cffunction>

</cfcomponent>