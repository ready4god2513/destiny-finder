<!----------------------------------------------------------------------
 USA ePay ColdFusion Library.
      v0.2 - October 13th, 2001
	  v1.0 - September 15, 2002
		v1.2 - October 15, 2003 (Added new fields)

      Copyright (c) 2001 USA Merchant Center
      v0.2 Written by Tim McEwen (tem@usamerchant.com)
	  v1.0 Written by Mind2Web   (mind2webinfo@yahoo.com)
		v1.2 - Written by Mind2Web   (mind2webinfo@yahoo.com)

	See http://www.usaepay.com


  Parameters:
   attributes.QueryName (defaults to q_auth)
   attributes.key
   attributes.cardnum
   attributes.expdate
   attributes.amount
   attributes.custid
   attributes.invoice
   attributes.description
   attributes.cvv
   attributes.email
   attributes.emailcustomer (FALSE)
   attributes.custname
   attributes.avsstreet
   attributes.avszip
   attributes.clientip
   attributes.TestRequest (TRUE, FALSE)
   

  creates:
   Creates a query object with response fields.  The name of the
   query object is defined by the value of "attributes.QueryName"
   The query will contain the following columns:

   1. x_response_code
             Indicates the result of the transaction.
             Approved,
             Declined,
             Error
   2. x_auth_code
             6 digit approval code
   3. x_response_reason_text
             Brief description of result
   4. x_avs_code

   5. x_cvv_code

   6. x_trans_id
	     (Transaction reference number)

------------------------------------------------------------------------>

<!----------------------------------------------------------------------
  Set defaults for common parameters
  
  You can find definition of all these parameters on http://www.usaepay.com
  ---------------------------------------------------------------------->
<cfparam name="attributes.queryname" default="q_auth">
<cfparam name="attributes.key" default="">
<cfparam name="attributes.refNum" default="">
<cfparam Name="attributes.cardnum" default="">
<cfparam Name="attributes.expdate" default="">
<cfparam name="attributes.amount" default="">
<cfparam name="attributes.tax" default="">
<cfparam Name="attributes.custid" default="">
<cfparam Name="attributes.invoice" default="">
<cfparam name="attributes.ponum" default="">
<cfparam name="attributes.description" default="Online Order">
<cfparam Name="attributes.cvv" default="">
<cfparam name="attributes.email" Default="">
<cfparam name="attributes.EmailCustomer" default="FALSE">
<cfparam name="attributes.custReceipt" default="">
<cfparam Name="attributes.custname" default="">
<cfparam Name="attributes.avsstreet" default="">
<cfparam Name="attributes.avszip" default="">
<cfparam Name="attributes.clientip" default="">
<cfparam name="attributes.TestRequest" default="FALSE">

<cfparam name="attributes.authCode" default="">
<cfparam name="attributes.routing" default="">
<cfparam name="attributes.account" default="">
<cfparam name="attributes.ticket" default="">
<cfparam name="attributes.ssn" default="">
<cfparam name="attributes.dlnum" default="">
<cfparam name="attributes.dlstate" default="">
<cfparam name="attributes.command" default="">
<cfparam name="attributes.redir" default="">
<cfparam name="attributes.redirApproved" default="">
<cfparam name="attributes.redirDeclined" default="">
<cfparam name="attributes.echofields" default="">
<cfparam name="attributes.recurring" default="">
<cfparam name="attributes.billAmount" default="">
<cfparam name="attributes.schedule" default="">
<cfparam name="attributes.numleft" default="">
<cfparam name="attributes.start" default="">
<cfparam name="attributes.expire" default="">
<cfparam name="attributes.billfname" default="">
<cfparam name="attributes.billlname" default="">
<cfparam name="attributes.billcompany" default="">
<cfparam name="attributes.billstreet" default="">
<cfparam name="attributes.billstreet2" default="">
<cfparam name="attributes.billcity" default="">
<cfparam name="attributes.billstate" default="">
<cfparam name="attributes.billzip" default="">
<cfparam name="attributes.billcountry" default="">
<cfparam name="attributes.billphone" default="">
<cfparam name="attributes.billemail" default="">
<cfparam name="attributes.fax" default="">
<cfparam name="attributes.website" default="">
<cfparam name="attributes.shipfname" default="">
<cfparam name="attributes.shiplname" default="">
<cfparam name="attributes.shipcompany" default="">
<cfparam name="attributes.shipstreet" default="">
<cfparam name="attributes.shipstreet2" default="">
<cfparam name="attributes.shipcity" default="">
<cfparam name="attributes.shipstate" default="">
<cfparam name="attributes.shipzip" default="">
<cfparam name="attributes.shipcountry" default="">
<cfparam name="attributes.shipphone" default="">
<cfparam name="attributes.cardauth" default="">
<cfparam name="attributes.pares" default="">
<cfparam name="attributes.xid" default="">
<cfparam name="attributes.cavv" default="">
<cfparam name="attributes.eci" default="">

