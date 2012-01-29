<cfcomponent displayname="foxycart" output="no" hint="I interact with the FoxyCart API">
	
	<cffunction name="save_user" returntype="boolean" output="false" hint="I create/update a user via the FoxyCart API">
		<cfargument name="username" type="string" require="yes" />		
		<cfargument name="password"	type="string" require="yes" />
		
		<cfhttp
			url="#APPLICATION.foxyCart.baseURL#"
			method="POST"
			port="443"
			userAgent="DestinyFinder">
			<cfhttpparam name="api_token" type="FormField" value="#APPLICATION.foxyCart.apiKey#" />
			<cfhttpparam name="api_action" type="FormField" value="customer_save" />
			<cfhttpparam name="customer_email" type="FormField" value="#ARGUMENTS.username#" />
			<cfhttpparam name="customer_password_hash" type="FormField" value="#ARGUMENTS.password#" />
		</cfhttp>
			
		<cfreturn true>
	</cffunction>
	
	
	<cffunction name="auth_token" returntype="string" output="false" hint="I authenticate a user via the FoxyCart API">
		<cfargument name="customer_id" type="string" require="yes" />		
		<cfargument name="timestamp" type="string" require="yes" />
		
		<cfreturn Lcase(Hash("#ARGUMENTS.customer_id#|#ARGUMENTS.timestamp#|#APPLICATION.foxyCart.apiKey#", "SHA-256"))>
	</cffunction>
	
	
	<cffunction name="find_foxycart_customer_id" returntype="string" output="false" hint="I find the customer id in foxycart based on the e-mail">
		<cfargument name="email" type="string" require="yes" />
		
		<cfhttp
			url="#APPLICATION.foxyCart.baseURL#"
			method="POST"
			port="443"
			userAgent="DestinyFinder">
			<cfhttpparam name="api_token" type="FormField" value="#APPLICATION.foxyCart.apiKey#" />
			<cfhttpparam name="api_action" type="FormField" value="customer_get" />
			<cfhttpparam name="customer_email" type="FormField" value="#ARGUMENTS.email#" />
		</cfhttp>
		
		<cfset xmlDoc = XmlParse(CFHTTP.FileContent) />
		
		<cfreturn xmlDoc.foxydata.customer_id.xmlText>
	</cffunction>
	
</cfcomponent>