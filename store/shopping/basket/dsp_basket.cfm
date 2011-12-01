<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the shopping basket. When items placed in basket, displays related products. Additional lines displayed during checkout process. Called by shopping.basket|clear|quickact and from shopping\checkout\do_checkout.cfm --->

<cfparam name="attributes.coupon" default="">
<cfparam name="codeerror" default="0">

<!--- Calculate the basket ---->
<cfif checkout>
	<cfset thetitle = "Order Form">
<cfelse>
	<cfset Webpage_title = "Shopping Cart">
	<cfset thetitle = "Contents of Shopping Cart">
</cfif>

<!--- This is used by the optional quickorder form in the extras directory --->
<cfif isdefined("message") and len(Message)>
	<table width="520" border="0" cellspacing="0" cellpadding="15" align="center" class="formerror">
		<tr>
			<td>
				<cfoutput>#Message#</cfoutput>
			</td>
		</tr>
	</table>
</cfif>


<cfmodule template="../../customtags/format_output_box.cfm"
	box_title="#thetitle#"
	align="center"
	border="1"
	width="520"
	>
	
<cfoutput>
<cfif not checkout>
	<form action="#self#?fuseaction=shopping.basket#request.token2#" method="post" name="cart">
</cfif>	
<table width="100%" cellspacing="0" border="0" cellpadding="3" class="carttext" style="color: ###Request.GetColors.OutputTText#;">	
</cfoutput>

<tr>
<cfif NOT qry_Get_Basket.RecordCount>
	<!--- Empty cart!  --->
	<td align="center" class="formtitle">
		<p><br/>Your cart is empty!</p>
	</td>
