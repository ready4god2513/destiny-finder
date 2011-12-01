<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- CyberSource custom tag --->


<cfparam name="attributes.server_host" default="ics2test.ic3.com"><!--- test server --->
<cfparam name="attributes.merchant" default="">
<cfparam name="attributes.customer_firstname" default="">
<cfparam name="attributes.customer_lastname" default="">
<cfparam name="attributes.billing_address" default="">
<cfparam name="attributes.billing_city" default="">
<cfparam name="attributes.billing_country" default="US">
<cfparam name="attributes.billing_state" default="">
<cfparam name="attributes.billing_zip" default="">
<cfparam name="attributes.customer_email" default="">
<cfparam name="attributes.currency" default="USD">
<cfparam name="attributes.customer_cc_expmo" default="">
<cfparam name="attributes.customer_cc_expyr" default="">
<cfparam name="attributes.customer_cc_number" default="">
<cfparam name="attributes.customer_phone" default="">
<cfparam name="attributes.ignore_avs" default="no">
<cfparam name="attributes.order_id" default="">
<cfparam name="attributes.shipping_zip" default="">
<cfparam name="attributes.name" default="result">
<cfparam name="attributes.price" default="1.00">
<cfparam name="attributes.debug" default="0">

<cfscript>
	oICS = CreateObject("COM", "CyberSource.ICS");
	oICS.ServerHost = "#attributes.server_host#";
	oICS.Merchant = "#attributes.merchant#";
	oICS.Log = True;
	oICS.LogPath = "D:\TEMP\";
	oICS.LogSize = 10;
	oICS.SetValue("ics_applications", "ics_auth");
	
	oICS.SetValue("bill_address1", "#attributes.billing_address#");
	oICS.SetValue("bill_city", "#attributes.billing_city#");
	oICS.SetValue("bill_state", "#attributes.billing_state#");
	oICS.SetValue("bill_country", "#attributes.billing_country#");
	oICS.SetValue("bill_zip", "#attributes.billing_zip#");
	oICS.SetValue("currency", "#attributes.currency#");
	oICS.SetValue("customer_cc_expmo", "#attributes.customer_cc_expmo#");
	oICS.SetValue("customer_cc_expyr", "#attributes.customer_cc_expyr#");
	oICS.SetValue("customer_cc_number", "#attributes.customer_cc_number#");
	oICS.SetValue("customer_email", "#attributes.customer_email#");
	oICS.SetValue("customer_firstname", "#attributes.customer_firstname#");
	oICS.SetValue("customer_lastname", "#attributes.customer_lastname#");
	oICS.SetValue("customer_phone", "#attributes.customer_phone#");
	oICS.SetValue("ignore_avs", "#attributes.ignore_avs#");
	oICS.SetValue("merchant_ref_number", "#attributes.order_id#");
	oICS.SetValue("offer0", "quantity:1^amount:#attributes.price#");
	oICS.SetValue("ship_to_zip", "#attributes.shipping_zip#");

	
	//  Sent the Authorization request to Cyber Source
	oICS.Send();

</cfscript>
<cfif attributes.debug eq "yes">
<cfoutput>
	Rcode: #oICS.GetResponseValue("ics_rcode")#<br/>
	Rflag: #oICS.GetResponseValue("ics_rflag")#<br/>
	Rmsg: #oICS.GetResponseValue("ics_rmsg")#<br/>
	
	 auth_auth_amount: #oICS.GetResponseValue("auth_auth_amount")#<br/>
	 auth_auth_code: #oICS.GetResponseValue("auth_auth_code")#<br/>
	 auth_auth_response: #oICS.GetResponseValue("auth_auth_response")#<br/>
	 auth_auth_time: #oICS.GetResponseValue("auth_auth_time")#<br/>
	 auth_factor_code: #oICS.GetResponseValue("auth_factor_code")#<br/>
	 auth_rcode: #oICS.GetResponseValue("auth_rcode")#<br/>
	 auth_rflag: #oICS.GetResponseValue("auth_rflag")#<br/>
	 auth_rmsg: #oICS.GetResponseValue("auth_rmsg")#<br/>
	 auth_auth_amount: #oICS.GetResponseValue("auth_auth_amount")#<br/>
	 auth_trans_ref_no: #oICS.GetResponseValue("auth_trans_ref_no")#<br/>
	
	request_id: #oICS.GetResponseValue("request_id")#<br/>
	<cfif val(oics.getresponsevalue("ics_rcode")) lte 0>
		Error: #oICS.GetResponseValue("ics_rmsg")#<br/>
	</cfif>
</cfoutput>
<cfabort>
</cfif>
<!--- Build Response Query --->
<cfset result = querynew("result,Error_Message,auth_code,ref_code")>
<cfset queryaddrow(result,1)>
<cfif val(oics.getresponsevalue("ics_rcode")) eq 1>
	<cfset querysetcell(result,"result","1")>
	<cfset querysetcell(result,"Error_Message","")>
	<cfset querysetcell(result,"auth_code",#oics.getresponsevalue("auth_auth_code")#)>
	<cfset querysetcell(result,"ref_code",#oics.getresponsevalue("request_id")#)>
<cfelse>
	<cfset querysetcell(result,"result","failure")>
	<cfset querysetcell(result,"Error_Message","Could not verify your credit card. #oICS.GetResponseValue("ics_rmsg")#")>
	<cfset querysetcell(result,"auth_code","")>
	<cfset querysetcell(result,"ref_code","")>
</cfif>
<!--- Set Caller Query to cc --->
<cfset caller.result = result>
