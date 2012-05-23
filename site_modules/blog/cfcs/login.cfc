<cfcomponent 
	displayname="login"
	output="no"
	hint="I handle the login details">
	
	<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>
	
	<cffunction name="is_logged_in" returntype="string" output="false" hint="I check to see if there is a user logged in">
		
		<cflock scope="session" timeout="30" type="readonly">
			<cfif isDefined('SESSION.user_id')>
				<cfset VARIABLES.user_id = SESSION.user_id>
			<cfelse>
				<cfset VARIABLES.user_id = 0>
			</cfif>
		</cflock>
		
		
		<cfreturn VARIABLES.user_id>
		
	</cffunction>
	
	<cffunction name="login_form_action" returntype="string" output="true"	hint="I handle the login form actions">
			<cfset var login = CreateObject("cfc", "cfcs.login")>
			<cfreturn login.login_form_action()>
	</cffunction>
	
	<cffunction name="logout" output="false" hint="I log a user out">
	
		<cflock scope="session" timeout="30">
			<cfset StructDelete(Session, "User_id")>
		</cflock>
	
	
	</cffunction>		

</cfcomponent>