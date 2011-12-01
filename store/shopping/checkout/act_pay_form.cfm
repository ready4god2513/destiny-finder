
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Processes the credit card information and calls the appropriate payment processing template. Validates that the fields have been filled out properly. Called by shopping.checkout (step=payment) --->

<cfif isdefined("attributes.SubmitPayment")>

	<cfset ErrorMessage = "">
	<cfset validonfile = 1>

	<!--- If billing to cc on-file, retrieve the card data for use with this form. --->
	<cfif isDefined("attributes.Offline") and attributes.Offline IS "BillUser">
		<cfinclude template="act_getccdata.cfm">
	</cfif>

	<cfif validonfile>
	<!--- Check expiration date --->
	<cfinclude template="creditcards/expdate.cfm">
	</cfif>

	<!--- Skip card number check if a token on file is detected --->
	<cfif validonfile and Left(attributes.CardNumber,1) is "@">
		<cfset validcard=1>
		<cfset typematch=1>
	<cfelse>
		<!--- Check card number --->
		<cfinclude template="creditcards/checkcard.cfm">
	</cfif>
	
	<!--- For Shift4 support --->
	<cfif typematch and (attributes.CardType is "Gift Card/Certificate" or attributes.CardType is "Gift Card" or attributes.CardType is "Gift Certificate")>
		<cfset checkdate=0>
	</cfif>

	<cfif len(trim(attributes.NameonCard)) AND checkdate GTE 0 AND validcard AND validonfile AND typematch>

		<!--- If all fields completed, process credit card, or complete order --->
		<!--- Get customer and shipping information --->
		<cfquery name="GetCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#TempCustomer 
		WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
		</cfquery>

		<cfquery name="GetShipTo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#TempShipTo 
		WHERE TempShip_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
		</cfquery>

		<!--- Get Order Totals --->
		<cfquery name="GetTotals" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#TempOrder 
		WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
		</cfquery>
		
		<!--- Verify that nothing new has been added to the shopping cart --->
		<cfquery name="GetLast" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT MAX(DateAdded) AS ItemDate 
		FROM #Request.DB_Prefix#TempBasket 
		WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
		</cfquery>
		
		<cfif GetTotals.OrderTotal GT 0 AND DateCompare(GetLast.ItemDate, GetTotals.DateAdded, "s") LT 1>

			<!--- Initialize Authorization Number --->
			<cfset AuthNumber = 0>
	
			<!-------------
			<cfif OrderType IS 1>
				<cfset cardexp = "#Month#" & "/" & "#Year#">
			</cfif>------>
	
			<cfset cardexp = "#Month#" & "/" & "#Year#">
			
			<cfif get_Order_Settings.CCProcess IS "CyberCash2">
		 		<cfinclude template="creditcards/act_cybercash.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "CyberCashDP">
				<cfinclude template="creditcards/act_cybercash3.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "ONCR_CyberCash">
				<cfinclude template="creditcards/act_cybercash2.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "ICVerify">
				<cfinclude template="creditcards/act_icverify.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "AuthorizeNet3">
				<cfinclude template="creditcards/act_authnet3.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "PayFlowPro">
				<cfinclude template="creditcards/act_payflowpro.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "PayFlowPro4">
				<cfinclude template="creditcards/act_payflowpro4.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "LinkPoint">
				<cfinclude template="creditcards/act_linkpoint.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "EZIC">
				<cfinclude template="creditcards/act_ezic.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "Shift4OTN">
				<cfinclude template="creditcards/act_shift4otn.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "Skipjack">
				<cfinclude template="creditcards/act_skipjack.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "Skypay">
				<cfinclude template="creditcards/act_skypay.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "bankofamerica">
				<cfinclude template="creditcards/act_bankofamerica.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "usaepay">
				<cfinclude template="creditcards/act_usaepay.cfm">		
			
			<cfelseif get_Order_Settings.CCProcess IS "CyberSource">
				<cfinclude template="creditcards/act_cybersource.cfm">				
				
			<cfelseif get_Order_Settings.CCProcess IS "PayPalPro">
				<cfinclude template="paypal/act_paypalpro.cfm">			
				
			<cfelse>
				<cfset attributes.step = "receipt">
			</cfif>
			
		<!--- This was probably a trial membership order, capture card data, but don't process --->
		<cfelseif GetTotals.OrderTotal IS 0>
			<cfset cardexp = "#Month#" & "/" & "#Year#">
			<cfset attributes.step = "receipt">
		<cfelse>
			<cfset attributes.step = "shipping">				
		</cfif>


	<cfelse>
	<!--- Otherwise, set error messages and redisplay form --->

		<!--- Set error message according to problem with form. --->
		<cfif checkdate LT 0>
			<cfset ErrorMessage = "This card is expired! Please enter a new card.">

		<cfelseif NOT validcard>
			<cfset ErrorMessage = "You did not enter a valid credit card number! Please enter another card number.">
			
		<cfelseif NOT validonfile>
				<cfset ErrorMessage = "The expiration date on file is not valid. Please enter another card.">

		<cfelseif NOT typematch>
			<cfset ErrorMessage = "This is not a valid card number for the type of credit card you selected. Please enter another card number.">

		<cfelse>
			<cfset ErrorMessage = "You did not fill out all the required fields!">
		</cfif>

		<cfset display = "Yes">
		<cfset CompOrder = "Complete Order">

	</cfif><!--- form field check --->
</cfif><!--- form submitted ---->



	

