
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template bills all recurring memberships. 
	- It can bill a single membership or daily batch.
	- It can charge the card or create an Offline order 
---->

<cfinclude template="../../../shopping/qry_get_order_settings.cfm">
<cfinclude template="../../../shopping/qry_ship_settings.cfm">
<cfinclude template="../../../users/qry_get_user_settings.cfm">

<cfparam name="attributes.membership_ID" default="">
<cfparam name="attributes.offline" default="0">
<cfset attributes.Error_Message = "">

<!--- Number of hours between the scheduled tasks running to check for renewals --->
<cfparam name="run_interval" default="24">

<!--- Get a list of all RECURRING memberships that: 
	1) are the Membership ID
	2) have expired OR are expiring today 
	3) who have an ACTIVE and UNEXPIRED credit card on file
---->

<!---- NOTE: The following query excludes users without a customer record. A customer record of 0 will cause an error in the payment processing when it passes the country name. The code uses a listLast() function that will not take a null. This could be written in the future to allow user billing without a customer record. --->
<cfquery name="Membership_list" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT M.*, U.*
	FROM #Request.DB_Prefix#Memberships M 
	INNER JOIN #Request.DB_Prefix#Users U ON M.User_ID = U.User_ID 
	WHERE  M.Recur = 1
		AND U.Customer_ID <> 0
	<cfif len(attributes.membership_ID)>
		AND M.Membership_ID = #attributes.membership_ID#
	<cfelse>
		AND M.Expire <= #CreateODBCDate(DateAdd("h",run_interval,Now()))#
		AND M.Valid = 1
	</cfif>
	<cfif NOT attributes.offline>
		AND U.CardisValid = 1
		AND U.CardExpire IS NOT NULL
	</cfif>
</cfquery>


