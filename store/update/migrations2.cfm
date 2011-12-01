
<cfquery name="MoveOptChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE Order_Items 
SET OptChoice = OptQuant
</cfquery>

<cfquery name="UpdOptQuant" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE Order_Items 
SET OptQuant = (SELECT P.OptQuant FROM Products P
		WHERE P.Product_ID = Order_Items.Product_ID)
WHERE EXISTS (SELECT P.OptQuant FROM Products P
		WHERE P.Product_ID = Order_Items.Product_ID)
</cfquery>

<cfquery name="UpdUsers" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE Users 
SET LastUpdate = Created, 
CardisValid = isActive
</cfquery>

<cfquery name="UpdUsers" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE Users 
SET Affiliate_ID = 0
WHERE Affiliate_ID IS NULL
</cfquery>

<cfquery name="GetUsers" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT User_ID, Password, CardNumber FROM Users
</cfquery>

<cfloop query="GetUsers">
	<!--- Check if this user has a credit card. --->
	<cfif isNumeric(GetUsers.CardNumber) AND len(GetUsers.CardNumber) GT 9>
		<!--- Encrypt the card number --->
		<cfmodule template="../customtags/crypt.cfm" string="#GetUsers.CardNumber#" key="#Request.encrypt_key#">
		<cfset EncryptedCard = crypt.value>
		<cfset Cardnum = "XXXXXXXXXXXX#right(GetUsers.cardnumber,4)#">
	<cfelse>
		<cfset EncryptedCard = "">
		<cfset Cardnum = GetUsers.cardnumber>
	</cfif>
	
	<cfquery name="UpdUsers" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE Users
	SET Password = '#Hash(GetUsers.Password)#',
	Cardnumber = '#Cardnum#',
	EncryptedCard = '#EncryptedCard#'
	WHERE User_ID = #GetUsers.User_ID#
	</cfquery>	
	
</cfloop>


<!--- Migrate the standard product option choices --->
<cfquery name="GetStdOptions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Std_ID, Std_Option_List, Std_Price_List, Std_Weight_List
FROM StdOptions
</cfquery>

