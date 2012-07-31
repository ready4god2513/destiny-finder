<cfcomponent displayname="Utility" initmethod="init" access="public">
	<cfset variables.requireRequestBody = "post,put,POST,PUT">
	<cffunction name="init" access="public" output="false">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="writeToText" access="public">
		<cfargument name="message" required="true">
	
	<cfdump var="#arguments.message#" output="C:\Users\David\Desktop\rawr.txt">
	
	
	</cffunction>
			
	<cffunction name="CTCTRequest">
		<cfargument name="requestMethod" type="string" default="GET" >
		<cfargument name="address" type="string" required="true">
		<cfargument name="requestValue" required="false">
		
		<cfhttp url="#arguments.address#"
				method="#arguments.requestMethod#"
				username="#application.apiKey#%#application.ccUsername#"
				password="#application.ccPassword#">
					
			<cfhttpparam type="header" name="Content-Type" value="application/atom+xml">
			<cfhttpparam type="header" name="Accept" value="application/atom+xml">
			
			<cfif listContains(variables.requireRequestBody, arguments.requestMethod)>
				<cfhttpparam type="body" value="#arguments.requestValue#">
			</cfif>
		</cfhttp>
		
		<cfset debug(cfhttp, arguments.requestMethod, arguments.address)>
		
		<cfreturn cfhttp.fileContent.toString()>
	
	</cffunction>
	
	<cffunction name="multiPartPost" access="public" output="false" returntype="any">
		<cfargument name="activityType" required="true" type="string">
		<cfargument name="lists" required="true" type="array">
		<cfargument name="dataFile" type="string" default="none">
		
		<cfhttp url="#application.apiPath#/activities"
				method="post" 
				username="#application.apiKey#%#application.ccUsername#"
				password="#application.ccPassword#">
				
			<cfhttpparam type="header" name="accept" value="application/atom+xml">
			
			<cfhttpparam type="formField" name="activityType" value="#arguments.activityType#">

			<cfloop from="1" to="#arrayLen(arguments.lists)#" index="i">
				<cfhttpparam type="formField" name="lists" value="#arguments.lists[i]#">
			</cfloop>
			
			<cfif (arguments.dataFile NEQ "none")>
				<cfhttpparam type="formField" name="data" value="#arguments.dataFile#">
			</cfif>
		</cfhttp>
		
		<cfset debug(cfhttp, 'post', '#application.apiPath#/activities')>
		
		<cfreturn cfhttp.FileContent.toString()>
	</cffunction>
	
	<cffunction name="urlencodedPost" access="public" output="false" returntype="any">
		<cfargument name="uploadString" type="string" required="true" hint="encoded string to upload">
		
		<cfhttp url="#application.apiPath#/activities"
				method="post"
				username="#application.apiKey#%#application.ccUsername#"
				password="#application.ccPassword#">
				
			<cfhttpparam type="header" name="Content-Type" value="application/x-www-form-urlencoded">
			<cfhttpparam type="body" name="Accept" value="#arguments.uploadString#">
		</cfhttp>
		
		<cfset debug(cfhttp, 'post', '#application.apiPath#/activities')>
		<cfreturn cfhttp.fileContent.toString()>
	</cffunction>
	
	<cffunction name="exportContactsPost" access="public" output="true" returntype="any">
		<cfargument name="listId" required="true" type="string" hint="id of list to be exported" />
		<cfargument name="columns" required="true" type="array" hint="array of columns to be exported" />
		<cfargument name="fileType" type="string" default="CSV" hint="Valid: CSV, TXT" />
		<cfargument name="exportOptDate" type="boolean" default="true" hint="include optDate in export" />
		<cfargument name="exportOptSource" type="boolean" default="true" hint="include opt source in export" />
		<cfargument name="exportListName" type="boolean"  default="true" hint="include list name in export" />
		<cfargument name="sortBy" type="string" default="EMAIL_ADDRESS" hint="Valid: EMAIL_ADDRESS, DATE_DESC" />
		
			<cfhttp url="#application.apiPath#/activities"
					method="post"
					username="#application.apiKey#%#application.ccUsername#"
					password="#application.ccPassword#">
					
				<cfhttpparam type="header" name="accept" value="multipart/form-data">
				<cfhttpparam type="formField" name="activityType" value="EXPORT_CONTACTS">
				<cfhttpparam type="formField" name="listId" value="#arguments.listId#">
				<cfhttpparam type="formField" name="fileType" value="#arguments.fileType#">
				<cfhttpparam type="formField" name="exportOptDate" value="#arguments.exportOptDate#">
				<cfhttpparam type="formField" name="exportOptSource" value="#arguments.exportOptSource#">
				<cfhttpparam type="formField" name="exportListName" value="#arguments.exportListName#">
				<cfhttpparam type="formField" name="sortBy" value="#arguments.sortBy#">
				
				<cfloop from="1" to="#arrayLen(columns)#" index="i">
					<cfhttpparam type="formField" name="columns" value="#arguments.columns[i]#">
				</cfloop>
			</cfhttp>
				<cfset debug(cfhttp, 'post', '#application.apiPath#/activities')>
		<cfreturn cfhttp.fileContent.toString()>
	</cffunction>
	
	<cffunction name="debug" access="private" output="false" hint="file write">
		<cfargument name="httpResponse" required="true">
		<cfargument name="requestMethod" required="true" type="string">
		<cfargument name="requestAddress" required="true" type="string">
		<cfif application.debug EQ true>
			<cfset local.failedStatus = "400,401,403,404,409,415,500"> 
			<cfif listContains(local.failedStatus, arguments.httpResponse.responseHeader['status_code'])>
				<cfset responseText = xmlFormat('#arguments.httpResponse.fileContent#') >
				<cfsavecontent variable="local.errormessage">
					<cfoutput>
					Status Code: #arguments.httpResponse.statusCode#<br />
					Request Method: #arguments.requestMethod#<br />
					Request Address: #arguments.requestAddress#<br />
					Response: #responseText#<br />
					</cfoutput>
				</cfsavecontent>
				<cfthrow detail="#local.errormessage#" 
					message="HTTP Request error with Constant Contact">
			</cfif>
		</cfif>
	</cffunction>
</cfcomponent>
