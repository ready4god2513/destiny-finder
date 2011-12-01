
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page completes the order checkout. It transfers all the temporary information into the permanent order tables, sends order notification emails, checks for reorder amounts, etc. Called by shopping.checkout (step=receipt) --->

<cfparam name="attributes.Offline" default="">
<cfif attributes.Offline is "BillUser">
	<cfset attributes.Offline="">
	<cfset offlinePayment = "BillUser">
</cfif>

<!--- If not already retrieved, get customer data --->
<cfif NOT isDefined("GetShipTo")>

	<!--- Get shipping information --->
	<cfquery name="GetShipTo" datasource="#Request.DS#" username="#Request.user#"
	password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#TempShipTo 
	WHERE TempShip_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>
	
</cfif>

<!--- Get Order Totals --->
<cfquery name="GetTotals" datasource="#Request.DS#" username="#Request.user#" 		
password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#TempOrder 
WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>	

<!--- START ==============================================================---->
<cfset r = Randomize(Minute(now())&Second(now()))>  
<cfparam name="randomnum" default="#RandRange(1000,9999)#">

<!--- UUID to tag new inserts --->
<cfset NewIDTag = CreateUUID()>
<!--- Remove dashes --->
<cfset NewIDTag = Replace(NewIDTag, "-", "", "All")>

<!--- PayPal settings --->
<cfparam name="Confirmed" default="0">
<cfparam name="PayPalStatus" default="">
<cfparam name="Reason" default="">

<!--- Setting for memberships --->
<cfparam name="membership_valid" default="1">

<!--- Get ShipTo & Customer Record IDs --->
<cfinclude template="customer/act_register.cfm">


<cfparam name="AuthNumber" default="0">
<cfparam name="PO_Number" default="">

<!--- If credit-card order, add card number to database --->

<cfif not len(attributes.Offline) AND NOT isDefined("PayPal")>

	<cfparam name="attributes.UpdateCC" default="">
	<cfif attributes.UpdateCC is "YES">
		<cfif not IsDefined("get_User_Settings")>
			<cfinclude template="../../users/qry_get_user_settings.cfm">
		</cfif>
		<cfif not IsDefined("get_User_Extended_Settings")>
			<cfinclude template="../../users/qry_get_user_extended_settings.cfm">
		</cfif>
		<cfif Val(Session.User_ID) EQ 0 or not get_User_Settings.UseCCard or not get_User_Extended_Settings.UserCCardOnTheFlyUpdate>
			<cfset attributes.UpdateCC="NO">
		</cfif>
	</cfif>
	
	<cfif get_Order_Settings.storecardinfo or attributes.UpdateCC is "YES">
		<!--- Run encryption on the card number --->
		<cfparam name="attributes.SaveCardNumber" default="#attributes.CardNumber#">
		<cfmodule template="../../customtags/crypt.cfm" string="#attributes.SaveCardNumber#" key="#Request.encrypt_key#">
	</cfif>
	
	<cftransaction>
		<cfquery name="GetCardNo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		<cfif Request.dbtype IS "MSSQL">
			SET NOCOUNT ON
		</cfif>
		INSERT INTO #Request.DB_Prefix#CardData 
				(ID_Tag, 
				Customer_ID, 
				CardType, 
				NameonCard, 
				CardNumber, 
				Expires,
				EncryptedCard)
		
		VALUES (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NewIDTag#">, 
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.customer_ID#">, 
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.CardType#">, 
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.NameonCard#">, 
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="XXXXXXXXXXXX#right(attributes.cardnumber,4)#">, 
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cardexp#">,
				<!--- Only save card data for Shift4 processing --->
				<cfif get_Order_Settings.storecardinfo AND get_Order_Settings.CCProcess IS "Shift4OTN">
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#crypt.value#">
				<cfelse>Null</cfif>
				)
			<cfif Request.dbtype IS "MSSQL">
				SELECT @@Identity AS newCard_No
				SET NOCOUNT OFF
			</cfif>
		</cfquery>
		
		<cfif Request.dbtype IS NOT "MSSQL">
			<cfquery name="GetCardNo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT ID AS newCard_No FROM #Request.DB_Prefix#CardData
				WHERE ID_Tag = '#NewIDTag#'
			</cfquery>
		</cfif>
	</cftransaction>
	
	<cfif attributes.UpdateCC is "YES">
		<!--- Convert expiration date to a true date --->
		<cfscript>
			if (ListLen(cardexp, "/" IS 2)) {
				cardMonth = ListGetAt(cardexp,1,"/");
				cardYear = ListGetAt(cardexp,2,"/");
				tempdate = CreateDate(cardYear, cardMonth, "1");
				lastday = DaysInMonth(tempdate);
				expirationdate = CreateDate(cardYear, cardMonth, lastday);
			}
			else {
				expirationdate = Now();
				}
		</cfscript>
		
			<cfquery name="SetCardNoOnFile" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users 
			SET		CardType = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.CardType#">, 
					CardNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="XXXXXXXXXXXX#right(attributes.cardnumber,4)#">, 
					CardExpire = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#expirationdate#">,
					NameOnCard = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.NameonCard#">, 
					CardZip = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetCustomer.Zip#">, 
					EncryptedCard = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#crypt.value#">,
					CardIsValid = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="1">
			WHERE	User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">
			</cfquery>
	</cfif>
	
	<cfset Card_No = GetCardNo.newCard_No>
	<cfparam name="offlinePayment" default="Online">

	<!--- UseBilling is an option set on the payment settings for
	stores that only authorize creditcards at check-out and bill the card upon shipment. --->
	<cfif NOT get_Order_Settings.UseBilling>
		<cfset paid = 1>	
	<cfelse>
		<cfset paid = 0>
	</cfif>
	
	<!--- If not using online processing, don't automatically approve memberships --->
	<cfif get_Order_Settings.CCProcess IS "None">
		<cfset membership_valid = 0>
	</cfif>

