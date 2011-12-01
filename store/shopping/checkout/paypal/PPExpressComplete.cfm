
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!-----------------------------------------------------------------------
	PPExpressComplete
		Process the third step of PayPal Express Checkout to complete the payment process.
		
	Required Parameters:
		username 	(API Login Username)
		password 	(API Password)		
		signature 	(signature key)
		server		(PayPal API server) 	
		token
		payerID
		ordertotal
		transtype
		
		
	Optional Parameters:
		structname		

  ----------------------------------------------------------------------->

<cfparam name="attributes.structname" default="results"> 
<cfset OrderTotal = DecimalFormat(attributes.OrderTotal)>
  
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
      <DoExpressCheckoutPaymentReq xmlns="urn:ebay:api:PayPalAPI">
         <DoExpressCheckoutPaymentRequest>
            <Version xmlns="urn:ebay:apis:eBLBaseComponents">1.0</Version>
            <DoExpressCheckoutPaymentRequestDetails xmlns="urn:ebay:apis:eBLBaseComponents">
               <Token>#attributes.Token#</Token>
               <PaymentAction>#attributes.transtype#</PaymentAction>
               <PayerID>#attributes.PayerID#</PayerID>
               <PaymentDetails>
                  <OrderTotal xmlns="urn:ebay:apis:eBLBaseComponents" currencyID="USD">#OrderTotal#</OrderTotal>
               </PaymentDetails>
            </DoExpressCheckoutPaymentRequestDetails>
         </DoExpressCheckoutPaymentRequest>
      </DoExpressCheckoutPaymentReq>
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
	else if (isDefined("myresponse.Body.DoExpressCheckoutPaymentResponse.Errors")) {
		results.success = 0;
		results.errormessage = myresponse.Body.DoExpressCheckoutPaymentResponse.Errors.LongMessage.XMLText;	
	}
	
	else if (isDefined("myresponse.Body.DoExpressCheckoutPaymentResponse.DoExpressCheckoutPaymentResponseDetails")) {
		theDetails = myresponse.Body.DoExpressCheckoutPaymentResponse.DoExpressCheckoutPaymentResponseDetails;
		thePayment = theDetails.PaymentInfo;
		results.success = 1;
		results.errormessage = '';
		results.transactionID = thePayment.TransactionID.XMLText;
		results.PaymentStatus = thePayment.PaymentStatus.XMLText;
		results.PendingReason = thePayment.PendingReason.XMLText;
		results.ReasonCode = thePayment.ReasonCode.XMLText;

	}
	else {
		results.success = 0;
		results.errormessage = "Unknown failure contacting PayPal. #CFHTTP.FileContent#";		
	}

</cfscript>

<cfset "Caller.#attributes.structname#" = results>




