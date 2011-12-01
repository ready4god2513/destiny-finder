
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!-----------------------------------------------------------------------
	PPExpressToken
		Process the first step of PayPal Express Checkout to retrieve the token before redirecting to the PayPal site.
		
	Required Parameters:
		username 	(API Login Username)
		password 	(API Password)		
		signature 	(signature key)
		server		(PayPal API server) 	
		transtype
		
		OrderTotal
		
	Optional Parameters:
		token
		firstname
		lastname
		address
		city
		state
		zip
		country
		email		
		structname		

  ----------------------------------------------------------------------->

<cfparam name="attributes.structname" default="results"> 
<cfparam name="attributes.token" default=""> 
<cfparam name="attributes.firstname" default=""> 
<cfparam name="attributes.lastname" default=""> 
<cfparam name="attributes.address" default=""> 
<cfparam name="attributes.email" default=""> 

<cfinclude template="../../../includes/cfw_functions.cfm">

<cfset OrderTotal = DecimalFormat(attributes.OrderTotal)>

<cfset ReturnURL = "#XHTMLFormat('#Request.SecureURL##request.self#?fuseaction=shopping.checkout&step=pp_doexpress&redirect=yes#Request.AddToken#')#">

<cfif len(attributes.Token)>
	<cfset CancelURL = "#XHTMLFormat('#Request.SecureURL##request.self#?fuseaction=shopping.checkout&step=shipping&redirect=yes#Request.AddToken#')#">
<cfelse>
	<cfset CancelURL = "#XHTMLFormat('#Request.SecureURL##request.self#?fuseaction=shopping.checkout&redirect=yes#Request.AddToken#')#">
</cfif>

  
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
      <SetExpressCheckoutReq xmlns="urn:ebay:api:PayPalAPI">
         <SetExpressCheckoutRequest xsi:type="ns:SetExpressCheckoutRequestType">
            <Version xmlns="urn:ebay:apis:eBLBaseComponents" xsi:type="xsd:string">1.0</Version>
            <SetExpressCheckoutRequestDetails xmlns="urn:ebay:apis:eBLBaseComponents">
				<cfif len(attributes.token)><Token xsi:type="ebl:ExpressCheckoutTokenType">#attributes.token#</Token></cfif>
               <OrderTotal xmlns="urn:ebay:apis:eBLBaseComponents" currencyID="USD" xsi:type="cc:BasicAmountType">#attributes.OrderTotal#</OrderTotal>
               <ReturnURL xsi:type="xsd:string">#ReturnURL#</ReturnURL>
               <CancelURL xsi:type="xsd:string">#CancelURL#</CancelURL>
			   <Custom>Basket No. #Session.BasketNum#</Custom>
			   <PaymentAction>#attributes.transtype#</PaymentAction>
			   <cfif len(attributes.email)><BuyerEmail>#attributes.email#</BuyerEmail></cfif>
			   <cfif len(attributes.address)><Address>
			   <Name>#attributes.firstname# #attributes.lastname#</Name>
                  <Street1>#attributes.address#</Street1>
                  <CityName>#attributes.city#</CityName>
                  <StateOrProvince>#attributes.state#</StateOrProvince>
                  <PostalCode>#attributes.zip#</PostalCode>
				  <Country>#attributes.country#</Country>
			   </Address></cfif>
            </SetExpressCheckoutRequestDetails>
         </SetExpressCheckoutRequest>
      </SetExpressCheckoutReq>
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
	else if (isDefined("myresponse.Body.SetExpressCheckoutResponse.Errors")) {
		results.success = 0;
		results.errormessage = myresponse.Body.SetExpressCheckoutResponse.Errors.LongMessage.XMLText;	
	}
	
	else if (isDefined("myresponse.Body.SetExpressCheckoutResponse")) {
		results.success = 1;
		results.errormessage = '';
		results.token = myresponse.Body.SetExpressCheckoutResponse.Token.XMLText;
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




