
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template calculates the various line item totals for the shopping cart. Called by shopping.order|basket basketstats|clear|quickact --->

<!--- Order promotions are only recalculated if basket was recalculated --->
<cfparam name="doOrderPromos" default="no">

<cfscript>
	qry_Get_Basket = Application.objCart.getBasket();
	BasketTotals = Application.objCart.doBasketTotals(qry_Get_Basket);
	
	if (doOrderPromos) {
		//Calculate order-level promotions
		OrderPromotion = Application.objPromotions.calcOrderPromotion(BasketTotals.SubTotal, BasketTotals.TotalItems,qry_Get_Basket);
	
		//If returned a Promotion, redo the totals
		if (OrderPromotion) {
			qry_Get_Basket = Application.objCart.getBasket();
			BasketTotals = Application.objCart.doBasketTotals(qry_Get_Basket);
		}
	}
	
	//Get the product taxes (VAT)
	qryProdTaxes = Application.objCart.getProdTaxes();
	// Check tax amount
	EstTaxTotal = BasketTotals.EstTaxTotal;
</cfscript>
