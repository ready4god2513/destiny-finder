
<!--- CFWebstore�, version 6.43 --->

<!--- CFWebstore� is �Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is called from the individual listings/put_xxx.cfm pages, and displays the item pricing information and the order box to place an order. --->

<!--- This page uses the queries run in qry_get_products --->

<!--- Required Parameters:
Product_ID : The product ID the orderbox is for
 --->
 
<!--- Set a default form action for the orderbox ---> 
<cfparam name="typeOrder" default="customer">
 
<cfscript>
	//set form action according to the type of order
	if (typeOrder IS "customer")
		prodOrderAction = "#self#?fuseaction=shopping.order#request.token2#";
	else if (typeOrder IS "adminorder")
		prodOrderAction = "#self#?fuseaction=shopping.admin&order=AddProduct&order_no=#attributes.order_no##request.token2#";
	else if (typeOrder IS "adminregistry")
		prodOrderAction = "#self#?fuseaction=shopping.admin&giftregistry=AddProduct&giftregistry_ID=#attributes.giftregistry_ID##request.token2#";

	// Determine method of ordering 
	if (GetProdOpts.RecordCount OR GetProdAddons.RecordCount OR Find("admin",typeOrder))
		Type="Table";
	else
		Type="Button";
</cfscript>

<cfif ShowDiscounts AND len(discounts)>
	<!--- Code used with CFC object --->
	<cfset DiscountMess = Application.objDiscounts.getDiscountMess(discounts)>
<cfelse>
	<cfset DiscountMess = "">
</cfif>

<cfif ShowPromotions AND len(promotions)>
	<!--- Code used with CFC object --->
	<cfset PromoMess = Application.objPromotions.getPromotionMess(promotions)>
<cfelse>
	<cfset PromoMess = "">
</cfif>

<!--- Output the price --->

<cfif ShowPrice>
	<!---------- Uncomment this line if you want orderbox to go under small image in listings 
	<cfif NOT isDefined("attributes.Product_ID")>
	<cfoutput></td></tr></table>
	<table cellpadding="2" cellspacing="2" width="100%">
	<tr><td colspan="2"></cfoutput>
	</cfif>
	---------->
	<cfif Request.AppSettings.ShowInStock and prod_type is "product">
	<cfoutput><br/><span class="prodSKU"><b>Number in Stock:</b> #qry_prod_stock.NumInStock#</span><br/></cfoutput>
	</cfif>
	 <cfinclude template="put_price.cfm"> 
 </cfif> 
 
<!--- table of quantity discounts --->
<cfif typeOrder IS "customer">
	<cfset fusebox.nextaction="product.qty_discount">
	<cfinclude template="../../lbb_runaction.cfm">
</cfif>

 
<cfif NOT Compare(Type, "Button") AND NOT ShowOrderBox>

<cfmodule template="../../customtags/putimage.cfm" filename="#Request.AppSettings.OrderButtonImage#" filealt="#Request.AppSettings.OrderButtonText#" imglink="#XHTMLFormat('#self#?fuseaction=shopping.order&Product_ID=#Product_ID##Request.Token2#')#" align="middle"><br/>

	<!--- mjs 09-11-08 Alternate code to include a quantity box with the order button, comment the line above out to use this instead --->
	<!--- <cfoutput>
	<form action="#XHTMLFormat(prodOrderAction)#" method="post" name="orderform#Product_ID#" class="nomargins" style="margin-left:0px;">
	<input type="hidden" name="Product_ID" value="#Product_ID#"/>
	<!--- Output list of product options and addons --->
	<input type="hidden" name="Prod#Product_ID#_Opts" value="#ValueList(GetProdOpts.Option_ID)#"/>
	<input type="hidden" name="Prod#Product_ID#_Addons" value="#ValueList(GetProdAddons.Addon_ID)#"/>
	<input type="text" name="Quantity" value="1" size="1" maxlength="4" class="formfield"/>
	 <input type="image" src="#Request.AppSettings.defaultimages#/#Request.AppSettings.OrderButtonImage#" border="0" 
				alt="#Request.AppSettings.OrderButtonText#" style="vertical-align:bottom" />
	</form>
	</cfoutput> --->
</cfif>

<!--- Output discount message generated by the discountmess called above --->
<cfif len(DiscountMess)>
	<cfif NOT isDefined("attributes.Product_ID") AND NOT ShowPrice>
		<cfoutput></td></tr></table>
		<table cellpadding="2" cellspacing="2">
		<tr><td colspan="2"></cfoutput>
	</cfif>
	<cfoutput><span class="proddisc"><!---<b>Special:</b>---> #replace(DiscountMess,',','<br/>','ALL')#</span><br/></cfoutput>
