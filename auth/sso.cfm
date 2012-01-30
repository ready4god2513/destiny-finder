<!--- This page is a callback from FoxyCart.  It is called when users attempt to log in to the shopping cart --->
<cfset foxyCart = CreateObject("component", "cfcs.foxycart") />
<cfset queries = CreateObject("component","cfcs.queries") />

<cfif REQUEST.user_id GT 0>
	<cfset user = queries.user_detail(user_id="#REQUEST.user_id#") />

	<cfset foxyCart.save_user(username = "#user.user_email#", password = "#user.user_password#") />
	<cfset customer_id = foxyCart.find_foxycart_customer_id(email = "#user.user_email#") />
	<cfset timestamp = url["timestamp"] + 86400 />
	<cfset auth_token = foxyCart.auth_token(customer_id = #customer_id#, timestamp = #timestamp#) />
	<cfset redirect_url = "https://destinyfinder.foxycart.com/checkout?fc_auth_token=#auth_token#&fcsid=#url["fcsid"]#&fc_customer_id=#customer_id#&timestamp=#timestamp#" />

	<cflocation url="#Lcase(redirect_url)#" addtoken="no" />
<cfelse>
	<cflocation url="/auth" />
</cfif>