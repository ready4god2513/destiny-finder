
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!-----------------------------------------------------------------------
	PayPal Direct
		Uses SOAP to send a request to the PayPal API for a Direct Payment and processes the XML response
		
	Required Parameters:
		username 	(API Login Username)
		password 	(API Password)		
		signature 	(signature key)
		server		(PayPal API server) 	
		transtype
		
		amount
		invoicenum
		cctype
		cardnumber				
		expiredate
		CVV2
		
		order
		customer
		firstname
		lastname
		address
		city
		state
		zip
		country
		email
		
		shipto_address
		shipto_address2
		shipto_city
		shipto_state
		shipto_sip
		shipto_country
		
		
	Optional Parameters:	
		structname

  ----------------------------------------------------------------------->
 
<cfparam name="attributes.structname" default="results"> 
  
  
<cfsavecontent variable="soapxml">
<cfoutput>
<SOAP-ENV:Envelope
   xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"
   xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
   xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
   xmlns:xsd="http://www.w3.org/1999/XMLSchema"
   SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
   <SOAP-ENV:Header>
      <RequesterCredentials xmlns="urn:ebay:api:PayPalAPI" SOAP-ENV:mustUnderstand="1">
         <Credentials xmlns="urn:ebay:apis:eBLBaseComponents">
            <Username>#attributes.username#</Username>
            <Password>#attributes.password#</Password>
			<Signature>#attributes.signature#</Signature>
            <Subject/>
         </Credentials>
      </RequesterCredentials>
   </SOAP-ENV:Header>
   <SOAP-ENV:Body>
      <DoDirectPaymentReq xmlns="urn:ebay:api:PayPalAPI">
         <DoDirectPaymentRequest>
            <Version xmlns="urn:ebay:apis:eBLBaseComponents">1.0</Version>
            <DoDirectPaymentRequestDetails xmlns="urn:ebay:apis:eBLBaseComponents">
               <PaymentAction>#attributes.transtype#</PaymentAction>
               <PaymentDetails>
                  <OrderTotal currencyID="USD" xmlns="ebl:BasicAmountType">#attributes.amount#</OrderTotal>
				  <InvoiceID>#attributes.invoicenum#</InvoiceID>
				  <ShipToAddress>
				  <Name>#attributes.shipto_name#</Name>
                  <Street1>#attributes.shipto_address#</Street1>
				  <Street2>#attributes.shipto_address2#</Street2>
                  <CityName>#attributes.shipto_city#</CityName>
                  <StateOrProvince>#attributes.shipto_state#</StateOrProvince>
                  <PostalCode>#attributes.shipto_zip#</PostalCode>
                  <Country>#attributes.shipto_country#</Country>
                </ShipToAddress>
               </PaymentDetails>
               <CreditCard>
                  <CreditCardType>#attributes.cctype#</CreditCardType>
                  <CreditCardNumber>#attributes.cardnumber#</CreditCardNumber>
                  <ExpMonth>#ListGetAt(attributes.expiredate,1,"/")#</ExpMonth>
                  <ExpYear>#ListGetAt(attributes.expiredate,2,"/")#</ExpYear>
                  <CardOwner>
                     <Payer>#attributes.email#</Payer>
                     <PayerName>
                       <FirstName>#attributes.firstname#</FirstName>
                       <LastName>#attributes.lastname#</LastName>
                     </PayerName>
                     <PayerCountry>#attributes.country#</PayerCountry>
                     <Address>
                        <Street1>#attributes.address#</Street1>
                        <CityName>#attributes.city#</CityName>
                        <StateOrProvince>#attributes.state#</StateOrProvince>
                        <Country>#attributes.country#</Country>
                        <PostalCode>#attributes.zip#</PostalCode>
                     </Address>
                  </CardOwner>
                  <CVV2>#attributes.CVV2#</CVV2>
               </CreditCard>
               <IPAddress>#CGI.REMOTE_ADDR#</IPAddress>
            </DoDirectPaymentRequestDetails>
         </DoDirectPaymentRequest>
      </DoDirectPaymentReq>
   </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
</cfoutput>
</cfsavecontent>

<!--- <cfset attributes.server = "https://api-aa.paypal.com/2.0/"> --->
<cfhttp url="#attributes.server#" method="post" resolveurl="No">
	<cfhttpparam type="CGI" name="SOAPAction" value="#attributes.server#">
 	<cfhttpparam type="XML" name="cgi" value="#soapxml#">
</cfhttp>



<!--- Set Structure to return results --->

<cfscript>
	results = StructNew();
	//try to parse the response
	try {
		response = XMLParse(cfhttp.FileContent);
		myresponse = response.XMLRoot;
	}
	catch(Any excpt) {
		myresponse = "none";
		}

	if (isDefined("myresponse.Body.Fault")) {
		results.success = 0;
		results.errormessage = myresponse.Body.Fault.faultstring.XMLText;		
	}
	else if (isDefined("myresponse.Body.DoDirectPaymentResponse.Errors")) {
		results.success = 0;
		results.errormessage = myresponse.Body.DoDirectPaymentResponse.Errors.LongMessage.XMLText;	
	}
	
	else if (isDefined("myresponse.Body.DoDirectPaymentResponse")) {
		results.success = 1;
		results.errormessage = '';
		results.AVSCode = myresponse.Body.DoDirectPaymentResponse.AVSCode.XMLText;
		results.CVV2Code = myresponse.Body.DoDirectPaymentResponse.CVV2Code.XMLText;
		results.TransactionID = myresponse.Body.DoDirectPaymentResponse.TransactionID.XMLText;
	}

	else {
		results.success = 0;
		results.errormessage = "Unknown failure contacting PayPal. #CFHTTP.FileContent#";		
	}

</cfscript>

<!--- <cfdump var="#soapxml#">
<cfdump var="#response#">
<cfdump var="#results#"> --->


<cfset "Caller.#attributes.structname#" = results>