<cfelseif isDefined("PayPal")>
	<cfset Card_No = 0>
	<cfset offlinePayment = "PayPal">
	<cfif PayPalStatus IS "Completed">
		<cfset paid = 1>
	<cfelse>
		<cfset paid = 0>
		<cfset membership_valid = 0>
	</cfif>
	
<cfelseif isDefined("attributes.PO_Number")>
	<cfset Card_No = 0>
	<cfset PO_Number = Trim(attributes.PO_Number)>
	<cfset offlinePayment = "Purchase Order">
	<cfset paid = 0>
	<cfset membership_valid = 0>
	
<cfelse>

	<cfset Card_No = 0>
	<cfset offlinePayment = "Offline">
	<cfset paid = 0>
	<cfset membership_valid = 0>
	
</cfif>

<!--- If OrderTotal was $0, set to paid for all order types --->
<cfif GetTotals.OrderTotal IS 0>
	<cfset paid = 1>
	<cfset membership_valid = 1>
</cfif>

<!--- Check for inventory management --->
<cfif Request.AppSettings.InvLevel IS "Store" OR (Request.AppSettings.InvLevel IS "Mixed" AND (Card_No IS NOT 0 OR paid IS 1))>
	<cfset removeInv = "Yes">
<cfelse>
	<cfset removeInv = "No">
</cfif>

<cfset InvoiceNum = Replace(CGI.REMOTE_ADDR,".","","ALL") & randomnum>
<cfparam name="TransactNum" default="">
<cfparam name="Notes" default="">

<!--- Check if using a Gift Certificate --->
<cfquery name="GetCert" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT * FROM #Request.DB_Prefix#Certificates
WHERE Cert_Code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Gift_Cert#">
</cfquery>

