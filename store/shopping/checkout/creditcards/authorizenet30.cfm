<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!-----------------------------------------------------------------------
	AuthorizeNet30
		Uses the "ADC Direct Response" method to send data to a secure
		AuthorizeNet gateway.
		
	Required Parameters:
		login 		(API Login ID)
		password 	(transaction key)		
		action	
		
		amount
		cardnumber				
		expiredate
		
		order
		customer
		firstname
		lastname
		address
		city
		state
		zip
		country
		phone
		email
		
		
	Optional Parameters:	
		company
		customer 		(customer ID)	
		proxy			(none)
		test			(TRUE)
		emailcustomer	(FALSE)
		emailmerchant	(TRUE)
		merchantemail	("")
		CVV2

  ----------------------------------------------------------------------->

<cfparam name="attributes.action" default="AUTH_ONLY">
<cfparam name="attributes.proxy" default="">
<cfparam name="attributes.test" default="FALSE">
<cfparam name="attributes.emailcustomer" default="FALSE">
<cfparam name="attributes.emailmerchant" default="TRUE">
<cfparam name="attributes.merchantemail" default="">
<cfparam name="attributes.firstname" default="">
<cfparam name="attributes.lastname" default="">
<cfparam name="attributes.company" default="">
<cfparam name="attributes.CVV2" default="">

<cfset amount = NumberFormat(attributes.amount, "0.00")>
 
		<cfhttp url="https://secure.authorize.net/gateway/transact.dll" method="post">

			<cfhttpparam type="FORMFIELD" name="x_login" value="#attributes.login#">
			<cfhttpparam type="FORMFIELD" name="x_tran_key" value="#attributes.password#">
			<cfhttpparam type="FORMFIELD" name="x_version" value="3.1">
			<cfhttpparam type="FORMFIELD" name="x_test_request" value="#attributes.test#">
			
			<cfhttpparam type="FORMFIELD" name="x_delim_data" value="TRUE">
			<cfhttpparam type="FORMFIELD" name="x_delim_char" value=",">
			<cfhttpparam type="FORMFIELD" name="x_relay_response" value="FALSE">
			
			<cfhttpparam type="FORMFIELD" name="x_first_name" value="#attributes.firstname#">
			<cfhttpparam type="FORMFIELD" name="x_last_name" value="#attributes.lastname#">
			<cfhttpparam type="FORMFIELD" name="x_company" value="#attributes.company#">
			<cfhttpparam type="FORMFIELD" name="x_address" value="#attributes.address#">
			<cfhttpparam type="FORMFIELD" name="x_city" value="#attributes.city#">
			<cfhttpparam type="FORMFIELD" name="x_state" value="#attributes.state#">
			<cfhttpparam type="FORMFIELD" name="x_zip" value="#attributes.zip#">
			<cfhttpparam type="FORMFIELD" name="x_country" value="#attributes.country#">
			<cfhttpparam type="FORMFIELD" name="x_phone" value="#attributes.phone#">
			
			<cfhttpparam type="FORMFIELD" name="x_cust_id" value="#attributes.customer#">
			<cfhttpparam type="FORMFIELD" name="x_customer_ip" value="#CGI.REMOTE_ADDR#">
			
			<cfhttpparam type="FORMFIELD" name="x_email" value="#attributes.email#">			
			<cfhttpparam type="FORMFIELD" name="x_email_customer" value="#attributes.emailcustomer#">
			<cfhttpparam type="FORMFIELD" name="x_email_merchant" value="#attributes.emailmerchant#">
			<cfhttpparam type="FORMFIELD" name="x_merchant_email" value="#attributes.merchantemail#">
			
			<cfhttpparam type="FORMFIELD" name="x_invoice_num" value="#attributes.order#">

			<cfhttpparam type="FORMFIELD" name="x_amount" value="#amount#">
			<cfhttpparam type="FORMFIELD" name="x_method" value="CC">
			<cfhttpparam type="FORMFIELD" name="x_type" value="#attributes.action#">
			<cfhttpparam type="FORMFIELD" name="x_card_num" value="#attributes.cardnumber#">
			<cfhttpparam type="FORMFIELD" name="x_exp_date" value="#attributes.expiredate#">
			<cfhttpparam type="FORMFIELD" name="x_card_code" value="#attributes.CVV2#">
			


		</cfhttp>

		<!----------------------------------------------------------------------
	Create a local query object for result
  ---------------------------------------------------------------------->
<cfset q_auth = QueryNew("response_code,authorization_code,response_text,avs_code,trans_id")>
<cfset nil = QueryAddRow(q_auth)>

<cfif ListLen(cfhttp.FileContent) GTE 5>

	<cfset nil = QuerySetCell( q_auth, "response_code", Replace(ListGetAt(CFHTTP.FileContent, 1),'"','','ALL'))>
	<cfset nil = QuerySetCell( q_auth, "authorization_code", Replace(ListGetAt(CFHTTP.FileContent, 5),'"','','ALL'))>
	<cfset nil = QuerySetCell( q_auth, "response_text", Replace(ListGetAt(CFHTTP.FileContent, 4),'"','','ALL'))>
	<cfset nil = QuerySetCell( q_auth, "avs_code", Replace(ListGetAt(CFHTTP.FileContent, 6),'"','','ALL'))>
	<cfset nil = QuerySetCell( q_auth, "trans_id", Replace(ListGetAt(CFHTTP.FileContent, 7),'"','','ALL'))>
	
<cfelse>

	<cfset nil = QuerySetCell( q_auth, "response_code", "E")>
	<cfset nil = QuerySetCell( q_auth, "authorization_code", "")>
	<cfset nil = QuerySetCell( q_auth, "response_text", cfhttp.FileContent)>
	<cfset nil = QuerySetCell( q_auth, "avs_code", "")>
	<cfset nil = QuerySetCell( q_auth, "trans_id", "")>

</cfif>

<!----------------------------------------------------------------------
	Set caller query object
  ---------------------------------------------------------------------->
<cfset "Caller.#attributes.queryname#" = q_auth>