<!--- Go through the list ---->
<cfif Membership_list.recordcount>

	<cfset BatchAbort = "NO">

	<!--- Loop through the query --->
	<cfloop query="Membership_list">

		<cfset attributes.step = "">
		<cfset User_ID = Membership_list.User_ID>
		<cfset attributes.User_ID = Membership_list.User_ID>
	
		<!--- Get Queries required to write orders ---->
		<cfquery name="GetCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT C.* FROM #Request.DB_Prefix#Customers C
		WHERE Customer_ID = #Customer_ID#
		</cfquery>
		
		<cfset attributes.Customer_ID = GetCustomer.Customer_ID>

		<cfquery name="GetShipTo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#Customers
		WHERE Customer_ID = #ShipTo#
		</cfquery>
		
		<!--- Check if this Membership renewal is not a trial and has an order available ---->
		<cfif Membership_list.Recur_Product_ID IS 0 AND isNumeric(Membership_list.Order_ID) AND Membership_list.Order_ID IS NOT 0>
			
			<cfquery name="GetTotals" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT OrderTotal, 0 as AddonTotal, 0 as OrderDisc, Tax, ShipType, Shipping, Affiliate,
			0 as Credits, '' as GiftCard, '' as Delivery, '' as Comments
			FROM #Request.DB_Prefix#Order_No
			WHERE Order_No = #Membership_list.Order_ID#
			</cfquery>
			
			<cfquery name="qry_Get_Basket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT OI.Product_ID, OI.Name, OI.SKU, OI.Price, 1 as Quantity, P.TaxCodes,
				OI.Options, NULL as Addons, OI.OptPrice, 0 as DiscAmount, 0 as AddonMultP, 
				0 as PromoQuant, 0 as PromoAmount, 0 as QuantDisc
			FROM #Request.DB_Prefix#Order_Items OI
			LEFT JOIN #Request.DB_Prefix#Products P ON OI.Product_ID = P.Product_ID
			WHERE OI.Order_No = #Membership_list.Order_ID#
			AND OI.Product_ID = #Membership_list.Product_ID#
			</cfquery>
		
		<cfelse>	
			
			<cfquery name="GetTotals" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT Product_ID, Base_Price as OrderTotal, 0 as AddonTotal, 0 as OrderDisc, 
				0 as Tax, 'No Shipping' as ShipType, 0 as Shipping, 0 as Credits, 0 as Affiliate,
				'' as GiftCard, '' as Delivery, '' as Comments
			FROM #Request.DB_Prefix#Products 
			WHERE Product_ID = #iif(Membership_list.Recur_Product_ID gt 0, Membership_list.Recur_Product_ID, Membership_list.Product_ID)#
			</cfquery>
			
			<cfquery name="qry_Get_Basket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT Product_ID, Name, SKU, Base_Price as Price, 1 as Quantity, TaxCodes,
				NULL as Options, NULL as Addons, 0 as OptPrice, 0 as DiscAmount, 0 as AddonMultP, 
				0 as PromoQuant, 0 as PromoAmount, 0 as QuantDisc
			FROM #Request.DB_Prefix#Products 
			WHERE Product_ID = #GetTotals.Product_ID#
			</cfquery>
		</cfif>
		
		<cfscript>
		//check if there are tax codes for the product
		if (len(qry_Get_Basket.TaxCodes)) {
			TaxTotals = Application.objCheckout.getTaxCodes();
			// loop through the tax codes and add the product amount to the totals if found in the list
			for(i=1; i lte ArrayLen(TaxTotals); i=i+1) {
				if (ListFind(qry_Get_Basket.TaxCodes, TaxTotals[i].Code_ID)) 
					TaxTotals[i].ProdTotal = qry_Get_Basket.Price;
			}
			
			//process the customer addresses
			CustAddress = Application.objCheckout.doCustomerAddress(GetCustomer, GetShipTo);
			//calculate the order tax
			arrTaxTotals = Application.objCheckout.calcOrderTax(TaxTotals, CustAddress, 0);
			//loop through the array and total up the taxes
			Tax = 0;
			for (i=1; i lte ArrayLen(arrTaxTotals); i=i+1) 
				Tax = Tax + arrTaxTotals[i].TotalTax;
				
		}
		else {
			Tax = 0;
		}
		
		</cfscript>
		
		<!--- Update Tax Amount --->
		<cfset QuerySetCell(GetTotals, "Tax", Tax)>
	
		<cfset Total = GetTotals.OrderTotal + Tax>
		<cfset ShipCost = 0>
			
		
	<!--- Charge the Card if the Total > 0 AND not an offline order ---->
	 <cfif Total AND NOT attributes.offline>
	
		<cfset attributes.CardType = CardType>
		<cfset attributes.NameonCard = NameonCard>
		<cfset month = DateFormat(CardExpire,"MM")>
		<cfset year = DateFormat(CardExpire,"YY")>
		<cfset cardexp = "#Month#" & "/" & "#Year#">
		
		<!--- Decrypt the card number --->		
		<cfmodule template="../../../customtags/crypt.cfm" string="#EncryptedCard#" key="#Request.encrypt_key#" action="de">
		<cfset attributes.CardNumber = crypt.value>
				
		<!----						
		<cfoutput>
			Total: #GetTotals.OrderTotal#<br/>
			month: #month#<br/>
			year: #year#<br/>
			cardexp: #cardexp#<br/>
			adddr: #GetCustomer.Address1#<br/>
		</cfoutput>
		---------------->
		
		 	<cfif get_Order_Settings.CCProcess IS "CyberCash2">
	 			<cfinclude template="../../../shopping/checkout/creditcards/act_cybercash.cfm">

			<cfelseif get_Order_Settings.CCProcess IS "CyberCashDP">
				<cfinclude template="../../../shopping/checkout/creditcards/act_cybercash3.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "ONCR_CyberCash">
				<cfinclude template="../../../shopping/checkout/creditcards/act_cybercash2.cfm">
		
			<cfelseif get_Order_Settings.CCProcess IS "AuthorizeNet3">
				<cfinclude template="../../../shopping/checkout/creditcards/act_authnet3.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "Paymentnet">
				<cfinclude template="../../../shopping/checkout/creditcards/act_payflowpro.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "LinkPoint">
				<cfinclude template="../../../shopping/checkout/creditcards/act_linkpoint.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "EZIC">
				<cfinclude template="../../../shopping/checkout/creditcards/act_ezic.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "Shift4OTN">
				<cfinclude template="../../../shopping/checkout/creditcards/act_shift4otn.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "Skipjack">
				<cfinclude template="../../../shopping/checkout/creditcards/act_skipjack.cfm">
			
			<cfelseif get_Order_Settings.CCProcess IS "Skypay">
				<cfinclude template="../../../shopping/checkout/creditcards/act_skypay.cfm">
	
			<cfelseif get_Order_Settings.CCProcess IS "bankofamerica">
				<cfinclude template="../../../shopping/checkout/creditcards/act_bankofamerica.cfm">
				
			<cfelseif get_Order_Settings.CCProcess IS "USAepay">
				<cfinclude template="../../../shopping/checkout/creditcards/act_usaepay.cfm">

		</cfif> 

		</cfif>
		
		<cfparam name="AuthNumber" default="0">
		
		<!--- If a credit card transaction failed, mark the card as inactive 
		and add a note to user record. Do not create order. --->
		<cfif NOT attributes.offline AND attributes.step is not "receipt">
			<cfif BatchAbort>
				<cfparam name="ErrorMessage" default="">
				<cfif attributes.Error_Message is "">
					<cfset attributes.Error_Message = ErrorMessage>
				</cfif>
				<cfif attributes.Error_Message is "">
					<cfset attributes.Error_Message = "OOPS! Batch process aborted because BatchAbort was set but neither ErrorMessage or attributes.Error_Message was set.">
				</cfif>