<cfif GetCert.RecordCount>
<cfquery name="UpdCert" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#Certificates
SET CertAmount = (CertAmount - <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#GetTotals.Credits#">)
<cfif GetCert.CertAmount LTE GetTotals.Credits>, Valid = 0</cfif>
WHERE Cert_Code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Gift_Cert#">
</cfquery>
</cfif>


<!--- Enter order in the database --->
<cftransaction>
<cfquery name="GetOrderNo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
<cfif Request.dbtype IS "MSSQL">
	SET NOCOUNT ON
</cfif>
INSERT INTO #Request.DB_Prefix#Order_No
(ID_Tag, Customer_ID, User_ID, Card_ID, ShipTo, OrderTotal, Tax, Shipping, ShipType,
Freight, Comments, AuthNumber, InvoiceNum, TransactNum, Notes, Affiliate, Referrer, Giftcard,
Delivery, OrderDisc, Credits, AddonTotal, Coup_Code, Cert_Code,
Paid, Filled, Process, Void, Printed, CodesSent, InvDone, PayPalStatus, Reason, OfflinePayment, PO_Number,
<!--- Custom textbox fields --->
<cfloop index="num" from="1" to="3">
	CustomText#num#,
</cfloop>
<!--- Custom selectbox fields --->
<cfloop index="num" from="1" to="2">
	CustomSelect#num#, 
</cfloop> 
DateOrdered)

VALUES (
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NewIDTag#">,
<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Customer_ID#">, 
<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">,
<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Card_No#">,
<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.ShipTo#">,
<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#GetTotals.OrderTotal#">,
<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#GetTotals.Tax#">,
<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#GetTotals.Shipping#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetTotals.ShipType#">,
<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#GetTotals.Freight#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetTotals.Comments#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AuthNumber#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#InvoiceNum#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#TransactNum#">,
<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#Notes#">,
<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetTotals.Affiliate#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetTotals.Referrer#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetTotals.Giftcard#" null="#YesNoFormat(NOT len(GetTotals.Giftcard))#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetTotals.Delivery#" null="#YesNoFormat(NOT len(GetTotals.Delivery))#">,
<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#GetTotals.OrderDisc#">,
<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#GetTotals.Credits#">,
<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#GetTotals.AddonTotal#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Coup_Code#" null="#YesNoFormat(NOT GetTotals.OrderDisc AND len(Session.Coup_Code))#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Gift_Cert#" null="#YesNoFormat(NOT GetTotals.Credits AND len(Session.Gift_Cert))#">,
<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#paid#">,
0, 0, 0, 0, 1,
<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#iif(removeInv, 1, 0)#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#PayPalStatus#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Reason#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#offlinePayment#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#PO_Number#" null="#YesNoFormat(NOT len(PO_Number))#">,
<!--- Custom textbox fields --->
<cfloop index="x" from="1" to="3">
	<cfset entry = GetTotals["CustomText" & x][1]>
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#entry#" null="#YesNoFormat(NOT len(entry))#">,
</cfloop>
<!--- Custom selectbox fields --->
<cfloop index="x" from="1" to="2">
	<cfset entry = GetTotals["CustomSelect" & x][1]>
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#entry#" null="#YesNoFormat(NOT len(entry))#">,
</cfloop> 
<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">)
<cfif Request.dbtype IS "MSSQL">
	SELECT @@Identity AS newOrder_No
	SET NOCOUNT OFF
</cfif>
</cfquery>

<cfif Request.dbtype IS NOT "MSSQL">
	<cfquery name="GetOrderNo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Order_No AS newOrder_No FROM #Request.DB_Prefix#Order_No
	WHERE ID_Tag = '#NewIDTag#'
	</cfquery>
</cfif>
</cftransaction>

<cfset New_OrderNo = GetOrderNo.newOrder_No>

<!--- Copy over the tax totals for the order --->
<cfif GetTotals.Tax IS NOT 0>
	
	<!--- Use the tax info in the session and add it to the Order Taxes table --->
	<cfset application.objCheckout.saveOrderTaxes(Session.CheckoutVars.TaxTotals, New_OrderNo)>

</cfif>

<cfset item_num = 0>

<cfloop query="qry_get_basket">

	<!--- Increment item number --->
	<cfset item_num = item_num + 1>
	
	<!--- Get the product's dropshipping and product type info --->
	<cfquery name="Dropship_info" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT Account_ID, Dropship_Cost, Vendor_SKU, Prod_Type 
	FROM #Request.DB_Prefix#Products
	WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Product_ID#">
	</cfquery>
	
	<!--- Add each item to order database --->
	<cfquery name="AddOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#Order_Items 
		(Item_ID, Order_No, Product_ID, Name, SKU, Options, Addons, AddonMultP, AddonNonMultP,
		Price, Quantity, DiscAmount, Disc_Code, PromoAmount, PromoQuant, Promo_Code, 
		OptQuant, OptChoice, OptPrice, Dropship_Account_ID, Dropship_Qty, Dropship_Cost, Dropship_SKU )
	
	VALUES 
	(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#item_num#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#New_OrderNo#">, 
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Product_ID#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qry_get_basket.Name#" null="#YesNoFormat(NOT len(qry_get_basket.Name))#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qry_get_basket.SKU#" null="#YesNoFormat(NOT len(qry_get_basket.SKU))#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qry_get_basket.Options#" null="#YesNoFormat(NOT len(qry_get_basket.Options))#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qry_get_basket.Addons#" null="#YesNoFormat(NOT len(qry_get_basket.Addons))#">,
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#qry_get_basket.AddonMultP#">, 
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#qry_get_basket.AddonNonMultP#">, 
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#(qry_get_basket.Price - qry_Get_Basket.QuantDisc)#">, 
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Quantity#">, 
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#qry_get_basket.DiscAmount#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qry_get_basket.Disc_Code#">, 
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#qry_get_basket.PromoAmount#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.PromoQuant#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qry_get_basket.Promo_Code#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.OptQuant#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.OptChoice#">,
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#qry_get_basket.OptPrice#">,
	<cfif Dropship_info.Account_ID gt 0>
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Dropship_info.Account_ID#">,
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Quantity#">,
	<cfelse>
		Null, 0, 
	</cfif>
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(isNumeric(Dropship_info.dropship_cost), Dropship_info.dropship_cost, 0)#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Dropship_info.Vendor_SKU#" null="#YesNoFormat(NOT len(Dropship_info.Vendor_SKU))#">
	)
	</cfquery>
	

	<!--- If Inventory Control is being used, and this is a tangible product, subtract quantity of item from number in stock. --->
	<cfif removeInv AND qry_get_basket.Prod_Type IS "product">
	
		<cfquery name="UpdateInv" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Products
		SET NumInStock = NumInStock - <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Quantity#">
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Product_ID#">
		</cfquery>
	
		<!--- Check to see if new inventory level is at or below the inventory re-order level. 
		If so, send an email to the store admin! --->
		<cfinclude template="../admin/order/act_reorder_check.cfm">	
	
		<!--- If inventory tracking by option, update option quantity --->
		<cfif qry_get_basket.OptChoice IS NOT 0>		
			<!--- Update Option Quantity --->
			<cfquery name="UpdateChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#ProdOpt_Choices
					SET NumInStock = NumInStock - <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Quantity#">
					WHERE Option_ID IN (SELECT OptQuant FROM Products
										WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Product_ID#">)
					AND Option_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.OptQuant#">
					AND Choice_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.OptChoice#">
			</cfquery>	
		</cfif><!--- inventory by options --->
	</cfif><!--- inventory update --->
	
	
	<!--- If product is a membership or download, process it --->
	<cfif qry_get_basket.prod_type is "membership" or qry_get_basket.prod_type is "download">
		<cfinclude template="post_processing/act_membership.cfm">
	<!--- If product is a gift certificate, generate new code --->
	<cfelseif qry_get_basket.prod_type is "certificate">
		<cfinclude template="post_processing/act_giftcert.cfm">
	</cfif>

	<!--- If product was purchased from a Gift Registry, process it --->
	<cfinclude template="post_processing/act_giftRegistry.cfm">

</cfloop>


