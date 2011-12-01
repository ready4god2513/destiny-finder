
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run Shift4 $$$ ON THE NET credit card validation. Called from checkout/act_pay_form.cfm --->

<cfset Vendor="CFWebstore6">
<cfset AdminNotes = "">
<cfset BatchAbort = "NO">

<!--- Retrieve $$$ ON THE NET settings --->
<cfinclude template="qry_get_Shift4OTN_Settings.cfm">	
<cfinclude template="../../qry_get_order_settings.cfm">	

<!--- see if "Gift Cards" are a valid payment method --->
<cfquery name="qGetCards" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT CardName FROM #Request.DB_Prefix#CreditCards
	WHERE Used = 1 and CardName like 'Gift%'
</cfquery>
<cfset GCEnabled=qGetCards.RecordCount GT 0>
<cfset SplitTender="NO">

<cfparam name="attributes.CVV2" default="">
<cfset s4CVV2Indicator="">
<cfif get_Order_Settings.usecvv2>
	<cfset s4CVV2Indicator="0">
</cfif>
<cfif attributes.CVV2 is not "">
	<cfset s4CVV2Indicator="1">
</cfif>
<cfset s4UniqueID="">
<cfset s4CardNumber=attributes.CardNumber>
<cfif Len(s4CardNumber) EQ 17 and Left(s4CardNumber,1) is "@">
	<cfset s4UniqueID=Mid(s4CardNumber,2,16)>
	<cfset s4CardNumber="">
	<cfset s4CVV2Indicator="">
	<cfset attributes.CVV2="">
	<cfset attributes.CardNumber="XXXXXXXXXXXX#Left(s4UniqueID,4)#">
</cfif>

<cfset ZipCode=GetCustomer.Zip>

<cfquery name="qTempOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#TempOrder
	WHERE BasketNum = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.BasketNum#">
</cfquery>
<cfif Val(qTempOrder.RecordCount) NEQ 1>
	<cfabort showerror="DATABASE LOGIC FAULT: Unexpected number of order header records returned (expected 1, returned #Val(qTempOrder.RecordCount)#).">
</cfif>
<cfset InvoiceNum="#Right('000000#CFID#',6)##DateFormat(Now(),'dd')##TimeFormat(Now(),'mm')#">
<cfif IsDefined("qTempOrder.ID") and Val(qTempOrder.ID) GT 0>
	<cfset InvoiceNum="#Right('0000000000#Val(qTempOrder.ID)#',10)#">
<cfelseif IsDefined("qTempOrder.DateAdded") and qTempOrder.DateAdded is not "">
	<cfset doyhash=DayOfYear(qTempOrder.DateAdded) mod 100>
	<cfset InvoiceNum="#Right('0000#CFID##doyhash#',4)##TimeFormat(qTempOrder.DateAdded,'HHmmss')#">
</cfif>

