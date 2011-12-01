
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run PayFlow Pro HTTP version 4 credit card validation. Called from checkout/act_pay_form.cfm --->

<!--- Retrive Authorize.Net settings --->

<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT Username, Password, CCServer, Setting1, Transtype  
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

<cfset expiration = "#Month#" & "#Right(Year,2)#">

<CF_PayFlowPro4
	QUERYNAME="Results"
	 USER="#GetSettings.Username#"
	 VENDOR="#GetSettings.Username#"
     PASSWORD="#GetSettings.Password#"
	 PARTNER="#GetSettings.Setting1#"
	 SERVER="#GetSettings.CCServer#"	 
	 ACTION="#GetSettings.Transtype#"
     CARDNUMBER="#attributes.CardNumber#"
     EXPIREDATE="#expiration#"
	 CVV2="#attributes.CVV2#"
     AMOUNT="#GetTotals.OrderTotal#"
     ORDER="#InvoiceNum#"
	 FIRSTNAME="#FirstName#" 
	 LASTNAME="#LastName#"      
	 COMPANY="#GetCustomer.Company#"
	 ADDRESS="#GetCustomer.Address1#"
	 CITY="#GetCustomer.City#"
	 STATE="#CustState#"
	ZIP="#GetCustomer.Zip#"
	COUNTRY="#ListGetAt(GetCustomer.Country, 2, "^")#"
	PHONE="#GetCustomer.Phone#"
	EMAIL="#GetCustomer.Email#"
	>
			  
			  
<!--- DEBUG
<cfdump var="#Results#">
<cfabort> ----->

<cfif Results.Result IS NOT 0>
<cfset ErrorMessage = Results.Respmsg & ". Please change the information entered, or return to the store.">    
<cfset display = "Yes">
<cfset CompOrder = "Complete Order">

<cfelse>

<cfset AuthNumber = Results.AuthCode>
<cfset TransactNum = Results.PNREF>
<cfset attributes.step = "receipt">

<!--- DEBUG 
<cfoutput><h1>step #attributes.step#</h1></cfoutput> ----->
<!----------
<cfset AuthNumber = Results.authorization_code>
<cfinclude template="../complete.cfm">
<cfset display = "No">
---->

</CFIF>


