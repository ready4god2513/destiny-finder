<cfcomponent displayname="queries" output="no" hint="I contain all the queries">

	<cffunction name="user_verify" returntype="numeric" hint="I verify a user">
		<cfargument name="user_name" type="string" require="yes">		
		<cfargument name="password"	type="string" require="yes">
				
		<cfquery name="qUser_Verify" datasource="#APPLICATION.dsn#">
			SELECT user_id
			FROM users
			WHERE user_username = <cfqueryparam cfsqltype="cf_sql_char" value="#user_name#">
				AND user_password = <cfqueryparam cfsqltype="cf_sql_char" value="#password#">
				AND user_active = 1
				<cfif isDefined('type')>
					AND user_type = #type#
				</cfif>
		</cfquery>
		
		<cfif qUser_Verify.recordcount EQ 0>
			<cfset VARIABLES.user_id = 0>
		<cfelse>
			<cfset VARIABLES.user_id = qUser_Verify.user_id>
		</cfif>
			
		<cfreturn VARIABLES.user_id>
			
	</cffunction>
	
	<cffunction name="find_user" output="false" returntype="numeric" hint="I check to see if a user exists">
			
		<cfquery name="qUser" datasource="#APPLICATION.dsn#">
			SELECT user_username
			FROM users
			WHERE user_username = <cfqueryparam cfsqltype="cf_sql_char" value="#user_username#">
		</cfquery>
				
		<cfreturn qUser.recordcount>
			
	</cffunction>
	
	<cffunction name="username" output="false" returntype="string" hint="I retrieve the username">
		<cfargument name="user_id" type="numeric" required="yes">
		
		<cfquery name="qName" datasource="#APPLICATION.DSN#">
			SELECT user_first_name,user_last_name
			FROM Users
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>
		
		<cfreturn qName.user_first_name & " " & qName.user_last_name>
		
	</cffunction>
	
	<cffunction name="max_user_id" output="false" returntype="numeric" hint="I return the last user id">
				
		<cfquery name="qMax_User" datasource="#APPLICATION.dsn#" maxrows="1">
			SELECT user_id
			FROM user
			ORDER BY user_id DESC
		</cfquery>
			
		<cfreturn qMax_User.user_id>
			
	</cffunction>
	
	<cffunction name="get_content" output="false" returntype="query" hint="I return the content of a page.">
	<cfargument name="page" type="string" required="yes">
	
		<cfquery name="qContent" datasource="#APPLICATION.DSN#" maxrows="1">
			SELECT * FROM Content 
			WHERE content_action = <cfqueryparam cfsqltype="cf_sql_char" maxlength="35" value="#page#">
		</cfquery>
		
		<cfreturn qContent>
	</cffunction>
	
	<cffunction name="user_detail" returntype="query" output="true" hint="I return user info.">
		<cfargument name="user_id" type="numeric" required="yes">
		
		<cfquery name="qUser" datasource="#APPLICATION.dsn#">
			SELECT *
			FROM Users
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>
								
		<cfreturn qUser>						
										
	</cffunction>
	
</cfcomponent>