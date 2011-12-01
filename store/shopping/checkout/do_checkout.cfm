
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Checkout Process:
	1)	Address - enter billing and ship to addresses. If a user is logged in and has defaultaddresses defined, this step (and Register) is SKIPPED. The user can always click the the "edit addresses" link to return to this page.
	(Optional step 1: Terms - user must agree to terms of purchase to continue)

	2)	Register - If a user is not logged in, they are offered an opportunity to Register. If the basket contains a download or membership product, registration is NOT optional.

	3)  Shipping - Allows shipping to be selected in needed. This page also gets other order options like comments, deliver by date, etc.

	4) 	Review & Payment - Presents full receipt with payment options at the bottom.

	5) 	Receipt 
--->

<!--- Called by shopping.checkout --->

<!--- Check for order cancellation, if so return to cart --->
<cfif isdefined("attributes.CancelForm")>
	<cfinclude template="act_cancel.cfm">
</cfif>

<cfparam name="attributes.step" default="">
<cfset Message = "">

<!--- If this is a return from PayPal Express Checkout, retrieve information --->
<cfif attributes.step IS "pp_doexpress">
	<cfinclude template="paypal/act_process_ppexpress.cfm">
</cfif>

<cfinclude template="qry_get_basket.cfm">
<cfinclude template="customer/qry_get_tempcustomer.cfm">

<!--- If user is returning from logging in, load temporary customer data --->
<cfif isDefined("attributes.login") AND NOT GetCustomer.RecordCount>
	<cfinclude template="customer/act_newcustomer.cfm">	
	<cfinclude template="customer/act_newshipto.cfm">
</cfif>

<!--- Error check for empty Basket, skip for PayPal IPN ---->
<cfif not qry_get_basket.RecordCount AND NOT IsDefined("attributes.txn_id")>
	<cfset attributes.step = "empty">

<!--- Check for a timed out session during checkout. --->	
<cfelseif NOT isDefined("Session.CheckingOut") AND ListFind("shipping,payment,receipt", attributes.step)>
	<cfset attributes.step = "error">
	<cfset message = "Your checkout session has been cancelled or has timed out. <br/>Please return to the shopping cart and begin checkout again.">

<!--- Make sure user has not re-started checkout and then used their history to go to a later step in the process. --->	
<cfelseif ListFind("shipping,payment,receipt", attributes.step) AND (NOT GetCustomer.RecordCount OR NOT len(GetCustomer.FirstName))>
	<cfset attributes.step = "error">
	<cfset message = "You missed a step in the checkout process. <br/>Please return to the shopping cart and begin checkout again.">


