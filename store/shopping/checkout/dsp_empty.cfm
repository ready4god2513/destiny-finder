<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the empty cart message when the store detects that the cart is empty. For PayPal orders, the IPN transaction will result in the cart being cleared, so displays a final order notice to the customer. Called by shopping.checkout (step=empty) --->

<div align="center">

<!--- Check for Paypal IPN transactions --->
<cfif IsDefined("attributes.PayPalCust")>
	<cfset PayPal = "yes">
<cfelse>
	<cfset PayPal = "no">
</cfif>

<cfmodule template="../../customtags/format_output_box.cfm"
	box_title="#iif(PayPal, DE("PayPal Payment Received!"), DE("Your cart is empty!"))#"
	align="center"
	border="1"
	width="400"
	>
	
<cfoutput>
<form action="#XHTMLFormat('#Request.StoreURL##self##request.token1#')#" method="post" class="margins">
<font color="###Request.GetColors.OutputTText#">
<!--- Check for Paypal IPN transactions --->
<cfif PayPal>
Thanks for your payment! You should receive an email confirmation shortly with a summary of your order.
<cfelse>
Your cart currently does not contain any items. You may have already completed your order, or your session may have timed out. Please return to the store to start a new purchase.
</cfif>
</font>
<br/><br/>
<input type="submit" name="OrderType" value="Back to the Store" class="formbutton"/>
</form>	
</cfoutput>

</cfmodule>
</div>
<br/>
<br/>

