
<!--- Get Settings --->
<cfinclude template="../shopping/qry_ship_settings.cfm">
<cfinclude template="../shopping/qry_get_order_settings.cfm">
<cfinclude template="../queries/qry_getsettings.cfm">

<!--- Get Payment Settings --->
<cfquery name="GetPaymentSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT * FROM CCProcess
</cfquery>

<!--- Check if the merchant is using PayPal --->
<cfif get_Order_Settings.CCProcess IS "PayPal">
	<cfset UsePayPal = 1>
	<cfset PayPalEmail = GetPaymentSettings.CCMerchantPassword>
	<cfset PayPalLog = iif(GetPaymentSettings.UniqueID IS "Yes", 1, 0)>
<cfelse>
	<cfset UsePayPal = 0>
	<cfset PayPalEmail = ''>
	<cfset PayPalLog = 0>
</cfif>


<cfquery name="Update1" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE OrderSettings SET
	CCProcess = 'PayFlowPro'
	WHERE CCProcess = 'PaymentNet'
</cfquery>

<cfquery name="Update2" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE OrderSettings SET
	ShowBasket = #Request.AppSettings.ShowBasket#,
	UsePayPal = #UsePayPal#,
	PayPalEmail = '#PayPalEmail#',
	PayPalLog = #PayPalLog#,
	AllowPO = 0,
	SkipAddressForm = 0,
	Giftwrap = 0
</cfquery>

<cfquery name="UserSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE UserSettings SET
	MaxFailures = 5,
	RequireCounty = 0,
	StrictLogins = 0,
	MemberNotify = 1,
	UseResidential = 0,
	MaxDailyLogins = 0,
	AllowAffs = #Request.AppSettings.AllowAffs#,
	AffPercent = #Request.AppSettings.AffPercent#,
	AllowWholesale = #Request.AppSettings.AllowWholesale#
</cfquery>

<cfquery name="OrphanWishListProds" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM WishList
	WHERE Product_ID NOT IN (SELECT Product_ID FROM Products)
</cfquery>

<!--- Add New Pages --->
<cftransaction isolation="SERIALIZABLE">

<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	SELECT MAX(Page_ID) AS maxid 
	FROM #Request.DB_Prefix#Pages
</cfquery>
	
<cfset attributes.Page_ID = get_id.maxid + 1>
<cfquery name="Add_Record" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#Pages
		(Page_ID, Page_URL, CatCore_ID, PassParam, Display, PageAction, Page_Name, Page_Title, Sm_Image,
		Lg_Image, Sm_Title, Lg_Title, Color_ID, PageText, System, Href_Attributes, AccessKey, Priority, 
		Parent_ID, Title_Priority, Metadescription, Keywords,TitleTag )
	VALUES ( #attributes.Page_ID#,
		'index.cfm?fuseaction=shopping.tracking',0,NULL,0,'tracking',
		'track order','',NULL,NULL,NULL,NULL,NULL,'',0,NULL,0,4,0,0,NULL,NULL,NULL)
	</cfquery>
	
<cfset attributes.Page_ID = attributes.Page_ID + 1>
	<cfquery name="Add_Record2" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#Pages
		(Page_ID, Page_URL, CatCore_ID, PassParam, Display, PageAction, Page_Name, Page_Title, Sm_Image,
		Lg_Image, Sm_Title, Lg_Title, Color_ID, PageText, System, Href_Attributes, AccessKey, Priority, 
		Parent_ID, Title_Priority, Metadescription, Keywords,TitleTag )
	VALUES (#attributes.Page_ID#,
		'index.cfm?fuseaction=shopping.giftregistry',0,NULL,0,'giftregistry',
		'gift registry','',NULL,NULL,NULL,NULL,NULL,'',0,NULL,0,4,0,0,NULL,NULL,NULL)
	</cfquery>

<cfset attributes.Page_ID = attributes.Page_ID + 1>
	<cfquery name="Add_Record3" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#Pages
		(Page_ID, Page_URL, CatCore_ID, PassParam, Display, PageAction, Page_Name, Page_Title, Sm_Image,
		Lg_Image, Sm_Title, Lg_Title, Color_ID, PageText, System, Href_Attributes, AccessKey, Priority, 
		Parent_ID, Title_Priority, Metadescription, Keywords,TitleTag )
	VALUES (#attributes.Page_ID#,
		'index.cfm?fuseaction=page.pagenotfound',0,'noline=1',0,'PageNotFound',
		'Page Error','Page Not Found',NULL,NULL,NULL,NULL,NULL,'<sup>Sorry, the item you are looking for was not found.<br/><br/>Please try Searching or The Site Map for assistance.<br/><br /></sup>',1,NULL,0,9999,0,0,NULL,NULL,NULL)
	</cfquery>
	
