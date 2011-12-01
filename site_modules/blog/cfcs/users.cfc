<cfcomponent displayname="users" output="no" hint="I handle the user functions">

<cfset obj_admin = CreateObject("component","admin.cfcs.admin")>
<cfset obj_files = CreateObject("component","site_modules.blog.cfcs.files")>

<cffunction name="process_user_form" returntype="string" output="false" hint="I process the user form">
	<cfargument name="process" required="yes" type="string">
	<cfargument name="return_url" required="no" type="string">
	
	<cfparam name="VARIABLES.user_image" default="">
	

	<cfset FORM.user_username = FORM.user_email>
	<cfset FORM.user_datecreated = DateFormat(NOW(),'yyyy-mm-dd')>
	
	<cfswitch expression="#process#">
	
		<cfcase value="Create Account">	
				
				<cfset FORM.user_password = HASH(FORM.user_password)>
				
				<cfquery name="Check_user" datasource="#APPLICATION.DSN#">
					SELECT user_id
					FROM Users
					WHERE user_username = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_email#">
				</cfquery>

				<cfif check_user.recordcount EQ 1>
					<cfset VARIABLES.message = "username exists">
					<cfreturn VARIABLES.message>
				<cfelse>

				<cfif LEN(FORM.add_profile_pic) GT 0>
					<cfset VARIABLES.user_image = obj_files.upload_file(form_file_field="add_profile_pic",file_type="image",file_purpose="profile")>
				</cfif>
				
					
					<cfquery name="Insert_User" datasource="#APPLICATION.dsn#">
						INSERT INTO	Users
							(user_first_name,user_last_name,user_username,user_email,user_address1,user_address2,user_city,user_state,user_zip,user_password,
								user_datecreated,user_phone,user_description,user_image,user_type,user_active)
						VALUES
							(<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_first_name#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_last_name#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_username#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_email#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_address1#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_address2#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_city#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_state#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_zip#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_password#">,
							<cfqueryparam cfsqltype="cf_sql_date" value="#FORM.user_datecreated#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_phone#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_description#">,
							<cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.user_image#">,
							2,
							1
							)
					</cfquery>
					
					<cfquery name="qUser" datasource="#APPLICATION.DSN#">
						SELECT user_id 
						FROM users
						WHERE user_username = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_email#">
					</cfquery>
					
					<cfif qUser.recordcount GT 0>
						<cflock scope="session" type="readonly" timeout="30">
							<cfset SESSION.user_id = qUser.user_id>
						</cflock>
					</cfif>
					
					<cfif isDefined('return_url')>
						<cflocation url="#return_url#" addtoken="no">
					<cfelse>
						<cflocation url="index.cfm?page=blog&admin=1&new=1" addtoken="no">
					</cfif>
					
				</cfif>
		</cfcase>
		
		<cfcase value="Update Profile">	
				<cfif LEN(FORM.user_password) GT 0>
					<cfset FORM.user_password = HASH(FORM.user_password)>
				</cfif>
				
				<cfif LEN(FORM.add_profile_pic) GT 0>
					<cfset VARIABLES.user_image = obj_files.upload_file(form_file_field="add_profile_pic",file_type="image",file_purpose="profile")>
				</cfif>
				
				<cfquery name="Update_User" datasource="#APPLICATION.dsn#">
					UPDATE users
						SET 
						user_first_name = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_first_name#">,
						user_last_name = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_last_name#">,
						user_address1 = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_address1#">,
						user_address2 = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_address2#">,					
						user_city = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_city#">,
						user_state = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_state#">,
						user_zip = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_zip#">,
						user_email = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_email#">,
						user_username = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_username#">,
						user_description = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_description#">,
						<cfif LEN(VARIABLES.user_image) GT 0>
						user_image = <cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.user_image#">,
						</cfif>
						<cfif LEN(FORM.user_password) GT 0>
							user_password = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_password#">,
						</cfif>
						user_phone = <cfqueryparam  cfsqltype="cf_sql_char" value="#FORM.user_phone#">
						WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.user_id#">
				</cfquery>
							
				<cfset VARIABLES.site_notification = "profile_updated">
			
				<cfreturn VARIABLES.site_notification>						
		</cfcase>
		
		<cfdefaultcase>
		</cfdefaultcase>
	
	</cfswitch>
		
</cffunction>

</cfcomponent>