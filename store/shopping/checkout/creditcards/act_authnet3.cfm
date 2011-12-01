
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run Authorize.Net credit card validation. Called from checkout/act_pay_form.cfm --->

<!--- Retrive Authorize.Net settings --->

<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT Password, Transtype, Username 
FROM #Request.DB_Prefix#CCProcess
</cfquery>

<cfset r = Randomize(Minute(now())&Second(now()))>  
<cfset randomnum = RandRange(1000,9999)>
<cfif GetCustomer.State Is "Unlisted">
<cfset CustState = GetCustomer.State2>
<cfelse>
<cfset CustState = GetCustomer.State>
</cfif>

<cfset NameLen = ListLen(attributes.NameonCard, " ")>
<cfset LastName = ListGetAt(attributes.NameonCard, NameLen, " ")>
<cfset FirstName = ListDeleteAt(attributes.NameonCard, NameLen, " ")>

<cfparam name="attributes.CVV2" default="">

<cfset InvoiceNum = Replace(CGI.REMOTE_ADDR,".","","ALL") & randomnum>

<cfset CustNum = Session.SessionID>

<CF_AuthorizeNet30
	QUERYNAME="Results"
	LOGIN="#GetSettings.Username#"
     PASSWORD="#GetSettings.Password#"
     CARDNUMBER="#attributes.CardNumber#"
     EXPIREDATE="#cardexp#"
	 CVV2="#attributes.CVV2#"
     AMOUNT="#GetTotals.OrderTotal#"
     ORDER="#InvoiceNum#"
	 CUSTOMER="#CustNum#"
	 FIRSTNAME="#FirstName#" 
	 LASTNAME="#LastName#" 
     ACTION="#GetSettings.Transtype#"
	 COMPANY="#GetCustomer.Company#"
	 ADDRESS="#GetCustomer.Address1#"
	 CITY="#GetCustomer.City#"
	 STATE="#CustState#"
ZIP="#GetCustomer.Zip#"
COUNTRY="#ListGetAt(GetCustomer.Country, 2, "^")#"
PHONE="#GetCustomer.Phone#"
EMAIL="#GetCustomer.Email#"
TEST="No">
			  
			  
<!--- DEBUG 
<cfoutput><h1>#Results.response_code#</h1></cfoutput> 
----->

<cfif Results.response_code IS NOT "1">
<cfset ErrorMessage = Results.response_text & " Please change the information entered, or return to the store.">    
<cfset display = "Yes">
<cfset CompOrder = "Complete Order">

<cfelse>

<cfset AuthNumber = Results.authorization_code>
<cfset TransactNum = Results.trans_id>
<cfset attributes.step = "receipt">

<!--- DEBUG 
<cfoutput><h1>step #attributes.step#</h1></cfoutput> ----->
<!----------
<cfset AuthNumber = Results.authorization_code>
<cfinclude template="../complete.cfm">
<cfset display = "No">
---->

</CFIF>


