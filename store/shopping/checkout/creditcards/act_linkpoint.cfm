
<!--- MODIFIED BY: Chad M. Adamson | webmaster@hostbranson.com --->

<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run Linkpoint credit card validation. Called from checkout/act_pay_form.cfm --->

<!--- Retrieve LinkPoint settings --->
<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT CCServer, Password, Setting1, Transtype, Username 
FROM #Request.DB_Prefix#CCProcess
</cfquery>

<cfif GetCustomer.State Is "Unlisted">
  <cfset CustState = GetCustomer.State2>
<cfelse>
  <cfset CustState = GetCustomer.State>
</cfif>

<cfif GetShipTo.Recordcount>
  <cfset ShipName= GetShipTo.FirstName & " " & GetShipTo.LastName>
  <cfset ShipCompany = GetShipTo.Company>
  <cfset ShipAddress1 = GetShipTo.Address1>
  <cfset ShipCity = GetShipTo.City>
  <cfset ShipState = GetShipTo.State>
  <cfset ShipZip = GetShipTo.Zip>
  <cfset ShipCountry = ListGetAt(GetShipTo.Country, 2, "^")>
  <cfset ShipPhone = GetShipTo.Phone>

<cfelse>
  <cfset ShipName= attributes.NameonCard>
  <cfset ShipCompany = GetCustomer.Company>
  <cfset ShipAddress1 = GetCustomer.Address1>
  <cfset ShipCity = GetCustomer.City>
  <cfset ShipState = CustState>
  <cfset ShipZip = GetCustomer.Zip>
  <cfset ShipCountry = ListGetAt(GetCustomer.Country, 2, "^")>
  <cfset ShipPhone = GetCustomer.Phone>
</cfif>

<!--- LinkPoint Definitions --->
<cfset Chargetype_Auth = "AUTH">
<!--- Funds Captured upon approval, funds will be set to transfer --->
<cfset Chargetype_Sale = "SALE">
<!--- Funds Captured upon approval, funds will be set to transfer --->
<cfset Chargetype_Preauth = "PREAUTH">
<!--- Funds Reserved upon approval, Postauth will be needed to transfer funds --->
<cfset Chargetype_Postauth = "POSTAUTH">
<!--- Reserved funds will be transferred, use upon shipping a hardgood --->
<cfset Chargetype_Credit = "CREDIT">
<!--- Return or Refund of funds that were, AUTH, SALE or POSTAUTH --->
<!--- LinkPoint Mode Settings --->
<cfset Result_Live = "LIVE">
<!--- Run transactions in LIVE mode, transaction charges apply --->
<cfset Result_Good = "GOOD">
<!--- Run transactions in TEST mode, no transaction charges --->
<cfset Result_Duplicate = "DUPLICATE">
<!--- Return a duplicate transaction result --->
<cfset Result_Decline = "DECLINE">
<!--- Return a decline transaction result --->

<!--- Get Transaction Type --->
<cfif getSettings.TransType is "S">
  <cfset ThisTrans=Chargetype_Sale>
<cfelse>
  <cfset ThisTrans=Chargetype_Preauth>
</cfif>

<!--- Set LinkPoint Variables --->
<cfset configfile = GetSettings.Username>
<cfset keyfile = GetSettings.Password>
<cfset host = GetSettings.CCServer>
<cfset port = GetSettings.Setting1>
<cfset terminaltype = "UNSPECIFIED">
<cfset company = GetCustomer.Company>
<cfset country = GetCustomer.Country>
<cfset name = attributes.NameonCard>
<cfset address1 = GetCustomer.Address1>
<cfset city = GetCustomer.City>
<cfset state = CustState>
<cfset zip = GetCustomer.Zip>
<cfset sname = ShipName>
<cfset saddress1 = ShipAddress1>
<cfset scity = ShipCity>
<cfset sstate = ShipState>
<cfset szip = ShipZip>
<cfset scountry = ShipCountry>
<cfset phone = GetCustomer.Phone>
<cfset comments = GetTotals.Comments>
<cfset cardnumber = attributes.CardNumber>
<cfset ordertype = ThisTrans>
<cfset cardexpmonth = Month>
<cfset cardexpyear = Right(Year,2)> 

<cfif get_Order_Settings.usecvv2 IS 1>
  <cfset cvmindicator = "provided">
  <cfset cvmvalue = attributes.CVV2>
</cfif>

<cfset email = GetCustomer.Email>
<cfset result = Result_Good> <!--- Change this to #Result_Live# after testing --->
<cfset tax = GetTotals.Tax>
<cfset shipping = GetTotals.Shipping>
<cfset chargetotal = GetTotals.OrderTotal>

<cfinclude template = "lpcfm.cfm">
<cfinclude template = "status.cfm">

<cfif (R_APPROVED IS NOT "APPROVED") AND (R_APPROVED IS NOT "YTEST")>
  <cfset ErrorMessage = R_ERROR & ". Please change the information entered, or return to the store.">
  <cfset display = "Yes">
  <cfset CompOrder = "Complete Order">
  <cfelse>
  <cfif R_REF IS "12345678">
    <cfset AuthNumber = "TestRequest">
    <cfelse>
    <cfset AuthNumber = R_REF>
    <cfset TransactNum= R_ORDERNUM>
  </cfif>
  <cfset attributes.step = "receipt">
</cfif>


