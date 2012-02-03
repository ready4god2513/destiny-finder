<cfcomponent output="false">
	<cfif FindNoCase("EXEC(", CGI.Query_String) OR FindNoCase("EXEC(", CGI.Script_Name) OR FindNoCase("EXEC(", CGI.Path_Info)>
		<cfabort>
	<cfelseif FindNoCase("CAST(", CGI.Query_String) OR FindNoCase("CAST(", CGI.Script_Name) OR FindNoCase("CAST(", CGI.Path_Info)>
		<cfabort>
	</cfif>
	
	<cfloop collection="#form#" item="item">
	 <cfif form[item] contains "exec(">
		<cfabort>
	 </cfif>
	</cfloop>
	
	<cfloop collection="#URL#" item="item">
	 <cfif url[item] contains "exec(">
		 <cfabort>
	 </cfif>
	</cfloop>

	<!--- Application name, should be unique --->
	<cfset this.name = "destinyfinder_dev">
	<!--- Should client vars be enabled? --->
	<cfset this.clientManagement = false>
	<!--- Where should we store them, if enable? --->
	<cfset this.clientStorage = "database">
	<!--- Where should cflogin stuff persist --->
	<cfset this.loginStorage = "session">
	<!--- Should we even use sessions? --->
	<cfset this.sessionManagement = true>
	<!--- How long do session vars persist? --->
	<cfset this.sessionTimeout = createTimeSpan(0,1,0,0)>
	<!--- Should we set cookies on the browser? --->
	<cfset this.setClientCookies = true>
	<!--- should cookies be domain specific, ie, *.foo.com or www.foo.com --->
	<cfset this.setDomainCookies = false>
	<!--- should we try to block 'bad' input from users --->
	<cfset this.scriptProtect = "all">
	<!--- should we secure our JSON calls? --->
	<cfset this.secureJSON = false>
	<!--- Should we use a prefix in front of JSON strings? --->
	<cfset this.secureJSONPrefix = "">
	<!--- Used to help CF work with missing files and dir indexes --->
	<cfset this.welcomeFileList = "">
	
	<!--- define custom coldfusion mappings. Keys are mapping names, values are full paths  --->
	<cfset this.mappings = structNew()>
	<!--- define a list of custom tag paths. --->
	<cfset this.customtagpaths = "">

	
	<cfset APPLICATION.webadmin_email = "brandonh@ibethel.org">
	<cfset APPLICATION.webadmin_ip = "68.229.193.96|75.140.100.15|68.189.112.146|71.94.35.210">

		
	<!--- Run when application starts up --->
	<cffunction name="onApplicationStart" returnType="boolean" output="true">
		
	
		<cfreturn true>
	</cffunction>

