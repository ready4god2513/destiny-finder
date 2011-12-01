<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to output the shopping cart during checkout. Called by do_checkout.cfm --->

<cfset variables.checkout = 1>
<cfset BasketTotals = Application.objCart.doBasketTotals(qry_Get_Basket)>
	
<!--- Calculate Taxes ------->
<cfinclude template="act_calc_tax.cfm">
<!--- Check for gift certificate --->
<cfinclude template="act_calc_giftcert.cfm">
	
<cfscript>
	Total = BasketTotals.SubTotal + Tax + ShipCost + TotalFreight;
	
	if (Credits GT Total)
		Credits = Total;
		
	Total = Total - Credits;

</cfscript>

	
<cfinclude template="do_basket.cfm">