<cfset attributes.Page_ID = attributes.Page_ID + 1>
	<cfquery name="Add_Record3" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#Pages
		(Page_ID, Page_URL, CatCore_ID, PassParam, Display, PageAction, Page_Name, Page_Title, Sm_Image,
		Lg_Image, Sm_Title, Lg_Title, Color_ID, PageText, System, Href_Attributes, AccessKey, Priority, 
		Parent_ID, Title_Priority, Metadescription, Keywords,TitleTag )
	VALUES (#attributes.Page_ID#,
		'index.cfm?fuseaction=page.nocookies',0,'noline=1',0,'nocookies',
		'No Cookies','Cookies Required!',NULL,NULL,NULL,NULL,NULL,'<p>This site requires cookies in order to shop and to checkout. This is the safest and most secure way to conduct online business so is done for your safety and convenience. Please check your browser settings and ensure that you have set it to allow cookies.</p><br/><br /></sup>',1,NULL,0,9999,0,0,NULL,NULL,NULL)
	</cfquery>
	
</cftransaction>

<!--- Make sure the System setting is not null --->
<cfquery name="UpdSyste" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
UPDATE Pages 
SET System = 0
WHERE System IS NULL
</cfquery>

<!--- Update the Tax Settings in the store --->
<cfquery name="ProdTaxes" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
UPDATE Products 
SET TaxCodes = 1
WHERE Tax <> 0
</cfquery>
		
<!--- Move State Taxes --->
<cfquery name="GetStateTaxes" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
SELECT * FROM Taxes
</cfquery>

