
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- runs iTransact credit card validation, not currently working. Called from checkout/act_pay_form.cfm --->

<!--- Retrieve iTransact settings --->

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

<cfset InvoiceNum = Replace(CGI.REMOTE_ADDR,".","","ALL") & randomnum>

<cfset CustNum = Session.SessionID>

<CF_iTransact
	QUERYNAME="Results"
	LOGIN="#GetSettings.Username#"
     PASSWORD="#GetSettings.Password#"
     CARDNUMBER="#attributes.CardNumber#"
     EXPIREDATE="#cardexp#"
     AMOUNT="#GetTotals.OrderTotal#"
     ORDER="#InvoiceNum#"
	 CUSTOMER="#CustNum#"
	 FIRSTNAME="#FirstName#" 
	 LASTNAME="#LastName#" 
     TYPE="#GetSettings.Transtype#"
	 ADDRESS="#GetCustomer.Address1#"
	 CITY="#GetCustomer.City#"
	 STATE="#CustState#"
ZIP="#GetCustomer.Zip#"
COUNTRY="#ListGetAt(GetCustomer.Country, 2, '^')#"
PHONE="#GetCustomer.Phone#"
EMAIL="#GetCustomer.Email#">
			  
<cfif Results.response_code IS NOT 1>
	<cfset ErrorMessage = Results.response_text & ". Please change the information entered, or return to the store.">    
	<cfset display = "Yes">
	<cfset CompOrder = "Complete Order">

<cfelse>
	<cfset AuthNumber = Results.authorization_code>
	<cfset attributes.step = "receipt">
</cfif>


