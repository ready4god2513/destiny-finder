
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run ICVErify credit card validation. Called from checkout/act_pay_form.cfm --->

<!--- Retrieve ICVerify settings --->

<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT Setting1, Transtype 
FROM #Request.DB_Prefix#CCProcess
</cfquery>
<!--- changed from cfx_icv to cfx_micv for multiple user license 7/8/99 --->
 <!--- Usually type C1 (sale); if type C6 (auth only), then need to do
	a C5 (force transaction) at order fulfillment time.--->
<cflock name="ICVcfx" timeout="150" type="EXCLUSIVE">
	<cfx_micv name="process_card"
		trans_type="#GetSettings.Transtype#"
         ic_sharedir="#GetSettings.Setting1#"
         account="#attributes.CardNumber#"
         amount="#GetTotals.OrderTotal#"
         expires_mo="#Left(cardexp, 2)#"
         expires_yr="#Right(cardexp, 2)#"
		 comment="CustName: #GetCustomer.FirstName# #GetCustomer.LastName#; CardName: #attributes.NameOnCard#"
		 billing="#GetCustomer.address1#"
		 zip="#GetCustomer.Zip#"> 
</cflock>
  
<cfif process_card.Validated is "N">
	<cfset ErrorMessage = "Card authorization failed. Please change the information entered, or try another card.">    
	<cfset display = "Yes">
	<cfset CompOrder = "Complete Order">
	
 <cfelse>
	<cfset AuthNumber = process_card.Auth_No>
	<cfset attributes.step = "receipt">
</CFIF>


