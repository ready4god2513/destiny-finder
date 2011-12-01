
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!-----------------------------------------------------------------------
	PayPalDirectCapture
		Uses the Authorization and Capture API for PayPal Websites Pro to capture funds for a previously authorized transaction.
		
	Required Parameters:
		username 	(API Login Username)
		password 	(API Password)		
		signature 	(signature key)
		server		(PayPal API server) 	
		OrderNum
		TransactNum	
		
		amount
				

  ----------------------------------------------------------------------->

<cfparam name="attributes.structname" default="results"> 
<cfset amount = DecimalFormat(attributes.amount)>
  
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
      <DoCaptureReq xmlns="urn:ebay:api:PayPalAPI">
         <DoCaptureRequest xmlns="urn:ebay:api:PayPalAPI">
            <Version xmlns="urn:ebay:apis:eBLBaseComponents" xsi:type="xsd:string">1.0</Version>
            <AuthorizationID>#attributes.TransactNum#</AuthorizationID>
            <Amount currencyID="USD" xsi:type="cc:BasicAmountType">#amount#</Amount>
            <CompleteType>Complete</CompleteType>
            <Note>Order completed for #Request.AppSettings.SiteName#</Note>
         </DoCaptureRequest>
      </DoCaptureReq>
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
	else if (isDefined("myresponse.Body.DoCaptureResponse.Errors")) {
		results.success = 0;
		results.errormessage = myresponse.Body.DoCaptureResponse.Errors.LongMessage.XMLText;	
	}
	
	else if (isDefined("myresponse.Body.DoCaptureResponse")) {
		results.success = 1;
		results.transactionID = myresponse.Body.DoCaptureResponse.DoCaptureResponseDetails.PaymentInfo.TransactionID.XMLText;
		results.errormessage = '';
	}

	else {
		results.success = 0;
		results.errormessage = "Unknown failure contacting PayPal. #CFHTTP.FileContent#";		
	}

</cfscript>

<!--- <cfdump var="#soapxml#">
<cfdump var="#response#">
<cfdump var="#results#">  --->


<cfset "Caller.#attributes.structname#" = results>




