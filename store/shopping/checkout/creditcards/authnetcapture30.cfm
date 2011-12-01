<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!-----------------------------------------------------------------------
	AuthNetCapture30
		Uses the "ADC Direct Response" method to send data to a secure
		AuthorizeNet gateway to capture funds for a previously authorized transaction.
		
	Required Parameters:
		login (API Login ID)
		password (transaction key)	
		TransactNum	
		
		amount
		type
				
	Optional Parameters:		
		action
		proxy			(none)
		test			(TRUE)
		emailcustomer	(FALSE)
		emailmerchant	(TRUE)
		merchantemail	("")

  ----------------------------------------------------------------------->

<cfparam name="attributes.action" default="PRIOR_AUTH_CAPTURE">
<cfparam name="attributes.proxy" default="">
<cfparam name="attributes.test" default="FALSE">
<cfparam name="attributes.emailcustomer" default="FALSE">
<cfparam name="attributes.emailmerchant" default="TRUE">
<cfparam name="attributes.merchantemail" default="">

<cfset amount = DecimalFormat(attributes.amount)>
 
		<cfhttp url="https://secure.authorize.net/gateway/transact.dll" method="post">

			<cfhttpparam type="FORMFIELD" name="x_login" value="#attributes.login#">
			<cfhttpparam type="FORMFIELD" name="x_tran_key" value="#attributes.password#">
			<cfhttpparam type="FORMFIELD" name="x_version" value="3.1">
			<cfhttpparam type="FORMFIELD" name="x_test_request" value="#attributes.test#">
			
			<cfhttpparam type="FORMFIELD" name="x_delim_data" value="TRUE">
			<cfhttpparam type="FORMFIELD" name="x_delim_char" value=",">
			<cfhttpparam type="FORMFIELD" name="x_relay_response" value="FALSE">
			
			<cfhttpparam type="FORMFIELD" name="x_amount" value="#amount#">		
			<cfhttpparam type="FORMFIELD" name="x_type" value="#attributes.action#">	
			<cfhttpparam type="FORMFIELD" name="x_trans_id" value="#attributes.TransActNum#">	
			<cfhttpparam type="FORMFIELD" name="x_email_customer" value="#attributes.emailcustomer#">
			<cfhttpparam type="FORMFIELD" name="x_email_merchant" value="#attributes.emailmerchant#">
			<cfhttpparam type="FORMFIELD" name="x_merchant_email" value="#attributes.merchantemail#">

			<cfhttpparam type="FORMFIELD" name="x_test_request" value="#attributes.test#">

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