<cfelse>
			
	<!--- Run totals and see if shipping and download is required  --->	
	<cfif attributes.step is "">
		<cfset refresh_vars = "yes">
	</cfif>
	<cfinclude template="act_get_checkout_vars.cfm">
	
	<!--- Check for minimum order level (if defined). 
		Skip if processing an IPN transaction as order would already have been checked. --->
	<cfif len(get_Order_Settings.mintotal) AND Session.CheckoutVars.TotalBasket LT get_Order_Settings.mintotal 
		AND attributes.step is not "ipn">
		<cfset attributes.step = "error">
		<cfset message = "Your basket total of #LSCurrencyFormat(Session.CheckoutVars.TotalBasket)# is below our <br/>minimum order value of #LSCurrencyFormat(get_Order_Settings.mintotal)#">
	</cfif>	
	
	<!--- Initialize checkout process --->
	<cfif attributes.step is "">
	
		<!--- Create a session variable to track checkout process --->
		<cflock scope="SESSION" timeout="10">
			<cfset Session.CheckingOut = "Yes">
			<cfif isDefined("Session.PP_Token")>
				<cfset temp = StructDelete(Session, "PP_Token")>
			</cfif>
			<cfif isDefined("Session.AgreeTerms")>
				<cfset temp = StructDelete(Session, "AgreeTerms")>
			</cfif>
		</cflock>
	
		<!--- Start Fresh with addresses --->
		<cftransaction>
			<cfquery name="ClearCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#TempCustomer
				WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
			</cfquery>
	
			<cfquery name="ClearShip" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#TempShipTo 
				WHERE TempShip_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
			</cfquery>	
		</cftransaction>
	
		<!--- set customer_ID and load temp customer table --->
		<cfinclude template="customer/act_newcustomer.cfm">	
		<cfinclude template="customer/act_newshipto.cfm">
	
		<!--- Check if there are user terms to agree to before checking out --->
		<cfif len(get_Order_Settings.AgreeTerms)>
			<cfset attributes.step ="terms">
		<cfelseif get_Order_Settings.SkipAddressForm AND attributes.Customer_ID IS NOT 0>
			<cfinclude template="customer/qry_get_tempcustomer.cfm">
			<!--- Check that all required fields were entered for the address --->
			<cfif len(GetCustomer.FirstName) AND len(GetCustomer.LastName) 
					AND len(GetCustomer.Address1) AND len(GetCustomer.City) AND len(GetCustomer.Zip) GTE 3 
					AND len(GetCustomer.Phone) AND len(GetCustomer.Email)>	
				<cfset attributes.step ="shipping">
			<cfelse>
				<cfset attributes.step ="address">
			</cfif>
		<cfelse>
			<cfset attributes.step ="address">
		</cfif>
		
	<!--- Process submission of checkout terms --->
	<cfelseif attributes.step is "terms" AND (isDefined("attributes.agreetoterms") OR StructKeyExists(Session, "AgreeTerms"))>
		<cfset Session.AgreeTerms = "Yes">
		<cfif get_Order_Settings.SkipAddressForm AND len(GetCustomer.FirstName) AND len(GetCustomer.LastName) 
					AND len(GetCustomer.Address1) AND len(GetCustomer.City) AND len(GetCustomer.Zip) GTE 3 
					AND len(GetCustomer.Phone) AND len(GetCustomer.Email)>
			<cfset attributes.step ="shipping">
		<cfelse>
			<cfset attributes.step ="address">
		</cfif>
		
	</cfif>
	
</cfif><!--- empty basket check --->

	

<!--- PROCESS ======================================================--->
<!--- The results of the process section determine which step of the display section will be used --->