<!----------------------------------------------------------------------
  Format variables to ePay specs before validating.
  ---------------------------------------------------------------------->

<cfset attributes.cardnum = REreplace(attributes.cardnum, "[^0-9]", "", "ALL")>
<cfset attributes.expdate = REreplace(attributes.expdate, "[^0-9]", "", "ALL")>
  

<!----------------------------------------------------------------------
  Check for required variables before sending to ePay
  ---------------------------------------------------------------------->
<cfset required = 0>
<cfif (attributes.command IS "check" OR attributes.command IS "checkcredit")>

 <cfif attributes.routing LTE "                                " OR
 	 	attributes.account LTE "                                " OR
		attributes.ssn LTE "                                " OR
		attributes.dlnum LTE "                                " OR
		attributes.dlstate LTE "                                ">
	  <cfset required = 1>
 </cfif>

<cfelse>
 <cfif attributes.cardnum LTE "                                " OR
	   attributes.expdate LTE "                                ">
	 <cfset required = 2>
 </cfif>
</cfif>

<cfif required IS 1 OR required IS 2 OR
    attributes.amount LTE "                                " OR
	attributes.invoice LTE "                                " OR
	attributes.custname LTE "                                " OR
	attributes.avsstreet LTE "                                " OR
	attributes.avszip LTE "                                ">

<!----------------------------------------------------------------------
  All required fields have not been filled out.
  You might want to insert your own error handling script below to
  give your users a more pleasing and helpfull error message.
  ---------------------------------------------------------------------->
	
<center><font color=\"red\" size=\"3\">Error missing parameter</font></center><br/>
Click on your browser's back button and fill out all required fields.	

<cfabort>
	
</cfif>

<!----------------------------------------------------------------------
  Post to USA ePay
  ---------------------------------------------------------------------->

