<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!-----------------------------------------------------------------------
	PayFlowPro HTTPS 
		Uses the PayPal PayFlowPro HTTPS method to send data to a secure
		PayFlowPro gateway.
		
	Required Parameters:
		user 		
		vendor (typically the same as user)
		password 		
		partner (typically 'PayPal')
		action	
		server
		
		amount
		cardnumber				
		expiredate
		
		order (invoice num)
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
		proxy			(none)
		CVV2

  ----------------------------------------------------------------------->

<cfparam name="attributes.action" default="A">
<cfparam name="attributes.proxy" default="">
<cfparam name="attributes.server" default="pilot-payflowpro.paypal.com">
<cfparam name="attributes.firstname" default="">
<cfparam name="attributes.lastname" default="">
<cfparam name="attributes.company" default="">
<cfparam name="attributes.CVV2" default="">

<cfset amount = NumberFormat(attributes.amount, "0.00")>

<!--- merchant settings --->
<cfset param = "USER=#attributes.user#&PWD=#attributes.password#&PARTNER=#attributes.partner#&VENDOR=#attributes.vendor#&TRXTYPE=#attributes.action#">

<!--- card data --->
<cfset param = param & "&TENDER=C&AMT=#amount#&EXPDATE=#attributes.expiredate#&ACCT=#attributes.cardnumber#">

<!--- customer data --->
<cfset param = param & "&FIRSTNAME=#attributes.firstname#&LASTNAME=#attributes.lastname#&STREET=#attributes.address#&CITY=#attributes.city#&STATE=#attributes.state#&ZIP=#attributes.zip#&BILLTOCOUNTRY=#attributes.country#&PHONENUM=#attributes.phone#&EMAIL=#attributes.email#&INVNUM=#attributes.order#&CVV2=#attributes.CVV2#">


<!--- <CFSET PARAM="USER=****&PWD=****&PARTNER=****&VENDOR=****&" &
             "TRXTYPE=S&TENDER=C&AMT=1.00&EXPDATE=1010&ACCT=4111111111111111"> --->
<cfhttp url="https://#attributes.server#:443" method="post" resolveurl="no" timeout="30">
 <cfhttpparam type="header" name="X-VPS-REQUEST-ID" value="#CreateUUID()#">
 <cfhttpparam type="header" name="X-VPS-CLIENT-TIMEOUT" value="30">
 <cfhttpparam type="body" value="#param#">
</cfhttp>

<cfscript>
	ParsedResults = StructNew();
	ParsedResults.Message = '';
	
	ResponseCodes = ListToArray(CFHTTP.FileContent, "&");
	
	//Make sure we got a valid PayPal Response
	if (ArrayLen(ResponseCodes) LT 2 OR NOT FindNoCase("Result",CFHTTP.FileContent)) {
		ParsedResults.Respmsg = CFHTTP.FileContent;
		}
	else {
	
		//Save into structure of values
		for (i=1; i lte ArrayLen(ResponseCodes); i=i+1) { 
		// get variable name
		CodeName = ListGetAt(ResponseCodes[i],1,"=");
		if (ListLen(ResponseCodes[i],"=") IS 2) {
			CodeValue = ListGetAt(ResponseCodes[i],2,"=");
			}
		else {
			CodeValue = '';
		}
		StructInsert(ParsedResults, CodeName, CodeValue);	
		}
	}
	
</cfscript>

<!--- <cfdump var="#ParsedResults#"><cfabort> --->


<!----------------------------------------------------------------------
	Set caller query object
  ---------------------------------------------------------------------->
<cfset "Caller.#attributes.queryname#" = ParsedResults>


