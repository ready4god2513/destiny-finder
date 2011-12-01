BEGIN TRANSACTION

CREATE TABLE "AccessKeys"
(
	"AccessKey_ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(50) NOT NULL ,
	"Keyring" nvarchar(50) NULL ,
	"System" bit NOT NULL DEFAULT 0
)

ALTER TABLE "AccessKeys" ADD
	CONSTRAINT "AccessKey_PK" PRIMARY KEY CLUSTERED  ("AccessKey_ID")

	;
CREATE TABLE "Account"
(
	"Account_ID" int IDENTITY NOT NULL ,
	"User_ID" int NULL  DEFAULT 0,
	"Customer_ID" int NOT NULL  DEFAULT 0,
	"Account_Name" nvarchar(50) NOT NULL ,
	"Type1" nvarchar(50) NOT NULL ,
	"Description" ntext NULL ,
	"Policy" ntext NULL ,
	"Logo" nvarchar(50) NULL ,
	"Rep" nvarchar(50) NULL ,
	"Terms" nvarchar(50) NULL ,
	"LastUsed" datetime NULL ,
	"Directory_Live" bit NOT NULL DEFAULT 0,
	"Web_URL" nvarchar(75) NULL ,
	"Dropship_Email" nvarchar(100) NULL ,
	"PO_Text" nvarchar(50) NULL ,
	"Map_URL" ntext NULL,
	"ID_Tag" nvarchar(35) NULL
)

ALTER TABLE "Account" ADD
	CONSTRAINT "Account_PK" PRIMARY KEY CLUSTERED  ("Account_ID")

CREATE  INDEX "Account_Customer_ID_Idx" ON "Account" ("Customer_ID")

CREATE  INDEX "Account_User_ID_Idx" ON "Account" ("User_ID")

CREATE  INDEX "Account_ID_Tag_Idx" ON "Account" ("ID_Tag")

	;
CREATE TABLE "Affiliates"
(
	"Affiliate_ID" int IDENTITY NOT NULL ,
	"AffCode" int NOT NULL  DEFAULT 0,
	"AffPercent" float NOT NULL  DEFAULT 0,
	"Aff_Site" nvarchar(255) NULL,
	"ID_Tag" nvarchar(35) NULL
)

ALTER TABLE "Affiliates" ADD
	CONSTRAINT "Affiliates_PK" PRIMARY KEY CLUSTERED  ("Affiliate_ID")

CREATE  INDEX "Affiliates_AffCode_Idx" ON "Affiliates" ("AffCode")

CREATE  INDEX "Affiliates_ID_Tag_Idx" ON "Affiliates" ("ID_Tag")

	;
CREATE TABLE "CardData"
(
	"ID" int IDENTITY NOT NULL ,
	"Customer_ID" int NOT NULL  DEFAULT 0,
	"CardType" nvarchar(50) NOT NULL ,
	"NameonCard" nvarchar(150) NOT NULL ,
	"CardNumber" nvarchar(50) NOT NULL ,
	"Expires" nvarchar(50) NOT NULL ,
	"EncryptedCard" nvarchar(100) NULL,
	"ID_Tag" nvarchar(35) NULL
)

ALTER TABLE "CardData" ADD
	CONSTRAINT "CardData_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "CardData_Customer_ID_Idx" ON "CardData" ("Customer_ID")

CREATE  INDEX "CardData_ID_Tag_Idx" ON "CardData" ("ID_Tag")

	;
CREATE TABLE "CatCore"
(
	"CatCore_ID" int NOT NULL DEFAULT 0,
	"Catcore_Name" nvarchar(50) NOT NULL ,
	"PassParams" nvarchar(150) NULL ,
	"Template" nvarchar(50) NOT NULL ,
	"Category" bit NOT NULL DEFAULT 0,
	"Products" bit NOT NULL DEFAULT 0,
	"Features" bit NOT NULL DEFAULT 0,
	"Page" bit NOT NULL DEFAULT 0
)

ALTER TABLE "CatCore" ADD
	CONSTRAINT "CatCore_PK" PRIMARY KEY CLUSTERED  ("CatCore_ID")

	;
CREATE TABLE "Categories"
(
	"Category_ID" int IDENTITY NOT NULL ,
	"Parent_ID" int NOT NULL  DEFAULT 0,
	"CatCore_ID" int NOT NULL  DEFAULT 1,
	"Name" nvarchar(255) NOT NULL ,
	"Short_Desc" ntext NULL ,
	"Long_Desc" ntext NULL ,
	"Sm_Image" nvarchar(100) NULL ,
	"Lg_Image" nvarchar(100) NULL ,
	"Sm_Title" nvarchar(100) NULL ,
	"Lg_Title" nvarchar(100) NULL ,
	"PassParam" nvarchar(100) NULL ,
	"AccessKey" int NULL  DEFAULT 0,
	"CColumns" smallint NULL ,
	"PColumns" smallint NULL ,
	"Display" bit NOT NULL  DEFAULT 1,
	"ProdFirst" bit NOT NULL  DEFAULT 0,
	"Priority" int NOT NULL  DEFAULT 9999,
	"Highlight" bit NOT NULL  DEFAULT 0,
	"ParentIDs" nvarchar(50) NULL ,
	"ParentNames" nvarchar(2000) NULL ,
	"Sale" bit NOT NULL DEFAULT 0,
	"DateAdded" datetime NULL ,
	"Color_ID" int NULL ,
	"Metadescription" nvarchar(255) NULL ,
	"Keywords" nvarchar(255) NULL ,
	"TitleTag" nvarchar(255) NULL
)

ALTER TABLE "Categories" ADD
	CONSTRAINT "Categories_PK" PRIMARY KEY CLUSTERED  ("Category_ID")

CREATE  INDEX "Categories_CatCore_ID_Idx" ON "Categories" ("CatCore_ID")

CREATE  INDEX "Category_Color_ID_Idx" ON "Categories" ("Color_ID")

CREATE  INDEX "Category_Parent_ID_Idx" ON "Categories" ("Parent_ID")

	;
CREATE TABLE "CCProcess"
(
	"ID" int IDENTITY NOT NULL ,
	"CCServer" nvarchar(150) NULL ,
	"Transtype" nvarchar(75) NULL ,
	"Username" nvarchar(75) NULL ,
	"Password" nvarchar(75) NULL ,
	"Setting1" nvarchar(75) NULL ,
	"Setting2" nvarchar(75) NULL ,
	"Setting3" nvarchar(75) NULL
)

ALTER TABLE "CCProcess" ADD
	CONSTRAINT "CCProcess_PK" PRIMARY KEY CLUSTERED  ("ID")

	;
CREATE TABLE "Certificates"
(
	"Cert_ID" int IDENTITY NOT NULL ,
	"Cert_Code" nvarchar(50) NOT NULL ,
	"Cust_Name" nvarchar(255) NULL ,
	"CertAmount" float NOT NULL  DEFAULT 0,
	"InitialAmount" float NULL  DEFAULT 0,
	"StartDate" datetime NULL ,
	"EndDate" datetime NULL ,
	"Valid" bit NOT NULL DEFAULT 0,
	"Order_No" int NULL  DEFAULT 0
)

ALTER TABLE "Certificates" ADD
	CONSTRAINT "Certificates_PK" PRIMARY KEY CLUSTERED  ("Cert_ID")

CREATE  INDEX "Certificates_Cert_Code_Idx" ON "Certificates" ("Cert_Code")

	;
CREATE TABLE "Colors"
(
	"Color_ID" int IDENTITY NOT NULL ,
	"Bgcolor" nvarchar(10) NULL ,
	"Bgimage" nvarchar(100) NULL ,
	"MainTitle" nvarchar(10) NULL ,
	"MainText" nvarchar(10) NULL ,
	"MainLink" nvarchar(10) NULL ,
	"MainVLink" nvarchar(10) NULL ,
	"BoxHBgcolor" nvarchar(10) NULL ,
	"BoxHText" nvarchar(10) NULL ,
	"BoxTBgcolor" nvarchar(10) NULL ,
	"BoxTText" nvarchar(10) NULL ,
	"InputHBgcolor" nvarchar(10) NULL ,
	"InputHText" nvarchar(10) NULL ,
	"InputTBgcolor" nvarchar(10) NULL ,
	"InputTText" nvarchar(10) NULL ,
	"OutputHBgcolor" nvarchar(10) NULL ,
	"OutputHText" nvarchar(10) NULL ,
	"OutputTBgcolor" nvarchar(10) NULL ,
	"OutputTText" nvarchar(10) NULL ,
	"OutputTAltcolor" nvarchar(10) NULL ,
	"OutputTHighlight" nvarchar(10) NULL ,
	"LineColor" nvarchar(10) NULL ,
	"HotImage" nvarchar(50) NULL ,
	"SaleImage" nvarchar(50) NULL ,
	"NewImage" nvarchar(50) NULL ,
	"MainLineImage" nvarchar(50) NULL ,
	"MinorLineImage" nvarchar(50) NULL ,
	"Palette_Name" nvarchar(50) NULL ,
	"FormReq" nvarchar(10) NULL ,
	"LayoutFile" nvarchar(50) NULL ,
	"FormReqOB" nvarchar(10) NULL ,
	"PassParam" nvarchar(100) NULL
)

ALTER TABLE "Colors" ADD
	CONSTRAINT "Colors_PK" PRIMARY KEY CLUSTERED  ("Color_ID")

	;
