<cfcomponent displayname="foxycart" output="no" hint="I interact with the FoxyCart API">
	
	<cfset apiToken="ZXfxZZFuKRzaWQyR3yexR2VUIjHFHvMxjXU9MvtscSs3CUKviPWZKINkWmUu">
	
	<cffunction name="save_user" returntype="boolean" output="false" hint="I create/update a user via the FoxyCart API">
		<cfargument name="username" type="string" require="yes" />		
		<cfargument name="password"	type="string" require="yes" />
		
		<cfhttp
			url="https://destinyfinder.foxycart.com/api/"
			method="POST"
			port="443"
			userAgent="DestinyFinder">
			<cfhttpparam name="api_token" type="FormField" value="#apiToken#" />
			<cfhttpparam name="customer_email" type="FormField" value="#username#" />
			<cfhttpparam name="customer_email" type="FormField" value="#username#" />
			<cfhttpparam name="customer_password_hash" type="FormField" value="#password#" />
		</cfhttp>
		
		<cfset xmlDoc = XmlParse(CFHTTP.FileContent) />
		
			
		<cfreturn true>
	</cffunction>
	
	<cffunction name="authenticate_user" returntype="void" output="false" hint="I authenticate a user via the FoxyCart API">
		<cfargument name="user_name" type="string" require="yes" />		
		<cfargument name="password"	type="string" require="yes" />
		
	</cffunction>
	
</cfcomponent>