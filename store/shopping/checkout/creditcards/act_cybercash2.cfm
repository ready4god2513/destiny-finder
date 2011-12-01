
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run cybercash credit card validation, using the ONCR Cybercash tag. Called from checkout/act_pay_form.cfm --->

<!--- Retrive Cybercash settings --->

<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT CCServer, Password, Transtype, Username 
FROM #Request.DB_Prefix#CCProcess
</cfquery>

<cfset r = Randomize(Minute(now())&Second(now()))>
<cfset randomnum = RandRange(10000,99999)>

<cfset InvoiceNum = Session.CFToken & randomnum>

<!--- Amount must be in US Dollars --->
<cflock name="cybercfx" timeout="150" type="EXCLUSIVE">
<CFX_ONCR_CYBERCASH
		 NAME="results"
         CCPS_HOST="#GetSettings.CCServer#"
         MERCHANT_KEY="#GetSettings.Password#"
		 TRANS_TYPE="#GetSettings.Transtype#"
         CYBERCASH_ID="#GetSettings.Username#"
         ORDER_ID="#InvoiceNum#"
         AMOUNT="#GetTotals.OrderTotal#"
		 CC_NAME="#attributes.NameonCard#"
         CC_NUMBER="#attributes.CardNumber#"
         CC_EXP="#cardexp#">
</cflock>
  
<cfif results.status IS NOT "success">
	<cfset ErrorMessage = results.ErrorMessage & ". Please change the information entered, or return to the store.">    
	<cfset display = "Yes">
	<cfset CompOrder = "Complete Order">

<cfelse>
	<cfset AuthNumber = results.AuthNumber>
	<cfset attributes.step = "receipt">
</cfif>


