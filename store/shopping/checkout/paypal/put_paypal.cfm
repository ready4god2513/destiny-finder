<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Outputs the form button to order through PayPal. Includes fields required for IPN. Called by checkout\dsp_payment_options.cfm --->

	<tr>
		<cfoutput>
		<td colspan="3">
		Save time. Checkout securely. Pay without sharing your financial information.<br/><br/>
		<div align="center">
		<form action="https://www.paypal.com/cgi-bin/webscr" method="post" >
		<!--- Sandbox address for testing --->
		<!--- <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" > --->
		<input type="hidden" name="cmd" value="_xclick" />
		<input type="hidden" name="bn" value="dogpatchsoft.cfwebstore" />
		<input type="hidden" name="rm" value="2">
		<input type="hidden" name="business" value="#get_order_settings.PayPalEmail#" />
		<input type="hidden" name="item_name" value="#Request.AppSettings.SiteName# Order" />
		<input type="hidden" name="currency_code" value="#Left(LSCurrencyFormat(10, "international"),3)#" />
		<input type="hidden" name="amount" value="#Total#" />		
		<input type="hidden" name="custom" value="#Session.BasketNum#" />
		<input type="hidden" name="notify_url" value="#XHTMLFormat('#Request.StoreURL##self#?fuseaction=shopping.checkout&step=ipn&redirect=yes&#Session.URLToken#')#" />
		<input type="hidden" name="return" value="#XHTMLFormat('#Request.StoreURL##self#?fuseaction=shopping.checkout&step=ipn&redirect=yes&PayPalCust=Yes&#Session.URLToken#')#" />
		<input type="hidden" name="cancel_return" value="#XHTMLFormat('#Request.StoreURL##self#?fuseaction=shopping.basket&redirect=yes&#Session.URLToken#')#" />
		<input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-but01.gif" name="submit" alt="Make payments with PayPal - it's fast, free and secure!" />
		</div></form>
		</td></tr>
		</cfoutput>
	