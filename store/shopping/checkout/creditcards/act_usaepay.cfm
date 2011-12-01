<!--- Processing for USAepay --->

<!--- Get USAepay Settings:
 Unique_ID = KEY 
 Command = Transaction Type: 
	sale, credit, void, authonly, capture, postauth, check and checkcredit. Default is sale.
---->
<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT Password, Transtype, Username FROM #Request.DB_Prefix#CCProcess
</cfquery>

<!---- TEST NUMBERS ---------------------------
4005562233445564 	Approved with full AVS match
4787292258606353 	Approved with zip code only Match
5424180279791740 	Approved with negative AVS
Any Other Valid CC Num 	Declined
-------------------------------------------->

<!--- 
Credit Cards
	amount:		no $
	CardExpire: MMYY
Checks
	routing -  	Bank Routing number
	account - Checking Account Number
	ssn		- social security number
	dlnum	- drivers license number (must have either dl or ss)
	dlstate - drivers license state
Recurring Billing
	recurring = "YES" 
	amount = INITIAL CHARGE
	billamount = RECURRING CHARGE
	schedule =  daily, weekly, biweekly, monthly, bimonthly, quarterly, biannually, annually.  
				The default value is monthly.
	numleft	= Number of transactions remaining. Indefinitely = *
	start =  Start Date in YYYYMMDD format. Default = tomorrow.
	expire = Expiration date in YYYYMMDD format. 
---->

<!--- Create Invoice Number --->
<cfset r = Randomize(Minute(now())&Second(now()))>  
<cfset randomnum = RandRange(1000,9999)>
<cfset InvoiceNum = Replace(CGI.REMOTE_ADDR,".","","ALL") & randomnum>

<!--- Create Customer Number --->
<cfset CustNum = Session.SessionID>

<cfset cardexp = Replace(cardexp, "/", "")>

<cfparam name="attributes.CVV2" default="">

<cfmodule template="usaepay-1.cfm"
	queryname="Results"
	KEY="#GetSettings.Username#"
	command="#GetSettings.Transtype#"
	CARDNUM="#attributes.CardNumber#"
	EXPDATE="#cardexp#"
	AMOUNT="#GetTotals.OrderTotal#"
	CustID="#CustNum#"
	INVOICE="#Right(InvoiceNum,11)#"
	DESCRIPTION="Online Order"
	CVV="#attributes.CVV2#"
	EMAIL="#GetCustomer.Email#"
	EMAILCUSTOMER="FALSE"
	CUSTNAME="#attributes.NameonCard#"
	AVSSTREET="#GetCustomer.Address1#"
	AVSZIP="#GetCustomer.Zip#"
	CLIENTIP="#CGI.REMOTE_ADDR#"
	TESTREQUEST="False">

			  
<!--- DEBUG
<cfoutput query="Results">
<b>UMversion</b>: (#UMversion#) <br/>
<b>UMstatus</b> - Approved, Declined, Verification or Error: (#UMstatus#)<br/>
<b>UMauthCode</b> - Number authorization number: (#UMauthCode#) <br/>
<b>UMrefNum</b> - Transaction reference number: (#UMrefNum#) <br/>
<b>UMavsResult</b> -  AVS result in human readable format: (#UMavsResult#) <br/>
<b>UMavsResultCode</b>: (#UMavsResultCode#) <br/>
<b>UMcvv2Result</b> - CVV2 result in human readable format: (#UMcvv2Result#) <br/>
<b>UMcvv2ResultCode</b>: (#UMcvv2ResultCode#) <br/>
<b>UMresult</b>: (#UMresult#) <br/>
<b>UMerror</b> -  Error description if UMstatus is declined or error: (#UMerror#) <br/>
<b>UMfiller</b>: (#UMfiller#) <br/>
</cfoutput>
 ----->


<cfif Results.UMstatus is "Approved">

	<cfset AuthNumber = Results.UMauthCode>
	<cfset TransactNum = Results.UMrefNum>
	<cfset attributes.step = "receipt">

<cfelse>

	<cfset AuthNumber = 0>
	<cfset ErrorMessage = Results.UMerror & " " & "Please change the information entered, or return to the store.">    
	<cfset display = "Yes">
	<cfset CompOrder = "Complete Order">

</cfif>