CREATE TABLE "Counties"
(
	"County_ID" int IDENTITY NOT NULL ,
	"Code_ID" int NOT NULL  DEFAULT 0,
	"State" nvarchar(2) NOT NULL ,
	"Name" nvarchar(50) NOT NULL ,
	"TaxRate" float NOT NULL  DEFAULT 0,
	"TaxShip" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "Counties" ADD
	CONSTRAINT "Counties_PK" PRIMARY KEY CLUSTERED  ("County_ID")

CREATE  INDEX "Counties_Code_ID_Idx" ON "Counties" ("Code_ID")

CREATE  INDEX "Counties_State_Idx" ON "Counties" ("State")

	;
CREATE TABLE "Countries"
(
	"ID" int IDENTITY NOT NULL ,
	"Abbrev" nvarchar(2) NOT NULL ,
	"Name" nvarchar(100) NOT NULL ,
	"AllowUPS" bit NOT NULL  DEFAULT 0,
	"Shipping" int NOT NULL  DEFAULT 0,
	"AddShipAmount" float NOT NULL  DEFAULT 0
)

ALTER TABLE "Countries" ADD
	CONSTRAINT "Countries_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "Countries_Shipping_Idx" ON "Countries" ("Shipping")

	;
CREATE TABLE "CountryTax"
(
	"Tax_ID" int IDENTITY NOT NULL ,
	"Code_ID" int NOT NULL  DEFAULT 0,
	"Country_ID" int NOT NULL  DEFAULT 0,
	"TaxRate" float NOT NULL  DEFAULT 0,
	"TaxShip" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "CountryTax" ADD
	CONSTRAINT "CountryTax_PK" PRIMARY KEY CLUSTERED  ("Tax_ID")

CREATE  INDEX "CountryTax_Code_ID_Idx" ON "CountryTax" ("Code_ID")

CREATE  INDEX "CountryTax_Country_ID_Idx" ON "CountryTax" ("Country_ID")

	;
CREATE TABLE "CreditCards"
(
	"ID" int IDENTITY NOT NULL ,
	"CardName" nvarchar(50) NOT NULL ,
	"Used" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "CreditCards" ADD
	CONSTRAINT "CreditCards_PK" PRIMARY KEY CLUSTERED  ("ID")

	;
CREATE TABLE "Customers"
(
	"Customer_ID" int IDENTITY NOT NULL ,
	"User_ID" int NOT NULL  DEFAULT 0,
	"FirstName" nvarchar(50) NOT NULL ,
	"LastName" nvarchar(150) NOT NULL ,
	"Company" nvarchar(150) NULL ,
	"Address1" nvarchar(150) NOT NULL ,
	"Address2" nvarchar(150) NULL ,
	"City" nvarchar(150) NOT NULL ,
	"County" nvarchar(50) NULL ,
	"State" nvarchar(50) NOT NULL ,
	"State2" nvarchar(50) NULL ,
	"Zip" nvarchar(50) NOT NULL ,
	"Country" nvarchar(50) NOT NULL ,
	"Phone" nvarchar(50) NULL ,
	"Phone2" nvarchar(50) NULL ,
	"Fax" nvarchar(50) NULL ,
	"Email" nvarchar(150) NULL ,
	"Residence" bit NOT NULL  DEFAULT 1,
	"LastUsed" datetime NULL,
	"ID_Tag" nvarchar(35) NULL
)

ALTER TABLE "Customers" ADD
	CONSTRAINT "Customers_PK" PRIMARY KEY CLUSTERED  ("Customer_ID")

CREATE  INDEX "Customers_User_ID_Idx" ON "Customers" ("User_ID")

CREATE  INDEX "Customers_ID_Tag_Idx" ON "Customers" ("ID_Tag")

	;
CREATE TABLE "CustomMethods"
(
	"ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(50) NULL ,
	"Amount" float NOT NULL  DEFAULT 0,
	"Used" bit NOT NULL DEFAULT 0,
	"Priority" int NULL  DEFAULT 0,
	"Domestic" bit NOT NULL  DEFAULT 0,
	"International" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "CustomMethods" ADD
	CONSTRAINT "CustomMethods_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "CustomMethods_Used_Idx" ON "CustomMethods" ("Used")

	;
CREATE TABLE "CustomShipSettings"
(
	"Setting_ID" int IDENTITY NOT NULL ,
	"ShowShipTable" bit NOT NULL  DEFAULT 0,
	"MultPerItem" bit NOT NULL  DEFAULT 0,
	"CumulativeAmounts" bit NOT NULL  DEFAULT 0,
	"MultMethods" bit NOT NULL  DEFAULT 0,
	"Debug" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "CustomShipSettings" ADD
	CONSTRAINT "CustomShipSettings_PK" PRIMARY KEY CLUSTERED  ("Setting_ID")

	;
CREATE TABLE "Discount_Categories"
(
	"ID" int IDENTITY NOT NULL ,
	"Discount_ID" int NOT NULL,
	"Category_ID" int NOT NULL
)

ALTER TABLE "Discount_Categories" ADD
	CONSTRAINT "Discount_Categories_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "Discount_Categories_Category_ID_Idx" ON "Discount_Categories" ("Category_ID")

CREATE  INDEX "Discount_Categories_Discount_ID_Idx" ON "Discount_Categories" ("Discount_ID")

	;
CREATE TABLE "Discount_Groups"
(
	"ID" int IDENTITY NOT NULL ,
	"Discount_ID" int NOT NULL,
	"Group_ID" int NOT NULL
)

ALTER TABLE "Discount_Groups" ADD
	CONSTRAINT "Discount_Groups_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "Discount_Groups_Discount_ID_Idx" ON "Discount_Groups" ("Discount_ID")

CREATE  INDEX "Discount_Groups_Group_ID_Idx" ON "Discount_Groups" ("Group_ID")

	;
CREATE TABLE "Discount_Products"
(
	"ID" int IDENTITY NOT NULL ,
	"Discount_ID" int NOT NULL,
	"Product_ID" int NOT NULL
)

ALTER TABLE "Discount_Products" ADD
	CONSTRAINT "Discount_Products_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "Discount_Products_Discount_ID_Idx" ON "Discount_Products" ("Discount_ID")

CREATE  INDEX "Discount_Products_Product_ID_Idx" ON "Discount_Products" ("Product_ID")

	;
CREATE TABLE "Discounts"
(
	"Discount_ID" int IDENTITY NOT NULL ,
	"Type1" int NOT NULL  DEFAULT 1,
	"Type2" int NOT NULL  DEFAULT 1,
	"Type3" int NOT NULL  DEFAULT 0,
	"Type4" int NOT NULL  DEFAULT 0,
	"Type5" int NOT NULL  DEFAULT 0,
	"Coup_Code" nvarchar(50) NULL ,
	"OneTime" bit NOT NULL  DEFAULT 0,
	"Name" nvarchar(255) NOT NULL ,
	"Display" nvarchar(255) NULL ,
	"Amount" float NOT NULL  DEFAULT 0,
	"MinOrder" float NOT NULL  DEFAULT 0,
	"MaxOrder" float NOT NULL  DEFAULT 0,
	"StartDate" datetime NULL ,
	"EndDate" datetime NULL ,
	"AccessKey" int NULL  DEFAULT 0
)

ALTER TABLE "Discounts" ADD
	CONSTRAINT "Discounts_PK" PRIMARY KEY CLUSTERED  ("Discount_ID")

CREATE  INDEX "Discounts_AccessKey_Idx" ON "Discounts" ("AccessKey")

CREATE  INDEX "Discounts_Coup_Code_Idx" ON "Discounts" ("Coup_Code")

	;
CREATE TABLE "Feature_Category"
(
	"Feature_Category_ID" int IDENTITY NOT NULL ,
	"Feature_ID" int NOT NULL,
	"Category_ID" int NOT NULL
)

ALTER TABLE "Feature_Category" ADD
	CONSTRAINT "Feature_Category_PK" PRIMARY KEY CLUSTERED  ("Feature_Category_ID")

CREATE  INDEX "Feature_Category_Category_ID_Idx" ON "Feature_Category" ("Category_ID")

CREATE  INDEX "Feature_Category_Feature_ID_Idx" ON "Feature_Category" ("Feature_ID")

	;
CREATE TABLE "Feature_Item"
(
	"Feature_Item_ID" int IDENTITY NOT NULL ,
	"Feature_ID" int NOT NULL,
	"Item_ID" int NOT NULL
)

ALTER TABLE "Feature_Item" ADD
	CONSTRAINT "Feature_Item_PK" PRIMARY KEY CLUSTERED  ("Feature_Item_ID")

CREATE  INDEX "Feature_Item_Feature_ID_Idx" ON "Feature_Item" ("Feature_ID")

CREATE  INDEX "Feature_Item_Item_ID_Idx" ON "Feature_Item" ("Item_ID")

	;
CREATE TABLE "Feature_Product"
(
	"Feature_Product_ID" int IDENTITY NOT NULL ,
	"Product_ID" int NOT NULL,
	"Feature_ID" int NOT NULL
)

ALTER TABLE "Feature_Product" ADD
	CONSTRAINT "Feature_Product_PK" PRIMARY KEY CLUSTERED  ("Feature_Product_ID")

CREATE  INDEX "Feature_Product_Feature_ID_Idx" ON "Feature_Product" ("Feature_ID")

CREATE  INDEX "Feature_Product_Product_ID_Idx" ON "Feature_Product" ("Product_ID")

	;
CREATE TABLE "FeatureReviews"
(
	"Review_ID" int IDENTITY NOT NULL,
	"Feature_ID" int NOT NULL,
	"Parent_ID" int NULL DEFAULT 0,
	"User_ID" int NULL DEFAULT 0,
	"Anonymous" bit NOT NULL DEFAULT 0,
	"Anon_Name" nvarchar(100) NULL ,
	"Anon_Loc" nvarchar(100) NULL ,
	"Anon_Email" nvarchar(100) NULL ,
	"Editorial" nvarchar(50) NULL ,
	"Title" nvarchar(75) NULL ,
	"Comment" ntext NULL ,
	"Rating" smallint NULL  DEFAULT 0,
	"Recommend" bit NOT NULL DEFAULT 0,
	"Posted" datetime NOT NULL ,
	"Updated" datetime NULL ,
	"Approved" bit NOT NULL DEFAULT 0,
	"NeedsCheck" bit NOT NULL DEFAULT 0
)

ALTER TABLE "FeatureReviews" ADD
	CONSTRAINT "FeatureReviews_PK" PRIMARY KEY CLUSTERED  ("Review_ID")

CREATE  INDEX "FeatureReviews_Feature_ID_Idx" ON "FeatureReviews" ("Feature_ID")

CREATE  INDEX "FeatureReviews_Parent_ID_Idx" ON "FeatureReviews" ("Parent_ID")

CREATE  INDEX "FeatureReviews_Posted_Idx" ON "FeatureReviews" ("Posted")

CREATE  INDEX "FeatureReviews_Rating_Idx" ON "FeatureReviews" ("Rating")

CREATE  INDEX "FeatureReviews_User_ID_Idx" ON "FeatureReviews" ("User_ID")

	;
CREATE TABLE "Features"
(
	"Feature_ID" int IDENTITY NOT NULL ,
	"User_ID" int NULL  DEFAULT 0,
	"Feature_Type" nvarchar(50) NULL ,
	"Name" nvarchar(125) NOT NULL ,
	"Author" nvarchar(50) NULL ,
	"Copyright" nvarchar(50) NULL ,
	"Display" bit NOT NULL DEFAULT 0,
	"Approved" bit NOT NULL  DEFAULT 0,
	"Start" datetime NULL ,
	"Expire" datetime NULL ,
	"Priority" int NULL  DEFAULT 9999,
	"AccessKey" int NULL  DEFAULT 0,
	"Highlight" bit NOT NULL DEFAULT 0,
	"Display_Title" bit NOT NULL DEFAULT 0,
	"Reviewable" bit NOT NULL DEFAULT 0,
	"Sm_Title" nvarchar(150) NULL ,
	"Sm_Image" nvarchar(150) NULL ,
	"Short_Desc" ntext NULL ,
	"Lg_Title" nvarchar(150) NULL ,
	"Lg_Image" nvarchar(150) NULL ,
	"Long_Desc" ntext NULL ,
	"PassParam" nvarchar(150) NULL ,
	"Color_ID" int NULL ,
	"Created" datetime NULL ,
	"Metadescription" nvarchar(255) NULL ,
	"Keywords" nvarchar(255) NULL ,
	"TitleTag" nvarchar(255) NULL
)

ALTER TABLE "Features" ADD
	CONSTRAINT "Features_PK" PRIMARY KEY CLUSTERED  ("Feature_ID")

CREATE  INDEX "Features_AccessKey_Idx" ON "Features" ("AccessKey")

CREATE  INDEX "Features_Color_ID_Idx" ON "Features" ("Color_ID")

CREATE  INDEX "Features_User_ID_Idx" ON "Features" ("User_ID")
	;
CREATE TABLE "FedEx_Dropoff"
(
	"FedEx_Code" nvarchar(30) NOT NULL ,
	"Description" nvarchar(50) NULL
)

ALTER TABLE "FedEx_Dropoff" ADD
	CONSTRAINT "FedEx_Dropoff_PK" PRIMARY KEY CLUSTERED  ("FedEx_Code")

	;
CREATE TABLE "FedEx_Packaging"
(
	"FedEx_Code" nvarchar(20) NOT NULL ,
	"Description" nvarchar(50) NULL
)

ALTER TABLE "FedEx_Packaging" ADD
	CONSTRAINT "FedEx_Packaging_PK" PRIMARY KEY CLUSTERED  ("FedEx_Code")

	;
CREATE TABLE "FedEx_Settings"
(
	"Fedex_ID" int IDENTITY NOT NULL ,
	"AccountNo" nvarchar(20) NULL ,
	"MeterNum" nvarchar(20) NULL ,
	"MaxWeight" int NULL  DEFAULT 0,
	"UnitsofMeasure" nvarchar(20) NULL ,
	"Dropoff" nvarchar(20) NULL ,
	"Packaging" nvarchar(20) NULL ,
	"OrigZip" nvarchar(20) NULL ,
	"OrigState" nvarchar(75) NULL ,
	"OrigCountry" nvarchar(10) NULL ,
	"Debug" bit NOT NULL  DEFAULT 0,
	"UseGround" bit NOT NULL  DEFAULT 0,
	"UseExpress" bit NOT NULL  DEFAULT 0,
	"Logging" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "FedEx_Settings" ADD
	CONSTRAINT "FedEx_Settings_PK" PRIMARY KEY CLUSTERED  ("Fedex_ID")

	;
CREATE TABLE "FedExMethods"
(
	"ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(75) NULL ,
	"Used" bit NOT NULL DEFAULT 0,
	"Shipper" nvarchar(10) NULL ,
	"Code" nvarchar(75) NULL ,
	"Priority" int NULL  DEFAULT 0
)

ALTER TABLE "FedExMethods" ADD
	CONSTRAINT "FedExMethods_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "FedExMethods_Code_Idx" ON "FedExMethods" ("Code")

CREATE  INDEX "FedExMethods_Used_Idx" ON "FedExMethods" ("Used")

	;
CREATE TABLE "GiftItems"
(
	"GiftItem_ID" int IDENTITY NOT NULL ,
	"GiftRegistry_ID" int NOT NULL ,
	"Product_ID" int NOT NULL ,
	"Options" nvarchar(2000) NULL ,
	"Addons" nvarchar(1000) NULL ,
	"AddonMultP" float NULL  DEFAULT 0,
	"AddonNonMultP" float NULL  DEFAULT 0,
	"AddonMultW" float NULL  DEFAULT 0,
	"AddonNonMultW" float NULL  DEFAULT 0,
	"OptPrice" float NOT NULL  DEFAULT 0,
	"OptWeight" float NOT NULL  DEFAULT 0,
	"OptQuant" int NOT NULL  DEFAULT 0,
	"OptChoice" smallint NOT NULL  DEFAULT 0,
	"OptionID_List" nvarchar(255) NULL ,
	"ChoiceID_List" nvarchar(255) NULL ,
	"SKU" nvarchar(100) NULL ,
	"Price" float NOT NULL  DEFAULT 0,
	"Weight" float NOT NULL  DEFAULT 0,
	"Quantity_Requested" smallint NOT NULL  DEFAULT 0,
	"Quantity_Purchased" smallint NOT NULL  DEFAULT 0,
	"DateAdded" datetime NULL
)

ALTER TABLE "GiftItems" ADD
	CONSTRAINT "GiftItems_PK" PRIMARY KEY CLUSTERED  ("GiftItem_ID")

CREATE  INDEX "GiftItems_GiftRegistry_ID_Idx" ON "GiftItems" ("GiftRegistry_ID")

CREATE  INDEX "GiftItems_Product_ID_Idx" ON "GiftItems" ("Product_ID")

	;
CREATE TABLE "GiftRegistry"
(
	"GiftRegistry_ID" int IDENTITY NOT NULL ,
	"User_ID" int NOT NULL ,
	"Registrant" nvarchar(75) NULL ,
	"OtherName" nvarchar(50) NULL ,
	"GiftRegistry_Type" nvarchar(50) NULL ,
	"Event_Date" datetime NULL ,
	"Event_Name" nvarchar(50) NULL ,
	"Event_Descr" nvarchar(255) NULL ,
	"Private" bit NOT NULL DEFAULT 0,
	"Order_Notification" bit NOT NULL DEFAULT 0,
	"Live" bit NOT NULL DEFAULT 0,
	"Approved" bit NOT NULL DEFAULT 0,
	"City" nvarchar(150) NULL ,
	"State" nvarchar(50) NULL ,
	"Created" datetime NULL ,
	"Expire" datetime NULL,
	"ID_Tag" nvarchar(35) NULL
)

ALTER TABLE "GiftRegistry" ADD
	CONSTRAINT "GiftRegistry_PK" PRIMARY KEY CLUSTERED  ("GiftRegistry_ID")

CREATE  INDEX "GiftRegistry_User_ID_Idx" ON "GiftRegistry" ("User_ID")

CREATE  INDEX "GiftRegistry_ID_Tag_Idx" ON "GiftRegistry" ("ID_Tag")

	;
CREATE TABLE "Giftwrap"
(
	"Giftwrap_ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(60) NOT NULL ,
	"Short_Desc" ntext NULL ,
	"Sm_Image" nvarchar(150) NULL ,
	"Price" float NOT NULL  DEFAULT 0,
	"Weight" float NOT NULL  DEFAULT 0,
	"Priority" smallint NOT NULL  DEFAULT 0,
	"Display" bit NOT NULL DEFAULT 0
)

ALTER TABLE "Giftwrap" ADD
	CONSTRAINT "Giftwrap_PK" PRIMARY KEY CLUSTERED  ("Giftwrap_ID")

	;
CREATE TABLE "Groups"
(
	"Group_ID" int NOT NULL ,
	"Name" nvarchar(50) NOT NULL ,
	"Description" ntext NULL ,
	"Permissions" nvarchar(255) NULL ,
	"Wholesale" bit NOT NULL DEFAULT 0,
	"Group_Code" nvarchar(20) NULL ,
	"TaxExempt" bit NOT NULL  DEFAULT 0,
	"ShipExempt" bit NOT NULL DEFAULT 0
)

ALTER TABLE "Groups" ADD
	CONSTRAINT "Groups_PK" PRIMARY KEY CLUSTERED  ("Group_ID")

CREATE  INDEX "Groups_Name_Idx" ON "Groups" ("Name")

	;
CREATE TABLE "Intershipper"
(
	"ID" int IDENTITY NOT NULL ,
	"Password" nvarchar(50) NULL ,
	"Residential" bit NOT NULL DEFAULT 0,
	"Pickup" nvarchar(5) NOT NULL ,
	"UnitsofMeasure" nvarchar(10) NOT NULL ,
	"MaxWeight" int NULL  DEFAULT 0,
	"Carriers" nvarchar(50) NOT NULL ,
	"UserID" nvarchar(100) NULL ,
	"Classes" nvarchar(100) NULL ,
	"MerchantZip" nvarchar(20) NULL ,
	"Logging" bit NOT NULL DEFAULT 0,
	"Debug" bit NOT NULL DEFAULT 0
)

ALTER TABLE "Intershipper" ADD
	CONSTRAINT "Intershipper_PK" PRIMARY KEY CLUSTERED  ("ID")

	;
CREATE TABLE "IntShipTypes"
(
	"ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(50) NOT NULL ,
	"Used" bit NOT NULL DEFAULT 0,
	"Code" nvarchar(10) NOT NULL ,
	"Priority" int NULL  DEFAULT 0
)

ALTER TABLE "IntShipTypes" ADD
	CONSTRAINT "IntShipTypes_PK" PRIMARY KEY CLUSTERED  ("ID")

	;
CREATE TABLE "Locales"
(
	"ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(30) NOT NULL ,
	"CurrExchange" nvarchar(50) NULL
)

ALTER TABLE "Locales" ADD
	CONSTRAINT "Locales_PK" PRIMARY KEY CLUSTERED  ("ID")

	;
CREATE TABLE "LocalTax"
(
	"Local_ID" int IDENTITY NOT NULL ,
	"Code_ID" int NOT NULL  DEFAULT 0,
	"ZipCode" nvarchar(20) NOT NULL ,
	"Tax" float NOT NULL  DEFAULT 0,
	"EndZip" nvarchar(20) NULL ,
	"TaxShip" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "LocalTax" ADD
	CONSTRAINT "LocalTax_PK" PRIMARY KEY CLUSTERED  ("Local_ID")

CREATE  INDEX "LocalTax_Code_ID_Idx" ON "LocalTax" ("Code_ID")

CREATE  INDEX "LocalTax_ZipCode_Idx" ON "LocalTax" ("ZipCode")
	;
CREATE TABLE "MailText"
(
	"MailText_ID" int IDENTITY NOT NULL ,
	"MailText_Name" nvarchar(50) NULL ,
	"MailText_Message" ntext NULL ,
	"MailText_Subject" nvarchar(75) NULL ,
	"MailText_Attachment" nvarchar(255) NULL ,
	"System" bit NOT NULL DEFAULT 0,
	"MailAction" nvarchar(50) NULL
)

ALTER TABLE "MailText" ADD
	CONSTRAINT "MailText_PK" PRIMARY KEY CLUSTERED  ("MailText_ID")

	;
CREATE TABLE "Memberships"
(
	"Membership_ID" int IDENTITY NOT NULL ,
	"User_ID" int NULL  DEFAULT 0,
	"Order_ID" int NULL ,
	"Product_ID" int NULL  DEFAULT 0,
	"Membership_Type" nvarchar(50) NULL ,
	"AccessKey_ID" nvarchar(50) NULL ,
	"Start" datetime NULL ,
	"Time_Count" int NULL  DEFAULT 0,
	"Access_Count" int NULL  DEFAULT 0,
	"Expire" datetime NULL ,
	"Valid" bit NOT NULL DEFAULT 0,
	"Date_Ordered" datetime NULL ,
	"Access_Used" int NULL  DEFAULT 0,
	"Recur" bit NOT NULL  DEFAULT 0,
	"Recur_Product_ID" int NULL  DEFAULT 0,
	"Suspend_Begin_Date" datetime NULL ,
	"Next_Membership_ID" int NULL  DEFAULT 0,
	"ID_Tag" nvarchar(35) NULL
)

ALTER TABLE "Memberships" ADD
	CONSTRAINT "Memberships_PK" PRIMARY KEY CLUSTERED  ("Membership_ID")

CREATE  INDEX "Memberships_AccessKey_ID_Idx" ON "Memberships" ("AccessKey_ID")

CREATE  INDEX "Memberships_Next_Membership_ID_Idx" ON "Memberships" ("Next_Membership_ID")

CREATE  INDEX "Memberships_Recur_Product_ID_Idx" ON "Memberships" ("Recur_Product_ID")

CREATE  INDEX "Memberships_User_ID_Idx" ON "Memberships" ("User_ID")

CREATE  INDEX "Memberships_ID_Tag_Idx" ON "Memberships" ("ID_Tag")

	;

CREATE TABLE "Order_Items"
(
	"Order_No" int NOT NULL,
	"Item_ID" int NOT NULL,
	"Product_ID" int NOT NULL  DEFAULT 0,
	"Options" ntext NULL ,
	"Addons" ntext NULL ,
	"AddonMultP" float NULL  DEFAULT 0,
	"AddonNonMultP" float NULL  DEFAULT 0,
	"Price" float NOT NULL  DEFAULT 0,
	"Quantity" int NOT NULL  DEFAULT 0,
	"OptPrice" float NOT NULL  DEFAULT 0,
	"SKU" nvarchar(50) NULL ,
	"OptQuant" int NOT NULL  DEFAULT 0,
	"OptChoice" int NULL ,
	"OptionID_List" nvarchar(255) NULL ,
	"ChoiceID_List" nvarchar(255) NULL ,
	"DiscAmount" float NULL ,
	"Disc_Code" nvarchar(50) NULL ,
	"PromoAmount" float NULL  DEFAULT 0,
	"PromoQuant" int NULL  DEFAULT 0,
	"Promo_Code" nvarchar(50) NULL ,
	"Name" nvarchar(255) NULL ,
	"Dropship_Account_ID" int NULL ,
	"Dropship_Qty" int NULL  DEFAULT 0,
	"Dropship_SKU" nvarchar(50) NULL ,
	"Dropship_Cost" float NULL  DEFAULT 0,
	"Dropship_Note" nvarchar(75) NULL
)

ALTER TABLE "Order_Items" ADD
	CONSTRAINT "Order_Items_PK" PRIMARY KEY CLUSTERED  ("Order_No","Item_ID")

CREATE  INDEX "Order_Items_Disc_Code_Idx" ON "Order_Items" ("Disc_Code")

CREATE  INDEX "Order_Items_Order_No_Idx" ON "Order_Items" ("Order_No")

CREATE  INDEX "Order_Items_Product_ID_Idx" ON "Order_Items" ("Product_ID")

CREATE  INDEX "Order_Items_Promo_Code_Idx" ON "Order_Items" ("Promo_Code")

	;
CREATE TABLE "Order_No"
(
	"Order_No" int IDENTITY NOT NULL ,
	"Filled" bit NOT NULL  DEFAULT 0,
	"Process" bit NOT NULL DEFAULT 0,
	"Void" bit NOT NULL DEFAULT 0,
	"InvDone" bit NOT NULL  DEFAULT 0,
	"Customer_ID" int NOT NULL  DEFAULT 0,
	"User_ID" int NULL  DEFAULT 0,
	"Card_ID" int NULL  DEFAULT 0,
	"ShipTo" int NULL  DEFAULT 0,
	"DateOrdered" datetime NOT NULL ,
	"OrderTotal" float NOT NULL  DEFAULT 0,
	"Tax" float NOT NULL  DEFAULT 0,
	"ShipType" nvarchar(75) NULL ,
	"Shipping" float NOT NULL  DEFAULT 0,
	"Freight" int NULL  DEFAULT 0,
	"Comments" nvarchar(255) NULL ,
	"AuthNumber" nvarchar(50) NULL ,
	"InvoiceNum" nvarchar(75) NULL ,
	"TransactNum" nvarchar(50) NULL ,
	"Shipper" nvarchar(50) NULL ,
	"Tracking" nvarchar(255) NULL ,
	"Giftcard" nvarchar(255) NULL ,
	"Delivery" nvarchar(50) NULL ,
	"OrderDisc" float NULL  DEFAULT 0,
	"Credits" float NULL  DEFAULT 0,
	"AddonTotal" float NULL  DEFAULT 0,
	"Coup_Code" nvarchar(50) NULL ,
	"Cert_Code" nvarchar(50) NULL ,
	"Affiliate" int NULL ,
	"Referrer" nvarchar(255) NULL ,
	"CustomText1" nvarchar(255) NULL ,
	"CustomText2" nvarchar(255) NULL ,
	"CustomText3" nvarchar(50) NULL ,
	"CustomSelect1" nvarchar(100) NULL ,
	"CustomSelect2" nvarchar(100) NULL ,
	"DateFilled" datetime NULL ,
	"PayPalStatus" nvarchar(30) NULL ,
	"Reason" ntext NULL ,
	"OfflinePayment" nvarchar(50) NULL ,
	"PO_Number" nvarchar(30) NULL ,
	"Notes" ntext NULL ,
	"Admin_Updated" datetime NULL ,
	"Admin_Name" nvarchar(50) NULL ,
	"AdminCredit" float NULL  DEFAULT 0,
	"AdminCreditText" nvarchar(50) NULL ,
	"Printed" int NOT NULL  DEFAULT 0,
	"Status" nvarchar(50) NULL ,
	"Paid" bit NOT NULL DEFAULT 0,
	"CodesSent" bit NOT NULL  DEFAULT 0,
	"ID_Tag" nvarchar(35) NULL
)

ALTER TABLE "Order_No" ADD
	CONSTRAINT "Order_No_PK" PRIMARY KEY CLUSTERED  ("Order_No")

CREATE  INDEX "Order_No_Coup_Code_Idx" ON "Order_No" ("Coup_Code")

CREATE  INDEX "Order_No_Customer_ID_Idx" ON "Order_No" ("Customer_ID")

CREATE  INDEX "Order_No_User_ID_Idx" ON "Order_No" ("User_ID")

CREATE  INDEX "Order_No_ID_Tag_Idx" ON "Order_No" ("ID_Tag")

	;
CREATE TABLE "Order_PO"
(
	"Order_PO_ID" int IDENTITY NOT NULL ,
	"Order_No" int NOT NULL,
	"PO_No" nvarchar(30) NOT NULL ,
	"Account_ID" int NOT NULL  DEFAULT 0,
	"PrintDate" datetime NULL ,
	"Notes" nvarchar(255) NULL ,
	"PO_Status" nvarchar(50) NULL ,
	"PO_Open" bit NOT NULL DEFAULT 0,
	"ShipDate" datetime NULL ,
	"Shipper" nvarchar(50) NULL ,
	"Tracking" nvarchar(50) NULL,
	"ID_Tag" nvarchar(35) NULL
)

ALTER TABLE "Order_PO" ADD
	CONSTRAINT "Order_PO_PK" PRIMARY KEY CLUSTERED  ("Order_PO_ID")

CREATE  INDEX "Order_PO_Account_ID_Idx" ON "Order_PO" ("Account_ID")

CREATE  INDEX "Order_PO_Order_No_Idx" ON "Order_PO" ("Order_No")

CREATE  INDEX "Order_PO_ID_Tag_Idx" ON "Order_PO" ("ID_Tag")

	;
CREATE TABLE "OrderSettings"
(
	"ID" int IDENTITY NOT NULL ,
	"AllowInt" bit NOT NULL DEFAULT 0,
	"AllowOffline" bit NOT NULL DEFAULT 0,
	"OnlyOffline" bit NOT NULL DEFAULT 0,
	"OfflineMessage" ntext NULL ,
	"CCProcess" nvarchar(50) NULL ,
	"AllowPO" bit NOT NULL  DEFAULT 0,
	"EmailAdmin" bit NOT NULL DEFAULT 0,
	"EmailUser" bit NOT NULL DEFAULT 0,
	"EmailAffs" bit NOT NULL DEFAULT 0,
	"EmailDrop" bit NOT NULL DEFAULT 0,
	"OrderEmail" nvarchar(100) NULL ,
	"DropEmail" nvarchar(100) NULL ,
	"EmailDropWhen" nvarchar(15) NOT NULL ,
	"Giftcard" bit NOT NULL DEFAULT 0,
	"Delivery" bit NOT NULL DEFAULT 0,
	"Coupons" bit NOT NULL DEFAULT 0,
	"Backorders" bit NOT NULL DEFAULT 0,
	"BaseOrderNum" int NOT NULL  DEFAULT 0,
	"StoreCardInfo" bit NOT NULL  DEFAULT 0,
	"UseCVV2" bit NOT NULL DEFAULT 0,
	"MinTotal" int NULL  DEFAULT 0,
	"NoGuests" bit NOT NULL DEFAULT 0,
	"UseBilling" bit NOT NULL DEFAULT 0,
	"UsePayPal" bit NOT NULL DEFAULT 0,
	"PayPalEmail" nvarchar(100) NULL ,
	"PayPalLog" bit NOT NULL DEFAULT 0,
	"CustomText1" nvarchar(255) NULL ,
	"CustomText2" nvarchar(255) NULL ,
	"CustomText3" nvarchar(255) NULL ,
	"CustomSelect1" nvarchar(100) NULL ,
	"CustomSelect2" nvarchar(100) NULL ,
	"CustomChoices1" ntext NULL ,
	"CustomChoices2" ntext NULL ,
	"CustomText_Req" nvarchar(50) NULL ,
	"CustomSelect_Req" nvarchar(50) NULL ,
	"AgreeTerms" ntext NULL ,
	"Giftwrap" bit NOT NULL DEFAULT 0,
	"ShowBasket" bit NOT NULL DEFAULT 1,
	"SkipAddressForm" bit NOT NULL DEFAULT 0
)

ALTER TABLE "OrderSettings" ADD
	CONSTRAINT "OrderSettings_PK" PRIMARY KEY CLUSTERED  ("ID")

	;
CREATE TABLE "OrderTaxes"
(
	"Order_No" int NOT NULL  DEFAULT 0,
	"Code_ID" int NOT NULL  DEFAULT 0,
	"ProductTotal" float NOT NULL  DEFAULT 0,
	"CodeName" nvarchar(50) NULL ,
	"AddressUsed" nvarchar(20) NULL ,
	"AllUserTax" float NOT NULL  DEFAULT 0,
	"StateTax" float NOT NULL  DEFAULT 0,
	"CountyTax" float NOT NULL  DEFAULT 0,
	"LocalTax" float NOT NULL  DEFAULT 0,
	"CountryTax" float NOT NULL  DEFAULT 0
)

ALTER TABLE "OrderTaxes" ADD
	CONSTRAINT "OrderTaxes_PK" PRIMARY KEY CLUSTERED  ("Order_No","Code_ID")

CREATE  INDEX "OrderTaxes_Order_No_Idx" ON "OrderTaxes" ("Order_No")

	;
CREATE TABLE "Pages"
(
	"Page_ID" int NOT NULL ,
	"Page_URL" nvarchar(75) NULL ,
	"CatCore_ID" int NULL  DEFAULT 0,
	"PassParam" nvarchar(100) NULL ,
	"Display" bit NOT NULL DEFAULT 0,
	"PageAction" nvarchar(30) NULL ,
	"Page_Name" nvarchar(100) NOT NULL ,
	"Page_Title" nvarchar(75) NULL ,
	"Sm_Image" nvarchar(100) NULL ,
	"Lg_Image" nvarchar(100) NULL ,
	"Sm_Title" nvarchar(100) NULL ,
	"Lg_Title" nvarchar(100) NULL ,
	"Color_ID" int NULL ,
	"PageText" ntext NULL ,
	"System" bit NOT NULL  DEFAULT 0,
	"Href_Attributes" nvarchar(50) NULL ,
	"AccessKey" int NULL  DEFAULT 0,
	"Priority" int NULL  DEFAULT 9999,
	"Parent_ID" int NULL  DEFAULT 0,
	"Title_Priority" int NULL  DEFAULT 0,
	"Metadescription" nvarchar(255) NULL ,
	"Keywords" nvarchar(255) NULL ,
	"TitleTag" nvarchar(255) NULL
)

ALTER TABLE "Pages" ADD
	CONSTRAINT "Pages_PK" PRIMARY KEY CLUSTERED  ("Page_ID")

CREATE  INDEX "Pages_AccessKey_Idx" ON "Pages" ("AccessKey")

CREATE  INDEX "Pages_CatCore_ID_Idx" ON "Pages" ("CatCore_ID")

CREATE  INDEX "Pages_Color_ID_Idx" ON "Pages" ("Color_ID")

;
CREATE TABLE "Permission_Groups"
(
	"Group_ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(20) NOT NULL
)

ALTER TABLE "Permission_Groups" ADD
	CONSTRAINT "Permission_Groups_PK" PRIMARY KEY CLUSTERED  ("Group_ID")

	;
CREATE TABLE "Permissions"
(
	"ID" int IDENTITY NOT NULL ,
	"Group_ID" int NOT NULL,
	"Name" nvarchar(30) NOT NULL ,
	"BitValue" int NULL  DEFAULT 0
)

ALTER TABLE "Permissions" ADD
	CONSTRAINT "Permissions_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "Permissions_Group_ID_Idx" ON "Permissions" ("Group_ID")

	;
CREATE TABLE "PickLists"
(
	"Picklist_ID" int IDENTITY NOT NULL ,
	"Feature_Type" ntext NULL ,
	"Acc_Rep" ntext NULL ,
	"Acc_Type1" ntext NULL ,
	"Acc_Descr1" ntext NULL ,
	"Product_Availability" ntext NULL ,
	"Shipping_Status" ntext NULL ,
	"PO_Status" ntext NULL ,
	"GiftRegistry_Type" ntext NULL ,
	"Review_Editorial" ntext NULL
)

ALTER TABLE "PickLists" ADD
	CONSTRAINT "PickLists_PK" PRIMARY KEY CLUSTERED  ("Picklist_ID")

	;
CREATE TABLE "Prod_CustInfo"
(
	"Product_ID" int NOT NULL,
	"Custom_ID" int NOT NULL,
	"CustomInfo" nvarchar(150) NULL
)

ALTER TABLE "Prod_CustInfo" ADD
	CONSTRAINT "Prod_CustInfo_PK" PRIMARY KEY CLUSTERED  ("Product_ID","Custom_ID")

CREATE  INDEX "Prod_CustInfo_Product_ID_Idx" ON "Prod_CustInfo" ("Product_ID")
	;
CREATE TABLE "Prod_CustomFields"
(
	"Custom_ID" int NOT NULL ,
	"Custom_Name" nvarchar(50) NULL ,
	"Custom_Display" bit NOT NULL  DEFAULT 0,
	"Google_Use" bit NOT NULL  DEFAULT 0,
	"Google_Code" nvarchar(50) NULL
)

ALTER TABLE "Prod_CustomFields" ADD
	CONSTRAINT "Prod_CustomFields_PK" PRIMARY KEY CLUSTERED  ("Custom_ID")

	;
CREATE TABLE "ProdAddons"
(
	"Addon_ID" int IDENTITY NOT NULL ,
	"Product_ID" int NOT NULL ,
	"Standard_ID" int NOT NULL ,
	"Prompt" nvarchar(100) NULL ,
	"AddonDesc" nvarchar(100) NULL ,
	"AddonType" nvarchar(10) NULL ,
	"Display" bit NOT NULL  DEFAULT 1,
	"Priority" int NOT NULL DEFAULT 9999,
	"Price" float NULL  DEFAULT 0,
	"Weight" float NULL  DEFAULT 0,
	"ProdMult" bit NOT NULL  DEFAULT 0,
	"Required" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "ProdAddons" ADD
	CONSTRAINT "ProdAddons_PK" PRIMARY KEY CLUSTERED  ("Addon_ID")

CREATE  INDEX "ProdAddons_Product_ID_Idx" ON "ProdAddons" ("Product_ID")

CREATE  INDEX "ProdAddons_Standard_ID_Idx" ON "ProdAddons" ("Standard_ID")

	;
CREATE TABLE "ProdDisc"
(
	"Product_ID" int NOT NULL,
	"ProdDisc_ID" int NOT NULL,
	"Wholesale" bit NOT NULL  DEFAULT 0,
	"QuantFrom" int NOT NULL  DEFAULT 0,
	"QuantTo" int NOT NULL  DEFAULT 0,
	"DiscountPer" float NOT NULL  DEFAULT 0
)

ALTER TABLE "ProdDisc" ADD
	CONSTRAINT "ProdDisc_PK" PRIMARY KEY CLUSTERED  ("Product_ID","ProdDisc_ID")

CREATE  INDEX "ProdDisc_Product_ID_Idx" ON "ProdDisc" ("Product_ID")

	;
CREATE TABLE "ProdGrpPrice"
(
	"Product_ID" int NOT NULL ,
	"GrpPrice_ID" int NOT NULL ,
	"Group_ID" int NOT NULL,
	"Price" float NOT NULL  DEFAULT 0
)

ALTER TABLE "ProdGrpPrice" ADD
	CONSTRAINT "ProdGrpPrice_PK" PRIMARY KEY CLUSTERED  ("Product_ID","GrpPrice_ID")

CREATE  INDEX "ProdGrpPrice_Group_ID_Idx" ON "ProdGrpPrice" ("Group_ID")

CREATE  INDEX "ProdGrpPrice_Product_ID_Idx" ON "ProdGrpPrice" ("Product_ID")
	;
CREATE TABLE "ProdOpt_Choices"
(
	"Option_ID" int NOT NULL,
	"Choice_ID" int NOT NULL,
	"ChoiceName" nvarchar(50) NULL ,
	"Price" float NULL DEFAULT 0,
	"Weight" float NULL DEFAULT 0,
	"SKU" nvarchar(50) NULL ,
	"NumInStock" int NULL  DEFAULT 0,
	"Display" bit NOT NULL DEFAULT 0,
	"SortOrder" int NULL  DEFAULT 0
)

ALTER TABLE "ProdOpt_Choices" ADD
	CONSTRAINT "ProdOpt_Choices_PK" PRIMARY KEY CLUSTERED  ("Option_ID","Choice_ID")

CREATE  INDEX "ProdOpt_Choices_Option_ID_Idx" ON "ProdOpt_Choices" ("Option_ID")

	;
CREATE TABLE "Product_Category"
(
	"ID" int IDENTITY NOT NULL ,
	"Product_ID" int NOT NULL,
	"Category_ID" int NOT NULL
)

ALTER TABLE "Product_Category" ADD
	CONSTRAINT "Product_Category_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "Product_Category_Category_ID_Idx" ON "Product_Category" ("Category_ID")

CREATE  INDEX "Product_Category_Product_ID_Idx" ON "Product_Category" ("Product_ID")

	;
CREATE TABLE "Product_Images"
(
	"Product_Image_ID" int NOT NULL ,
	"Product_ID" int NOT NULL,
	"Image_File" nvarchar(150) NOT NULL ,
	"Gallery" nvarchar(50) NULL ,
	"File_Size" int NULL  DEFAULT 0,
	"Caption" nvarchar(100) NULL ,
	"Priority" int NULL  DEFAULT 0
)

ALTER TABLE "Product_Images" ADD
	CONSTRAINT "Product_Images_PK" PRIMARY KEY CLUSTERED  ("Product_Image_ID")

CREATE  INDEX "Product_Images_Product_ID_Idx" ON "Product_Images" ("Product_ID")

	;
CREATE TABLE "Product_Item"
(
	"Product_Item_ID" int IDENTITY NOT NULL ,
	"Product_ID" int NOT NULL,
	"Item_ID" int NOT NULL
)

ALTER TABLE "Product_Item" ADD
	CONSTRAINT "Product_Item_PK" PRIMARY KEY CLUSTERED  ("Product_Item_ID")

CREATE  INDEX "Product_Item_Item_ID_Idx" ON "Product_Item" ("Item_ID")

CREATE  INDEX "Product_Item_Product_ID_Idx" ON "Product_Item" ("Product_ID")

	;
CREATE TABLE "Product_Options"
(
	"Option_ID" int IDENTITY NOT NULL ,
	"Product_ID" int NOT NULL,
	"Std_ID" int NOT NULL DEFAULT 0,
	"Prompt" nvarchar(50) NULL ,
	"OptDesc" nvarchar(50) NULL ,
	"ShowPrice" nvarchar(10) NULL ,
	"Display" bit NOT NULL  DEFAULT 0,
	"Priority" int NULL  DEFAULT 0,
	"TrackInv" bit NOT NULL  DEFAULT 0,
	"Required" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "Product_Options" ADD
	CONSTRAINT "Product_Options_PK" PRIMARY KEY CLUSTERED  ("Option_ID")

CREATE  INDEX "Product_Options_Product_ID_Idx" ON "Product_Options" ("Product_ID")

CREATE  INDEX "Product_Options_Std_ID_Idx" ON "Product_Options" ("Std_ID")

	;
CREATE TABLE "ProductReviews"
(
	"Review_ID" int IDENTITY NOT NULL,
	"Product_ID" int NOT NULL,
	"User_ID" int NULL  DEFAULT 0,
	"Anonymous" bit NOT NULL DEFAULT 0,
	"Anon_Name" nvarchar(50) NULL ,
	"Anon_Loc" nvarchar(50) NULL ,
	"Anon_Email" nvarchar(75) NULL ,
	"Editorial" nvarchar(50) NULL ,
	"Title" nvarchar(75) NOT NULL ,
	"Comment" ntext NOT NULL ,
	"Rating" smallint NULL  DEFAULT 0,
	"Recommend" bit NOT NULL DEFAULT 0,
	"Posted" datetime NOT NULL ,
	"Updated" datetime NULL ,
	"Approved" bit NOT NULL DEFAULT 0,
	"NeedsCheck" bit NOT NULL DEFAULT 0,
	"Helpful_Total" int NULL  DEFAULT 0,
	"Helpful_Yes" int NULL  DEFAULT 0
)

ALTER TABLE "ProductReviews" ADD
	CONSTRAINT "ProductReviews_PK" PRIMARY KEY CLUSTERED  ("Review_ID")

CREATE  INDEX "ProductReviews_Posted_Idx" ON "ProductReviews" ("Posted")

CREATE  INDEX "ProductReviews_Product_ID_Idx" ON "ProductReviews" ("Product_ID")

CREATE  INDEX "ProductReviews_Rating_Idx" ON "ProductReviews" ("Rating")

CREATE  INDEX "ProductReviews_User_ID_Idx" ON "ProductReviews" ("User_ID")

	;
CREATE TABLE "ProductReviewsHelpful"
(
	"Helpful_ID" nvarchar(35) NOT NULL,
	"Product_ID" int NOT NULL,
	"Review_ID" int NOT NULL,
	"Helpful" bit NOT NULL DEFAULT 0,
	"User_ID" int NULL  DEFAULT 0,
	"Date_Stamp" datetime NULL  DEFAULT 'Date()',
	"IP" nvarchar(30) NULL
)

ALTER TABLE "ProductReviewsHelpful" ADD
	CONSTRAINT "ProductReviewsHelpful_PK" PRIMARY KEY CLUSTERED  ("Helpful_ID")

CREATE  INDEX "ProductReviewsHelpful_IP_Idx" ON "ProductReviewsHelpful" ("IP")

CREATE  INDEX "ProductReviewsHelpful_Product_ID_Idx" ON "ProductReviewsHelpful" ("Product_ID")

CREATE  INDEX "ProductReviewsHelpful_Review_ID_Idx" ON "ProductReviewsHelpful" ("Review_ID")

CREATE  INDEX "ProductReviewsHelpful_User_ID_Idx" ON "ProductReviewsHelpful" ("User_ID")

	;
CREATE TABLE "Products"
(
	"Product_ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(255) NOT NULL ,
	"Short_Desc" ntext NULL ,
	"Long_Desc" ntext NULL ,
	"SKU" nvarchar(50) NULL ,
	"Vendor_SKU" nvarchar(50) NULL ,
	"Retail_Price" float NULL  DEFAULT 0,
	"Base_Price" float NOT NULL  DEFAULT 0,
	"Wholesale" float NOT NULL  DEFAULT 0,
	"Dropship_Cost" float NULL  DEFAULT 0,
	"Weight" float NULL  DEFAULT 0,
	"Shipping" bit NOT NULL  DEFAULT 1,
	"TaxCodes" nvarchar(50) NULL ,
	"AccessKey" int NULL  DEFAULT 0,
	"Sm_Image" nvarchar(100) NULL ,
	"Lg_Image" nvarchar(255) NULL ,
	"Enlrg_Image" nvarchar(100) NULL ,
	"Sm_Title" nvarchar(100) NULL ,
	"Lg_Title" nvarchar(100) NULL ,
	"PassParam" nvarchar(100) NULL ,
	"Color_ID" int NULL ,
	"Display" bit NOT NULL  DEFAULT 1,
	"Priority" int NOT NULL  DEFAULT 9999,
	"NumInStock" int NULL  DEFAULT 0,
	"ShowOrderBox" bit NOT NULL  DEFAULT 0,
	"ShowPrice" bit NOT NULL  DEFAULT 1,
	"ShowDiscounts" bit NOT NULL  DEFAULT 1,
	"ShowPromotions" bit NOT NULL  DEFAULT 0,
	"Highlight" bit NOT NULL  DEFAULT 0,
	"NotSold" bit NOT NULL  DEFAULT 0,
	"Reviewable" bit NOT NULL  DEFAULT 0,
	"UseforPOTD" bit NOT NULL  DEFAULT 0,
	"Sale" bit NOT NULL DEFAULT 0,
	"Hot" bit NOT NULL DEFAULT 0,
	"DateAdded" datetime NULL ,
	"OptQuant" int NOT NULL  DEFAULT 0,
	"Reorder_Level" int NULL  DEFAULT 0,
	"Min_Order" int NULL  DEFAULT 0,
	"Mult_Min" bit NOT NULL  DEFAULT 0,
	"Sale_Start" datetime NULL ,
	"Sale_End" datetime NULL ,
	"Discounts" nvarchar(255) NULL ,
	"Promotions" nvarchar(255) NULL ,
	"Account_ID" int NULL  DEFAULT 0,
	"Mfg_Account_ID" int NULL  DEFAULT 0,
	"Prod_Type" nvarchar(50) NULL ,
	"Content_URL" nvarchar(75) NULL ,
	"MimeType" nvarchar(50) NULL ,
	"Access_Count" int NULL  DEFAULT 0,
	"Num_Days" int NULL  DEFAULT 0,
	"Access_Keys" nvarchar(50) NULL ,
	"Recur" bit NOT NULL  DEFAULT 0,
	"Recur_Product_ID" int NULL  DEFAULT 0,
	"VertOptions" bit NOT NULL  DEFAULT 0,
	"Metadescription" nvarchar(255) NULL ,
	"Keywords" nvarchar(255) NULL ,
	"TitleTag" nvarchar(255) NULL ,
	"GiftWrap" bit NOT NULL  DEFAULT 0,
	"Availability" nvarchar(75) NULL ,
	"Freight_Dom" float NULL  DEFAULT 0,
	"Freight_Intl" float NULL  DEFAULT 0,
	"Pack_Width" float NULL  DEFAULT 0,
	"Pack_Height" float NULL  DEFAULT 0,
	"Pack_Length" float NULL  DEFAULT 0,
	"User_ID" int NULL  DEFAULT 0,
	"Goog_Brand" nvarchar(100) NULL ,
	"Goog_Condition" nvarchar(100) NULL ,
	"Goog_Expire" datetime NULL ,
	"Goog_Prodtype" nvarchar(100) NULL
)

ALTER TABLE "Products" ADD
	CONSTRAINT "Products_PK" PRIMARY KEY CLUSTERED  ("Product_ID")

CREATE  INDEX "Products_AccessKey_Idx" ON "Products" ("AccessKey")

CREATE  INDEX "Products_Account_ID_Idx" ON "Products" ("Account_ID")

CREATE  INDEX "Products_Highlight_Idx" ON "Products" ("Highlight")

CREATE  INDEX "Products_NumInStock_Idx" ON "Products" ("NumInStock")

CREATE  INDEX "Products_Recur_Product_ID_Idx" ON "Products" ("Recur_Product_ID")

CREATE  INDEX "Products_User_ID_Idx" ON "Products" ("User_ID")
	;
CREATE TABLE "Promotion_Groups"
(
	"ID" int IDENTITY NOT NULL ,
	"Promotion_ID" int NOT NULL,
	"Group_ID" int NOT NULL
)

ALTER TABLE "Promotion_Groups" ADD
	CONSTRAINT "Promotion_Groups_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "Promotion_Groups_Group_ID_Idx" ON "Promotion_Groups" ("Group_ID")

CREATE  INDEX "Promotion_Groups_Promotion_ID_Idx" ON "Promotion_Groups" ("Promotion_ID")

	;
CREATE TABLE "Promotion_Qual_Products"
(
	"ID" int IDENTITY NOT NULL ,
	"Promotion_ID" int NOT NULL,
	"Product_ID" int NOT NULL
)

ALTER TABLE "Promotion_Qual_Products" ADD
	CONSTRAINT "Promotion_Qual_Products_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "Promotion_Qual_Products_Product_ID_Idx" ON "Promotion_Qual_Products" ("Product_ID")

CREATE  INDEX "Promotion_Qual_Products_Promotion_ID_Idx" ON "Promotion_Qual_Products" ("Promotion_ID")

	;
CREATE TABLE "Promotions"
(
	"Promotion_ID" int IDENTITY NOT NULL ,
	"Type1" int NOT NULL  DEFAULT 1,
	"Type2" int NOT NULL  DEFAULT 1,
	"Type3" int NOT NULL  DEFAULT 0,
	"Type4" int NOT NULL  DEFAULT 0,
	"Coup_Code" nvarchar(50) NULL ,
	"OneTime" bit NOT NULL DEFAULT 0,
	"Name" nvarchar(255) NOT NULL ,
	"Display" nvarchar(255) NULL ,
	"Amount" float NOT NULL  DEFAULT 0,
	"QualifyNum" float NOT NULL  DEFAULT 0,
	"DiscountNum" float NOT NULL  DEFAULT 0,
	"Multiply" bit NOT NULL DEFAULT 0,
	"StartDate" datetime NULL ,
	"EndDate" datetime NULL ,
	"Disc_Product" int NOT NULL  DEFAULT 0,
	"Add_DiscProd" bit NOT NULL DEFAULT 0,
	"AccessKey" int NULL  DEFAULT 0
)

ALTER TABLE "Promotions" ADD
	CONSTRAINT "Promotions_PK" PRIMARY KEY CLUSTERED  ("Promotion_ID")

CREATE  INDEX "Promotions_AccessKey_Idx" ON "Promotions" ("AccessKey")

CREATE  INDEX "Promotions_Coup_Code_Idx" ON "Promotions" ("Coup_Code")

	;
CREATE TABLE "Settings"
(
	"SettingID" int IDENTITY NOT NULL ,
	"SiteName" nvarchar(50) NULL ,
	"SiteLogo" nvarchar(100) NULL ,
	"Merchant" ntext NULL ,
	"HomeCountry" nvarchar(100) NULL ,
	"MerchantEmail" nvarchar(150) NULL ,
	"Webmaster" nvarchar(150) NULL ,
	"DefaultImages" nvarchar(100) NULL ,
	"FilePath" nvarchar(150) NULL ,
	"MimeTypes" nvarchar(255) NULL ,
	"MoneyUnit" nvarchar(50) NULL ,
	"WeightUnit" nvarchar(50) NULL ,
	"SizeUnit" nvarchar(50) NULL ,
	"InvLevel" nvarchar(50) NULL ,
	"ShowInStock" bit NOT NULL  DEFAULT 0,
	"OutofStock" bit NOT NULL  DEFAULT 1,
	"ShowRetail" bit NOT NULL  DEFAULT 1,
	"ItemSort" nvarchar(50) NULL ,
	"Wishlists" bit NOT NULL  DEFAULT 0,
	"OrderButtonText" nvarchar(50) NULL ,
	"OrderButtonImage" nvarchar(100) NULL ,
	"AllowWholesale" bit NOT NULL  DEFAULT 0,
	"UseVerity" bit NOT NULL DEFAULT 0,
	"CollectionName" nvarchar(50) NULL ,
	"CColumns" int NOT NULL  DEFAULT 0,
	"PColumns" int NOT NULL  DEFAULT 0,
	"MaxProds" int NOT NULL  DEFAULT 9999,
	"ProdRoot" int NULL  DEFAULT 0,
	"CachedProds" bit NOT NULL  DEFAULT 0,
	"FeatureRoot" int NULL  DEFAULT 0,
	"MaxFeatures" smallint NULL  DEFAULT 0,
	"Locale" nvarchar(30) NULL ,
	"CurrExchange" nvarchar(30) NULL ,
	"CurrExLabel" nvarchar(30) NULL ,
	"Color_ID" smallint NULL  DEFAULT 0,
	"Metadescription" nvarchar(255) NULL ,
	"Keywords" nvarchar(255) NULL ,
	"Email_Server" nvarchar(255) NULL ,
	"Email_Port" int NULL  DEFAULT 0,
	"Admin_New_Window" bit NOT NULL DEFAULT 0,
	"UseSES" bit NOT NULL  DEFAULT 0,
	"Default_Fuseaction" nvarchar(50) NULL ,
	"Editor" nvarchar(20) NULL ,
	"ProductReviews" bit NOT NULL DEFAULT 0,
	"ProductReview_Approve" bit NOT NULL DEFAULT 0,
	"ProductReview_Flag" bit NOT NULL DEFAULT 0,
	"ProductReview_Add" int NULL  DEFAULT 1,
	"ProductReview_Rate" bit NOT NULL DEFAULT 0,
	"ProductReviews_Page" int NULL  DEFAULT 4,
	"FeatureReviews" bit NOT NULL DEFAULT 0,
	"FeatureReview_Add" int NULL  DEFAULT 1,
	"FeatureReview_Flag" bit NOT NULL DEFAULT 0,
	"FeatureReview_Approve" bit NOT NULL DEFAULT 0,
	"GiftRegistry" bit NOT NULL DEFAULT 0
)

ALTER TABLE "Settings" ADD
	CONSTRAINT "Settings_PK" PRIMARY KEY CLUSTERED  ("SettingID")

	;
CREATE TABLE "Shipping"
(
	"ID" int IDENTITY NOT NULL ,
	"MinOrder" float NOT NULL  DEFAULT 0,
	"MaxOrder" float NOT NULL  DEFAULT 0,
	"Amount" float NOT NULL  DEFAULT 0
)

ALTER TABLE "Shipping" ADD
	CONSTRAINT "Shipping_PK" PRIMARY KEY CLUSTERED  ("ID")

	;
CREATE TABLE "ShipSettings"
(
	"ID" int IDENTITY NOT NULL ,
	"ShipType" nvarchar(50) NULL ,
	"ShipBase" float NOT NULL ,
	"MerchantZip" nvarchar(10) NULL ,
	"InStorePickup" bit NOT NULL  DEFAULT 0,
	"AllowNoShip" bit NOT NULL DEFAULT 0,
	"NoShipMess" ntext NULL ,
	"NoShipType" nvarchar(50) NULL ,
	"ShipHand" float NOT NULL ,
	"Freeship_Min" int NULL  DEFAULT 0,
	"Freeship_ShipIDs" nvarchar(50) NULL ,
	"ShowEstimator" bit NOT NULL  DEFAULT 0,
	"ShowFreight" bit NOT NULL  DEFAULT 0,
	"UseDropShippers" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "ShipSettings" ADD
	CONSTRAINT "ShipSettings_PK" PRIMARY KEY CLUSTERED  ("ID")

	;
CREATE TABLE "States"
(
	"Abb" nvarchar(2) NOT NULL ,
	"Name" nvarchar(50) NOT NULL
)

ALTER TABLE "States" ADD
	CONSTRAINT "States_PK" PRIMARY KEY CLUSTERED  ("Abb")

	;
CREATE TABLE "StateTax"
(
	"Tax_ID" int IDENTITY NOT NULL ,
	"Code_ID" int NOT NULL DEFAULT 0,
	"State" nvarchar(2) NOT NULL ,
	"TaxRate" float NOT NULL  DEFAULT 0,
	"TaxShip" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "StateTax" ADD
	CONSTRAINT "StateTax_PK" PRIMARY KEY CLUSTERED  ("Tax_ID")

CREATE  INDEX "StateTax_Code_ID_Idx" ON "StateTax" ("Code_ID")

CREATE  INDEX "StateTax_State_Idx" ON "StateTax" ("State")
	;
CREATE TABLE "StdAddons"
(
	"Std_ID" int IDENTITY NOT NULL ,
	"Std_Name" nvarchar(50) NOT NULL ,
	"Std_Prompt" nvarchar(100) NOT NULL ,
	"Std_Desc" nvarchar(100) NULL ,
	"Std_Type" nvarchar(10) NOT NULL ,
	"Std_Display" bit NOT NULL DEFAULT 0,
	"Std_Price" float NULL  DEFAULT 0,
	"Std_Weight" float NULL  DEFAULT 0,
	"Std_ProdMult" bit NOT NULL DEFAULT 0,
	"Std_Required" bit NOT NULL DEFAULT 0,
	"User_ID" int NULL  DEFAULT 0
)

ALTER TABLE "StdAddons" ADD
	CONSTRAINT "StdAddons_PK" PRIMARY KEY CLUSTERED  ("Std_ID")

CREATE  INDEX "StdAddons_User_ID_Idx" ON "StdAddons" ("User_ID")

	;
CREATE TABLE "StdOpt_Choices"
(
	"Std_ID" int NOT NULL,
	"Choice_ID" int NOT NULL,
	"ChoiceName" nvarchar(50) NULL ,
	"Price" float NULL  DEFAULT 0,
	"Weight" float NULL  DEFAULT 0,
	"Display" bit NOT NULL DEFAULT 0,
	"SortOrder" int NULL  DEFAULT 0
)

ALTER TABLE "StdOpt_Choices" ADD
	CONSTRAINT "StdOpt_Choices_PK" PRIMARY KEY CLUSTERED  ("Std_ID","Choice_ID")

CREATE  INDEX "StdOpt_Choices_Std_ID_Idx" ON "StdOpt_Choices" ("Std_ID")

	;
CREATE TABLE "StdOptions"
(
	"Std_ID" int IDENTITY NOT NULL ,
	"Std_Name" nvarchar(50) NOT NULL ,
	"Std_Prompt" nvarchar(50) NOT NULL ,
	"Std_Desc" nvarchar(50) NULL ,
	"Std_ShowPrice" nvarchar(10) NOT NULL ,
	"Std_Display" bit NOT NULL DEFAULT 0,
	"Std_Required" bit NOT NULL DEFAULT 0,
	"User_ID" int NULL  DEFAULT 0
)

ALTER TABLE "StdOptions" ADD
	CONSTRAINT "StdOptions_PK" PRIMARY KEY CLUSTERED  ("Std_ID")

CREATE  INDEX "StdOptions_User_ID_Idx" ON "StdOptions" ("User_ID")

	;
CREATE TABLE "TaxCodes"
(
	"Code_ID" int IDENTITY NOT NULL ,
	"CodeName" nvarchar(50) NOT NULL ,
	"DisplayName" nvarchar(50) NULL ,
	"CalcOrder" int NULL  DEFAULT 0,
	"Cumulative" bit NOT NULL  DEFAULT 0,
	"TaxAddress" nvarchar(25) NULL ,
	"TaxAll" bit NOT NULL  DEFAULT 0,
	"TaxRate" float NULL  DEFAULT 0,
	"TaxShipping" bit NOT NULL  DEFAULT 0,
	"ShowonProds" bit NOT NULL DEFAULT 0
)

ALTER TABLE "TaxCodes" ADD
	CONSTRAINT "TaxCodes_PK" PRIMARY KEY CLUSTERED  ("Code_ID")

	;
CREATE TABLE "TempBasket"
(
	"Basket_ID" nvarchar(60) NOT NULL ,
	"BasketNum" nvarchar(30) NOT NULL ,
	"Product_ID" int NOT NULL ,
	"Options" nvarchar(2000) NULL ,
	"Addons" nvarchar(1000) NULL ,
	"AddonMultP" float NULL  DEFAULT 0,
	"AddonNonMultP" float NULL  DEFAULT 0,
	"AddonMultW" float NULL  DEFAULT 0,
	"AddonNonMultW" float NULL  DEFAULT 0,
	"OptPrice" float NOT NULL  DEFAULT 0,
	"OptWeight" float NOT NULL  DEFAULT 0,
	"SKU" nvarchar(100) NULL ,
	"Price" float NULL DEFAULT 0,
	"Weight" float NULL DEFAULT 0,
	"Quantity" int NULL DEFAULT 0,
	"OptQuant" int NOT NULL  DEFAULT 0,
	"OptChoice" int NULL  DEFAULT 0,
	"OptionID_List" nvarchar(255) NULL ,
	"ChoiceID_List" nvarchar(255) NULL ,
	"GiftItem_ID" int NULL  DEFAULT 0,
	"Discount" int NULL DEFAULT 0,
	"DiscAmount" float NULL  DEFAULT 0,
	"Disc_Code" nvarchar(50) NULL ,
	"QuantDisc" float NULL DEFAULT 0,
	"Promotion" int NULL  DEFAULT 0,
	"PromoAmount" float NULL  DEFAULT 0,
	"PromoQuant" int NULL  DEFAULT 0,
	"Promo_Code" nvarchar(50) NULL ,
	"DateAdded" datetime NULL
)

ALTER TABLE "TempBasket" ADD
	CONSTRAINT "TempBasket_PK" PRIMARY KEY CLUSTERED  ("Basket_ID")

CREATE  INDEX "TempBasket_BasketNum_Idx" ON "TempBasket" ("BasketNum")

CREATE  INDEX "TempBasket_Product_ID_Idx" ON "TempBasket" ("Product_ID")

	;
CREATE TABLE "TempCustomer"
(
	"TempCust_ID" nvarchar(30) NOT NULL ,
	"FirstName" nvarchar(50) NULL ,
	"LastName" nvarchar(100) NULL ,
	"Company" nvarchar(150) NULL ,
	"Address1" nvarchar(150) NULL ,
	"Address2" nvarchar(150) NULL ,
	"City" nvarchar(150) NULL ,
	"County" nvarchar(50) NULL ,
	"State" nvarchar(50) NULL ,
	"State2" nvarchar(50) NULL ,
	"Zip" nvarchar(50) NULL ,
	"Country" nvarchar(50) NULL ,
	"Phone" nvarchar(50) NULL ,
	"Email" nvarchar(150) NULL ,
	"ShipToYes" bit NOT NULL DEFAULT 0,
	"DateAdded" datetime NULL ,
	"Phone2" nvarchar(50) NULL ,
	"Fax" nvarchar(50) NULL ,
	"Residence" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "TempCustomer" ADD
	CONSTRAINT "TempCustomer_PK" PRIMARY KEY CLUSTERED  ("TempCust_ID")

	;
CREATE TABLE "TempOrder"
(
	"BasketNum" nvarchar(30) NOT NULL ,
	"OrderTotal" float NULL ,
	"Tax" float NULL ,
	"ShipType" nvarchar(75) NULL ,
	"Shipping" float NULL  DEFAULT 0,
	"Freight" int NULL  DEFAULT 0,
	"OrderDisc" float NULL  DEFAULT 0,
	"Credits" float NULL  DEFAULT 0,
	"AddonTotal" float NULL  DEFAULT 0,
	"DateAdded" datetime NULL ,
	"Affiliate" int NULL  DEFAULT 0,
	"Referrer" nvarchar(255) NULL ,
	"GiftCard" nvarchar(255) NULL ,
	"Delivery" nvarchar(50) NULL ,
	"Comments" nvarchar(255) NULL ,
	"CustomText1" nvarchar(255) NULL ,
	"CustomText2" nvarchar(255) NULL ,
	"CustomText3" nvarchar(255) NULL ,
	"CustomSelect1" nvarchar(100) NULL ,
	"CustomSelect2" nvarchar(100) NULL
)

ALTER TABLE "TempOrder" ADD
	CONSTRAINT "TempOrder_PK" PRIMARY KEY CLUSTERED  ("BasketNum")

	;
CREATE TABLE "TempShipTo"
(
	"TempShip_ID" nvarchar(30) NOT NULL ,
	"FirstName" nvarchar(50) NULL ,
	"LastName" nvarchar(150) NULL ,
	"Company" nvarchar(150) NULL ,
	"Address1" nvarchar(150) NULL ,
	"Address2" nvarchar(150) NULL ,
	"City" nvarchar(150) NULL ,
	"County" nvarchar(50) NULL ,
	"State" nvarchar(50) NULL ,
	"State2" nvarchar(50) NULL ,
	"Zip" nvarchar(50) NULL ,
	"Country" nvarchar(50) NULL ,
	"DateAdded" datetime NULL ,
	"Phone" nvarchar(50) NULL ,
	"Email" nvarchar(150) NULL ,
	"Residence" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "TempShipTo" ADD
	CONSTRAINT "TempShipTo_PK" PRIMARY KEY CLUSTERED  ("TempShip_ID")

	;
CREATE TABLE "UPS_Origins"
(
	"UPS_Code" nvarchar(10) NOT NULL ,
	"Description" nvarchar(20) NULL ,
	"OrderBy" int NULL  DEFAULT 0
)

ALTER TABLE "UPS_Origins" ADD
	CONSTRAINT "UPS_Origins_PK" PRIMARY KEY CLUSTERED  ("UPS_Code")

	;
CREATE TABLE "UPS_Packaging"
(
	"UPS_Code" nvarchar(10) NOT NULL ,
	"Description" nvarchar(50) NULL
)

ALTER TABLE "UPS_Packaging" ADD
	CONSTRAINT "UPS_Packaging_PK" PRIMARY KEY CLUSTERED  ("UPS_Code")

	;
CREATE TABLE "UPS_Pickup"
(
	"UPS_Code" nvarchar(10) NOT NULL ,
	"Description" nvarchar(50) NULL
)

ALTER TABLE "UPS_Pickup" ADD
	CONSTRAINT "UPS_Pickup_PK" PRIMARY KEY CLUSTERED  ("UPS_Code")

	;
CREATE TABLE "UPS_Settings"
(
	"UPS_ID" int IDENTITY NOT NULL ,
	"ResRates" bit NOT NULL DEFAULT 0,
	"Username" nvarchar(150) NULL ,
	"Password" nvarchar(100) NULL ,
	"Accesskey" nvarchar(100) NULL ,
	"AccountNo" nvarchar(20) NULL ,
	"Origin" nvarchar(10) NULL ,
	"MaxWeight" int NULL  DEFAULT 0,
	"UnitsofMeasure" nvarchar(20) NULL ,
	"CustomerClass" nvarchar(20) NULL ,
	"Pickup" nvarchar(20) NULL ,
	"Packaging" nvarchar(20) NULL ,
	"OrigZip" nvarchar(20) NULL ,
	"OrigCity" nvarchar(75) NULL ,
	"OrigCountry" nvarchar(10) NULL ,
	"Debug" bit NOT NULL  DEFAULT 0,
	"UseAV" bit NOT NULL  DEFAULT 0,
	"Logging" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "UPS_Settings" ADD
	CONSTRAINT "UPS_Settings_PK" PRIMARY KEY CLUSTERED  ("UPS_ID")

	;
CREATE TABLE "UPSMethods"
(
	"ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(75) NULL ,
	"USCode" nvarchar(5) NULL ,
	"EUCode" nvarchar(5) NULL ,
	"CACode" nvarchar(5) NULL ,
	"PRCode" nvarchar(5) NULL ,
	"MXCode" nvarchar(5) NULL ,
	"OOCode" nvarchar(5) NULL ,
	"Used" bit NOT NULL  DEFAULT 0,
	"Priority" int NULL  DEFAULT 0
)

ALTER TABLE "UPSMethods" ADD
	CONSTRAINT "UPSMethods_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "UPSMethods_Used_Idx" ON "UPSMethods" ("Used")

	;
CREATE TABLE "Users"
(
	"User_ID" int IDENTITY NOT NULL ,
	"Username" nvarchar(50) NOT NULL ,
	"Password" nvarchar(50) NOT NULL ,
	"Email" nvarchar(50) NULL ,
	"EmailIsBad" bit NOT NULL DEFAULT 0,
	"EmailLock" nvarchar(50) NULL ,
	"Subscribe" bit NOT NULL  DEFAULT 0,
	"Customer_ID" int NOT NULL  DEFAULT 0,
	"ShipTo" int NOT NULL  DEFAULT 0,
	"Group_ID" int NOT NULL  DEFAULT 0,
	"Account_ID" int NULL  DEFAULT 0,
	"Affiliate_ID" int NULL  DEFAULT 0,
	"Basket" nvarchar(30) NULL ,
	"Birthdate" datetime NULL ,
	"CardisValid" bit NOT NULL DEFAULT 0,
	"CardType" nvarchar(50) NULL ,
	"NameonCard" nvarchar(75) NULL ,
	"CardNumber" nvarchar(50) NULL ,
	"CardExpire" datetime NULL ,
	"CardZip" nvarchar(50) NULL ,
	"EncryptedCard" nvarchar(75) NULL ,
	"CurrentBalance" int NULL  DEFAULT 0,
	"LastLogin" datetime NULL ,
	"Permissions" nvarchar(255) NULL ,
	"AdminNotes" ntext NULL ,
	"Disable" bit NOT NULL DEFAULT 0,
	"LoginsTotal" int NULL  DEFAULT 0,
	"LoginsDay" int NULL  DEFAULT 0,
	"FailedLogins" int NULL  DEFAULT 0,
	"LastAttempt" datetime NULL ,
	"Created" datetime NULL ,
	"LastUpdate" datetime NULL,
	"ID_Tag" nvarchar(35) NULL
)

ALTER TABLE "Users" ADD
	CONSTRAINT "Users_PK" PRIMARY KEY CLUSTERED  ("User_ID")

CREATE  INDEX "Users_Account_ID_Idx" ON "Users" ("Account_ID")

CREATE  INDEX "Users_Affiliate_ID_Idx" ON "Users" ("Affiliate_ID")

CREATE  INDEX "Users_Customer_ID_Idx" ON "Users" ("Customer_ID")

CREATE  INDEX "Users_Group_ID_Idx" ON "Users" ("Group_ID")

CREATE  INDEX "Users_ID_Tag_Idx" ON "Users" ("ID_Tag")

	;
CREATE TABLE "UserSettings"
(
	"ID" int IDENTITY NOT NULL ,
	"UseRememberMe" bit NOT NULL DEFAULT 0,
	"EmailAsName" bit NOT NULL DEFAULT 0,
	"UseStateList" bit NOT NULL DEFAULT 0,
	"UseStateBox" bit NOT NULL DEFAULT 0,
	"RequireCounty" bit NOT NULL  DEFAULT 0,
	"UseCountryList" bit NOT NULL DEFAULT 0,
	"UseResidential" bit NOT NULL  DEFAULT 0,
	"UseGroupCode" bit NOT NULL DEFAULT 0,
	"UseBirthdate" bit NOT NULL DEFAULT 0,
	"UseTerms" bit NOT NULL DEFAULT 0,
	"TermsText" ntext NULL ,
	"UseCCard" bit NOT NULL DEFAULT 0,
	"UseEmailConf" bit NOT NULL DEFAULT 0,
	"UseEmailNotif" bit NOT NULL DEFAULT 0,
	"MemberNotify" bit NOT NULL  DEFAULT 0,
	"UseShipTo" bit NOT NULL DEFAULT 0,
	"UseAccounts" bit NOT NULL DEFAULT 0,
	"ShowAccount" bit NOT NULL DEFAULT 0,
	"ShowDirectory" bit NOT NULL DEFAULT 0,
	"ShowSubscribe" bit NOT NULL DEFAULT 0,
	"StrictLogins" bit NOT NULL DEFAULT 0,
	"MaxDailyLogins" int NULL  DEFAULT 0,
	"MaxFailures" int NULL  DEFAULT 0,
	"AllowAffs" bit NOT NULL DEFAULT 0,
	"AffPercent" float NULL  DEFAULT 0,
	"AllowWholesale" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "UserSettings" ADD
	CONSTRAINT "UserSettings_PK" PRIMARY KEY CLUSTERED  ("ID")

	;
CREATE TABLE "USPS_Settings"
(
	"USPS_ID" int IDENTITY NOT NULL ,
	"UserID" nvarchar(30) NOT NULL ,
	"Server" nvarchar(75) NOT NULL ,
	"MerchantZip" nvarchar(20) NULL ,
	"MaxWeight" int NULL  DEFAULT 0,
	"Logging" bit NOT NULL  DEFAULT 0,
	"Debug" bit NOT NULL  DEFAULT 0,
	"UseAV" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "USPS_Settings" ADD
	CONSTRAINT "USPS_Settings_PK" PRIMARY KEY CLUSTERED  ("USPS_ID")

	;
CREATE TABLE "USPSCountries"
(
	"ID" int NOT NULL ,
	"Abbrev" nvarchar(2) NOT NULL ,
	"Name" nvarchar(255) NOT NULL
)

ALTER TABLE "USPSCountries" ADD
	CONSTRAINT "USPSCountries_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "USPSCountries_Abbrev_Idx" ON "USPSCountries" ("Abbrev")

	;
CREATE TABLE "USPSMethods"
(
	"ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(75) NULL ,
	"Used" bit NOT NULL DEFAULT 0,
	"Code" nvarchar(225) NULL ,
	"Type" nvarchar(20) NULL ,
	"Priority" int NULL  DEFAULT 0
)

ALTER TABLE "USPSMethods" ADD
	CONSTRAINT "USPSMethods_PK" PRIMARY KEY CLUSTERED  ("ID")

CREATE  INDEX "USPSMethods_Used_Idx" ON "USPSMethods" ("Used")

	;
CREATE TABLE "WishList"
(
	"User_ID" int NOT NULL,
	"ListNum" int NOT NULL  DEFAULT 1,
	"ItemNum" int NOT NULL  DEFAULT 0,
	"ListName" nvarchar(50) NULL ,
	"Product_ID" int NOT NULL  DEFAULT 0,
	"DateAdded" datetime NULL ,
	"NumDesired" int NULL  DEFAULT 0,
	"Comments" nvarchar(255) NULL
)

ALTER TABLE "WishList" ADD
	CONSTRAINT "WishList_PK" PRIMARY KEY CLUSTERED  ("User_ID","ListNum","ItemNum")

CREATE  INDEX "WishList_Product_ID_Idx" ON "WishList" ("Product_ID")

CREATE  INDEX "WishList_User_ID_Idx" ON "WishList" ("User_ID")
	;
	
	
ALTER TABLE "CardData" ADD CONSTRAINT "Customers_CardData_FK" FOREIGN KEY ("Customer_ID" ) 
	REFERENCES "Customers" ("Customer_ID")
	
ALTER TABLE "Categories" ADD CONSTRAINT "CatCore_Categories_FK" FOREIGN KEY ("CatCore_ID" ) 
	REFERENCES "CatCore" ("CatCore_ID")

ALTER TABLE "Categories" ADD CONSTRAINT "Colors_Categories_FK" FOREIGN KEY ("Color_ID" ) 
	REFERENCES "Colors" ("Color_ID")

ALTER TABLE "Counties" ADD CONSTRAINT "States_Counties_FK" FOREIGN KEY ("State" ) 
	REFERENCES "States" ("Abb")

ALTER TABLE "Counties" ADD CONSTRAINT "TaxCodes_Counties_FK" FOREIGN KEY ("Code_ID" ) 
	REFERENCES "TaxCodes" ("Code_ID")

ALTER TABLE "CountryTax" ADD CONSTRAINT "Countries_CountryTax_FK" FOREIGN KEY ("Country_ID" ) 
	REFERENCES "Countries" ("ID")

ALTER TABLE "CountryTax" ADD CONSTRAINT "TaxCodes_CountryTax_FK" FOREIGN KEY ("Code_ID" ) 
	REFERENCES "TaxCodes" ("Code_ID")

ALTER TABLE "Discount_Categories" ADD CONSTRAINT "Categories_Discount_Categories_FK" FOREIGN KEY ("Category_ID" ) 
	REFERENCES "Categories" ("Category_ID")

ALTER TABLE "Discount_Categories" ADD CONSTRAINT "Discounts_Discount_Categories_FK" FOREIGN KEY ("Discount_ID" )
	REFERENCES "Discounts" ("Discount_ID")
	
ALTER TABLE "Discount_Groups" ADD CONSTRAINT "Groups_Discount_Groups_FK" FOREIGN KEY ("Group_ID" ) 
	REFERENCES "Groups" ("Group_ID")
	
ALTER TABLE "Discount_Products" ADD CONSTRAINT "Discounts_Discount_Products_FK" FOREIGN KEY ("Discount_ID" )
	REFERENCES "Discounts" ("Discount_ID")

ALTER TABLE "Discount_Products" ADD CONSTRAINT "Products_Discount_Products_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "Feature_Category" ADD CONSTRAINT "Categories_Feature_Category_FK" FOREIGN KEY ("Category_ID" )
	REFERENCES "Categories" ("Category_ID")

ALTER TABLE "Feature_Category" ADD CONSTRAINT "Features_Feature_Category_FK" FOREIGN KEY ("Feature_ID" )
	REFERENCES "Features" ("Feature_ID")

ALTER TABLE "Feature_Item" ADD CONSTRAINT "Features_Feature_Item_FK" FOREIGN KEY ("Feature_ID" )
	REFERENCES "Features" ("Feature_ID")

ALTER TABLE "Feature_Item" ADD CONSTRAINT "Features_Feature_Item_FK_2" FOREIGN KEY ("Item_ID" )
	REFERENCES "Features" ("Feature_ID")

ALTER TABLE "Feature_Product" ADD CONSTRAINT "Features_Feature_Product_FK" FOREIGN KEY ("Feature_ID" )
	REFERENCES "Features" ("Feature_ID")

ALTER TABLE "Feature_Product" ADD CONSTRAINT "Products_Feature_Product_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")
	
ALTER TABLE "FeatureReviews" ADD CONSTRAINT "Features_FeatureReviews_FK" FOREIGN KEY ("Feature_ID" )
	REFERENCES "Features" ("Feature_ID")

ALTER TABLE "Features" ADD CONSTRAINT "Colors_Features_FK" FOREIGN KEY ("Color_ID" )
	REFERENCES "Colors" ("Color_ID")

ALTER TABLE "Features" ADD CONSTRAINT "Users_Features_FK" FOREIGN KEY ("User_ID" )
	REFERENCES "Users" ("User_ID")

ALTER TABLE "GiftItems" ADD CONSTRAINT "GiftRegistry_GiftItems_FK" FOREIGN KEY ("GiftRegistry_ID" )
	REFERENCES "GiftRegistry" ("GiftRegistry_ID")

ALTER TABLE "GiftItems" ADD CONSTRAINT "Products_GiftItems_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")
	
ALTER TABLE "GiftRegistry" ADD CONSTRAINT "Users_GiftRegistry_FK" FOREIGN KEY ("User_ID" )
	REFERENCES "Users" ("User_ID")
	
ALTER TABLE "LocalTax" ADD CONSTRAINT "TaxCodes_LocalTax_FK" FOREIGN KEY ("Code_ID" )
	REFERENCES "TaxCodes" ("Code_ID")

ALTER TABLE "Memberships" ADD CONSTRAINT "Users_Memberships_FK" FOREIGN KEY ("User_ID" )
	REFERENCES "Users" ("User_ID")

ALTER TABLE "Order_Items" ADD CONSTRAINT "Order_No_Orders_FK" FOREIGN KEY ("Order_No" )
	REFERENCES "Order_No" ("Order_No")

ALTER TABLE "Order_No" ADD CONSTRAINT "Customers_Order_No_FK" FOREIGN KEY ("Customer_ID" )
	REFERENCES "Customers" ("Customer_ID")

ALTER TABLE "Order_PO" ADD CONSTRAINT "Order_No_Order_PO_FK" FOREIGN KEY ("Order_No" )
	REFERENCES "Order_No" ("Order_No")

ALTER TABLE "OrderTaxes" ADD CONSTRAINT "Order_No_OrderTaxes_FK" FOREIGN KEY ("Order_No" )
	REFERENCES "Order_No" ("Order_No")

ALTER TABLE "OrderTaxes" ADD CONSTRAINT "TaxCodes_OrderTaxes_FK" FOREIGN KEY ("Code_ID" )
	REFERENCES "TaxCodes" ("Code_ID")

ALTER TABLE "Pages" ADD CONSTRAINT "CatCore_Pages_FK" FOREIGN KEY ("CatCore_ID" )
	REFERENCES "CatCore" ("CatCore_ID")

ALTER TABLE "Pages" ADD CONSTRAINT "Colors_Pages_FK" FOREIGN KEY ("Color_ID" )
	REFERENCES "Colors" ("Color_ID")

ALTER TABLE "Permissions" ADD CONSTRAINT "Permission_Groups_Permissions_FK" FOREIGN KEY ("Group_ID" )
	REFERENCES "Permission_Groups" ("Group_ID")

ALTER TABLE "Prod_CustInfo" ADD CONSTRAINT "Prod_CustomFields_Prod_CustInfo_FK" FOREIGN KEY ("Custom_ID" )
	REFERENCES "Prod_CustomFields" ("Custom_ID")

ALTER TABLE "Prod_CustInfo" ADD CONSTRAINT "Products_Prod_CustInfo_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "ProdAddons" ADD CONSTRAINT "Products_ProdAddons_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "ProdDisc" ADD CONSTRAINT "Products_ProdDisc_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "ProdGrpPrice" ADD CONSTRAINT "Groups_ProdGrpPrice_FK" FOREIGN KEY ("Group_ID" )
	REFERENCES "Groups" ("Group_ID")

ALTER TABLE "ProdGrpPrice" ADD CONSTRAINT "Products_ProdGrpPrice_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "ProdOpt_Choices" ADD CONSTRAINT "Product_Options_ProdOpt_Choices_FK" FOREIGN KEY ("Option_ID" )
	REFERENCES "Product_Options" ("Option_ID")

ALTER TABLE "Product_Category" ADD CONSTRAINT "Categories_Product_Category_FK" FOREIGN KEY ("Category_ID" )
	REFERENCES "Categories" ("Category_ID")

ALTER TABLE "Product_Category" ADD CONSTRAINT "Products_Product_Category_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "Product_Images" ADD CONSTRAINT "Products_Product_Images_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "Product_Item" ADD CONSTRAINT "Products_Product_Item_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "Product_Item" ADD CONSTRAINT "Products_Product_Item_FK_2" FOREIGN KEY ("Item_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "Product_Options" ADD CONSTRAINT "Products_Product_Options_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "ProductReviews" ADD CONSTRAINT "Products_ProductReviews_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "ProductReviewsHelpful" ADD CONSTRAINT "Products_ProductReviewsHelpful_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "Products" ADD CONSTRAINT "Colors_Products_FK" FOREIGN KEY ("Color_ID" )
	REFERENCES "Colors" ("Color_ID")

ALTER TABLE "Promotion_Groups" ADD CONSTRAINT "Groups_Promotion_Groups_FK" FOREIGN KEY ("Group_ID" )
	REFERENCES "Groups" ("Group_ID")

ALTER TABLE "Promotion_Groups" ADD CONSTRAINT "Promotions_Promotion_Groups_FK" FOREIGN KEY ("Promotion_ID" )
	REFERENCES "Promotions" ("Promotion_ID")

ALTER TABLE "Promotion_Qual_Products" ADD CONSTRAINT "Products_Promotion_Qual_Products_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "Promotion_Qual_Products" ADD CONSTRAINT "Promotions_Promotion_Qual_Products_FK" FOREIGN KEY ("Promotion_ID" )
	REFERENCES "Promotions" ("Promotion_ID")

ALTER TABLE "StateTax" ADD CONSTRAINT "States_StateTax_FK" FOREIGN KEY ("State" )
	REFERENCES "States" ("Abb")

ALTER TABLE "StateTax" ADD CONSTRAINT "TaxCodes_StateTax_FK" FOREIGN KEY ("Code_ID" )
	REFERENCES "TaxCodes" ("Code_ID")

ALTER TABLE "StdOpt_Choices" ADD CONSTRAINT "StdOptions_StdOpt_Choices_FK" FOREIGN KEY ("Std_ID" )
	REFERENCES "StdOptions" ("Std_ID")

ALTER TABLE "WishList" ADD CONSTRAINT "Products_WishList_FK" FOREIGN KEY ("Product_ID" )
	REFERENCES "Products" ("Product_ID")

ALTER TABLE "WishList" ADD CONSTRAINT "Users_WishList_FK" FOREIGN KEY ("User_ID" )
	REFERENCES "Users" ("User_ID")

COMMIT
