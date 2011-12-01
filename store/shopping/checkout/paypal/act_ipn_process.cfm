
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to process an IPN post from PayPal. Called by shopping.checkout (step=ipn) --->
<cfparam name="Form.FieldNames" default="">
<cfparam name="Form.payment_status" default="">
<cfparam name="Form.pending_reason" default="">
<cfparam name="Form.reason_code" default="">
<cfparam name="Form.txn_id" default="">
<cfparam name="Form.receiver_email" default="">
<cfparam name="Form.mc_gross" default="0">
<cfparam name="Form.test_ipn" default="0">

<cfparam name="Session.BasketNum" default="">
<cfparam name="Session.User_ID" default="0">
<cfparam name="Reason" default="">
<cfparam name="Confirmed" default="0">
<cfparam name="dbUpdate" default="0">

<cfset theDirectory = GetDirectoryFromPath(ExpandPath("*.*"))>
<cfset theDirectory = theDirectory & "logs">

<cfparam name="logmess" default="">

<!--- read post from PayPal system and add 'cmd' --->
 <cfset str="cmd=_notify-validate">
<cfloop index="thefield" list="#Form.FieldNames#">
<cfset str = str & "&#LCase(TheField)#=#URLEncodedFormat(Form[TheField])#">
</cfloop>
<cfif IsDefined("Form.payment_date")>
	<cfset str = str & "&payment_date=#URLEncodedFormat(Form.payment_date)#">
</cfif>
<cfif IsDefined("Form.subscr_date")>
	<cfset str = str & "&subscr_date=#URLEncodedFormat(Form.subscr_date)#">
</cfif> 

<!--- post back to PayPal system to validate --->
<cfif form.test_ipn>
	<cfset paypalserver = "https://www.sandbox.paypal.com/cgi-bin/webscr">
<cfelse>
	<cfset paypalserver = "https://www.paypal.com/cgi-bin/webscr">
</cfif>
 <cfhttp url="#paypalserver#?#str#" method="get" resolveurl="false">
</cfhttp>
<!--- <cfhttp url="http://www.eliteweaver.co.uk/testing/ipntest.php?#str#" method="get" resolveurl="false">
</cfhttp>
 --->
<!--- assign posted variables to local variables --->

<cfset PayPalStatus = Form.payment_status>
<cfset mc_gross=Form.mc_gross>
<cfset receiver_email=Form.receiver_email>

<cfset PayPal = "yes">

<cfif isDefined("form.parent_txn_id")>
	<cfset AuthNumber = Form.parent_txn_id>
<cfelse>
<cfset AuthNumber = Form.txn_id>
</cfif>


			

<cfset DateStamp = "Transaction " & AuthNumber & " received " & DateFormat(Now(), "mm/dd/yyyy")>
<cfset DateStamp = DateStamp & " " & Timeformat(Now(), "HH:mm") & " -">

