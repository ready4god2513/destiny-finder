<!--- This page is a callback from FoxyCart.  It is called when users attempt to log in to the shopping cart --->
<cfset foxyCart = CreateObject("component", "cfcs.foxycart") />
<cfset queries = CreateObject("component","cfcs.queries") />

<cfset user = queries.user_detail(user_id="#REQUEST.user_id#") />

<cfset foxyCart.save_user(username = "#user.user_email#", password = "#user.user_password#") />
<cfset foxyCart.find_foxycart_customer_id(email = "#user.user_email#") />

<cflocation url="'https://destinyfinder.foxycart.com/checkout?fc_auth_token=#auth_token#&fcsid=#url["fcsid"]#&fc_customer_id=#url["fc_customer_id"]#&timestamp=#url["timestamp"]#" />