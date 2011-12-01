<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!-----------------------------------------------------------------------
Bank of America eStores Payment Processing
----------------------------------------------------------------------->


<!--- Variable previously set:
	Billing information in GetCustomer query of tempcust
	Order Information  in GetTotals query of TempOrder
	Payment form fields:
		NameonCard
		amount
		cardnumber
		month
		year
		CVV2
--->

<!--- Get Settings: ioc_merchant_id, ioc_auto_settle_flag, ioc_cvv_indicator --->
<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT  Username, Transtype, Setting1 
FROM #Request.DB_Prefix#CCProcess
</cfquery>

<cfparam name="attributes.CVV2" default="">

<cfset randomnum = RandRange(1000,9999)>
<cfset InvoiceNum = Replace(CGI.REMOTE_ADDR,".","","ALL") & randomnum>

<cfif len(GetCustomer.state)>
	<cfset StateProvince = GetCustomer.state>
<cfelse>
	<cfset StateProvince = GetCustomer.state2>
</cfif>
	
<cfset CountryCode = listfirst(GetCustomer.country,'^')>

	
<cfset AuthNumber = 0>

<!--- Field Values passed
ioc_merchant_id 					R eStores Store ID 			GetSettings.Username
ioc_merchant_shopper_id				text32					
ioc_merchant_order_id				text32						#InvoiceNum#
ioc_order_description				text255					
ioc_order_total_amount				R money 10, 2 decimals		NumberFormat(GetTotals.OrderTotal, "________.00")

ecom_billto_postal_name_first		R text 50					GetCustomer.FirstName
ecom_billto_postal_name_last		R text 50					GetCustomer.LastName
ioc_billto_business_name			text 50						GetCustomer.Company
ecom_billto_postal_street_line1		R text 50					GetCustomer.Address1
ecom_billto_postal_street_line2		text 50						GetCustomer.Address2
ecom_billto_postal_city				R text 30					GetCustomer.City
ecom_billto_postal_stateprov		R text 30					StateProvince
ecom_billto_postal_postalcode		R text 20					GetCustomer.Zip
ecom_billto_postal_countrycode		R text 2					listfirst(GetCustomer.country,'^')
ecom_billto_online_email			R text 75					GetCustomer.Email

ecom_payment_card_name				R text 75					NameonCard
ecom_payment_card_number			R text 19					cardnumber
ecom_payment_card_expdate_month		R number 2					month
ecom_payment_card_expdate_year		R number 4					year

ioc_cvv_indicator 					FLAG: 1=provided; 0 default	GetSettings.Setting1
ecom_payment_card_verification		number 4 req if flag = 1	CVV2

ioc_auto_settle_flag				FLAG: Y=create settlement	GetSettings.Transtype
ioc_transaction_type				E=Ecommerce (R=recurring)	E
--->


<CF_bankofamerica
	Referer="#Request.StoreURL#"
	FieldNames="ioc_merchant_id~ioc_merchant_order_id~ioc_order_description~ioc_order_total_amount~ecom_billto_postal_name_first~ecom_billto_postal_name_last~ioc_billto_business_name~ecom_billto_postal_street_line1~ecom_billto_postal_street_line2~ecom_billto_postal_city~ecom_billto_postal_stateprov~ecom_billto_postal_postalcode~ecom_billto_postal_countrycode~ecom_billto_online_email~ecom_payment_card_name~ecom_payment_card_number~ecom_payment_card_expdate_month~ecom_payment_card_expdate_year~ioc_cvv_indicator~ecom_payment_card_verification~ioc_auto_settle_flag~ioc_transaction_type"
	FieldValues="#GetSettings.Username#~#InvoiceNum#~From Website~#GetTotals.OrderTotal#~#GetCustomer.FirstName#~#GetCustomer.LastName#~#GetCustomer.Company#~#GetCustomer.Address1#~#GetCustomer.Address2#~#GetCustomer.City#~#StateProvince#~#GetCustomer.zip#~#listfirst(GetCustomer.country,'^')#~#GetCustomer.Email#~#attributes.NameonCard#~#attributes.cardnumber#~#Month#~20#Year#~#GetSettings.Setting1#~#attributes.CVV2#~#GetSettings.Transtype#~E"

>

<!--- DEBUG - 
Add this to tag call above: TransactionType="debug/payment"
<hr/>
<cfoutput>#BAReturned#</cfoutput>
<hr/>
<cfabort>
 --->

<!--- Results placed into structure called eStoresResults with the following variables (return field names):
IOC_response_code					numeric 2			
	0=APPROVED
	1=communication issue
	2=auth declined
	... 11						
Ecom_payment_card_verification_rc	text 2				cvv response code
	M=match
	N=no match
	P=not processed
IOC_avs_result						text 10				AVS response code
	0=no data
	1=no match
	2=address match only
	3=zip code match only
	4=exact match
	NULL=no result provided
IOC_order_id						numeric 10			Transaction Number
IOC_authorization_amount			money 10
IOC_authorization_code				text 6

									FOR AUTO SETTLE ONLY:
IOC_processed_flag					FLAG for auto settle indicating settlement
IOC_settlement_amount				FLAG for auto settle indicating settlement
IOC_invoice_number					text 10	auto settle system invoice number

IOC_reject_description				text 1000 - reason for rejection
---->

<!--- SUCCESS (response code = 0) ---->
<cfif not eStoresResults.IOC_response_code>
  <cfset attributes.step = "receipt">
  <cfset AuthNumber = eStoresResults.IOC_authorization_code>
  <cfset TransactNum = eStoresResults.IOC_order_id>

  	<cfset Notes = dateformat(now(),'mm/dd/yy') & " - ">
	<cfif GetSettings.Transtype is "Y">
		<cfset Notes= notes & " Processed: " & eStoresResults.IOC_processed_flag & " for " & eStoresResults.IOC_settlement_amount>
	
	<cfelse>
		<cfset Notes= notes & " Authorized: " & eStoresResults.IOC_authorization_code & " for " & eStoresResults.IOC_authorization_amount>
	</cfif>

	<cfif GetSettings.Setting1>
		<cfset Notes= notes & " CVV: ">
		<cfif eStoresResults.Ecom_payment_card_verification_rc is "M">
			<cfset Notes= notes & "Match">
		<cfelseif eStoresResults.Ecom_payment_card_verification_rc is "N">
			<cfset Notes= notes & "No Match">
		<cfelse>
			<cfset Notes= notes & "Not Processed">
		</cfif>
	</cfif>
	
	<cfset Notes= notes & " AVS: ">
		<cfif eStoresResults.IOC_avs_result is "4">
			<cfset Notes= notes & "Exact Match">
		<cfelseif eStoresResults.IOC_avs_result is "3">
			<cfset Notes= notes & "Zip Code Match Only">
		<cfelseif eStoresResults.IOC_avs_result is "2">
			<cfset Notes= notes & "Address Match Only">
		<cfelseif eStoresResults.IOC_avs_result is "1">
			<cfset Notes= notes & "No Match">
		<cfelse>
			<cfset Notes= notes & "No Data">
		</cfif>


<!--- If FAILED ---->
<cfelse>
  <cfset ErrorMessage =  "AUTHORIZATION FAILED - " & eStoresResults.IOC_reject_description>
  <cfset display = "Yes">
  <cfset CompOrder = "Complete Order">
</cfif>


