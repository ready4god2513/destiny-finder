<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- EZIC custom tag, runs the EZIC transcation processing --->

<cfparam name="attributes.action" default="AUTH">
<cfparam name="attributes.proxy" default="">
<cfparam name="attributes.test" default="FALSE">
<cfparam name="attributes.Debug" default="FALSE">
<cfparam name="attributes.emailcustomer" default="FALSE">
<cfparam name="attributes.emailmerchant" default="TRUE">
<cfparam name="attributes.merchantemail" default="">
<cfparam name="attributes.CVV2" default="">
<cfparam name="attributes.DisableCVV2" default="0">
 
		<cfif find("/", attributes.expiredate)>
		 	<cfset month = GetToken(attributes.expiredate, 1, "/")>
			<cfset year = GetToken(attributes.expiredate, 2, "/")>
			<cfset newDate = month & year>
		<cfelse>
			<cfset newDate = attributes.expiredate>
		 </cfif>
		 
<cfif attributes.test>
	<cfset ezicserver = "http://secure.ezic.com:1401">
<cfelse>
	<cfset ezicserver = "https://secure.ezic.com:1402">
</cfif>

<cfset sendrequest = "pay_type=C&tran_type=" & URLEncodedFormat(attributes.action)>
<cfset sendrequest = sendrequest & "&account_id=" & URLEncodedFormat(attributes.account)>
<cfset sendrequest = sendrequest & "&amount=" & attributes.amount>
<cfset sendrequest = sendrequest & "&card_number=" & URLEncodedFormat(attributes.cardnumber)>
<cfset sendrequest = sendrequest & "&card_expire=" & URLEncodedFormat(newDate)>
<!--- <cfset sendrequest = sendrequest & "&card_cvv2=" & URLEncodedFormat(attributes.CVV2)>
<cfset sendrequest = sendrequest & "&bill_name1=" & URLEncodedFormat(attributes.FirstName)>
<cfset sendrequest = sendrequest & "&bill_name2=" & URLEncodedFormat(attributes.LastName)>
<cfset sendrequest = sendrequest & "&bill_street=" & URLEncodedFormat(attributes.address)>
<cfset sendrequest = sendrequest & "&bill_city=" & URLEncodedFormat(attributes.city)>
<cfset sendrequest = sendrequest & "&bill_state=" & URLEncodedFormat(attributes.state)>
<cfset sendrequest = sendrequest & "&bill_zip=" & URLEncodedFormat(attributes.zip)>
<cfset sendrequest = sendrequest & "&bill_country=" & URLEncodedFormat(attributes.country)>
<cfset sendrequest = sendrequest & "&cust_phone=" & URLEncodedFormat(attributes.phone)>
<cfset sendrequest = sendrequest & "&cust_email=" & URLEncodedFormat(attributes.email)>
<cfset sendrequest = sendrequest & "&disable_cvv2=" & URLEncodedFormat(attributes.DisableCVV2)> --->
		 
		 <cfhttp url="#ezicserver#/gw/sas/direct3.0?#sendrequest#" method="Get">
<!--- 			<cfhttpparam type="FORMFIELD" name="account_id" value="#URLEncodedFormat(attributes.account)#">
			<cfhttpparam type="FORMFIELD" name="tran_type" value="#URLEncodedFormat(attributes.action)#">
			<cfhttpparam type="FORMFIELD" name="Amount" value="#URLEncodedFormat(attributes.amount)#">
			<cfhttpparam type="FORMFIELD" name="pay_type" value="C">
			<cfhttpparam type="FORMFIELD" name="card_number" value="#URLEncodedFormat(attributes.cardnumber)#">
			<cfhttpparam type="FORMFIELD" name="card_expire" value="#URLEncodedFormat(newDate)#">	
			<cfhttpparam type="FORMFIELD" name="card_cvv2" value="#URLEncodedFormat(attributes.CVV2)#">	
			<cfhttpparam type="FORMFIELD" name="bill_name1" value="#URLEncodedFormat(attributes.FirstName)#">
			<cfhttpparam type="FORMFIELD" name="bill_name2" value="#URLEncodedFormat(attributes.LastName)#">
			<cfhttpparam type="FORMFIELD" name="bill_street" value="#URLEncodedFormat(attributes.address)#">
			<cfhttpparam type="FORMFIELD" name="bill_city" value="#URLEncodedFormat(attributes.city)#">
			<cfhttpparam type="FORMFIELD" name="bill_state" value="#URLEncodedFormat(attributes.state)#">
			<cfhttpparam type="FORMFIELD" name="bill_zip" value="#URLEncodedFormat(attributes.zip)#">
			<cfhttpparam type="FORMFIELD" name="bill_country" value="#URLEncodedFormat(attributes.country)#">
			<cfhttpparam type="FORMFIELD" name="cust_phone" value="#URLEncodedFormat(attributes.phone)#">
			<cfhttpparam type="FORMFIELD" name="cust_email" value="#URLEncodedFormat(attributes.email)#">
			<cfhttpparam type="FORMFIELD" name="disable_cvv2" value="#attributes.DisableCVV2#"> --->
		</cfhttp>

<cfif attributes.debug>
<cfoutput>Request: #sendrequest#<br/>
Response: #CFHTTP.Filecontent#<br/><br/></cfoutput></cfif>

<cfset Results = structnew()>	

<cfloop delimiters="&" list="#CFHTTP.FileContent#" index="extract">
	<cfset x = URLDecode(GetToken(extract, 1, "="))>
	<cfset y = URLDecode(GetToken(extract, 2, "="))>

	<cfscript>
	if (not(structKeyExists(Results, x))) {
		StructInsert(Results,x,y);
	}
	</cfscript>
</cfloop>
		
<cfset q_auth = QueryNew("response_code,authorization_code,response_text,avs_code,trans_id")>
<cfset nil = QueryAddRow(q_auth)>

<cfif NOT len(CFHTTP.FileContent)>
	<cfset nil = QuerySetCell( q_auth, "response_code", 0)>
	<cfset nil = QuerySetCell( q_auth, "response_text", "No response from EZIC server.")>
<cfelse>
	<cfset nil = QuerySetCell( q_auth, "response_code", StructFind(Results,"status_code"))>
	<cfset nil = QuerySetCell( q_auth, "response_text", StructFind(Results,"auth_msg"))>
	<cfset nil = QuerySetCell( q_auth, "avs_code", StructFind(Results,"avs_code"))>
	<cfset nil = QuerySetCell( q_auth, "trans_id", StructFind(Results,"trans_id"))>
</cfif>



<cfif q_auth.response_code IS NOT "0" AND q_auth.response_code IS NOT "D">
	<cfset nil = QuerySetCell( q_auth, "authorization_code", StructFind(Results,"auth_code"))>
</cfif>

<!----------------------------------------------------------------------
	Set caller query object
  ---------------------------------------------------------------------->
<cfset "Caller.#attributes.queryname#" = q_auth>
 