<cfloop query="GetStdOptions">
	<cfset Choices = GetStdOptions.Std_Option_List>
	<cfset Prices = GetStdOptions.Std_Price_List>
	<cfset Weights = GetStdOptions.Std_Weight_List>
	<cfset NumChoices = ListLen(Choices, "^")>
	
	<cfloop index="num" from="1" to="#NumChoices#">
		<cfquery name="AddChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO StdOpt_Choices
		(Std_ID, Choice_ID, ChoiceName, Price, Weight, Display, SortOrder)
		VALUES
		(#GetStdOptions.Std_ID#, #num#, '#ListGetAt(Choices, num, "^")#', 
		#ListGetAt(Prices, num, "^")#, #ListGetAt(Weights, num, "^")#, 1, #num#)
		</cfquery>	
	</cfloop>

</cfloop>

<!--- Migrate the product options --->
<cfquery name="GetOptions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM ProdOptions
</cfquery>

<cfloop query="GetOptions">
	<cfset Choices = GetOptions.Option_List>
	<cfset Prices = GetOptions.Price_List>
	<cfset Weights = GetOptions.Weight_List>
	<cfset SKUs = GetOptions.SKU_List>
	<cfset Quants = GetOptions.Quant_List>
	<cfset DisplayList = GetOptions.OnOff_List>
	<cfset NumChoices = ListLen(Choices, "^")>
	<cfset NumSKUs = ListLen(SKUs, "^")>
	<cfset OptQuant = 0>
	
	<!--- Create the Product Option First --->
	<cftransaction isolation="SERIALIZABLE">					
		<cfquery name="InsertOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Product_Options
			(Product_ID, Std_ID, Prompt, OptDesc, ShowPrice, Display, Priority, TrackInv, Required)
		VALUES
			(#GetOptions.Product_ID#, #GetOptions.Standard_ID#, 			
			<cfif len(GetOptions.Prompt)>'#GetOptions.Prompt#',<cfelse>NULL,</cfif>
			<cfif len(GetOptions.OptDesc)>'#GetOptions.OptDesc#',<cfelse>NULL,</cfif>
			<cfif len(GetOptions.ShowPrice)>'#GetOptions.ShowPrice#',<cfelse>NULL,</cfif>
			#GetOptions.Display#, #GetOptions.Priority#, 
			#iif(ListLen(Quants, "^"), 1, 0)#, 
			<cfif len(GetOptions.Required)>#GetOptions.Required#<cfelse>0</cfif>)
		</cfquery>	
		
		<cfquery name="getNewID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT MAX(Option_ID) AS newid 
			FROM #Request.DB_Prefix#Product_Options
		</cfquery>
	
		<cfset new_id = getNewID.newid>

	</cftransaction>
	
	<!--- Add custom product options --->
	<cfif NumChoices GT 0>
		<cfloop index="num" from="1" to="#NumChoices#">
			<cfset SKU = ListGetAt(SKUs, num, "^")>
			<cfif ListLen(Quants, "^")>
				<cfset NuminStock = ListGetAt(Quants, num, "^")>
				<cfset OptQuant = new_id>
			<cfelse>
				<cfset NuminStock = "">
			</cfif>
			
			<cfquery name="AddChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO ProdOpt_Choices
			(Option_ID, Choice_ID, ChoiceName, Price, Weight, SKU, NumInStock, Display, SortOrder)
			VALUES
			(#new_id#, #num#, '#ListGetAt(Choices, num, "^")#', 
			#ListGetAt(Prices, num, "^")#, #ListGetAt(Weights, num, "^")#, 
			<cfif SKU IS NOT 0>'#SKU#',<cfelse>NULL,</cfif>
			#iif(isNumeric(NuminStock), NuminStock, 0)#,
			#ListGetAt(DisplayList, num, "^")#, #num#)
			</cfquery>	
		</cfloop>
	
	<!--- Add standard product options --->
	<cfelseif ListGetAt(SKUs, 1, "^") IS NOT 0 OR ListLen(Quants, "^")>
		<cfloop index="num" from="1" to="#NumSKUs#">
			<cfset SKU = ListGetAt(SKUs, num, "^")>
			<cfif ListLen(Quants, "^")>
				<cfset NuminStock = ListGetAt(Quants, num, "^")>
				<cfset OptQuant = new_id>
			<cfelse>
				<cfset NuminStock = "">
			</cfif>
			
			<cfquery name="AddChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO ProdOpt_Choices
			(Option_ID, Choice_ID, ChoiceName, Price, Weight, SKU, NumInStock, Display, SortOrder)
			VALUES
			(#new_id#, #num#, NULL, 0, 0, 
			<cfif SKU IS NOT 0>'#SKU#',<cfelse>NULL,</cfif>
			#iif(isNumeric(NuminStock), NuminStock, 0)#,
			#ListGetAt(DisplayList, num, "^")#, #num#)
			</cfquery>	
		</cfloop>
	
	</cfif>

	<!--- Update the product OptQuant values --->
	<cfif OptQuant IS NOT 0>
		<cfquery name="UpdProducts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE Products
			SET OptQuant = #OptQuant#
			WHERE Product_ID = #GetOptions.Product_ID#
		</cfquery>
	
		<cfquery name="UpdOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE Order_Items
			SET OptQuant = #OptQuant#
			WHERE Product_ID = #GetOptions.Product_ID#
		</cfquery>
	</cfif>
	
</cfloop>

<!--- Remove any products in the wishlist that are not in the database --->
<cfquery name="RemoveProducts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM WishList
	WHERE Product_ID NOT IN (SELECT Product_ID FROM Products)
</cfquery>

<!--- Add the new foreign key restraint --->
<cfquery name="AddKey" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE WishList ADD CONSTRAINT Products_WishList_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID)
</cfquery>