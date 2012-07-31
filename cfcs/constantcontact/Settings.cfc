<cfcomponent displayname="Settings"  initmethod="init">
	<cffunction name="init" access="public" output="false">
		<cfreturn this>
	</cffunction> 
	
	<cffunction name="getVerifiedEmail" access="public" output="false">
		<cfset local.verifiedEmailArray = arrayNew(1)>
		
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="GET"
				address="#application.apiPath#/settings/emailaddresses"
				returnValue="local.httpResponse" />
				
		<cfset local.responseXml = xmlParse(local.httResponse)>
				
		<cfloop from="1" to="#arrayLen(local.responseXml.feed.entry)#" index="i">
			<cfset local.verifiedEmailStruct.id = local.responseXml.feed.entry[i].content.email.xmlattributes.id>
			<cfset local.verifiedEmailStruct.status = local.responseXml.feed.entry[i].content.email.status.xmlText>
			<cfset local.verifiedEmailStruct.verifiedTime = local.responseXml.feed.entry[i].content.email.verifiedtime.xmlText>
			<cfset local.verifiedEmailStruct.emailAddress = local.responseXml.feed.entry[i].content.email.emailAddress.xmlText>
			<cfset local.verifiedEmail = createObject("component", "VerifiedEmail").init(argumentCollection = local.verifiedEmailStruct)>
			<cfset arrayAppend(local.verifiedEmailArray, local.verifiedEmail)>
		
		</cfloop>
		
		<cfreturn local.verifiedEmailArray>
	</cffunction>
</cfcomponent>