<cfswitch expression = "#attributes.step#">

	<cfcase value="address">

		<!--- Only run this code if address form was just submitted ----->
		<cfif isdefined("attributes.SubmitAddress")>
		
			<!--- write the form fields to temp tables ---->
			<cfinclude template="customer/act_update_tmp_customer.cfm">
			<cfinclude template="customer/act_update_tmp_shipto.cfm">
				
			<!--- 1) Error check the email address --->
			<CFModule template="../../customtags/form/emailverify.cfm"
				Email="#trim(Attributes.Email)#">
			
			<!--- 2) Error check required fields in case javascript is off --------------->				
			<cfif len(trim(attributes.FirstName)) AND len(trim(attributes.LastName)) 
			AND len(trim(attributes.Address1)) AND len(trim(attributes.City)) AND len(trim(attributes.Country)) 
			AND len(trim(attributes.Zip)) GTE 3 AND len(trim(attributes.Phone)) AND NOT emailerror>	
			
				<!--- Error check required fields if shipping address is entered --->	
				<cfif NOT attributes.ShipToYes AND (NOT len(trim(attributes.FirstName_shipto)) 
				OR NOT len(trim(attributes.LastName_shipto)) OR NOT len(trim(attributes.Address1_shipto)) 
				OR NOT len(trim(attributes.City_shipto)) OR NOT len(trim(attributes.Zip_shipto)) 
					OR NOT len(trim(attributes.Country_shipto)))>		
				
					<cfset Message = "You did not fill out all the required fields for the shipping address!">

				<cfelse>
				
					<!--- If using address verification, run now --->
					<cfif ShipSettings.ShipType IS "UPS" AND NOT isDefined("attributes.addressverify")>					
						<cfinclude template="customer/act_ups_address_verify.cfm">		
					<cfelseif ShipSettings.ShipType IS "USPS" AND NOT isDefined("attributes.addressverify")>					
						<cfinclude template="customer/act_uspostal_address_verify.cfm">					
					<cfelse>					
						<cfset addressOK = "yes">						
					</cfif>
					
				
					<!--- 3) Everything is OK! Decide what's next ---->
					<cfif addressOK AND Session.User_ID>
						
						<!--- On To Shipping Page if user is already logged in ----->
						<cfinclude template="customer/qry_get_tempcustomer.cfm">
						<cfinclude template="shipping/act_calc_shipping.cfm">
						
						<!--- If skipping shipping page, add temp order data first --->
						<cfif attributes.step IS "payment">
							<cfinclude template="customer/act_update_tmp_orderinfo.cfm">
						</cfif>
						
					<cfelseif addressOK>
					
						<!--- If user is not logged in, offer registration ----->
						<cfset attributes.step ="register">
	
					</cfif>	
				
				</cfif>

			<cfelse><!--- form validation error --->
			
				<!--- Error on form! Set message and return to form ---->
				<cfif emailerror>
					<cfset Message = err_msg>
				<cfelse>
					<cfset Message = "You did not fill out all the required fields!">
				</cfif>
				
			</cfif><!--- form validation --->
			
		</cfif><!--- processing form check --->

	</cfcase>
	
	<cfcase value="pp_express">
		<cfinclude template="paypal/act_pp_express.cfm">
	</cfcase>
	
	<cfcase value="register">
		<!--- if successful registration, write tmp records to db & update user record ---->
		<cfif Session.User_ID>
		    <cfinclude template="customer/act_register.cfm">	

			<!--- Send to shipping ----->
			<cfif attributes.step IS NOT "error">
				<cfinclude template="shipping/act_calc_shipping.cfm">
				<!--- If skipping shipping page, add temp order data first --->
				<cfif attributes.step IS "payment">
					<cfinclude template="customer/act_update_tmp_orderinfo.cfm">
				</cfif>
			</cfif>
			
		</cfif>
	</cfcase>
	
	
	<cfcase value="shipping"> 
		
		<cfinclude template="shipping/act_calc_shipping.cfm">	

		<!--- Process the shipping form's "other" (non shipping) information ----->
		<cfif isdefined("attributes.SubmitShipping")>
		
			<!--- If a coupon code was entered, make sure it's valid. (returns codeerror) --->
			<cfinclude template="customer/act_check_code.cfm">
			<!--- If required custom fields used, make sure required ones filled out --->
			<cfinclude template="act_check_custom_required.cfm">
			
			<!--- If there is a code error, send it back to the shipping form --->
			<cfif codeerror is 1>	
				<cfset Message = "The coupon/certificate code you entered was not valid!">
				<cfset attributes.step = "shipping">				
			
			<cfelseif customneeded IS 1>
				<cfset Message = "You did not fill out all the required fields!">
				<cfset attributes.step = "shipping">
	
			<!--- if no error, write the form fields to temp_cust table --->
			<cfelse>
				<cfinclude template="customer/act_update_tmp_orderinfo.cfm">
				
				<cfif Session.CheckoutVars.NoShipInfo AND ShipSettings.AllowNoShip>
					<cfset shipcost=0>
					<cfset attributes.step = "payment">
				<!--- Now process shipping selection. If OK send to payment step ---->
				<cfelseif isdefined("attributes.RateID")>
					<!--- act_pickshipping will process shipping selection then
					forward to payment step OR do nothing & allow shipping options 
					to display ---->
					<cfinclude template="shipping/act_pickshipping.cfm">
				<cfelseif Session.CheckoutVars.NoShipInfo IS 0>
					<cfset attributes.step = "payment">
				</cfif>			
				
			</cfif>
			
		<!--- If skipping shipping page, add temp order data first --->
		<cfelseif attributes.step IS "payment">
			<cfinclude template="customer/act_update_tmp_orderinfo.cfm">
		
		</cfif><!--- end process form ---->		
		
	</cfcase>
	
	<cfcase value="payment">
	
		<!--- Process form ----->
		<cfif not isdefined("attributes.backorder") AND isdefined("attributes.SubmitPayment")>
			<cfif isDefined("attributes.Offline") and attributes.Offline IS NOT "BillUser">
				<cfset attributes.step = "receipt">
			<cfelse>
				<cfinclude template="act_pay_form.cfm">
			</cfif>			
		<cfelse>
			<cfinclude template="shipping/act_calc_shipping.cfm">
		</cfif>
	
	</cfcase>
	
	<cfcase value="ipn">
	<!--- IPN post from PayPal received --->
		<cfinclude template="paypal/act_ipn_process.cfm">
	</cfcase>
	
	<cfcase value="pp_complete">
	<!--- Complete a PayPal Express Checkout request --->
		<cfinclude template="paypal/act_complete_ppexpress.cfm">
	</cfcase>

	
