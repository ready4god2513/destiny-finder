
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run cybercash credit card validation, using the Allaire tag, version 2.1 style messages. Called from checkout/act_pay_form.cfm --->

<!--- Retrive Cybercash settings --->

<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT CCServer, Password, Transtype, Username 
FROM #Request.DB_Prefix#CCProcess
</cfquery>

<cfset Amount = LSCurrencyFormat(GetTotals.OrderTotal, "international")>
<cfset Amount = Insert(" ", Amount, 3)>

<cfset r = Randomize(Minute(now())&Second(now()))>
<cfset randomnum = RandRange(10000,99999)>

<cfset InvoiceNum = Session.CFToken & randomnum>

<cflock name="cybercfx" timeout="150" type="EXCLUSIVE">
<cfx_cybercash ccps_host="#GetSettings.CCServer#"
			   cybercash_id="#GetSettings.Username#"
               merchant_key="#GetSettings.Password#"
			   action="#GetSettings.Transtype#" 
               order_id="#InvoiceNum#"
               amount="#Amount#"
               card_number="#attributes.CardNumber#"
               card_exp="#cardexp#" 
			   card_name="#attributes.NameonCard#"
			   OutputFieldsQuery="results"
			   hash_secret = "secret-test-mck">
</cflock>
		   
<cfif results.MStatus IS NOT "success">
	<cfset ErrorMessage = results.MErrMsg & ". Please change the information entered, or return to the store.">    
	<cfset display = "Yes">
	<cfset CompOrder = "Complete Order">

<cfelse>
	<cfset AuthNumber = results.auth_code>
	<cfset attributes.step = "receipt">
</cfif>