<cfhttp method="post" url="https://www.usaepay.com/gate.php">
    <cfhttpparam type="Formfield"
        value="#attributes.key#"
        name="UMkey">
	<cfhttpparam type="Formfield"
        value="#attributes.refNum#"
        name="UMrefNum">
    <cfhttpparam type="Formfield"
        value="#attributes.cardnum#"
        name="UMcard">
    <cfhttpparam type="Formfield"
        value="#attributes.expdate#"
        name="UMexpir">
    <cfhttpparam type="Formfield"
        value="#attributes.amount#"
        name="UMamount">
	<cfhttpparam type="Formfield"
        value="#attributes.tax#"
        name="UMtax">
    <cfhttpparam type="Formfield"
        value="#attributes.custid#"
        name="UMcustid">
    <cfhttpparam type="Formfield"
        value="#attributes.invoice#"
        name="UMinvoice">
	<cfhttpparam type="Formfield"
        value="#attributes.ponum#"
        name="UMponum">
    <cfhttpparam type="Formfield"
        value="#attributes.description#"
        name="UMdescription">
    <cfhttpparam type="Formfield"
        value="#attributes.cvv#"
        name="UMcvv2">
    <cfhttpparam type="Formfield"
        value="#attributes.email#"
        name="UMcustemail">
    <cfhttpparam type="Formfield"
        value="#attributes.custname#"
        name="UMname">
	<cfhttpparam type="Formfield"
        value="#attributes.custReceipt#"
        name="UMcustreceipt">
    <cfhttpparam type="Formfield"
        value="#attributes.avsstreet#"
        name="UMstreet">
    <cfhttpparam type="Formfield"
        value="#attributes.avszip#"
        name="UMzip">
    <cfhttpparam type="Formfield"
        value="#attributes.clientip#"
        name="UMip">
	<cfhttpparam type="Formfield"
        value="#attributes.authCode#"
        name="UMauthCode">
	<cfhttpparam type="Formfield"
        value="#attributes.routing#"
        name="UMrouting">
	<cfhttpparam type="Formfield"
        value="#attributes.account#"
        name="UMaccount">
	<cfhttpparam type="Formfield"
        value="#attributes.ticket#"
        name="UMticket">
	<cfhttpparam type="Formfield"
        value="#attributes.ssn#"
        name="UMssn">
	<cfhttpparam type="Formfield"
        value="#attributes.dlnum#"
        name="UMdlnum">
	<cfhttpparam type="Formfield"
        value="#attributes.dlstate#"
        name="UMdlstate">
	<cfhttpparam type="Formfield"
        value="#attributes.command#"
        name="UMcommand">
	<cfhttpparam type="Formfield"
        value="#attributes.redir#"
        name="UMredir">
	<cfhttpparam type="Formfield"
        value="#attributes.redirApproved#"
        name="UMredirApproved">
	<cfhttpparam type="Formfield"
        value="#attributes.redirDeclined#"
        name="UMredirDeclined">
	<cfhttpparam type="Formfield"
        value="#attributes.echofields#"
        name="UMechofields">
	<cfhttpparam type="Formfield"
        value="#attributes.recurring#"
        name="UMrecurring">
	<cfhttpparam type="Formfield"
        value="#attributes.billAmount#"
        name="UMbillamount">
	<cfhttpparam type="Formfield"
        value="#attributes.schedule#"
        name="UMschedule">
	<cfhttpparam type="Formfield"
        value="#attributes.numleft#"
        name="UMnumleft">
	<cfhttpparam type="Formfield"
        value="#attributes.start#"
        name="UMstart">
	<cfhttpparam type="Formfield"
        value="#attributes.expire#"
        name="UMexpire">
	<cfhttpparam type="Formfield"
        value="#attributes.billfname#"
        name="UMbillfname">
	<cfhttpparam type="Formfield"
        value="#attributes.billlname#"
        name="UMbilllname">
	<cfhttpparam type="Formfield"
        value="#attributes.billcompany#"
        name="UMbillcompany">
	<cfhttpparam type="Formfield"
        value="#attributes.billstreet#"
        name="UMbillstreet">
	<cfhttpparam type="Formfield"
        value="#attributes.billstreet2#"
        name="UMbillstreet2">
	<cfhttpparam type="Formfield"
        value="#attributes.billcity#"
        name="UMbillcity">
	<cfhttpparam type="Formfield"
        value="#attributes.billstate#"
        name="UMbillstate">
	<cfhttpparam type="Formfield"
        value="#attributes.billzip#"
        name="UMbillzip">
	<cfhttpparam type="Formfield"
        value="#attributes.billcountry#"
        name="UMbillcountry">
	<cfhttpparam type="Formfield"
        value="#attributes.billphone#"
        name="UMbillphone">
	<cfhttpparam type="Formfield"
        value="#attributes.billAmount#"
        name="UMbillamount">
	<cfhttpparam type="Formfield"
        value="#attributes.billemail#"
        name="UMemail">
	<cfhttpparam type="Formfield"
        value="#attributes.fax#"
        name="UMfax">
	<cfhttpparam type="Formfield"
        value="#attributes.website#"
        name="UMwebsite">
	<cfhttpparam type="Formfield"
        value="#attributes.shipfname#"
        name="UMshipfanme">
	<cfhttpparam type="Formfield"
        value="#attributes.shiplname#"
        name="UMshiplname">
	<cfhttpparam type="Formfield"
        value="#attributes.shipcompany#"
        name="UMshipcompany">
	<cfhttpparam type="Formfield"
        value="#attributes.shipstreet#"
        name="UMshipstreet">
	<cfhttpparam type="Formfield"
        value="#attributes.shipstreet2#"
        name="UMshipstreet2">
	<cfhttpparam type="Formfield"
        value="#attributes.shipcity#"
        name="UMshipcity">
	<cfhttpparam type="Formfield"
        value="#attributes.shipstate#"
        name="UMshipstate">
	<cfhttpparam type="Formfield"
        value="#attributes.shipzip#"
        name="UMshipzip">
	<cfhttpparam type="Formfield"
        value="#attributes.shipcountry#"
        name="UMshipcountry">
	<cfhttpparam type="Formfield"
        value="#attributes.shipphone#"
        name="UMshipphone">	
	<cfhttpparam type="Formfield"
        value="#attributes.cardauth#"
        name="UMcardauth">
	<cfhttpparam type="Formfield"
        value="#attributes.pares#"
        name="UMpares">
	<cfhttpparam type="Formfield"
        value="#attributes.xid#"
        name="UMxid">
	<cfhttpparam type="Formfield"
        value="#attributes.cavv#"
        name="UMcavv">
	<cfhttpparam type="Formfield"
        value="#attributes.eci#"
        name="UMeci">	