</cfswitch>




	<!---- DEBUG - This can help when customizing the shipping functions.	
	<cfoutput>
	<ul>
		<li>step: #attributes.step#</li>
		<li>download: #Session.CheckoutVars.Download#</li>
		<li>totalship: #TotalShip#</li>
		<li>ShipSettings.ShipType: #ShipSettings.ShipType#</li>
		<li>noshipinfo: #Session.CheckoutVars.NoShipInfo#</li>
	</ul>
	</cfoutput>	
	---->




<!--- DISPLAY =====================================================- --->

<cfswitch expression = "#attributes.step#">
			
	<cfcase value="empty">
		<cfset Webpage_title = "Empty Basket">
		<cfinclude template="dsp_empty.cfm">
	</cfcase>
	
	<cfcase value="terms">
		<cfset Webpage_title = "Purchase Terms">
		<cfinclude template="dsp_terms.cfm">
	</cfcase>
		
	<cfcase value="address">
		<cfset Webpage_title = "Order Information">
		<cfinclude template="customer/dsp_addresses.cfm">
	</cfcase>
	
	<cfcase value="register">
		<cfset Webpage_title = "Register">
		<cfinclude template="customer/dsp_register.cfm">
	</cfcase>
	
	<cfcase value="error">
		<cfset Webpage_title = "Checkout Error">
		<cfinclude template="dsp_error.cfm">
	</cfcase>	
	
	<cfcase value="shipping">
		<cfset Webpage_title = "Order Options">
		<cfinclude template="qry_get_temporder.cfm">
		<cfinclude template="dsp_invoice_header.cfm">
		<cfinclude template="dsp_ship_form.cfm">
	</cfcase>
		
	<cfcase value="payment">
		<cfset Webpage_title = "Order Payment">
		<cfinclude template="act_check_order.cfm">
		<cfinclude template="qry_get_temporder.cfm">
		
		<!--- Show Payment options the first time through --->
		<cfif not isdefined("attributes.submitpayment")>		
			<cfinclude template="dsp_invoice_header.cfm">
			<cfinclude template="dsp_invoice_shipping.cfm">
			
			<!--- Display the basket --->
			<cfinclude template="../basket/do_checkout_basket.cfm">
			<cfinclude template="act_save_tmp_order.cfm">

			<!--- Error Checking for Inventory Control ---->
			<cfif Request.AppSettings.InvLevel IS NOT "None" AND NOT isDefined("attributes.BackOrder")>
				<cfinclude template="act_invcontrol.cfm">
				<!--- If order has items that will be backordered --->
				<cfif Backorder.RecordCount>
					<cfinclude template="dsp_backorder.cfm">
				</cfif>	
			</cfif>	

			<!---- Payment Options ---->
			<cfif not isdefined("no_checkout")>
				<cfinclude template="dsp_payment_options.cfm">
			</cfif>
			
		<cfelse><!--- problem with credit card payment form information, 
				redisplay form ---->
	
			<cfinclude template="dsp_pay_form.cfm">
	
		</cfif>
		
	</cfcase>
	
	<cfcase value="paypal">
		<cfset Webpage_title = "Completed PayPal Transaction">
		<cfinclude template="paypal/qry_paypalorder.cfm">
		<cfif Len(message)>
			<cfinclude template="dsp_error.cfm">
		<cfelse>
			<cfinclude template="dsp_paypal_complete.cfm">
		</cfif>
	</cfcase>	
		
	<cfcase value="receipt">
		<cfinclude template="act_check_order.cfm">
		<cfset Webpage_title = "Order Receipt">
		<cfinclude template="act_save_order.cfm">
		<cfinclude template="dsp_receipt.cfm">
		<cfinclude template="act_clear_order_vars.cfm">
	</cfcase>
	
		
</cfswitch>