<cfelse>
	<!--- Output Basket Headers --->
	<th align="left">Item to Purchase</th>
	<th align="left">Qty.</th>
	<th align="right">Price after Options</th>
	<th align="right" nowrap="nowrap">Ext. Price</th>
	<cfif NOT Checkout><th>Remove</th></cfif>
	</tr>

		
	<!--- List Items in Basket --->
	<cfoutput query="qry_Get_Basket">
	
		<!--- Setting for row background color --->
		<cfif CurrentRow MOD 2 IS 0>
			<tr>
		<cfelse>
			<tr bgcolor="###Request.GetColors.outputtaltcolor#">
		</cfif>
		<cfif Request.AppSettings.UseSES>
			<cfset prodlink = "#Request.SESindex#product/#product_ID#/#SESFile(Name)##Request.Token1#">
		<cfelse>
			<cfset prodlink = "#self#?fuseaction=product.display&product_ID=#product_ID##Request.Token2#">
		</cfif>
			<td align="left">
			<a href="#XHTMLFormat(prodlink)#" #doMouseover(Name)#>#Name#</a>
		<cfif len(SKU) AND SKU IS NOT 0>
			<br/><span class="smallcarttext">Item##: #SKU#</span>
		</cfif>
		
		<cfif Len(Trim(Options))>
			<br/><span class="smallcarttext"><i>Options: #Options#</i></span>
		</cfif>
		
		<cfif QuantDisc gt "0">
			<br/><span class="smallcarttext"><i>Quantity Discount: #LSCurrencyFormat(QuantDisc)# per</i></span>
		</cfif>
		
		<cfif Len(Trim(Addons))>
			<br/><span class="smallcarttext"><i>#Addons#</i></span>
		</cfif>
		
		<!--- Add checks to see if the product and option choice for inventory still available --->
		<cfset Num = qry_Get_Basket.CurrentRow>
		<cfinclude template="qry_check_item.cfm">
		<cfif NOT Available>
			<br/><span class="smallcarterror">This product is not currently available, recalculate to remove</span>
		<cfelseif NOT OptQuantAvail OR NOT OptChoiceAvail>
			<br/><span class="smallcarterror">The options selected for this product are no longer valid, recalculate to remove</span>
		</cfif>
	
	<!--- Giftwrap code: If giftwrapping on and product allows giftwrap, show Add Gift Wrap link ---->
	<cfif NOT Checkout AND get_Order_Settings.giftwrap AND qry_Get_Basket.giftwrap neq 0>
		<cfif Not Find("Gift Wrap",addons)>
		<br/><span class="smallcarttext"><a href="#XHTMLFormat('#request.self#?fuseaction=shopping.giftwrap&item=#listlast(basket_ID,'_')##request.token2#')#" #doMouseover('Add Giftwrap')#>Giftwrap This</a></span>
		<cfelse>
		<span class="smallcarttext"><a href="#XHTMLFormat('#request.self#?fuseaction=shopping.giftwrap&item=#listlast(basket_ID,'_')##request.token2#')#" #doMouseover('Change Giftwrap')#>Change</a></span>
		</cfif>
	</cfif>
	<!--- end custom code --->

	<!--- GiftRegistry code: --->
	<cfif len(GiftItem_ID) and GiftItem_ID>
		<br/><span class="smallcarttext"><i>Gift Registry: <a href="#XHTMLFormat('#request.self#?fuseaction=shopping.giftregistry&do=display&giftregistry_ID=#GiftRegistry_ID##request.token2#')#" #doMouseover('View Registry')#>#Registrant# #GiftRegistry_Type#</a></i></span>
	</cfif>
	<!--- end custom code --->

				</td>
				
			<cfif NOT Checkout>
				<td align="left">
				<input type="text" name="Quantity#CurrentRow#" value="#Quantity#" size="3" maxlength="5" class="carttext"/></td>
			<cfelse>
				<td align="center">#Quantity#</td>
			</cfif>
				
			<cfset ItemPrice = Price + OptPrice - QuantDisc + AddonMultP>
			<cfset Ext = ItemPrice * Quantity>
			
			<td align="right">#LSCurrencyFormat(ItemPrice)#</td>	
			<td align="right">#LSCurrencyFormat(Ext)#</td>
	
			<cfif NOT Checkout>
				<td align="center"><input type="checkbox" name="Remove" value="#CurrentRow#" class="carttext"/></td>
			</cfif>
	
		</tr>

	</cfoutput>
	
	<cfoutput>
	
	<!--- Output Addons Line --->
	<cfif BasketTotals.AddonTotal IS NOT 0>
		<tr>
		<cfif NOT Checkout>
			<td>&nbsp;</td>
		</cfif>
			<td colspan="3" align="right"><b>Additional Items:</b></td>
			<td align="right">+#LSCurrencyFormat(BasketTotals.AddonTotal)#</td>
		</tr>
	</cfif>
	
	
	<!--- Output Discount & Credits Line --->
	<cfif BasketTotals.TotalDisc IS NOT 0>
		<tr>
		<cfif NOT Checkout>
			<td>&nbsp;</td>
		</cfif>
			<td colspan="3" align="right"><b>Discounts/Credits:</b></td>
			<td align="right">-#LSCurrencyFormat(BasketTotals.TotalDisc)#</td>
		</tr>
	</cfif>
	
	<!--- Output Promotions Line --->
	<cfif BasketTotals.PromoTotal IS NOT 0>
		<tr>
		<cfif NOT Checkout>
			<td>&nbsp;</td>
		</cfif>
			<td colspan="3" align="right"><b>Promotions:</b></td>
			<td align="right">-#LSCurrencyFormat(BasketTotals.PromoTotal)#</td>
		</tr>
	</cfif>
		
	<!--- Shipping Estimator --->
	<cfif NOT Checkout AND ShipSettings.ShowEstimator>
	
		<cfinclude template="estimator/put_ship_estimator.cfm">
		
	<cfelse>
		<tr>
		<cfif NOT Checkout>
			<td>&nbsp;</td>
		</cfif>
			<td colspan="3" align="right"><b>Subtotal:</b></td>
			<td align="right">#LSCurrencyFormat(BasketTotals.SubTotal)#</td>
		</tr>
		
		<!--- If there is estimated tax, display it --->
		<cfif NOT Checkout AND BasketTotals.EstTaxTotal IS NOT 0>
		<tr>
			<td>&nbsp;</td>
				<td colspan="3" align="right"><b>Estimated #qryProdTaxes.DisplayName# Tax:</b></td>
				<td align="right">#LSCurrencyFormat(EstTaxTotal)#</td>
			</tr>
		</cfif>	
	</cfif>


	<!--- Output Gift Certificate Total --->
	<cfif get_Order_Settings.Coupons and NOT Checkout>
	
		<cfinclude template="act_calc_giftcert.cfm">
		<cfif Credits GT 0>
			<tr><td>&nbsp;</td>
			<td colspan="3" align="right"><b>Gift Certificate Amount:</b></td>
			<td align="right">#LSCurrencyFormat(Credits)#</td>
			<cfif NOT Checkout AND qry_Get_Basket.RecordCount>
				<td>&nbsp;</td>
			</cfif>
			</tr>
			<tr>
			<td colspan="4" align="right" nowrap="nowrap" class="smallcarttext">Gift Certificate amount will be applied after<br/>
			taxes and shipping charges are calculated.</td>
			<cfif NOT Checkout AND qry_Get_Basket.RecordCount>
			<td>&nbsp;</td>
			</cfif>
			</tr>
		</cfif>
	</cfif>

</cfoutput>

</cfif><!--- basket items check --->


