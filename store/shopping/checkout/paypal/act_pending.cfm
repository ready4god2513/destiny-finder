

<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to set the message for pending orders. Called from act_ipn_process.cfm --->

<cfparam name="PendingReason" default="">

<cfswitch expression="#PendingReason#">

	<cfcase value="echeck">
		<cfset Reason = "payment was made by an eCheck, which has not yet cleared">
	</cfcase>
	
	<cfcase value="multi_currency">
		<cfset Reason = "you do not have a balance in the currency sent, and you do not have your Payment Receiving Preferences set to automatically convert and accept this payment. You must manually accept or deny this payment">
	</cfcase>

	<cfcase value="intl">
		<cfset Reason = "the merchant holds a non-U.S. account and does not have a withdrawal mechanism. You must manually accept or deny this payment from your Account Overview">
	</cfcase>
	
	<cfcase value="verify">
		<cfset Reason = "the  merchant is not yet verified. You must verify your account before you can accept this payment">
	</cfcase>
	
	<cfcase value="address">
		<cfset Reason = "your customer did not include a confirmed shipping address and you have your Payment Receiving Preferences set such that you want to manually accept or deny each of these payments. To change your preference, go to the Preferences section of your Profile">
	</cfcase>
	
	<cfcase value="upgrade">
		<cfset Reason = "the payment was made via credit card and you must upgrade your account to Business or Premier status in order to receive the funds">
	</cfcase>
	
	<cfcase value="unilateral">
		<cfset Reason = "the payment was made to an email address that is not yet registered or confirmed">
	</cfcase>
	
	<cfcase value="other">
		<cfset Reason = "the payment is pending for an unknown reason. For more information, contact customer service.">
	</cfcase>
	
	<cfcase value="authorization">
		<cfset Reason = "the payment was authorized only and is pending capture.">
	</cfcase>
	
	<cfdefaultcase>
		<cfset Reason = "">
	</cfdefaultcase>


</cfswitch>