</cfif>

<!--- Output promotion message generated by the promomess called above --->
<cfif len(PromoMess)>
	<cfif NOT isDefined("attributes.Product_ID") AND NOT ShowPrice AND NOT len(DiscountMess)>
		<cfoutput></td></tr></table>
		<table cellpadding="2" cellspacing="2">
		<tr><td colspan="2"></cfoutput>
	</cfif>
	<cfoutput><span class="proddisc"><!---<b>Special:</b>---> #replace(PromoMess,',','<br/>','ALL')#</span><br/></cfoutput>
</cfif>

<cfif request.appsettings.productreviews AND Reviewable AND typeOrder IS "customer">
	<span class="prodSKU"><br/>
		<cfset attributes.do = "summary">
		<cfset attributes.putlink = "thispage">
		<cfset fusebox.nextaction="product.reviews">
		<cfinclude template="../../lbb_runaction.cfm">
	</span>
</cfif>

<!--- Display wishlist link --->
<cfif Request.AppSettings.wishlists AND typeOrder IS "customer">
	<cfset ShowWishList = "Yes">
<cfelse>
	<cfset ShowWishList = "No">
</cfif>
<!--- Display GiftRegistry link if using an order button --->
<cfif Request.AppSettings.GiftRegistry AND typeOrder IS "customer" AND Type IS "Button">
	<cfset RegistryLink = "Yes">
<cfelse>
	<cfset RegistryLink = "No">
</cfif>