<cfif NOT Checkout>
	<!--- Add form to enter a coupon code --->
	<cfif get_Order_Settings.Coupons AND qry_Get_Basket.RecordCount>
		
		<!--- see if "Gift Cards" are a valid payment method, for Shift4 --->
		<cfquery name="qGetCards" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT CardName FROM #Request.DB_Prefix#CreditCards
			WHERE Used = 1 and CardName like 'Gift%'
		</cfquery>
		<cfset GCEnabled=qGetCards.RecordCount GT 0>
			
		<cfif codeerror>
		<tr>
			<td colspan="5" class="formerror"><br/>The coupon/certificate code you entered was not valid!<br/></td></tr>
		</cfif>	
		
		<cfif NOT GCEnabled>
		<tr>
	    	<td colspan="5" align="left"><br/>
			<strong>Coupon or Gift Certificate:</strong> &nbsp;<span class="formtextsmall"></span><br/>
	(Enter and recalculate to apply)<br/>
			<cfoutput><input type="text" name="Coupon" value="" size="40" maxlength="50" class="formfield"/>
			<cfif len(Session.Coup_Code)><br/>Current Coupon Code: #Session.Coup_Code#</cfif>
			<cfif len(Session.Gift_Cert)><br/>Current Gift Certificate: #Session.Gift_Cert#</cfif>
			<br/><br/></cfoutput>
			</td>
			</tr>
		</cfif>
	</cfif>
	
	<!--- Gift Registry Link - Add Items to Gift Registry --->
	<cfif Request.AppSettings.GiftRegistry AND qry_Get_Basket.RecordCount>
		<cfinclude template="../giftregistry/manager/put_registry_basket_button.cfm">
	</cfif>
	
	<tr>	
	<!--- Add buttons for shopping cart actions --->
	<!--- You can use images for these buttons instead by changing the type to "Image" and adding the src --->
<td<cfif qry_Get_Basket.RecordCount> colspan="5"</cfif> align="center"><br/>
<input type="submit" name="KeepShopping" value="Keep Shopping" class="formbutton"/> 
<cfif qry_Get_Basket.RecordCount><input type="submit" name="ClearCart" value="Clear" class="formbutton"/> 
<input type="submit" name="Recalculate" value="Recalculate" class="formbutton"/> 
<input type="submit" name="Checkout" value="Checkout" class="formbutton"/></cfif></td> 

	</tr>
	
<cfelse>	
	<!--- Add Shipping, Tax and Final totals if checkout --->
	<cfif Tax IS NOT 0>
		<cfinclude template="put_taxline.cfm">
	</cfif>
	
	<cfinclude template="put_shipline.cfm">
	
	<cfoutput>
	
	<cfif Credits IS NOT 0>
	<tr>
		<td colspan="3" align="right"><b>Credits:</b></td>
		<td align="right">-#LSCurrencyFormat(Credits)#</td>
	</tr>
	</cfif>

	<tr>
		<td colspan="3" align="right"><b>Total <cfif Session.CheckoutVars.NoShipInfo>(Not including shipping charges)</cfif>:</b></td>
		<td align="right">#LSCurrencyFormat(Total)#</td>
	</tr>
	</cfoutput>

</cfif><!--- checkout check --->

</table>
<cfif not checkout></form></cfif>

</cfmodule>



<cfif NOT Checkout>

	<!------ Related Products ------>
	<cfif isDefined("attributes.Product_ID") AND isNumeric(attributes.Product_ID)>
		<br/><br/>	
		<cfset attributes.detail_type = "Product">
		<cfset attributes.detail_id = attributes.product_ID>
		<cfset fusebox.nextaction="product.related">
		<cfinclude template="../../lbb_runaction.cfm">
	</cfif>

	<!--- If using a custom shipping table, display shipping rates --->
	<cfif NOT ListFind("UPS,Intershipper,USPS,FedEx", ShipSettings.ShipType)>
		<cfinclude template="put_shiptable.cfm">
	</cfif>
	
	<cfoutput>
	<!--- Output the Qforms validation scripts --->
	<cfprocessingdirective suppresswhitespace="no">
		<script type="text/javascript">
		<!--
		objForm = new qForm("cart");

		<cfloop query="qry_Get_Basket">		
			objForm.Quantity#CurrentRow#.validateNumeric();
			<!--- Set the required minimum to the Quantity amount --->
			<cfif qry_Get_Basket.Min_Order GT 0>
				objForm.Quantity#CurrentRow#.validateExp('parseInt(this.value) < #qry_Get_Basket.Min_Order#', 'A minimum quantity of #qry_Get_Basket.Min_Order# is required' );	
				<!--- Check if we are multiplying the minimums --->
				<cfif qry_Get_Basket.Mult_Min>
					objForm.Quantity#CurrentRow#.validateQuantityMult(#qry_Get_Basket.Min_Order#);
				</cfif>
			</cfif>
		</cfloop>
		
		qFormAPI.errorColor = "###Request.GetColors.formreqOB#";
		//-->
		</script>
		</cfprocessingdirective>
		</cfoutput>
		
<cfelse>
<br/>

</cfif>
