<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!-----------------------------------------------------------------------
	PayFlowPro4Action
		Uses the PayPal PayFlowPro HTTPS method to send data to a secure
		PayFlow gateway to perform actions on a previously authorized transaction.
		
	Required Parameters:
		user 		
		vendor (typically the same as user)
		password 		
		partner (typically 'PayPal')
		TransactNum	
		
				
	Optional Parameters:		
		action			D|C|V
		amount			for capture and credit
		proxy			(none)

  ----------------------------------------------------------------------->

<cfparam name="attributes.action" default="D">
<cfparam name="attributes.proxy" default="">
<cfparam name="attributes.amount" default="0">
<cfparam name="attributes.server" default="pilot-payflowpro.paypal.com">
<!--- merchant settings --->
<cfset param = "USER=#attributes.user#&PWD=#attributes.password#&PARTNER=#attributes.partner#&VENDOR=#attributes.vendor#&TRXTYPE=#attributes.action#">
	
<!--- Transaction settings --->
<cfset param = param & "&TENDER=C&ORIGID=#attributes.TransactNum#">

<!--- Delayed capture and credit settings --->
<cfif attributes.action IS "D" OR attributes.action IS "C">
	<cfset amount = DecimalFormat(attributes.amount)>
	<cfset param = param & "&AMT=#amount#">
</cfif>

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

<!--- <cfdump var="#CFHTTP.FileContent#">
<cfabort> --->
<!----------------------------------------------------------------------
	Set caller query object
  ---------------------------------------------------------------------->
<cfset "Caller.#attributes.queryname#" = ParsedResults>