<cfif ShowWishList>
	<cfoutput><br/><span class="prodSKU">[<a href="#XHTMLFormat('#self#?fuseaction=shopping.wishlist&Product_ID=#Product_ID##request.token2#')#" #doMouseover('Add to My Wishlist')#>Add to Wishlist</a>]</span></cfoutput>
	<cfif NOT RegistryLink><br/></cfif>
<cfelseif RegistryLink><br/>
</cfif>

<cfif RegistryLink>
	<cfoutput><span class="prodSKU">[<a href="#XHTMLFormat('#self#?fuseaction=shopping.order&Product_ID=#Product_ID#&AddtoRegistry=Yes#request.token2#')#" #doMouseover('Add to Gift Registry')#>Add to Gift Registry</a>]</span><br/></cfoutput>
</cfif>

<!--- Check if reloading page due to required option not selected --->
<cfif isDefined("attributes.Prod_ID")>
	<cfif attributes.Prod_ID IS Product_ID>
		<cfoutput><p> <span class="proderror"><b>An option selection/entry is required!</b></span></p></cfoutput>
	</cfif>
</cfif>

<!--- If category page, and no price or discounts --->
<cfif NOT isDefined("attributes.Product_ID") AND NOT len(DiscountMess) AND NOT len(PromoMess) AND NOT ShowPrice>
	<cfoutput></td></tr></table>
	<table cellpadding="2" cellspacing="2" >
	<tr><td colspan="2"><br/></cfoutput>
</cfif>

<cfif NOT Compare(Type, "Table") OR ShowOrderBox>
<!--- Begin Order Box --->
<cfoutput>
<form action="#XHTMLFormat(prodOrderAction)#" method="post" name="orderform#Product_ID#" class="margins" style="margin-left:0px;">
<input type="hidden" name="Product_ID" value="#Product_ID#"/>
<!--- Output list of product options and addons --->
<input type="hidden" name="Prod#Product_ID#_Opts" value="#ValueList(GetProdOpts.Option_ID)#"/>
<input type="hidden" name="Prod#Product_ID#_Addons" value="#ValueList(GetProdAddons.Addon_ID)#"/>

<!--- Set the minimum required quantity --->
<cfset MinQuant = iif(qry_get_products.Min_Order GT 0, qry_get_products.Min_Order, 1)>

<table cellspacing="4" cellpadding="0" border="0" <cfif Request.GetColors.BoxTBgcolor is not '' and NOT vertoptions AND typeOrder IS "customer">bgcolor="###Request.GetColors.BoxTBgcolor#" style="color:###Request.GetColors.BoxTText#" </cfif> class="formtext"></cfoutput>

<!--- Initialize QForms required Fields --->
<cfset RequireList = "">
<cfset RequireNames = "">

<!--- Initialize QForms numeric Fields --->
<cfset NumericList = "">
<cfset NumericNames = "">

<cfif NOT vertoptions>
	<!---- Horizontal product options ----------------->
	<cfset extras = GetProdOpts.RecordCount - GetProdAddons.RecordCount + 1>

	<cfoutput><tr><td valign="bottom">
	Quantity:&nbsp;<input type="text" name="Quantity" value="#MinQuant#" size="2" maxlength="5" class="formfield"/>

	<!--- Output total number of product options --->

	</td></cfoutput>

	<cfif GetProdOpts.RecordCount IS 0>
		<!-------------------->
		<cfoutput><td valign="bottom"><!--- #Name# ---></td></cfoutput>
		
	<cfelse>
		<cfinclude template="put_options.cfm">
	</cfif>
	
	<!--- Output total number of product addons --->
	<cfif GetProdAddons.RecordCount IS NOT 0>
		<cfoutput></tr></cfoutput>
		<cfinclude template="put_addons.cfm">
	</cfif>
	
	<cfoutput>
	<td valign="bottom" align="center">
	</cfoutput>


	
<cfelse>
<!---- Vertical product options ----------------->
	<cfset extras = 1>

	<!--- Check if product has options --->
	<cfif GetProdOpts.RecordCount IS NOT 0>
		<cfinclude template="put_options.cfm">
	</cfif>
	
	<!--- Check if product has addons --->
	<cfif GetProdAddons.RecordCount IS NOT 0>
		<cfinclude template="put_addons.cfm">
	</cfif>	

	<cfoutput><tr><td valign="bottom">
	<span class="formtext">Quantity: <input type="text" name="Quantity" value="#MinQuant#" size="2" maxlength="5" class="formfield"/></span></cfoutput>

</cfif>

<!------------------------------------------------->
<cfoutput>
	
	<cfif typeOrder IS "customer">
		<!--- Output Order Button --->
		<cfif NOT ShowOrderBox>
			<input type="image" src="#Request.AppSettings.defaultimages#/#Request.AppSettings.OrderButtonImage#" border="0" 
			alt="#Request.AppSettings.OrderButtonText#" style="vertical-align:bottom" />
		<cfelse>
			<input type="submit" value="#Request.AppSettings.OrderButtonText#" class="formbutton"/>		
		</cfif>
		<!--- Output Gift Registry Button --->
		<cfif Request.AppSettings.GiftRegistry AND isDefined("Request.RegistryButton") AND NOT ShowOrderBox>
			<input type="image" src="#Request.AppSettings.defaultimages#/#Request.RegistryButton#" border="0" 
				name="AddtoRegistry" alt="Add to Gift Registry" style="vertical-align:bottom" />
		<cfelseif Request.AppSettings.GiftRegistry>
			<input type="submit" value="Add to Registry" name="AddtoRegistry" class="formbutton"/>
		</cfif>
		
	<!--- Output buttons for order admin section --->
	<cfelseif typeOrder IS "adminorder">
		<input type="submit" name="AddtoOrder" value="Add to Order" class="formbutton"/>
		<input type="button" value="Cancel" class="formbutton" onclick="window.close();"/>
	<cfelseif typeOrder IS "adminregistry">
		<input type="submit" name="AddtoRegistry" value="Add to Registry" class="formbutton"/>
		<input type="button" value="Cancel" class="formbutton" onclick="window.close();"/>
	</cfif>

</td></tr>
</table>
</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--
objForm = new qForm("orderform#Product_ID#");

<cfset numrequired = ListLen(RequireList, "^")>

<cfloop from="1" to="#numrequired#" index="num">
objForm.required("#ListGetAt(RequireList, num, "^")#");
objForm.#ListGetAt(RequireList, num, "^")#.description = "#ListGetAt(RequireNames, num, "^")#";
</cfloop>

/* verify numeric for addon fields that require it */
<cfset numnumeric = ListLen(NumericList, "^")>

<cfloop from="1" to="#numnumeric#" index="num">
objForm.#ListGetAt(NumericList, num, "^")#.validateNumeric();
objForm.#ListGetAt(NumericList, num, "^")#.description = "#ListGetAt(NumericNames, num, "^")#";
</cfloop>

objForm.Quantity.validateNumeric();
<!--- Set the required minimum to the Quantity amount --->
objForm.Quantity.validateExp('parseInt(this.value) < #MinQuant#', 'A minimum quantity of #MinQuant# is required' );	

<!--- Check if we are multiplying the minimums --->
<cfif qry_get_products.Mult_Min>
	objForm.Quantity.validateQuantityMult(#MinQuant#);
</cfif>

qFormAPI.errorColor = "###Request.GetColors.formreqOB#";
//-->
</script>
</cfprocessingdirective>

<!--- End Order Box --->
</cfoutput>

</cfif>