<cfset Msg="">
<cfset DoAuth="YES">
<cfloop condition="#DoAuth#">
	<cfset DoAuth="NO">
	<cfset RemainingBalance=GetTotals.OrderTotal>
	<cfset PrimaryAmount=RemainingBalance>
	<cfset ExpirationMonth=Val(ListFirst(cardexp,"/"))>
	<cfset ExpirationYear=Val(ListLast(cardexp,"/"))>

	<cfif GCEnabled>
		<!---
			This block of code handles multiple gift card payments since CFWebStore does not currently
			have support for split tender. If split tender is ever supported, this code can and should
			be removed.
		--->
		<cf_Shift4OTN
			Result = "OTN"
			URL = "#get_Shift4OTN_Settings.URL#"
			ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
			ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
			ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
			ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
			SerialNumber = "#get_Shift4OTN_Settings.SerialNumber#"
			Username = "#get_Shift4OTN_Settings.Username#"
			Password = "#get_Shift4OTN_Settings.Password#"
			FunctionRequestCode = "07"
			MerchantID = "#get_Shift4OTN_Settings.MID#"
			Invoice = "#InvoiceNum#"
			APIOptions="ALLDATA"
			Vendor="#Vendor#">
		<cfloop condition="OTN.ErrorIndicator is 'N' and OTN.Invoice is InvoiceNum">
			<cfif OTN.SaleFlag is "A" or OTN.SaleFlag is "S">
				<cfset dup="NO">
				<cfset dup=dup or OTN.CardNumber is CardNumber>
				<cfset dup=dup or (FindNoCase("x",OTN.CardNumber) NEQ 0 and Right(OTN.CardNumber,4) is Right(CardNumber,4))>
				<cfset dup=dup or OTN.CardNumber is Right(CardNumber,4)>
				<cfif not dup>
					<cfset SplitTender="YES">
					<cfset RemainingBalance=RemainingBalance-OTN.PrimaryAmount>
				</cfif>
			</cfif>
			<cf_Shift4OTN
				Result = "OTN"
				URL = "#get_Shift4OTN_Settings.URL#"
				ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
				ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
				ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
				ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
				SerialNumber = "#get_Shift4OTN_Settings.SerialNumber#"
				Username = "#get_Shift4OTN_Settings.Username#"
				Password = "#get_Shift4OTN_Settings.Password#"
				FunctionRequestCode = "0D"
				MerchantID = "#get_Shift4OTN_Settings.MID#"
				Invoice = "#OTN.Invoice#"
				TranID = "#OTN.TranID#"
				APIOptions="ALLDATA"
				Vendor="#Vendor#">
		</cfloop>
		<cfset PrimaryAmount=RemainingBalance>
		<!--- end of split tender code --->
		
		<cfif ATTRIBUTES.CardType is "Gift Card/Certificate"
			or ATTRIBUTES.CardType is "Gift Card"
			or ATTRIBUTES.CardType is "Gift Certificate">
			<cfset ZipCode="">
			<cfset ExpirationMonth=12>
			<cfset ExpirationYear=Year(Now())+4>
			<cf_Shift4OTN
				Result = "OTN"
				URL = "#get_Shift4OTN_Settings.URL#"
				ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
				ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
				ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
				ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
				SerialNumber = "#get_Shift4OTN_Settings.SerialNumber#"
				Username = "#get_Shift4OTN_Settings.Username#"
				Password = "#get_Shift4OTN_Settings.Password#"
				FunctionRequestCode = "61"
				MerchantID = "#get_Shift4OTN_Settings.MID#"
				CardNumber = "#attributes.CardNumber#"
				APIOptions="ALLDATA"
				Vendor="#Vendor#">
			<cfif OTN.ErrorIndicator is "N" and IsDefined("OTN.IYCAvailableBalance")>
				<cfif Val(OTN.IYCAvailableBalance) GT 0 and Val(OTN.IYCAvailableBalance) LT RemainingBalance>
					<cfset PrimaryAmount=Val(OTN.IYCAvailableBalance)>
				</cfif>
			</cfif>
		</cfif>
	</cfif>

	<cf_Shift4OTN
		Result = "OTN"
		URL = "#get_Shift4OTN_Settings.URL#"
		ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
		ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
		ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
		ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
		SerialNumber = "#get_Shift4OTN_Settings.SerialNumber#"
		Username = "#get_Shift4OTN_Settings.Username#"
		Password = "#get_Shift4OTN_Settings.Password#"
		FunctionRequestCode = "#get_Shift4OTN_Settings.FunctionRequestCode#"
		MerchantID = "#get_Shift4OTN_Settings.MID#"
		Invoice = "#InvoiceNum#"
		CardEntryMode = "M"
		CardNumber = "#s4CardNumber#"
		UniqueID = "#s4UniqueID#"
		CardPresent = "N"
		CustomerName = "#attributes.NameOnCard#"
		ExpirationMonth = "#ExpirationMonth#"
		ExpirationYear = "#ExpirationYear#"
		SaleFlag = "S"
		PrimaryAmount = "#PrimaryAmount#"
		SecondaryAmount = "0.00"
		TaxAmount = "0.00"
		CVV2Indicator = "#s4CVV2Indicator#"
		CVV2Code = "#attributes.CVV2#"
		ZipCode = "#ZipCode#"
		xNotes = "Would be nice to have HTML Invoice here"
		APIOptions="ALLDATA"
		Vendor="#Vendor#">
	<cfif OTN.ErrorText is not "">
		<cfabort showerror="#OTN.ErrorText#">
	</cfif>
	
	<cfif IsDefined("OTN.UniqueID")>
		<cfif OTN.UniqueID is not "">
			<cfset attributes.SaveCardNumber="@#OTN.UniqueID#">

			<!--- Users token update - token in CardData will be updated via normal processing in act_save_order.cfm --->
			<cfset tokenUserID=session.User_ID>
			<cfif IsDefined("User_ID")>
				<cfset tokenUserID=User_ID>
			<cfelseif IsDefined("attributes.User_ID")>
				<cfset tokenUserID=attributes.User_ID>
			</cfif>
			<cfmodule template="../../../customtags/crypt.cfm" string="#attributes.SaveCardNumber#" key="#Request.encrypt_key#" return="newtoken">
			<cfquery name="SetCardNoOnFile" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Users 
				SET		EncryptedCard = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#newtoken.value#">
				WHERE	User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#tokenUserID#">
			</cfquery>
		</cfif>
	</cfif>
	
	<cfif OTN.ErrorIndicator is "Y">
		<cfparam name="OTN.CardNumber" default="">
		<cfparam name="OTN.TranID" default="">
		<cf_Shift4OTN
			Result = "OTNVoid"
			URL = "#get_Shift4OTN_Settings.URL#"
			ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
			ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
			ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
			ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
			SerialNumber = "#get_Shift4OTN_Settings.SerialNumber#"
			Username = "#get_Shift4OTN_Settings.Username#"
			Password = "#get_Shift4OTN_Settings.Password#"
			FunctionRequestCode = "08"
			Timeout = "5"
			MerchantID = "#get_Shift4OTN_Settings.MID#"
			Invoice = "#InvoiceNum#"
			CardNumber = "#Right(OTN.CardNumber,4)#"
			TranID = "#OTN.TranID#"
			Vendor="#Vendor#">
			
		<cfif OTN.PrimaryErrorCode EQ 9842>
			<cfset Msg = "Invalid Card Number... The card number you entered is not valid. Please enter the information again.">
			<cfset AdminNotes = "Invalid Card Number">
		<cfelse>
			<cfset Msg = "$OTN Interface Error... Sorry, there was a problem processing your order. Please try your request again or contact the web master if the problem persists. (#OTN.LongError# (#OTN.PrimaryErrorCode#,#OTN.SecondaryErrorCode#))">
			<cfset AdminNotes = "$OTN Interface Error - #OTN.LongError# (#OTN.PrimaryErrorCode#,#OTN.SecondaryErrorCode#)">
			<cfset BatchAbort = "YES">
		</cfif>
	<cfelseif OTN.ResponseCode is not "A">
		<cf_Shift4OTN
			Result = "OTNVoid"
			URL = "#get_Shift4OTN_Settings.URL#"
			ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
			ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
			ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
			ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
			SerialNumber = "#get_Shift4OTN_Settings.SerialNumber#"
			Username = "#get_Shift4OTN_Settings.Username#"
			Password = "#get_Shift4OTN_Settings.Password#"
			FunctionRequestCode = "08"
			MerchantID = "#get_Shift4OTN_Settings.MID#"
			Invoice = "#InvoiceNum#"
			CardNumber = "#Right(OTN.CardNumber,4)#"
			TranID = "#OTN.TranID#"
			Vendor="#Vendor#">

		<cfif IsDefined("OTN.ValidAVS") and OTN.ValidAVS is "N">
			<cfset Msg = "Sorry, invalid billing information... The billing address you provided did not match the billing address of the credit card used. Please correct the address or use another form of payment.">
			<cfset AdminNotes = "Invalid Billing Information (AVS failure)">
			<!---
			<cfif IsDefined("OTN.CVV2Valid") and OTN.CVV2Valid is "Y" and ZipCode is not "">
				<cfset ZipCode="">
				<cfset DoAuth="YES">
			</cfif>
			--->
		<cfelseif IsDefined("OTN.CVV2Valid") and OTN.CVV2Valid is "N">
			<cfset AdminNotes = "Invalid CVV2 Information">
			<cfset Msg = "Sorry, invalid CVV2 information... The CVV2 code on the back of the card did not match with what your bank has on file. Please correct the code or use another form of payment.">
		<cfelseif OTN.ResponseCode is "D">
			<cfset AdminNotes = "Declined">
			<cfset Msg = "Sorry... Your bank declined the transaction. Please resolve the issue with your bank or use another form of payment.">
		<cfelseif OTN.ResponseCode is "R">
			<cfset AdminNotes = "Voice Referral">
			<cfset Msg = "Sorry... Your bank did not approve the transaction. Please resolve the issue with your bank or use another form of payment.">
		<cfelse>
			<cfabort showerror="Unexpected response (#OTN.ResponseCode#) on #FunctionRequestCode# authorization request.">
		</cfif>
	</cfif>
