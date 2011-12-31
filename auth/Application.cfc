<cfcomponent output="false">
	<!---<cfif NOT ListContains("68.30.233.215,108.100.97.6,75.16.198.64,68.229.193.96,209.36.244.253,98.238.142.48,192.150.3.7,74.10.105.233",cgi.REMOTE_ADDR)>
 <cflocation url="default.htm">
    <cfabort>
    </cfif>--->
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
	<cfset this.clientStorage = "registry">
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

	
	<cfset APPLICATION.webadmin_email = "tony@webvisionhosting.com">
	<cfset APPLICATION.webadmin_ip = "68.229.193.96">

		
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
		
		
		<cfset DSN="destinyfinder_dev">
		<cfset APPLICATION.DSN="destinyfinder_dev">
		<cfset APPLICATION.STORE_DSN = "destinyfinder_store">
		<cfset APPLICATION.STAGING = 0>
		
		<cfset APPLICATION.sitename = "Destiny Finder">
		<cfset thispath=GetDirectoryFromPath(CF_TEMPLATE_PATH)>
		<cfset APPLICATION.server_path = REPLACE(GetDirectoryFromPath(CF_TEMPLATE_PATH),"\admin\","\")>
	
		
		<cfset APPLICATION.contact_email = "tony@webvisionhosting.com">

		
		<cfset REQUEST.site_url = "http://dev.destinyfinder.com/">
		
		<!--- FOR BLOG --->
		<cfset REQUEST.time_offset = 2>
		<cfset REQUEST.from_email = "noreply@destinyfinder.com">
		<cfset REQUEST.site_path= "">
		<cfset REQUEST.temp_upload_dir = "">
		
		
		<!--- MANAGE UNIVERSAL LOGIN --->
		<cfset obj_login = CreateObject("component","cfcs.login")>
		
		<cfif isDefined('URL.logout')>
			<cfset obj_login.logout()>
			<!--- <cflocation url="/index.cfm" addtoken="no"> --->
		</cfif>
		
            
		<!--- THIS VARIABLE EITHER STORES THE USER_ID OR 0 IF A USER IS NOT LOGGED IN --->
		<cfset REQUEST.user_id = obj_login.is_logged_in()>

		<!---
		<cfif REQUEST.user_id EQ 0>
			<cfmodule template="/templates/login.cfm">
			<cfabort>
		</cfif>
		--->
		
		<cfreturn true>
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