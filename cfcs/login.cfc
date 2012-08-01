<cfcomponent 
	displayname="login"
	output="no"
	hint="I handle the login details">
	
	<cfset obj_queries = CreateObject("component","cfcs.queries") />
	<cfset foxyCart = CreateObject("component", "cfcs.foxycart") />
	
	<cffunction name="is_logged_in" returntype="string" output="false" hint="I check to see if there is a user logged in">
		
		<cflock scope="session" timeout="30" type="readonly">
			<cfif isDefined('SESSION.user_id')>
				<cfset VARIABLES.user_id = SESSION.user_id>
			<cfelseif isDefined("COOKIE.user_id")>
				<cfset VARIABLES.user_id = COOKIE.user_id>
			<cfelse>
				<cfset VARIABLES.user_id = 0>
			</cfif>
		</cflock>
		
		
		<cfreturn VARIABLES.user_id>
		
	</cffunction>
	
	
	<cffunction name="forceLogin" returntype="void" output="false" hint="I force the login for a user">
		<cfargument name="user" type="query" required="yes" />
		<cfargument name="redirect_after" type="string" required="no" default="/auth/account/" />
		
		<cflock scope="session" type="exclusive" timeout="30">
			<cfset SESSION.user_id = user.user_id />
			<cfset COOKIE.user_id = user.user_id />
			<cflocation url="#ARGUMENTS.redirect_after#" addtoken="no" />
		</cflock>
	</cffunction>
	
	
	<cffunction name="login_form_action" returntype="string" output="true"	hint="I handle the login form actions">

		<cfset VARIABLES.login_result = obj_queries.user_verify(user_name = "#FORM.user_name#", 
															password = "#HASH(FORM.password)#")>
															
		<!--- DID THE USER_VERIFY FUNCTION RETURN A VALID USER_ID? --->
		<cfif VARIABLES.login_result GT 0>
			<!--- IF YES, SET USER_ID IN THE SESSION --->
			<cfset SESSION.user_id = VARIABLES.login_result>
			<cfset COOKIE.user_id = VARIABLES.login_result>
			<cfset VARIABLES.site_notification = "login_sucess">
			<cfset foxyCart.save_user(username = "#FORM.user_name#", password = "#HASH(FORM.password)#") />
		<cfelse>
			<cfset VARIABLES.site_notification = "login_fail">
		</cfif>
		
		<cfreturn VARIABLES.site_notification>
	</cffunction>
	
	<cffunction name="logout" output="false" hint="I log a user out">
		<cflock scope="session" timeout="30">
			<cfset StructClear(Session)>
			<cfset StructClear(COOKIE)>
		</cflock>
	</cffunction>		

</cfcomponent>