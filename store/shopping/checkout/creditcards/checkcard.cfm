
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is run to check that a valid credit card number has been entered. Called from checkout\act_pay_form.cfm --->

<cfparam name="validcard" default="1">
<cfparam name="typematch" default="1">

<cfset CCErrorCode = 0>

<cf_iCCVerify ccordernum="#attributes.CardNumber#">

<cfif attributes.CardType is "Gift Card/Certificate"
	or attributes.CardType is "Gift Card"
	or attributes.CardType is "Gift Certificate">
	<cfif not CCValidLuhn or CCLen LT 8>
		<cfset validcard = 0>
		<cfset CCErrorCode = 1>
		<cfset CCErrorMessage = CCErrorMessage & "Please enter a valid gift card/certificate number.<br/>">
	<cfelseif CCType is not "??">
		<cfset typematch = 0>
	</cfif>
<cfelse>
	<cfif not CCValidLuhn or CCLen LT 8>
		<cfset validcard = 0>
		<cfset CCErrorCode = 1>
		<cfset CCErrorMessage = CCErrorMessage & "Please enter a valid credit card number.<br/>">
	<cfelseif CCType is "??">
		<cfset validcard = 0>
		<cfset CCErrorCode = 1>
		<cfset CCErrorMessage = CCErrorMessage & "We accept Visa, MasterCard, Discover, American Express, Diners Club/Carte Blanche, enRoute, and JCB.<br/>">
	<cfelseif CCType IS "VISA" AND attributes.CardType IS NOT "VISA">
		<cfset typematch = 0>
	<cfelseif CCType IS "MC" AND attributes.CardType IS NOT "Mastercard">
		<cfset typematch = 0>
	<cfelseif CCType IS "NOVUS" AND attributes.CardType IS NOT "Discover">
		<cfset typematch = 0>
	<cfelseif CCType IS "AMEX" AND attributes.CardType IS NOT "Amex">
		<cfset typematch = 0>
	<cfelseif CCType IS "Diners Club/Carte Blanche" AND ( attributes.CardType IS NOT "Carte Blanche" OR attributes.CardType IS NOT "Diner's Club" )>
		<cfset typematch = 0>
	<cfelseif CCType IS "JCB" AND attributes.CardType IS NOT "JCB">
		<cfset typematch = 0>
	</cfif>
</cfif>