<cfloop query="GetStateTaxes">
	<cfquery name="AddStateTaxes" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	INSERT INTO StateTax
	(Code_ID, State, TaxRate, TaxShip)
	VALUES
	(1, '#GetStateTaxes.State#', #GetStateTaxes.Rate#, #GetStateTaxes.TaxShip#)
	</cfquery>
</cfloop>

<!--- Move Country Tax --->
<cfif ListGetAt(ShipSettings.BaseTax, 1) IS NOT 0>
	<cfquery name="GetCountryID" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	SELECT ID FROM Countries
	WHERE Abbrev = '#ListGetAt(Request.AppSettings.HomeCountry, 1, "^")#'
	</cfquery>

	<cfquery name="AddCountryTax" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	INSERT INTO CountryTax
	(Code_ID, Country_ID, TaxRate, TaxShip)
	VALUES
	(1, #GetCountryID.ID#, #ListGetAt(ShipSettings.BaseTax, 1)#, #ListGetAt(ShipSettings.BaseTax, 2)#)
	</cfquery>
</cfif>

<!--- Move Order Taxes --->
<cfquery name="GetOrders" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	SELECT Order_No, OrderTotal, Tax, Shipping, OrderDisc, Credits
	FROM Order_No
	WHERE Tax <> 0
</cfquery>

<cfloop query="GetOrders">
	<cfset ProdTotal = GetOrders.OrderTotal - GetOrders.Tax - GetOrders.Shipping + GetOrders.OrderDisc + GetOrders.Credits>
	<cfquery name="AddOrderTax" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		INSERT INTO OrderTaxes
		(Order_No, Code_ID, ProductTotal, CodeName, AddressUsed, AllUserTax, StateTax, CountyTax, LocalTax, CountryTax)
		VALUES
		(#GetOrders.Order_No#, 1, #ProdTotal#, 'Taxes', NULL, #GetOrders.Tax#, 0, 0, 0, 0)
	</cfquery>
</cfloop>

<!--- Move Product Custom Fields --->
<cfquery name="GetCustom" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
SELECT * FROM CustomNames
</cfquery>

<cfset CustomIDList = "">

<cfloop index="num" from="1" to="6">
	<cfif Len(Evaluate("GetCustom.Custom#num#_Name")) AND Evaluate("GetCustom.Custom#num#_Use")>
		<cfquery name="AddCustomField" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		INSERT INTO Prod_CustomFields
		(Custom_ID, Custom_Name, Custom_Display, Google_Use, Google_Code)
		VALUES
		(#num#, '#Evaluate("GetCustom.Custom#num#_Name")#', #Evaluate("GetCustom.Custom#num#_Display")#, 0, NULL)
		</cfquery>
		<cfset CustomIDList = ListAppend(CustomIDList,num)>
	</cfif>
</cfloop>

<cfquery name="GetProdCustom" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
SELECT * FROM ProdCustom
</cfquery>

<cfloop query="GetProdCustom">
	<cfloop index="num" from="1" to="6">
		<cfif Len(Evaluate("GetProdCustom.Custom#num#")) AND ListFind(CustomIDList,num)>
			<cfquery name="AddCustomInfo" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			INSERT INTO Prod_CustInfo
			(Product_ID, Custom_ID, CustomInfo)
			VALUES
			(#GetProdCustom.Product_ID#, #num#, '#Evaluate("GetProdCustom.Custom#num#")#')
			</cfquery>
		</cfif>
	</cfloop>
</cfloop>

<!--- Move Orders to new table --->
<cfquery name="GetOrders" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
SELECT * FROM Orders
Order By Order_No
</cfquery>

<cfset CurrOrderNo = 0>
<cfset ItemNum = 0>

<cfloop query="GetOrders">
	<!--- Check if this is a new order number --->
	<cfif GetOrders.Order_No IS NOT CurrOrderNo>
		<cfset CurrOrderNo = GetOrders.Order_No>
		<cfset ItemNum = 0>
	</cfif>
	<!--- Increment the item number --->
	<cfset ItemNum = ItemNum + 1>
	
	<cfquery name="AddItems" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		INSERT INTO Order_Items
		(Item_ID, Order_No, Product_ID, Options, Addons, AddonMultP, AddonNonMultP, Price, Quantity, OptPrice, SKU, OptQuant,
		 OptChoice, DiscAmount, Disc_Code, PromoAmount, PromoQuant, Promo_Code, Name, Dropship_Account_ID, Dropship_Qty, 
		 Dropship_Cost, Dropship_SKU, Dropship_Note)
		 VALUES
		 (#ItemNum#, #CurrOrderNo#, #GetOrders.Product_ID#, 
		 <cfif len(GetOrders.Options)>'#GetOrders.Options#',<cfelse>NULL,</cfif>
		 <cfif len(GetOrders.Addons)>'#GetOrders.Addons#',<cfelse>NULL,</cfif>
		 #GetOrders.AddonMultP#,  #GetOrders.AddonNonMultP#, #GetOrders.Price#, #GetOrders.Quantity#, 0, 
		 <cfif len(GetOrders.SKU)>'#GetOrders.SKU#',<cfelse>NULL,</cfif>
		 #GetOrders.OptQuant#, 0, #GetOrders.DiscAmount#, NULL, 0, 0, NULL, 
		 <cfif len(GetOrders.Name)>'#GetOrders.Name#',<cfelse>NULL,</cfif>
		 <cfif isNumeric(GetOrders.Dropship_Account_ID)>#GetOrders.Dropship_Account_ID#,<cfelse>NULL,</cfif>
		 #GetOrders.Dropship_Qty#, 
		 <cfif len(GetOrders.Dropship_Cost)>#GetOrders.Dropship_Cost#,<cfelse>0,</cfif>
		 <cfif len(GetOrders.Dropship_SKU)>'#GetOrders.Dropship_SKU#',<cfelse>NULL,</cfif>
		 <cfif len(GetOrders.Dropship_Note)>'#GetOrders.Dropship_Note#'<cfelse>NULL</cfif> )	 
	</cfquery>

</cfloop>

<!--- Check if this store uses custom shipping methods. If so, migrate them over to the new CustomMethods table --->
<cfif NOT ListFind('UPS,FedEx,USPS,Intershipper',ShipSettings.ShipType)>
	<!--- Turn off the new Custom Methods --->
	<cfquery name="UpdateMethods" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	UPDATE CustomMethods
	SET Used = 0
	</cfquery>
	
	<cfquery name="GetMethods" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		SELECT * FROM ShipTypes
		WHERE Used <> 0
	</cfquery>
	
	<cfloop query="GetMethods">
		<cfquery name="AddMethods" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			INSERT INTO CustomMethods
			(Name, Amount, Used, Priority, Domestic, International)
			VALUES
			('#GetMethods.Name#', #GetMethods.Amount#, #GetMethods.Used#, 0, 1, 1)
		</cfquery>	
	</cfloop>

</cfif>


<!--- Check if this store uses UPS methods. If so, update the methods currently turned on. --->
<cfif ShipSettings.ShipType IS 'UPS'>
	<cfquery name="GetMethods" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		SELECT Code FROM ShipTypes
		WHERE Used <> 0
		AND Shipper = 'UPS'
	</cfquery>
	
	<cfloop query="GetMethods">
		<cfquery name="UpdMethods" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			UPDATE UPSMethods
			SET Used = 1
			WHERE USCode = '#GetMethods.Code#'
		</cfquery>	
	</cfloop>
	
	<cfquery name="SetOrigin" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
	UPDATE UPS_Settings
	SET OrigCountry = '#ListGetAt(Request.AppSettings.HomeCountry, 1, "^")#'
	</cfquery>

</cfif>

<!--- Check if this store uses USPS methods. If so, update the methods currently turned on. --->
<cfif ShipSettings.ShipType IS 'USPS'>
	<cfquery name="GetMethods" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		SELECT Name FROM ShipTypes
		WHERE Used <> 0
		AND Shipper = 'U.S.P.S.'
	</cfquery>
	
	<cfloop query="GetMethods">
		<cfquery name="UpdMethods" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			UPDATE USPSMethods
			SET Used = 1
			WHERE Name = '#GetMethods.Name#'
		</cfquery>	
	</cfloop>
	
	<cfquery name="GetUSPS" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		SELECT * FROM USPS
	</cfquery>
	
	<cfquery name="UpdSettings" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		UPDATE USPS_Settings
		SET UserID = '#GetUSPS.UserID#',
		Server = '#GetUSPS.Server#'
	</cfquery>	

</cfif>