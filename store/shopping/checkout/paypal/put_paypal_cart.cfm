<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Outputs the form button to order through PayPal including the entire shopping cart. Includes fields required for IPN. Replace the link to put_paypal.cfm on checkout\dsp_payment_options.cfm with this file. --->

<!--- IMPORTANT NOTES FOR USEAGE
PayPal at this time does not have any capability to receive order-level discounts or gift certificates. You can not use either of these features if you use this template, or your total in PayPal will not be correct. 

To ensure that the shipping amount is accepted, log into your PayPal account and then go to Profile - Shipping Calculations
Check the box at the bottom of the page that says 'Click here to allow transaction-based shipping values to override the profile shipping settings listed above (if profile settings are enabled).'
 --->

	<tr>
		<cfoutput>
		<td colspan="3">
		Use PayPal for secure online payment using your credit card or checking account! You will receive verification of your order after completing your transaction on the PayPal website.<br/><br/>
		<div align="center">
		<form action="https://www.paypal.com/cgi-bin/webscr" method="post" >
		<!--- Sandbox address for testing --->
		<!--- <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" > --->
		<input type="hidden" name="cmd" value="_cart" />
		<input type="hidden" name="upload" value="1" />
		<input type="hidden" name="rm" value="2">
		<input type="hidden" name="bn" value="dogpatchsoft.cfwebstore" />
		<input type="hidden" name="business" value="#get_order_settings.PayPalEmail#" />
		<input type="hidden" name="currency_code" value="#Left(LSCurrencyFormat(10, "international"),3)#" />
		<input type="hidden" name="shipping_1" value="#(ShipCost+TotalFreight)#" />
		<input type="hidden" name="tax_cart" value="#Tax#" />		
		<input type="hidden" name="custom" value="#Session.BasketNum#" />
		<input type="hidden" name="notify_url" value="#XHTMLFormat('#Request.StoreURL##self#?fuseaction=shopping.checkout&step=ipn&redirect=yes&#Session.URLToken#')#" />
		<input type="hidden" name="return" value="#XHTMLFormat('#Request.StoreURL##self#?fuseaction=shopping.checkout&step=ipn&redirect=yes&PayPalCust=Yes&#Session.URLToken#')#" />
		<input type="hidden" name="cancel_return" value="#XHTMLFormat('#Request.StoreURL##self#?fuseaction=shopping.basket&redirect=yes&#Session.URLToken#')#" />
		</cfoutput>
		<!--- Output the basket items --->
		<cfoutput query="qry_Get_Basket">
		<cfset Amount = Price + OptPrice - QuantDisc + AddonMultP - DiscAmount - (PromoAmount/Quantity)>
		<input type="hidden" name="amount_#CurrentRow#" value="#Amount#" />
		<input type="hidden" name="item_name_#CurrentRow#" value="#Left(Name, 127)#" />
		<input type="hidden" name="quantity_#CurrentRow#" value="#Quantity#" />
		<cfif Len(Trim(Options))>
		<input type="hidden" name="on0_#CurrentRow#" value="Options" />
		<input type="hidden" name="os0_#CurrentRow#" value="#Left(Options, 197)##iif(Len(Options) GT 197, DE('...'), DE(''))#" />
		</cfif>
		<cfif Len(Trim(Addons))>
		<cfif Len(Trim(Options))><cfset prefix = "1"><cfelse><cfset prefix = "0"></cfif>
		<!--- Set the output --->
		<cfset ppAddons = Left(Trim(Addons), Len(Trim(Addons))-4)>
		<cfset ppAddons = Replace(Left(ppAddons, 197), '<br/>', ' || ', 'ALL') & iif(Len(Options) GT 197, DE('...'), DE(''))>
		<input type="hidden" name="on#prefix#_#CurrentRow#" value="Addons" />
		<input type="hidden" name="os#prefix#_#CurrentRow#" value="#ppAddons#" />
		</cfif>		
		</cfoutput>
		<cfoutput>
		<cfset totalitems = qry_Get_Basket.Recordcount>
		<!--- Output additional items --->
		<cfif BasketTotals.AddonTotal IS NOT 0>
			<cfset totalitems = totalitems + 1>
			<input type="hidden" name="amount_#totalitems#" value="#BasketTotals.AddonTotal#" />
			<input type="hidden" name="item_name_#totalitems#" value="Additional Items" />
			<input type="hidden" name="quantity_#totalitems#" value="1" />
		</cfif>
<!--- 		<cfif TotalDisc IS NOT 0>
			<cfset totalitems = totalitems + 1>
			<input type="hidden" name="amount_#totalitems#" value="-#TotalDisc#" />
			<input type="hidden" name="item_name_#totalitems#" value="Discounts" />
			<input type="hidden" name="quantity_#totalitems#" value="1" />
		</cfif>
		<cfif Credits IS NOT 0>
			<cfset totalitems = totalitems + 1>
			<input type="hidden" name="amount_#totalitems#" value="-#Credits#" />
			<input type="hidden" name="item_name_#totalitems#" value="Credits" />
			<input type="hidden" name="quantity_#totalitems#" value="1" />
		</cfif> --->
		</cfoutput>
		
		<input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-but01.gif" name="submit" alt="Make payments with PayPal - it's fast, free and secure!" />
		</form></div>
		</td></tr>
	