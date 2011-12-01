
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run PayPal Website Payments Pro Direct Pay credit card processing. Called from checkout/act_pay_form.cfm --->

<!--- Retrive PayPal Website Payments Pro settings --->
<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT CCServer, Password, Setting1, Transtype, Username 
	FROM #Request.DB_Prefix#CCProcess
</cfquery>

<cfset r = Randomize(Minute(now())&Second(now()))>  
<cfset randomnum = RandRange(1000,9999)>

<!--- Get the Address Information --->
<cfset strCustAddress = Application.objCheckout.doCustomerAddress(GetCustomer,GetShipTo)>

<cfset NameLen = ListLen(attributes.NameonCard, " ")>
<cfset LastName = ListGetAt(attributes.NameonCard, NameLen, " ")>
<cfset FirstName = ListDeleteAt(attributes.NameonCard, NameLen, " ")>

<cfparam name="attributes.CVV2" default="">

<cfset InvoiceNum = Replace(CGI.REMOTE_ADDR,".","","ALL") & randomnum>

<cfset CustNum = Session.SessionID>

<CF_PayPalDirect
		STRUCTNAME="Results"
		USERNAME="#GetSettings.Username#"
	    PASSWORD="#GetSettings.Password#"
		SERVER="#GetSettings.CCServer#"
		SIGNATURE="#GetSettings.Setting1#"
		TRANSTYPE="#GetSettings.Transtype#"
		INVOICENUM="#InvoiceNum#"
		CCTYPE="#attributes.CardType#"
	    CARDNUMBER="#attributes.CardNumber#"
	    EXPIREDATE="#cardexp#"
		CVV2="#attributes.CVV2#"
	    AMOUNT="#GetTotals.OrderTotal#"
	    ORDER="#InvoiceNum#"
		CUSTOMER="#CustNum#"
		FIRSTNAME="#FirstName#" 
		LASTNAME="#LastName#" 
		COMPANY="#GetCustomer.Company#"
		ADDRESS="#strCustAddress.Billing.Address#"
		CITY="#strCustAddress.Billing.City#"
		STATE="#strCustAddress.Billing.State#"
		ZIP="#strCustAddress.Billing.Zip#"
		COUNTRY="#strCustAddress.Billing.Country#"
		SHIPTO_NAME="#strCustAddress.Shipping.Name#"
		SHIPTO_ADDRESS="#strCustAddress.Shipping.Address#"
		SHIPTO_ADDRESS2="#strCustAddress.Shipping.Address2#"
		SHIPTO_CITY="#strCustAddress.Shipping.City#"
		SHIPTO_STATE="#strCustAddress.Shipping.State#"
		SHIPTO_ZIP="#strCustAddress.Shipping.Zip#"
		SHIPTO_COUNTRY="#strCustAddress.Shipping.Country#"
		EMAIL="#GetCustomer.Email#">
			  
			  
<!--- DEBUG 
<cfoutput><h1>#Results.response_code#</h1></cfoutput> 
----->

<cfif Results.Success IS NOT "1">
	<cfset ErrorMessage = Results.errormessage & ". Please change the information entered, or return to the store.">    
	<cfset display = "Yes">
	<cfset CompOrder = "Complete Order">

<cfelse>
	
	<cfset AuthNumber = ''>
	<cfset TransactNum = Results.TransactionID>
	<cfset attributes.step = "receipt">

</cfif>


