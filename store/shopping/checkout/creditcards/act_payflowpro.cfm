
<!--- CFWebstore�, version 6.43 --->

<!--- CFWebstore� is �Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run PayFlow Pro credit card validation. Called from checkout/act_pay_form.cfm --->

<!--- Retrieve Verisign PayFlowPro settings --->
<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT * FROM #Request.DB_Prefix#CCProcess
</cfquery>

<cfset CustZIP = Replace(GetCustomer.Zip, "-", "")>

<cfset r = Randomize(Minute(now())&Second(now()))>
<cfset randomnum = RandRange(1000,9999)>
<cfif GetCustomer.State Is "Unlisted">
	<cfset CustState = GetCustomer.State2>
<cfelse>
	<cfset CustState = GetCustomer.State>
</cfif>

<cfset expiration = "#Month#" & "#Right(Year,2)#">

<cfparam name="attributes.CVV2" default="">

<cfset InvoiceNum = Replace(CGI.REMOTE_ADDR,".","","ALL") & randomnum>

<cfset CustNum = Session.SessionID>

<cflock name="payflowpro" timeout="150" type="EXCLUSIVE">

<CFX_PAYFLOWPRO 
	 			QUERY			= "RESULT"
                HostAddress		="#GetSettings.CCServer#" 
				HostPort		="#GetSettings.Setting1#" 
				TimeOut			="30" 
				TRXTYPE			="#GetSettings.Transtype#"
                TENDER         	= "C"
                PARTNER       	= "#GetSettings.Setting2#"
                USER			="#GetSettings.Username#"
     			PWD 			="#GetSettings.Password#"
                ACCT			="#attributes.CardNumber#"
     			EXPDATE			="#expiration#"
				CVV2			="#attributes.CVV2#"
				CERTPATH 		= "#GetSettings.Setting3#" 
				STREET			="#GetCustomer.Address1#"
				ZIP				="#GetCustomer.Zip#"
				NAME			="#attributes.NameonCard#"
                AMT				="#NumberFormat(GetTotals.OrderTotal, "________.00")#"
                INVNUM			="#InvoiceNum#"
				CUSTID			="#CustNum#"
				COMMENT1       	= "This transaction was automatically generated by cfwebstore"
                COMMENT2       	= ""
				DEBUGMODE		= "0"
				PARMLIST		= "" 
				PROXYADDRESS	= ""
				PROXYPORT		= ""
				PROXYLOGON		= ""
				PROXYPASSWORD	= ""
>
	 
	 
	 
	 
</cflock>

<!--- Debug --->
<!--- <cfdump var="#Result#"> --->

<!---If the message is approved, continue processing the order---->
<cfif result.result IS "0">
  <cfset AuthNumber = result.authcode>
  <cfset TransactNum = result.PNREF>
  <cfset attributes.step = "receipt">
  
<!---If the result is less than 0, a connection error has occurred.  --->
<cfelseif result.result LT 0>
  <cfset ErrorMessage = "A connection error has occured. Please wait 10 minutes and try again or place your order offline.">
  <cfset display = "Yes">
  <cfset CompOrder = "Complete Order">
  
 <!---If the result is 24, an invalid expiration date was used.  Display a warning.--->
<cfelseif result.result IS "24">
  <cfset ErrorMessage = "This card is expired! Please enter a new card.">
  <cfset display = "Yes">
  <cfset CompOrder = "Complete Order">
  
 <!---If the result is 23, an invalid credit card number was used.  Display a warning.--->
<cfelseif result.result IS "23">
  <cfset ErrorMessage = "You did not enter a valid credit card number! Please enter another card number.">
 <!--Otherwise, display the --->
	<cfset display = "Yes">
  <cfset CompOrder = "Complete Order">

 <!--Otherwise, display the result message.--->
<cfelse>
  <cfset ErrorMessage = result.respmsg>
  <cfset display = "Yes">
  <cfset CompOrder = "Complete Order">
</cfif>
			


			