</CFHTTP>

 <!----------------------------------------------------------------------
  Create a local query object for result
  ---------------------------------------------------------------------->

 <cfset q_auth =QueryNew("UMversion,UMstatus,UMauthCode,UMrefNum,UMavsResult,UMavsResultCode,UMcvv2Result,UMcvv2ResultCode,UMresult,UMerror,UMfiller")>
 <cfset nil = QueryAddRow(q_auth)>

<cfif ListLen(cfhttp.FileContent,",") IS 0>
  <cfset nil = QuerySetCell( q_auth, "UMstatus", "Error")>
  <cfset nil = QuerySetCell( q_auth, "UMauthCode", "000000")>
  <cfset nil = QuerySetCell( q_auth, "UMavsResult", "Invalid Response from USA ePay")>
  <cfset nil = QuerySetCell( q_auth, "UMavsResultCode", "n/a")>
  <cfset nil = QuerySetCell( q_auth, "UMcvv2Result", "n/a")>
  <cfset nil = QuerySetCell( q_auth, "UMcvv2ResultCode", "n/a")>
  <cfset nil = QuerySetCell( q_auth, "UMrefNum", "000000")>
  <cfset nil = QuerySetCell( q_auth, "UMversion", "n/a")>
  <cfset nil = QuerySetCell( q_auth, "UMresult", "n/a")>
  <cfset nil = QuerySetCell( q_auth, "UMerror", "n/a")>
  <cfset nil = QuerySetCell( q_auth, "UMfiller", "n/a")>
<cfelse>
  <cfloop index = "i" list = "#cfhttp.FileContent#" delimiters = "&">
      <cfset responseHash = ArrayNew(1)>
      <cfset responseHash = ListToArray(i,"=")>
      <cfif responseHash[1] IS "UMstatus">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMstatus", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMstatus","Error")>
           </cfcatch>
           </cftry>
      </cfif>

      <cfif responseHash[1] IS "UMauthCode">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMauthCode", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMauthCode","000000")>
           </cfcatch>
           </cftry>
      </cfif>

      <cfif responseHash[1] IS "UMavsResult">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMavsResult", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMavsResult","Invalid Response from USA ePay")>
           </cfcatch>
           </cftry>
      </cfif>

      <cfif responseHash[1] IS "UMavsResultCode">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMavsResultCode", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMavsResultCode","n/a")>
           </cfcatch>
           </cftry>
      </cfif>

      <cfif responseHash[1] IS "UMcvv2Result">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMcvv2Result", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMcvv2Result","n/a")>
           </cfcatch>
           </cftry>
      </cfif>

      <cfif responseHash[1] IS "UMcvv2ResultCode">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMcvv2ResultCode", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMcvv2ResultCode","n/a")>
           </cfcatch>
           </cftry>
      </cfif>

      <cfif responseHash[1] IS "UMrefNum">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMrefNum", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMrefNum","000000")>
           </cfcatch>
           </cftry>
      </cfif>

      <cfif responseHash[1] IS "UMversion">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMversion", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMversion","n/a")>
           </cfcatch>
           </cftry>
      </cfif>

      <cfif responseHash[1] IS "UMresult">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMresult", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMresult","n/a")>
           </cfcatch>
           </cftry>
      </cfif>

      <cfif responseHash[1] IS "UMerror">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMerror", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMerror","n/a")>
           </cfcatch>
           </cftry>
      </cfif>

      <cfif responseHash[1] IS "UMfiller">
          <cftry>
  	<cfset nil = QuerySetCell( q_auth, "UMfiller", URLDecode(responseHash[2]))>
          <cfcatch>
  	<cfset nil = QuerySetCell( q_auth, "UMfiller","n/a")>
           </cfcatch>
           </cftry>
      </cfif>
  </cfloop>
</cfif>

 <!----------------------------------------------------------------------
  Set caller query object
  ---------------------------------------------------------------------->
 <CFSET "Caller.#attributes.queryname#" = q_auth>