<!--- check notification validation --->
<!--- <cfif CFHTTP.FileContent is "Verified"> --->
	<!--- check that receiver_email is your email address --->
	<!--- <cfif Form.receiver_email IS get_Order_Settings.PayPalEmail> --->

		<!--- Only save new orders if completed or pending --->
   	 	 <cfif PayPalStatus IS "Completed" OR PayPalStatus IS "Pending">
	        <!--- process payment --->
			
			<cfif PayPalStatus eq "Completed" AND CFHTTP.FileContent is "Verified">
				<cfif Form.receiver_email IS get_Order_Settings.PayPalEmail>
					<cfset Confirmed = 1>
				<cfelse>
					<cfset PendingReason = "invalid">
					<cfset Reason = "the PayPal merchant email is not the primary email for the account and needs to be manually validated.">
				</cfif>
			<cfelseif CFHTTP.FileContent is NOT "Verified">
				<cfset PendingReason = "invalid">
				<cfset Reason = "the transaction did not pass a validation check and needs to be manually validated.">
			<cfelse>
				<cfset PendingReason = Form.pending_reason>
				<cfinclude template="act_pending.cfm">
			</cfif>
			
			<!--- Check if this order has already been saved --->
			<cfquery name="GetOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
				SELECT Order_No FROM #Request.DB_Prefix#Order_No
				WHERE (AuthNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AuthNumber#">
				OR TransactNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AuthNumber#"> )
			</cfquery>
			
			<cfif GetOrder.RecordCount>
			<!--- Update the existing order --->
			
				<!--- Check if this is a customer returning from PayPal --->
				<cfif isDefined("attributes.PayPalCust")>
				
					<cfset attributes.step = "paypal">
					
				<cfelse>
					
					<cfset logmess = "#DateStamp# The order was updated.">
					<cfset message = "The order has been updated."> 
					<cfset dbUpdate = 1>
					<cfset attributes.step = "empty">
				
				</cfif>
				
						
			<cfelse>
			
				<!--- Check if the amount sent was correct and basket exists --->
				<cfquery name="GetTotal" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
					SELECT OrderTotal FROM #Request.DB_Prefix#TempOrder
					WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
				</cfquery>
				
				<!--- Could not find the order --->
				<cfif NOT GetTotal.RecordCount>
					<cfset logmess = "#DateStamp# The order could not be found in the database.">
					<cfset message = "Sorry, your order could not be found in our system. Please contact customer support."> 
					<cfset attributes.step = "error">
					
				<!--- Amount of order does not match --->	
				<cfelseif Round(GetTotal.OrderTotal) IS NOT Round(mc_gross)>
					<cfset logmess = "#DateStamp# The amount of the transaction was invalid.">
					<cfset message = "Sorry, your payment did not match the total for your order. Please contact customer support."> 
					<cfset attributes.step = "error">
				<cfelse>
					
					<!--- Place the Order --->			
					<cfset logmess = "#DateStamp# Transaction has been placed.">
					<cfset attributes.step = "receipt">
				</cfif>			
			
			</cfif>
		
		<cfelseif PayPalStatus IS "Failed">
		    <!--- log for investigation --->
			<cfset logmess = "#DateStamp# Transaction failed.">
			<cfset message = "Your transaction was declined. Please use another method of payment."> 
			<cfset Reason = "a payment from your customer's bank account failed.">
			<cfset dbUpdate = 1>
			<cfset attributes.step = "error">
			
			
		<cfelseif PayPalStatus IS "Denied">
		    <!--- log for investigation --->
			<cfset logmess = "#DateStamp# Transaction denied by merchant.">
			<cfset message = "Your transaction was declined. Please use another method of payment."> 
			<cfset Reason = "the payment was denied by the merchant.">
			<cfset dbUpdate = 1>
			<cfset attributes.step = "error">
			
		<cfelseif PayPalStatus IS "Refunded" OR PayPalStatus IS "Reversed">
		    <!--- log for investigation --->
			<cfset RefundReason = Form.reason_code>
			<cfinclude template="act_reversed.cfm">
			<cfset logmess = "#DateStamp# The transaction has been #Lcase(PayPalStatus)#.">
			<cfset message = "The transaction was #Lcase(PayPalStatus)#."> 
			<cfset Reason = "the payment was refunded by the merchant.">
			<cfset dbUpdate = 1>
			<cfset attributes.step = "error">
			
			
		<cfelseif PayPalStatus IS "Canceled">
		    <!--- log for investigation --->
			<cfset logmess = "#DateStamp# Transaction reversal has been cancelled.">
			<cfset message = "The transaction reversal was cancelled."> 
			<cfset Reason = "the merchant won a dispute with the customer and the funds for the transaction that was reversed have been returned.">
			<cfset dbUpdate = 1>
			<cfset attributes.step = "error">
	
		</cfif>
			
			
	<cfif dbUpdate>
	<!--- Update the Order in the Database --->		
		<cfquery name="GetOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
			UPDATE #Request.DB_Prefix#Order_No
			SET 
			<cfif Confirmed>Paid = 1,
			<cfelse>
				Paid = 0,
			</cfif>
			PayPalStatus = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#PayPalStatus#">,
			Reason = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Reason#">,
			TransactNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.txn_id#">
			WHERE (AuthNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AuthNumber#">
				OR TransactNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AuthNumber#"> )
		</cfquery>
	</cfif>	

			
<!--- 	<cfelse>
		<cfset logmess = "#DateStamp# Invalid email address returned.">
		<cfset message = "There was a problem processing your order. Please contact technical support."> 
		<cfset attributes.step = "error">
	</cfif> --->

<!--- <cfelse>
    <!--- log for investigation --->
	<cfset logmess = "#DateStamp# Invalid transaction returned.#CFHTTP.FileContent#">
	<cfset message = "There was a problem processing your order. Please contact technical support."> 
	<cfset attributes.step = "error">

</cfif> --->



<cfif len(logmess) AND get_Order_Settings.PayPalLog>
	<cftry>
	<cffile action="append" file="#theDirectory##Request.slash#paypal_log.txt" output="#logmess#">
	<cfcatch></cfcatch>
	</cftry>	
</cfif>

