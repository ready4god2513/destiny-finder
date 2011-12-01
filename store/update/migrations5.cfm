
<!--- Removes the unused tables and columns --->

<cfif Request.DBType IS "MSSQL">

<!--- If using MS-SQL, add a view with the list of defaults --->
	<cfquery name="AddView" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	CREATE VIEW Table_Defaults
	AS
	SELECT 	db_name() AS Database_Name,
			t_obj.name AS Table_Name,
			c_obj.name AS Constraint_Name,
			col.name AS Column_Name
	
	FROM	sysobjects	c_obj
	JOIN 	sysobjects	t_obj on c_obj.parent_obj = t_obj.id  
	JOIN    sysconstraints con on c_obj.id	= con.constid
	JOIN 	syscolumns	col on t_obj.id = col.id
				and con.colid = col.colid
	WHERE 	c_obj.xtype	= 'D'
	</cfquery>

	<!--- If MS-SQL, we need to delete the default values before we can drop some columns. 
	To do that, we need to change it first --->
	<cfquery name="FindConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Constraint_Name FROM Table_Defaults
	WHERE Table_Name = 'Products'
	AND Column_Name = 'Processing'
	</cfquery>

	<cfif FindConstraint.recordcount>
	<cfquery name="DropConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	ALTER TABLE Products DROP CONSTRAINT #FindConstraint.CONSTRAINT_NAME#
	</cfquery>
	</cfif>	

	<cfquery name="FindConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Constraint_Name FROM Table_Defaults
	WHERE Table_Name = 'Products'
	AND Column_Name = 'NumAddons'
	</cfquery>
	
	<cfif FindConstraint.recordcount>
	<cfquery name="DropConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	ALTER TABLE Products DROP CONSTRAINT #FindConstraint.CONSTRAINT_NAME#
	</cfquery>
	</cfif>

	<cfquery name="FindConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Constraint_Name FROM Table_Defaults
	WHERE Table_Name = 'Products'
	AND Column_Name = 'NumOptions'
	</cfquery>
	
	<cfif FindConstraint.recordcount>
	<cfquery name="DropConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	ALTER TABLE Products DROP CONSTRAINT #FindConstraint.CONSTRAINT_NAME#
	</cfquery>
	</cfif>
	
	<cfquery name="FindConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Constraint_Name FROM Table_Defaults
	WHERE Table_Name = 'Products'
	AND Column_Name = 'Pass_Thru'
	</cfquery>
	
	<cfif FindConstraint.recordcount>
	<cfquery name="DropConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	ALTER TABLE Products DROP CONSTRAINT #FindConstraint.CONSTRAINT_NAME#
	</cfquery>
	</cfif>
	
	<cfquery name="FindConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Constraint_Name FROM Table_Defaults
	WHERE Table_Name = 'Products'
	AND Column_Name = 'Tax'
	</cfquery>
	
	<cfif FindConstraint.recordcount>
	<cfquery name="DropConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	ALTER TABLE Products DROP CONSTRAINT #FindConstraint.CONSTRAINT_NAME#
	</cfquery>
	</cfif>
	
	<cfquery name="FindConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Constraint_Name FROM Table_Defaults
	WHERE Table_Name = 'Settings'
	AND Column_Name = 'ShowBasket'
	</cfquery>

	<cfif FindConstraint.recordcount>	
	<cfquery name="DropConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	ALTER TABLE Settings DROP CONSTRAINT #FindConstraint.CONSTRAINT_NAME#
	</cfquery>
	</cfif>
	
	<cfquery name="FindConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Constraint_Name FROM Table_Defaults
	WHERE Table_Name = 'Settings'
	AND Column_Name = 'AllowAffs'
	</cfquery>
	
	<cfif FindConstraint.recordcount>
	<cfquery name="DropConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	ALTER TABLE Settings DROP CONSTRAINT #FindConstraint.CONSTRAINT_NAME#
	</cfquery>
	</cfif>
	
	<cfquery name="FindConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Constraint_Name FROM Table_Defaults
	WHERE Table_Name = 'Settings'
	AND Column_Name = 'AffPercent'
	</cfquery>

	<cfif FindConstraint.recordcount>	
	<cfquery name="DropConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	ALTER TABLE Settings DROP CONSTRAINT #FindConstraint.CONSTRAINT_NAME#
	</cfquery>
	</cfif>
	
	<cfquery name="FindConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Constraint_Name FROM Table_Defaults
	WHERE Table_Name = 'UPS_Settings'
	AND Column_Name = 'FuelCharge'
	</cfquery>	
	
	<cfif FindConstraint.recordcount>
	<cfquery name="DropConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	ALTER TABLE UPS_Settings DROP CONSTRAINT #FindConstraint.CONSTRAINT_NAME#
	</cfquery>
	</cfif>
	
	<cfquery name="FindConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Constraint_Name FROM Table_Defaults
	WHERE Table_Name = 'Users'
	AND Column_Name = 'IsActive'
	</cfquery>
	
	<cfif FindConstraint.recordcount>
	<cfquery name="DropConstraint" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	ALTER TABLE Users DROP CONSTRAINT #FindConstraint.CONSTRAINT_NAME#
	</cfquery>
	</cfif>
	
	<cfquery name="DropView" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DROP VIEW Table_Defaults
	</cfquery>

</cfif>

<!--- Now delete the columns and tables --->

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Categories DROP COLUMN Discounts
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE CCProcess DROP COLUMN ICShareDir
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE CCProcess DROP COLUMN CCMerchantPassword
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE CCProcess DROP COLUMN UniqueID
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Discounts DROP COLUMN Users
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Discounts DROP COLUMN Products
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Discounts DROP COLUMN Categories
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Groups DROP COLUMN Discounts
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Intershipper DROP COLUMN Weight
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE IntShipTypes DROP COLUMN Shipper
</cfquery>	


<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Products DROP COLUMN Processing
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Products DROP COLUMN NumOptions
</cfquery>

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Products DROP COLUMN NumAddons
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Products DROP COLUMN Tax
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Products DROP COLUMN Pass_Thru
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Settings DROP COLUMN EncryptionKey
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Settings DROP COLUMN StoreURL
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Settings DROP COLUMN SecureURL
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Settings DROP COLUMN ShowBasket
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Settings DROP COLUMN AllowAffs
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Settings DROP COLUMN AffPercent
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE ShipSettings DROP COLUMN BaseTax
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE StdOptions DROP COLUMN Std_Weight_List
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE StdOptions DROP COLUMN Std_Price_List
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE StdOptions DROP COLUMN Std_Option_List
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE TempCustomer DROP COLUMN GiftCard
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE TempCustomer DROP COLUMN Coupon
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE TempCustomer DROP COLUMN Comments
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE TempCustomer DROP COLUMN Delivery
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE UPS_Settings DROP COLUMN FuelCharge
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE UPS_Settings DROP COLUMN Location
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
ALTER TABLE Users DROP COLUMN IsActive
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
DROP TABLE CustomNames
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
DROP TABLE Orders
</cfquery>	

<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
DROP TABLE ProdCustom
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
DROP TABLE ProdOptions
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
DROP TABLE ShipTypes
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
DROP TABLE Taxes
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
DROP TABLE UPS_CanadaZones
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
DROP TABLE UPSZones
</cfquery>	
	
<cfquery name="Deletions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
DROP TABLE USPS
</cfquery>	