</cfloop>

<cfif OTN.ResponseCode is "A">
	<cfset RemainingBalance=Round((RemainingBalance-PrimaryAmount)*100) / 100.0>
	<cfif (ATTRIBUTES.CardType is "Gift Card/Certificate"
		or ATTRIBUTES.CardType is "Gift Card"
		or ATTRIBUTES.CardType is "Gift Certificate")
		and RemainingBalance GT 0>

		<cfif 1 EQ 2>
			<!--- A failed attempt at adding split tender support directly into CFWebStore --->
			<!--- Get next number for basket Item --->
			<cfset basket_ID = CreateUUID()>
			<cfset basket_ID = Replace(basket_ID, "-", "", "All")>

			<cfquery name="AddItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#TempBasket
					(Basket_ID, BasketNum, Product_ID, Options, AddOns, AddonMultP, AddonNonMultP, AddonMultW, AddonNonMultW, 
					SKU, Price, Weight, Quantity, OptChoice, Discount, DateAdded, QuantDisc)
				VALUES
					('#basket_ID#', '#qTempOrder.BasketNum#', 
					NULL, 
					NULL,
					NULL,
					0, 0, 0, 0,
					'Gift Card/Certificate Partial Payment xxxx#Right(CardNumber,4)# (#InvoiceNum#,#OTN.UniqueID#,#Trim(NumberFormat(PrimaryAmount,"9999999.00"))#)',
					-#PrimaryAmount#, 0, 
					1, 
					0, 0, #CreateODBCDateTime(Now())#, 0)
			</cfquery>
		</cfif>

		<cfset ErrorMessage = "<h2>PARTIAL PAYMENT APPLIED</h2>A payment of #DollarFormat(PrimaryAmount)# was applied which represents the total remaining balance on the card/certificate. Please enter another form of payment for the remaining balance of #DollarFormat(RemainingBalance)#.">
		<cfset Display = "Yes">
		<cfset CompOrder = "Complete Order">

	<cfelse>

		<cfset AuthNumber = OTN.Authorization>
		<cfif SplitTender>
			<cfset TransactNum = "#InvoiceNum#,#OTN.UniqueID#,#Trim(NumberFormat(PrimaryAmount,'9999999.00'))#,#SplitTender#">
		<cfelse>
			<cfset TransactNum = "#InvoiceNum#,#OTN.UniqueID#,#Trim(NumberFormat(PrimaryAmount,'9999999.00'))#">
		</cfif>
		<cfset attributes.step = "receipt">

	</cfif>
<cfelse>

	<cfset ErrorMessage = Msg>
	<cfset Display = "Yes">
	<cfset CompOrder = "Complete Order">

</cfif>
