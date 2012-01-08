<cfcomponent displayname="foxycart" output="no" hint="I interact with the FoxyCart API">
	
	<cfset apiToken = "ZXfxZZFuKRzaWQyR3yexR2VUIjHFHvMxjXU9MvtscSs3CUKviPWZKINkWmUu" />
	<cfset baseURL = "https://destinyfinder.foxycart.com/api">
	
	<cffunction name="save_user" returntype="boolean" output="false" hint="I create/update a user via the FoxyCart API">
		<cfargument name="username" type="string" require="yes" />		
		<cfargument name="password"	type="string" require="yes" />
		
		<cfhttp
			url="#baseURL#"
			method="POST"
			port="443"
			userAgent="DestinyFinder">
			<cfhttpparam name="api_token" type="FormField" value="#apiToken#" />
			<cfhttpparam name="api_action" type="FormField" value="customer_save" />
			<cfhttpparam name="customer_email" type="FormField" value="#username#" />
			<cfhttpparam name="customer_password_hash" type="FormField" value="#password#" />
		</cfhttp>
		
		<cfset xmlDoc = XmlParse(CFHTTP.FileContent) />
		<cfdump var = "#xmlDoc#" />
		<cfabort />
			
		<cfreturn true>
	</cffunction>
	
	<cffunction name="authenticate_user" returntype="void" output="false" hint="I authenticate a user via the FoxyCart API">
		<cfargument name="user_name" type="string" require="yes" />		
		<cfargument name="password"	type="string" require="yes" />
		
	</cffunction>
	
	
	<cffunction name="hmacEncrypt" returntype="binary" access="public" output="false">
	   <cfargument name="signKey" type="string" required="true" />
	   <cfargument name="signMessage" type="string" required="true" />

	   <cfset var jMsg = JavaCast("string",arguments.signMessage).getBytes("iso-8859-1") />
	   <cfset var jKey = JavaCast("string",arguments.signKey).getBytes("iso-8859-1") />

	   <cfset var key = createObject("java","javax.crypto.spec.SecretKeySpec") />
	   <cfset var mac = createObject("java","javax.crypto.Mac") />

	   <cfset key = key.init(jKey,"HmacSHA1") />

	   <cfset mac = mac.getInstance(key.getAlgorithm()) />
	   <cfset mac.init(key) />
	   <cfset mac.update(jMsg) />

	   <cfreturn mac.doFinal() />
	</cffunction>
	
	
	<cffunction name="find_foxycart_customer_id" returntype="integer" output="false" hint="I find the customer id in foxycart based on the e-mail">
		<cfargument name="email" type="string" require="yes" />
		
		<cfhttp
			url="#baseURL#"
			method="POST"
			port="443"
			userAgent="DestinyFinder">
			<cfhttpparam name="api_token" type="FormField" value="#apiToken#" />
			<cfhttpparam name="api_action" type="FormField" value="customer_get" />
			<cfhttpparam name="customer_email" type="FormField" value="#ARGUMENTS.email#" />
		</cfhttp>
		
		<cfset xmlDoc = XmlParse(CFHTTP.FileContent) />
		<cfdump var = "#xmlDoc#" />
		<cfabort />
	</cffunction>
	
</cfcomponent>