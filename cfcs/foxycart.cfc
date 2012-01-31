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
		
		<cfreturn Hash("#ARGUMENTS.customer_id#|#ARGUMENTS.timestamp#|#APPLICATION.foxyCart.apiKey#", "SHA-1")>
	</cffunction>
	
	
	<cffunction name="getCustomerTransactions" returntype="any" output="false" hint="I get any transactions for a user">
		<cfargument name="email" type="string" require="yes" />
		
		<cfset var local = {}>
		
		<cfhttp
			url="#APPLICATION.foxyCart.baseURL#"
			method="POST"
			port="443"
			userAgent="DestinyFinder">
			<cfhttpparam name="api_token" type="FormField" value="#APPLICATION.foxyCart.apiKey#" />
			<cfhttpparam name="api_action" type="FormField" value="transaction_list" />
			<cfhttpparam name="customer_email_filter" type="FormField" value="#ARGUMENTS.email#" />
		</cfhttp>
		
		<cfset local.xmlDoc = XmlParse(CFHTTP.FileContent) />
		<cfreturn local.xmlDoc.foxydata.transactions />
	</cffunction>
	
	
	<cffunction name="customerPurchasedCode" returntype="any" output="false" hint="I check against the foxycart API to see if the customer has purchased a product with a specific code">
		<cfargument name="email" type="string" require="yes" />
		<cfargument name="code" type="string" require="yes" />
		
		<cfset var local = {}>
		<cfset local.transactions = this.getCustomerTransactions(email = ARGUMENTS.email)>
		
		<cfloop from="1" to="#arraylen(local.transactions)#" index="i">
			<cfif local.transactions.transaction[i].transaction_details.transaction_detail.product_code.xmlText EQ ARGUMENTS.code>
				<cfreturn true>
			</cfif>
		</cfloop>
		
		<cfreturn false />
	</cffunction>
	
	
	<cffunction name="find_foxycart_customer_id" returntype="string" output="false" hint="I find the customer id in foxycart based on the e-mail">
		<cfargument name="email" type="string" require="yes" />
		
		<cfset var local = {}>
		
		<cfhttp
			url="#APPLICATION.foxyCart.baseURL#"
			method="POST"
			port="443"
			userAgent="DestinyFinder">
			<cfhttpparam name="api_token" type="FormField" value="#APPLICATION.foxyCart.apiKey#" />
			<cfhttpparam name="api_action" type="FormField" value="customer_get" />
			<cfhttpparam name="customer_email" type="FormField" value="#ARGUMENTS.email#" />
		</cfhttp>
		
		<cfset local.xmlDoc = XmlParse(CFHTTP.FileContent) />
		
		<cfreturn local.xmlDoc.foxydata.customer_id.xmlText>
	</cffunction>
	
</cfcomponent>