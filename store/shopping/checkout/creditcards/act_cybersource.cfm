
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run CyberSource credit card validation. Called from checkout/act_pay_form.cfm --->

<!--- Retrive CyberSource settings --->
<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT Password, Transtype, Username, CCServer
FROM #Request.DB_Prefix#CCProcess
</cfquery>

<cfset custzip = replace(getcustomer.zip, "-", "")>

<cfset r = randomize(minute(now())&second(now()))>
<cfset randomnum = randrange(1000,9999)>
<cfif getcustomer.state is "Unlisted">
<cfset custstate = getcustomer.state2>
<cfelse>
<cfset custstate = getcustomer.state>
</cfif>

<cfset InvoiceNum = Replace(CGI.REMOTE_ADDR,".","","ALL") & randomnum>

<cfset custnum = session.sessionid>
<cfparam name="attributes.CVV2" default="">

<cflock name="cybersource" timeout="150" type="EXCLUSIVE">
	<cf_cybersource_payment
		server_host="#GetSettings.CCServer#"
	    merchant="#GetSettings.Username#"
	    trans_type="mauthonly"
		timeout="300"
	    order_id="#InvoiceNum#"
	    currency="USD"
		price="#NumberFormat(GetTotals.OrderTotal, "________.00")#"
	    customer_cc_number="#attributes.CardNumber#"
	    customer_cc_expmo="#month#"
		customer_cc_cv_number="#attributes.CVV2#"
		customer_cc_expyr="#year#"
	    customer_firstname="#GetCustomer.firstname#"
		customer_lastname="#GetCustomer.lastname#"
		customer_phone="#GetCustomer.phone#"
		customer_email="#GetCustomer.email#"
	    billing_address="#GetCustomer.address1#"
	    billing_city="#GetCustomer.city#"
	    billing_state="#GetCustomer.state#"
	    billing_zip="#GetCustomer.zip#"
	    billing_country="#ListFirst(GetCustomer.country, '^')#"	
	    name="RESULT">
	 
</cflock>

<!--- Debug --->
<!--- <cfdump var="#Result#"> --->

<!---If the message is approved, continue processing the order---->
<cfif result.result is "1">
  <cfset authnumber = result.auth_code>
  <cfset transactnum = result.ref_code>
  <cfset attributes.step = "receipt">
<cfelse><!--Otherwise, display the result message.--->
  <cfset errormessage = result.error_message & " Please change the information entered, or return to the store.">   
  <cfset display = "Yes">
  <cfset CompOrder = "Complete Order">
</cfif>
			


			