<cfmail to="#request.appsettings.merchantemail#" from="#request.appsettings.merchantemail#" 
	subject="#request.appsettings.sitename# Recurring Payment Batch Process Failure" 
	server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
The Automatic Rebill process was aborted do to the following:

#attributes.Error_Message#


Record being processed:

User: #username#
Membership: #Membership_ID# 

Product: #qry_Get_Basket.Name#
Amount: #Total#
</cfmail>
				<cfbreak>
			</cfif>
		
			<cfquery name="User_BadCard" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users 
			SET 
			CardisValid = 0,
			AdminNotes = '#dateformat(now(),"mm/dd/yy")#: Autobill TX failed. Card marked inactive.  #AdminNotes#'
			WHERE User_ID = #User_ID#
			</cfquery>		
			
			<!---- Send an Email ---->
<cfmail to="#request.appsettings.merchantemail#" from="#request.appsettings.merchantemail#" 
	subject="#request.appsettings.sitename# Recurring Payment Failure on Membership #membership_ID#" 
	server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
The Automatic Rebill of the following Membership failed:

User: #username#
Membership: #Membership_ID# 

Product: #qry_Get_Basket.Name#
Amount: #Total#

The card on file has been marked as inactive.
</cfmail>

			<cfoutput>Membership ###Membership_ID# was not renewed due to a failure billing the credit card.<br/></cfoutput>
			
						
		<cfelse>
		<!--- OK to save order to database. ---->
		
			<cfset r = Randomize(Minute(now())&Second(now()))>  
			<cfparam name="randomnum" default="#RandRange(1000,9999)#">
			<cfset NewIDTag = CreateUUID()>
			<!--- Remove dashes --->
			<cfset NewIDTag = Replace(NewIDTag, "-", "", "All")>
				
			<!--- Write CardData to database if online order ---->
			<cfif NOT attributes.offline>

				<!--- If credit-card order, add card number to database --->
				<cfif get_Order_Settings.storecardinfo>
					<!--- Run encryption on the card number --->
					<cfparam name="attributes.SaveCardNumber" default="#attributes.CardNumber#">
					<cfmodule template="../../../customtags/crypt.cfm" string="#attributes.SaveCardNumber#" key="#Request.encrypt_key#">
				</cfif>

				<cftransaction>	
					<cfquery name="GetCardNo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					<cfif Request.dbtype IS "MSSQL">
						SET NOCOUNT ON
					</cfif>		
					INSERT INTO #Request.DB_Prefix#CardData 
					(ID_Tag, Customer_ID, CardType, NameonCard, CardNumber, Expires, EncryptedCard)
					VALUES 
					(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NewIDTag#">,
					<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#customer_ID#">, 
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
	
				<cfset Card_No = GetCardNo.newCard_No>
				<cfset paid = 1>
				<cfset membership_valid = 1>
						
			<cfelse>
			
				<cfset Card_No = 0>
				<cfset paid = 0>
				<cfset membership_valid = 0>
				
			</cfif>
			
			<cfset InvoiceNum = Replace(CGI.REMOTE_ADDR,".","","ALL") & randomnum>
			<cfparam name="TransactNum" default="">
			<cfparam name="Notes" default="Auto-Renewal of Membership">
			

<!--- Enter order in the database --->
<cftransaction>
	<cfquery name="GetOrderNo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">		
	<cfif Request.dbtype IS "MSSQL">
		SET NOCOUNT ON
	</cfif>
	INSERT INTO #Request.DB_Prefix#Order_No
	(ID_Tag, Customer_ID, User_ID, Card_ID, ShipTo, DateOrdered, OrderTotal, Tax, Shipping, Freight, ShipType, Comments, AuthNumber,
	InvoiceNum, TransactNum, Notes, Affiliate, Referrer, OrderDisc, Credits, AddonTotal, Coup_Code, Cert_Code, 
	Filled, Paid, Process, Void, PayPalStatus, Reason, OfflinePayment)
	
	VALUES (
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NewIDTag#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Customer_ID#">, 
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#User_ID#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Card_No#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ShipTo#">,
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#Total#">,
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#Tax#">,
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="0">,
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="0">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="No Shipping">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AuthNumber#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#InvoiceNum#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#TransactNum#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Notes#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="0">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Unknown">,
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="0">,
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="0">,
	<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="0">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="" null="Yes">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="" null="Yes">,
	<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="0">,
	<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#paid#">,
	<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="0">,
	<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="0">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="AutoRebill">
	)
	
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
	<cfset application.objCheckout.saveOrderTaxes(arrTaxTotals, New_OrderNo)>

</cfif>	

	<cfquery name="AddOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#Order_Items
		(Item_ID, Order_No, Product_ID, Name, SKU, Options, Addons, AddonMultP, AddonNonMultP,
		Price, Quantity, DiscAmount, Disc_Code, PromoAmount, PromoQuant, Promo_Code,
		OptQuant, OptChoice, OptPrice, Dropship_Account_ID, Dropship_Qty, Dropship_Cost, Dropship_SKU)

	VALUES 
		(1, #New_OrderNo#, #qry_get_basket.Product_ID#, 
		<cfif len(qry_get_basket.Name)>'#qry_get_basket.Name#',<cfelse>NULL,</cfif>
		<cfif len(qry_get_basket.SKU)>'#qry_get_basket.SKU#',<cfelse>NULL,</cfif>
		NULL, NULL, 0, 0, 
		#qry_get_basket.Price#, 
		1, 0, NULL, 0, 0, NULL,
		0, 0, 0, NULL, 0, 0, NULL)
	</cfquery>

	<cfset offlinePayment = "">

	<cfinclude template="../../../shopping/checkout/post_processing/act_membership.cfm">
					
	<!--- Send Email to Member 	
	<cfif offlinePayment is "Online">	
		<cftry>
			<cfmodule template="../../../#self#"
			fuseaction="users.admin"
			email="auto"
			MailAction="MembershipAutoRenewBilled"
			UN="#User_ID#"
			>
			<cfcatch type="ANY">
			</cfcatch>
		</cftry>				
	</cfif>		--->		
			
					
		<cfinclude template="../../../shopping/checkout/post_processing/act_mailorder.cfm">		
					
		</cfif><!--- tx good --->
		
		<cfoutput>Membership ###Membership_ID# was successfully renewed.<br/></cfoutput>
			
	</cfloop>

<cfelse>

	<!--- If no memberships found, set error message. --->
	<cfset attributes.Error_Message = "OOPS! No memberships found">
	<cfoutput>No recurring memberships needing to be renewed were found.<br/></cfoutput>

</cfif><!--- memberships recordcount --->


<cfsetting enablecfoutputonly="no">
