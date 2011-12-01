
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!-----------------------------------------------------------------------
	PPExpressCheckoutDetails
		Process the second step of PayPal Express Checkout to retrieve the customer and order information 
		after returning from the PayPal site.
		
	Required Parameters:
		username 	(API Login Username)
		password 	(API Password)		
		signature 	(signature key)
		server		(PayPal API server) 	
		token
		
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
      <GetExpressCheckoutDetailsReq xmlns="urn:ebay:api:PayPalAPI">
         <GetExpressCheckoutDetailsRequest xsi:type="ns:SetExpressCheckoutRequestType">
            <Version xmlns="urn:ebay:apis:eBLBaseComponents" xsi:type="xsd:string">1.0</Version>
            <Token>#attributes.token#</Token>
         </GetExpressCheckoutDetailsRequest>
      </GetExpressCheckoutDetailsReq>
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
	else if (isDefined("myresponse.Body.GetExpressCheckoutDetailsResponse.Errors")) {
		results.success = 0;
		results.errormessage = myresponse.Body.GetExpressCheckoutDetailsResponseDetails.Errors.LongMessage.XMLText;	
	}
	
	else if (isDefined("myresponse.Body.GetExpressCheckoutDetailsResponse.GetExpressCheckoutDetailsResponseDetails")) {
		// Make sure Payer ID was returned
		theDetails = myresponse.Body.GetExpressCheckoutDetailsResponse.GetExpressCheckoutDetailsResponseDetails;
		if (NOT len(theDetails.PayerInfo.PayerID.XMLText)) {
			results.success = 0;
			results.errormessage = 'A PayPal approved payment has not been returned to the shopping cart.';
		}
		
		else {
			results.success = 1;
			results.errormessage = '';
			results.custom = theDetails.Custom.XMLText;
			results.CustInfo = StructNew();
			results.CustInfo.ID = theDetails.PayerInfo.PayerID.XMLText;
			results.CustInfo.FirstName = theDetails.PayerInfo.PayerName.FirstName.XMLText;
			results.CustInfo.LastName = theDetails.PayerInfo.PayerName.LastName.XMLText;
			results.CustInfo.Company = theDetails.PayerInfo.PayerBusiness.XMLText;
			results.CustInfo.Address = theDetails.PayerInfo.Address;
			results.CustInfo.Email = theDetails.PayerInfo.Payer.XMLText;
			if (isDefined("results.CustInfo.Phone")) 
				results.CustInfo.Phone = theDetails.ContactPhone.XMLText;
			else 
				results.CustInfo.Phone = '';
		}
	}
	else {
		results.success = 0;
		results.errormessage = "Unknown failure contacting PayPal. #CFHTTP.FileContent#";		
	}

</cfscript>

<!---  <cfdump var="#soapxml#">
<cfdump var="#response#">
<cfdump var="#results#">  --->


<cfset "Caller.#attributes.structname#" = results>




