<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Processes batch billing from Order Manager.
	Attributes.ACT = 	paid	- mark as paid only (for offline orders)
						charge  - bill credit card then mark as paid
---->

<!--- Called by shopping.admin&order=billing --->

<cfparam name="attributes.orderlist" default="">

<!--- If the charge button on the order detail is pressed, set the order list to be the order number --->
<cfparam name="attributes.order_no" default="">
<cfif not len(attributes.orderlist) and len(attributes.order_no)>
	<cfset attributes.orderlist = attributes.order_no>
</cfif>

<cfswitch expression="#attributes.act#">

	<cfcase value="paid">
	
		<cfloop index="attributes.order_no" list="#attributes.orderlist#">
		
			<cfquery name="OrderPaid" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
				UPDATE #Request.DB_Prefix#Order_No
				SET Paid = 1,
				Admin_Name = '#Session.Realname#',
				Admin_Updated = #createodbcdatetime(now())#
				WHERE Order_No = #attributes.Order_No#
			</cfquery>
		
		</cfloop>
	
		<cfset attributes.order_no = "">
	</cfcase>

	<cfcase value="charge">
	
		<cfloop index="attributes.order_no" list="#attributes.orderlist#">
		
			<cfif get_Order_Settings.CCProcess IS "AuthorizeNet3">
				<cfinclude template="../../checkout/creditcards/act_authnet3_delayedcapture.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "PayFlowPro">
				<cfinclude template="../../checkout/creditcards/act_payflowpro_delayedcapture.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "PayFlowPro4">
				<cfinclude template="../../checkout/creditcards/act_payflowpro4_delayedcapture.cfm">

			<cfelseif get_Order_Settings.CCProcess IS "Shift4OTN">
				<cfinclude template="../../checkout/creditcards/act_shift4otn_delayedcapture.cfm">
			
			<cfelseif get_Order_Settings.CCProcess IS "BankofAmerica">
				<cfinclude template="../../checkout/creditcards/act_bankofamerica_delayedcapture.cfm">
	
		<cfelseif get_Order_Settings.CCProcess IS "LinkPoint">
				<cfinclude template="../../checkout/creditcards/act_linkpoint_delayedcapture.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "PayPalPro">
				<cfinclude template="../../checkout/paypal/act_paypal_delayedcapture.cfm">
	<!--- 	
			<cfelseif get_Order_Settings.CCProcess IS "EZIC">
				<cfinclude template="../../checkout/creditcards/act_ezic_delayedcapture.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "Skipjack">
				<cfinclude template="../../checkout/creditcards/act_skipjack_delayedcapture.cfm"> --->
	
			<cfelse>
				
				<!--- Do Nothing --->
				
			</cfif>

		</cfloop>
		
		<cfset attributes.order_no = "">
		
	</cfcase>
	
</cfswitch>



