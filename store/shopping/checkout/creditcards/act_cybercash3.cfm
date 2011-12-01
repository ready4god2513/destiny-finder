
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run cybercash credit card validation, using the Allaire tag, Direct Pay style messages. Called from checkout/act_pay_form.cfm --->

<!--- Retrive Cybercash settings --->

<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT CCServer, Password, Transtype, Username 
FROM #Request.DB_Prefix#CCProcess
</cfquery>

<cfset Amount = LSCurrencyFormat(GetTotals.OrderTotal, "international")>
<cfset CurrCode = Left(Amount, 3)>
<cfset Amount = CurrCode & " " & Trim(NumberFormat(GetTotals.OrderTotal, "________.00"))>

<cfset r = Randomize(Minute(now())&Second(now()))>
<cfset randomnum = RandRange(10000,99999)>
<cfif GetCustomer.State Is "Unlisted">
	<cfset CustState = GetCustomer.State2>
<cfelse>
	<cfset CustState = GetCustomer.State>
</cfif>

<cfset InvoiceNum = Session.CFToken & randomnum>
   
 <cflock name="cybercfx" timeout="150" type="EXCLUSIVE">
<cfx_cybercash version="3.2"
			   ccps_host="#GetSettings.CCServer#"
			   cybercash_id="#GetSettings.Username#"
               merchant_key="#GetSettings.Password#"
			   action="#GetSettings.Transtype#" 
               mo_order_id="#InvoiceNum#"
			   mo_version="3.2.0.2"
               mo_price="#Amount#"
               cpi_card_number="#attributes.CardNumber#"
               cpi_card_exp="#cardexp#" 
			   cpi_card_name="#attributes.NameonCard#"
			   cpi_card_address="#GetCustomer.Address1#"
			   cpi_card_city="#GetCustomer.City#"
			   cpi_card_state="#CustState#"
			   cpi_card_zip="#GetCustomer.Zip#"
			   cpi_card_country="#ListGetAt(GetCustomer.Country, 2, "^")#"
			   OutputPOPQuery="pop">
</cflock>
		   
<cfif pop.Status IS NOT "success">
	<cfset ErrorMessage = pop.error_message & ". Please change the information entered, or return to the store.">    
	<cfset display = "Yes">
	<cfset CompOrder = "Complete Order">

<cfelse>
	<cfset AuthNumber = pop.auth_code>
	<cfset attributes.step = "receipt">
</cfif>