<!--- Run when application stops --->
	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>

	<!--- Fired when user requests a CFM that doesn't exist. --->
	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetpage" required="true" type="string">
		<cfreturn true>
	</cffunction>
	
	<!--- Run before the request is processed --->
	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">
		<cfset var u = CreateObject("component","cfcs.users")>
		
		<cfset DSN="destinyfinder_dev">
		<cfset APPLICATION.DSN="destinyfinder_dev">
		<cfset APPLICATION.STORE_DSN = "destinyfinder_store">
		<cfset APPLICATION.STAGING = 0>
		
		<cfset APPLICATION.sitename = "Destiny Finder">
		<cfset thispath=GetDirectoryFromPath(CF_TEMPLATE_PATH)>
		<cfset APPLICATION.server_path = REPLACE(GetDirectoryFromPath(CF_TEMPLATE_PATH),"\admin\","\")>
	
		
		<cfset APPLICATION.contact_email = "brandonh@ibethel.org">

		
		<cfset REQUEST.site_url = "http://dev.destinyfinder.com/" />
		<cfset APPLICATION.environment = "development" />
		<cfset this.enforceSSLRequirement() />
		
		<!--- FOR BLOG --->
		<cfset REQUEST.time_offset = 2>
		<cfset REQUEST.from_email = "noreply@destinyfinder.com">
		<cfset REQUEST.site_path= "">
		<cfset REQUEST.temp_upload_dir = "">
			
		<!--- FOR FOXYCART --->
		<cfset APPLICATION.foxyCart = { 
			apiKey = "eNsgJKP1KlMIImFkrizBmaSdlFSwUydYdw9R7SHH4pkGFVVW8lsqlatBJbXv", 
			baseURL = "https://destinyfinder.foxycart.com/api"
		}>
		
		
		<!--- MANAGE UNIVERSAL LOGIN --->
		<cfset obj_login = CreateObject("component","cfcs.login")>
		
		
		<cfif isDefined('URL.logout')>
			<cfset obj_login.logout()>
			<cflocation url="/index.cfm" addtoken="no">
		</cfif>
		
            
		<!--- THIS VARIABLE EITHER STORES THE USER_ID OR 0 IF A USER IS NOT LOGGED IN --->
		<cfset REQUEST.user_id = obj_login.is_logged_in()>
			
		<cfif REQUEST.user_id GT 0>
			<cfset REQUEST.user = u.findById(id = REQUEST.user_id)>
		</cfif>
			
			
		<!--- Modify your credentials here --->
		<cfset application.ccUsername = "destinyfinder"> 
		<cfset application.ccPassword = "cecilia">
		<cfset application.apiKey = "71c7fffd-b05b-40ba-95c6-581942d36fb7">

		<!--- Typical modifications should end here --->
		<cfset application.optInSource = "ACTION_BY_CUSTOMER">
		<cfset application.debug = "true">
		<cfset application.path = "https://api.constantcontact.com">
		<cfset application.apiPath = "https://api.constantcontact.com/ws/customers/#application.ccUsername#">
		<cfset application.doNotInclude = "Active,Do Not Mail,Removed">
		
		<cfreturn true>
	</cffunction>
	
	<!--- Run SSL in production mode --->
	<cffunction
		name="enforceSSLRequirement"
		access="public"
		returntype="void"
		output="false"
		hint="I check to see if the current request aligns properly with the current SSL connection.">
 
		<!--- Definet the local scope. --->
		<cfset var local = {} />
 
		<!---
			Get the current directory in case we need to use
			this for SSL logic.
		--->
		<cfset local.directory = listLast(
			getDirectoryFromPath( cgi.script_name ),
			"\/"
			) />
 
		<!---
			Get the current file in case we need to use this
			for SSL logic.
		--->
		<cfset local.template = listLast(
			cgi.script_name,
			"\/"
			) />
 
		<!---
			Check to see if the current request is currently
			using an SSL connection.
		--->
		<cfset local.usingSSL = (cgi.https eq "on") />
 
		<!---
			In production we always want to run SSL
		--->
		<cfset local.requiresSSL = APPLICATION.environment EQ "production" />
 
 
		<!---
			At this point, we know if we are currently using
			SSL or not and we know if the current request
			requires SSL. Let's use this information to see if
			we need to perform any redirect.
		--->
		<cfif (local.usingSSL eq local.requiresSSL)>
 
			<!---
				The current page is synched with the SSL
				requirements of the request (either is requires
				and IS using an SSL connection or it does not
				require and is NOT using an SSL connection).
				Just return out of the function - no further
				action is required.
			--->
			<cfreturn />
 
		<cfelseif local.requiresSSL>
 
			<!---
				At this point, we know that we need to do some
				sort of redirect, and because the requrest
				requires an SSL connection, we know we need to
				redirect to an HTTPS connection. Let's store the
				protocol for use in the following CFLocation.
			--->
			<cfset local.protocol = "https://" />
 
		<cfelse>
 
			<!---
				At this point, we know that we need to do some
				sort of redirect, and because the request does
				NOT requiere an SSL connection, we know we need
				to redirect to an HTTP connection. Let's store the
				protocol for use in the following CFLocation.
			--->
			<cfset local.protocol = "http://" />
 
		</cfif>
 
		<!---
			If we've made it this far, then we are redirecting
			the user to a different page based on the chosen
			protocol. Build the target URL.
		--->
		<cfset local.url = (
			local.protocol &
			cgi.server_name &
			cgi.script_name &
			"?" &
			cgi.query_string
			) />
 
		<!--- Redirect the use to the target connection. --->
		<cflocation
			url="#local.url#"
			addtoken="false"
			/>
 
		<!--- Return out (NOTE: we will never make it here). --->
		<cfreturn />
	</cffunction>

	
	<!--- Runs on error --->
	<cffunction name="onError" returnType="void" output="true">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
		
		<!--- --->
		<cfif FIND(CGI.REMOTE_ADDR,APPLICATION.webadmin_ip)>
			<cfdump var="#arguments#">		
		<cfelse>
			<cfmail to="#APPLICATION.webadmin_email#" from="#APPLICATION.webadmin_email#" subject="Error Report From: DestinyFinder" type="html">
				<cfdump var="#arguments#">
			</cfmail>
			<cflocation url="/templates/error_message.cfm" addtoken="no">
		</cfif>
		
	</cffunction>
	
	<!--- Runs when your session starts --->
	<cffunction name="onSessionStart" returnType="void" output="false">
	</cffunction>

	<!--- Runs when session ends --->
	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
	</cffunction>
	
</cfcomponent>