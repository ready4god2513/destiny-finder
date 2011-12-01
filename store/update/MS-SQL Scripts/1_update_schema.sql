BEGIN TRANSACTION

CREATE TABLE "Counties"
(
	"County_ID" int IDENTITY NOT NULL ,
	"Code_ID" int NOT NULL DEFAULT 0,
	"State" nvarchar(2) NOT NULL ,
	"Name" nvarchar(50) NOT NULL ,
	"TaxRate" float NOT NULL DEFAULT 0,
	"TaxShip" bit NOT NULL DEFAULT 0
)

ALTER TABLE "Counties" ADD
	CONSTRAINT "Counties_PK" PRIMARY KEY  CLUSTERED ("County_ID")

CREATE  INDEX "Counties_Code_ID_Idx" ON "Counties" ("Code_ID")

CREATE  INDEX "Counties_State_Idx" ON "Counties" ("State")
	;

CREATE TABLE "CountryTax"
(
	"Tax_ID" int IDENTITY NOT NULL ,
	"Code_ID" int NOT NULL DEFAULT 0,
	"Country_ID" int NOT NULL DEFAULT 0,
	"TaxRate" float NOT NULL DEFAULT 0,
	"TaxShip" bit NOT NULL DEFAULT 0
)

ALTER TABLE "CountryTax" ADD
	CONSTRAINT "CountryTax_PK" PRIMARY KEY  CLUSTERED ("Tax_ID")

CREATE  INDEX "CountryTax_Code_ID_Idx" ON "CountryTax" ("Code_ID")

CREATE  INDEX "CountryTax_Country_ID_Idx" ON "CountryTax" ("Country_ID")
	;

CREATE TABLE "CustomMethods"
(
	"ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(50) NULL ,
	"Amount" float NOT NULL DEFAULT 0,
	"Used" bit NOT NULL DEFAULT 0,
	"Priority" int NULL DEFAULT 0,
	"Domestic" bit NOT NULL DEFAULT 0,
	"International" bit NOT NULL DEFAULT 0
)

ALTER TABLE "CustomMethods" ADD
	CONSTRAINT "CustomMethods_PK" PRIMARY KEY  CLUSTERED ("ID")

CREATE  INDEX "CustomMethods_Used_Idx" ON "CustomMethods" ("Used")
	;
	
CREATE TABLE "CustomShipSettings"
(
	"Setting_ID" int IDENTITY NOT NULL ,
	"ShowShipTable" bit NOT NULL DEFAULT 0,
	"MultPerItem" bit NOT NULL DEFAULT 0,
	"CumulativeAmounts" bit NOT NULL DEFAULT 0,
	"MultMethods" bit NOT NULL DEFAULT 0,
	"Debug" bit NOT NULL DEFAULT 0
)

ALTER TABLE "CustomShipSettings" ADD
	CONSTRAINT "CustomShipSettings_PK" PRIMARY KEY  CLUSTERED ("Setting_ID")
	;
	
CREATE TABLE "Discount_Categories"
(
	"ID" int IDENTITY NOT NULL ,
	"Discount_ID" int NOT NULL DEFAULT 0,
	"Category_ID" int NOT NULL DEFAULT 0
)

ALTER TABLE "Discount_Categories" ADD
	CONSTRAINT "Discount_Categories_PK" PRIMARY KEY  CLUSTERED ("ID")

CREATE  INDEX "Discount_Categories_Category_ID_Idx" ON "Discount_Categories" ("Category_ID")

CREATE  INDEX "Discount_Categories_Discount_ID_Idx" ON "Discount_Categories" ("Discount_ID")

	;

CREATE TABLE "Discount_Groups"
(
	"ID" int IDENTITY NOT NULL ,
	"Discount_ID" int NOT NULL DEFAULT 0,
	"Group_ID" int NOT NULL DEFAULT 0
)

ALTER TABLE "Discount_Groups" ADD
	CONSTRAINT "Discount_Groups_PK" PRIMARY KEY  CLUSTERED ("ID")

CREATE  INDEX "Discount_Groups_Discount_ID_Idx" ON "Discount_Groups" ("Discount_ID")

CREATE  INDEX "Discount_Groups_Group_ID_Idx" ON "Discount_Groups" ("Group_ID")

	;
	
CREATE TABLE "Discount_Products"
(
	"ID" int IDENTITY NOT NULL ,
	"Discount_ID" int NOT NULL  DEFAULT 0,
	"Product_ID" int NOT NULL  DEFAULT 0
)

ALTER TABLE "Discount_Products" ADD
	CONSTRAINT "Discount_Products_PK" PRIMARY KEY  CLUSTERED ("ID")

CREATE  INDEX "Discount_Products_Discount_ID_Idx" ON "Discount_Products" ("Discount_ID")

CREATE  INDEX "Discount_Products_Product_ID_Idx" ON "Discount_Products" ("Product_ID")

	;
	
CREATE TABLE "FeatureReviews"
(
	"Review_ID" int IDENTITY NOT NULL,
	"Feature_ID" int NOT NULL,
	"Parent_ID" int NULL  DEFAULT 0,
	"User_ID" int NULL  DEFAULT 0,
	"Anonymous" bit NOT NULL  DEFAULT 0,
	"Anon_Name" nvarchar(100) NULL ,
	"Anon_Loc" nvarchar(100) NULL ,
	"Anon_Email" nvarchar(100) NULL ,
	"Editorial" nvarchar(50) NULL ,
	"Title" nvarchar(75) NULL ,
	"Comment" ntext NULL ,
	"Rating" smallint NULL  DEFAULT 0,
	"Recommend" bit NOT NULL  DEFAULT 0,
	"Posted" datetime NOT NULL ,
	"Updated" datetime NULL ,
	"Approved" bit NOT NULL  DEFAULT 0,
	"NeedsCheck" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "FeatureReviews" ADD
	CONSTRAINT "FeatureReviews_PK" PRIMARY KEY  CLUSTERED ("Review_ID")

CREATE  INDEX "FeatureReviews_Feature_ID_Idx" ON "FeatureReviews" ("Feature_ID")

CREATE  INDEX "FeatureReviews_Parent_ID_Idx" ON "FeatureReviews" ("Parent_ID")

CREATE  INDEX "FeatureReviews_Posted_Idx" ON "FeatureReviews" ("Posted")

CREATE  INDEX "FeatureReviews_Rating_Idx" ON "FeatureReviews" ("Rating")

CREATE  INDEX "FeatureReviews_User_ID_Idx" ON "FeatureReviews" ("User_ID")
	;

CREATE TABLE "FedEx_Dropoff"
(
	"FedEx_Code" nvarchar(30) NOT NULL ,
	"Description" nvarchar(50) NULL
)

ALTER TABLE "FedEx_Dropoff" ADD
	CONSTRAINT "FedEx_Dropoff_PK" PRIMARY KEY  CLUSTERED ("FedEx_Code")
	;

CREATE TABLE "FedEx_Packaging"
(
	"FedEx_Code" nvarchar(20) NOT NULL ,
	"Description" nvarchar(50) NULL
)

ALTER TABLE "FedEx_Packaging" ADD
	CONSTRAINT "FedEx_Packaging_PK" PRIMARY KEY  CLUSTERED ("FedEx_Code")
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
	CONSTRAINT "FedEx_Settings_PK" PRIMARY KEY  CLUSTERED ("Fedex_ID")

	;
CREATE TABLE "FedExMethods"
(
	"ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(75) NULL ,
	"Used" bit NOT NULL  DEFAULT 0,
	"Shipper" nvarchar(10) NULL ,
	"Code" nvarchar(75) NULL ,
	"Priority" int NULL  DEFAULT 0
)

ALTER TABLE "FedExMethods" ADD
	CONSTRAINT "FedExMethods_PK" PRIMARY KEY  CLUSTERED ("ID")

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
	CONSTRAINT "GiftItems_PK" PRIMARY KEY  CLUSTERED ("GiftItem_ID")

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
	"Event_Descr" nvarchar(50) NULL ,
	"Private" bit NOT NULL  DEFAULT 0,
	"Order_Notification" bit NOT NULL  DEFAULT 0,
	"Live" bit NOT NULL  DEFAULT 0,
	"Approved" bit NOT NULL  DEFAULT 0,
	"City" nvarchar(150) NULL ,
	"State" nvarchar(50) NULL ,
	"Created" datetime NULL ,
	"Expire" datetime NULL,
	"ID_Tag" nvarchar(35) NULL
)

ALTER TABLE "GiftRegistry" ADD
	CONSTRAINT "GiftRegistry_PK" PRIMARY KEY  CLUSTERED ("GiftRegistry_ID")

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
	"Display" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "Giftwrap" ADD
	CONSTRAINT "Giftwrap_PK" PRIMARY KEY  CLUSTERED ("Giftwrap_ID")
	;
	
	
CREATE TABLE "MailText"
(
	"MailText_ID" int IDENTITY NOT NULL ,
	"MailText_Name" nvarchar(50) NULL ,
	"MailText_Message" ntext NULL ,
	"MailText_Subject" nvarchar(75) NULL ,
	"MailText_Attachment" nvarchar(255) NULL ,
	"System" bit NOT NULL  DEFAULT 0,
	"MailAction" nvarchar(50) NULL
)

ALTER TABLE "MailText" ADD
	CONSTRAINT "MailText_PK" PRIMARY KEY  CLUSTERED ("MailText_ID")
	;
	
CREATE TABLE "Order_Items"
(
	"Item_ID" int NOT NULL  DEFAULT 0,
	"Order_No" int NOT NULL  DEFAULT 0,
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
	CONSTRAINT "Order_Items_PK" PRIMARY KEY  CLUSTERED ("Order_No","Item_ID")

CREATE  INDEX "Order_Items_Disc_Code_Idx" ON "Order_Items" ("Disc_Code")

CREATE  INDEX "Order_Items_Order_No_Idx" ON "Order_Items" ("Order_No")

CREATE  INDEX "Order_Items_Product_ID_Idx" ON "Order_Items" ("Product_ID")

CREATE  INDEX "Order_Items_Promo_Code_Idx" ON "Order_Items" ("Promo_Code")
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
	CONSTRAINT "OrderTaxes_PK" PRIMARY KEY  CLUSTERED ("Order_No","Code_ID")

CREATE  INDEX "OrderTaxes_Order_No_Idx" ON "OrderTaxes" ("Order_No")
	;
	
CREATE TABLE "Permission_Groups"
(
	"Group_ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(20) NOT NULL
)

ALTER TABLE "Permission_Groups" ADD
	CONSTRAINT "Permission_Groups_PK" PRIMARY KEY  CLUSTERED ("Group_ID")
	;
	
CREATE TABLE "Permissions"
(
	"ID" int IDENTITY NOT NULL ,
	"Group_ID" int NOT NULL  DEFAULT 0,
	"Name" nvarchar(30) NOT NULL ,
	"BitValue" int NULL  DEFAULT 0
)

ALTER TABLE "Permissions" ADD
	CONSTRAINT "Permissions_PK" PRIMARY KEY  CLUSTERED ("ID")

CREATE  INDEX "Permissions_Group_ID_Idx" ON "Permissions" ("Group_ID")
	;
	
CREATE TABLE "Prod_CustInfo"
(
	"Product_ID" int NOT NULL  DEFAULT 0,
	"Custom_ID" int NOT NULL  DEFAULT 0,
	"CustomInfo" nvarchar(150) NULL
)

ALTER TABLE "Prod_CustInfo" ADD
	CONSTRAINT "Prod_CustInfo_PK" PRIMARY KEY  CLUSTERED ("Product_ID","Custom_ID")

CREATE  INDEX "Prod_CustInfo_Product_ID_Idx" ON "Prod_CustInfo" ("Product_ID")
	;
	
CREATE TABLE "Prod_CustomFields"
(
	"Custom_ID" int NOT NULL  DEFAULT 0,
	"Custom_Name" nvarchar(50) NULL ,
	"Custom_Display" bit NOT NULL  DEFAULT 0,
	"Google_Use" bit NOT NULL  DEFAULT 0,
	"Google_Code" nvarchar(50) NULL
)


ALTER TABLE "Prod_CustomFields" ADD
	CONSTRAINT "Prod_CustomFields_PK" PRIMARY KEY  CLUSTERED ("Custom_ID")
	;
	
ALTER TABLE "ProdDisc" DROP CONSTRAINT "aaaaaProdDisc1_PK"
ALTER TABLE "ProdDisc" ADD
	CONSTRAINT "ProdDisc_PK" PRIMARY KEY  CLUSTERED ("Product_ID","ProdDisc_ID" )	
CREATE  INDEX "ProdDisc_Product_ID_Idx" ON "ProdDisc" ("Product_ID")
	;

CREATE TABLE "ProdGrpPrice"
(
	"GrpPrice_ID" int NOT NULL  DEFAULT 0,
	"Product_ID" int NOT NULL  DEFAULT 0,
	"Group_ID" int NULL  DEFAULT 0,
	"Price" float NULL  DEFAULT 0
)

ALTER TABLE "ProdGrpPrice" ADD
	CONSTRAINT "ProdGrpPrice_PK" PRIMARY KEY  CLUSTERED ("Product_ID","GrpPrice_ID")

CREATE  INDEX "ProdGrpPrice_Group_ID_Idx" ON "ProdGrpPrice" ("Group_ID")

CREATE  INDEX "ProdGrpPrice_Product_ID_Idx" ON "ProdGrpPrice" ("Product_ID")
	;
	
CREATE TABLE "ProdOpt_Choices"
(
	"Option_ID" int NOT NULL  DEFAULT 0,
	"Choice_ID" int NOT NULL  DEFAULT 0,
	"ChoiceName" nvarchar(50) NULL ,
	"Price" float NULL  DEFAULT 0,
	"Weight" float NULL  DEFAULT 0,
	"SKU" nvarchar(50) NULL ,
	"NumInStock" int NULL  DEFAULT 0,
	"Display" bit NOT NULL  DEFAULT 0,
	"SortOrder" int NULL  DEFAULT 0
)

ALTER TABLE "ProdOpt_Choices" ADD
	CONSTRAINT "ProdOpt_Choices_PK" PRIMARY KEY  CLUSTERED ("Option_ID","Choice_ID")

CREATE  INDEX "ProdOpt_Choices_Option_ID_Idx" ON "ProdOpt_Choices" ("Option_ID")
	;
	
CREATE TABLE "Product_Options"
(
	"Option_ID" int IDENTITY NOT NULL ,
	"Product_ID" int NOT NULL  DEFAULT 0,
	"Std_ID" int NOT NULL ,
	"Prompt" nvarchar(50) NULL ,
	"OptDesc" nvarchar(50) NULL ,
	"ShowPrice" nvarchar(10) NULL ,
	"Display" bit NOT NULL  DEFAULT 0,
	"Priority" int NULL  DEFAULT 0,
	"TrackInv" bit NOT NULL  DEFAULT 0,
	"Required" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "Product_Options" ADD
	CONSTRAINT "Product_Options_PK" PRIMARY KEY  CLUSTERED ("Option_ID")

CREATE  INDEX "Product_Options_Product_ID_Idx" ON "Product_Options" ("Product_ID")

CREATE  INDEX "Product_Options_Std_ID_Idx" ON "Product_Options" ("Std_ID")
	;
	
CREATE TABLE "ProductReviews"
(
	"Review_ID" int IDENTITY NOT NULL,
	"Product_ID" int NOT NULL,
	"User_ID" int NULL  DEFAULT 0,
	"Anonymous" bit NOT NULL  DEFAULT 0,
	"Anon_Name" nvarchar(50) NULL ,
	"Anon_Loc" nvarchar(50) NULL ,
	"Anon_Email" nvarchar(75) NULL ,
	"Editorial" nvarchar(50) NULL ,
	"Title" nvarchar(75) NOT NULL ,
	"Comment" ntext NULL ,
	"Rating" smallint NULL  DEFAULT 0,
	"Recommend" bit NOT NULL  DEFAULT 0,
	"Posted" datetime NOT NULL ,
	"Updated" datetime NULL ,
	"Approved" bit NOT NULL  DEFAULT 0,
	"NeedsCheck" bit NOT NULL  DEFAULT 0,
	"Helpful_Total" int NULL  DEFAULT 1,
	"Helpful_Yes" int NULL  DEFAULT 1
)

ALTER TABLE "ProductReviews" ADD
	CONSTRAINT "ProductReviews_PK" PRIMARY KEY  CLUSTERED ("Review_ID")

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
	"Helpful" bit NOT NULL  DEFAULT 0,
	"User_ID" int NULL  DEFAULT 0,
	"Date_Stamp" datetime NULL  DEFAULT 'convert(datetime,convert(varchar,getdate(),1),1)',
	"IP" nvarchar(30) NULL
)

ALTER TABLE "ProductReviewsHelpful" ADD
	CONSTRAINT "ProductReviewsHelpful_PK" PRIMARY KEY  CLUSTERED ("Helpful_ID")

CREATE  INDEX "ProductReviewsHelpful_IP_Idx" ON "ProductReviewsHelpful" ("IP")

CREATE  INDEX "ProductReviewsHelpful_Product_ID_Idx" ON "ProductReviewsHelpful" ("Product_ID")

CREATE  INDEX "ProductReviewsHelpful_Review_ID_Idx" ON "ProductReviewsHelpful" ("Review_ID")

CREATE  INDEX "ProductReviewsHelpful_User_ID_Idx" ON "ProductReviewsHelpful" ("User_ID")
	;
	
CREATE TABLE "Promotion_Groups"
(
	"ID" int IDENTITY NOT NULL ,
	"Promotion_ID" int NOT NULL  DEFAULT 0,
	"Group_ID" int NOT NULL  DEFAULT 0
)

ALTER TABLE "Promotion_Groups" ADD
	CONSTRAINT "Promotion_Groups_PK" PRIMARY KEY  CLUSTERED ("ID")

CREATE  INDEX "Promotion_Groups_Group_ID_Idx" ON "Promotion_Groups" ("Group_ID")

CREATE  INDEX "Promotion_Groups_Promotion_ID_Idx" ON "Promotion_Groups" ("Promotion_ID")
	;
	
CREATE TABLE "Promotion_Qual_Products"
(
	"ID" int IDENTITY NOT NULL ,
	"Promotion_ID" int NOT NULL  DEFAULT 0,
	"Product_ID" int NOT NULL  DEFAULT 0
)

ALTER TABLE "Promotion_Qual_Products" ADD
	CONSTRAINT "Promotion_Qual_Products_PK" PRIMARY KEY  CLUSTERED ("ID")

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
	"OneTime" bit NOT NULL  DEFAULT 0,
	"Name" nvarchar(255) NOT NULL ,
	"Display" nvarchar(255) NULL ,
	"Amount" float NOT NULL  DEFAULT 0,
	"QualifyNum" float NOT NULL  DEFAULT 0,
	"DiscountNum" float NOT NULL  DEFAULT 0,
	"Multiply" bit NOT NULL  DEFAULT 0,
	"StartDate" datetime NULL ,
	"EndDate" datetime NULL ,
	"Disc_Product" int NOT NULL  DEFAULT 0,
	"Add_DiscProd" bit NOT NULL  DEFAULT 0,
	"AccessKey" int NULL  DEFAULT 0
)

ALTER TABLE "Promotions" ADD
	CONSTRAINT "Promotions_PK" PRIMARY KEY  CLUSTERED ("Promotion_ID")

CREATE  INDEX "Promotions_AccessKey_Idx" ON "Promotions" ("AccessKey")

CREATE  INDEX "Promotions_Coup_Code_Idx" ON "Promotions" ("Coup_Code")
	;
	
CREATE TABLE "StateTax"
(
	"Tax_ID" int IDENTITY NOT NULL ,
	"Code_ID" int NOT NULL  DEFAULT 0,
	"State" nvarchar(2) NOT NULL ,
	"TaxRate" float NOT NULL  DEFAULT 0,
	"TaxShip" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "StateTax" ADD
	CONSTRAINT "StateTax_PK" PRIMARY KEY  CLUSTERED ("Tax_ID")

CREATE  INDEX "StateTax_Code_ID_Idx" ON "StateTax" ("Code_ID")

CREATE  INDEX "StateTax_State_Idx" ON "StateTax" ("State")
	;

CREATE TABLE "StdOpt_Choices"
(
	"Std_ID" int NOT NULL  DEFAULT 0,
	"Choice_ID" int NOT NULL  DEFAULT 0,
	"ChoiceName" nvarchar(50) NULL ,
	"Price" float NULL  DEFAULT 0,
	"Weight" float NULL  DEFAULT 0,
	"Display" bit NOT NULL  DEFAULT 0,
	"SortOrder" int NULL  DEFAULT 0
)

ALTER TABLE "StdOpt_Choices" ADD
	CONSTRAINT "StdOpt_Choices_PK" PRIMARY KEY  CLUSTERED ("Std_ID","Choice_ID")

CREATE  INDEX "StdOpt_Choices_Std_ID_Idx" ON "StdOpt_Choices" ("Std_ID")
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
	"ShowonProds" bit NOT NULL  DEFAULT 0
)

ALTER TABLE "TaxCodes" ADD
	CONSTRAINT "TaxCodes_PK" PRIMARY KEY  CLUSTERED ("Code_ID")
	;
	
CREATE TABLE "UPS_Origins"
(
	"UPS_Code" nvarchar(10) NOT NULL ,
	"Description" nvarchar(20) NULL ,
	"OrderBy" int NULL  DEFAULT 0
)

ALTER TABLE "UPS_Origins" ADD
	CONSTRAINT "UPS_Origins_PK" PRIMARY KEY  CLUSTERED ("UPS_Code")
	;
	
CREATE TABLE "UPS_Packaging"
(
	"UPS_Code" nvarchar(10) NOT NULL ,
	"Description" nvarchar(50) NULL
)

ALTER TABLE "UPS_Packaging" ADD
	CONSTRAINT "UPS_Packaging_PK" PRIMARY KEY  CLUSTERED ("UPS_Code")
	;
	
CREATE TABLE "UPS_Pickup"
(
	"UPS_Code" nvarchar(10) NOT NULL ,
	"Description" nvarchar(50) NULL
)

ALTER TABLE "UPS_Pickup" ADD
	CONSTRAINT "UPS_Pickup_PK" PRIMARY KEY  CLUSTERED ("UPS_Code")
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
	CONSTRAINT "UPSMethods_PK" PRIMARY KEY  CLUSTERED ("ID")

CREATE  INDEX "UPSMethods_Used_Idx" ON "UPSMethods" ("Used")
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
	CONSTRAINT "USPS_Settings_PK" PRIMARY KEY  CLUSTERED ("USPS_ID")
	;
	
CREATE TABLE "USPSCountries"
(
	"ID" int NOT NULL ,
	"Abbrev" nvarchar(2) NOT NULL ,
	"Name" nvarchar(255) NOT NULL
)

ALTER TABLE "USPSCountries" ADD
	CONSTRAINT "USPSCountries_PK" PRIMARY KEY  CLUSTERED ("ID")

CREATE  INDEX "USPSCountries_Abbrev_Idx" ON "USPSCountries" ("Abbrev")
	;
	
CREATE TABLE "USPSMethods"
(
	"ID" int IDENTITY NOT NULL ,
	"Name" nvarchar(75) NULL ,
	"Used" bit NOT NULL  DEFAULT 0,
	"Code" nvarchar(225) NULL ,
	"Type" nvarchar(20) NULL ,
	"Priority" int NULL  DEFAULT 0
)

ALTER TABLE "USPSMethods" ADD
	CONSTRAINT "USPSMethods_PK" PRIMARY KEY  CLUSTERED ("ID")

CREATE  INDEX "USPSMethods_Used_Idx" ON "USPSMethods" ("Used")
	;
	
	

ALTER TABLE "Account"
ADD
"Map_URL" ntext NULL,
"ID_Tag" nvarchar(35) NULL

CREATE  INDEX "Account_ID_Tag_Idx" ON "Account" ("ID_Tag")
	;

ALTER TABLE "Affiliates"
ADD
"Aff_Site" nvarchar(255) NULL,
"ID_Tag" nvarchar(35) NULL

CREATE  INDEX "Affiliates_ID_Tag_Idx" ON "Affiliates" ("ID_Tag")
	;

ALTER TABLE "CardData"
ADD
"EncryptedCard" nvarchar(100) NULL,
"ID_Tag" nvarchar(35) NULL

CREATE  INDEX "CardData_ID_Tag_Idx" ON "CardData" ("ID_Tag")
	;

DROP INDEX "Categories"."Color_ID"
	
ALTER TABLE "Categories"
ALTER COLUMN "Color_ID" INT NULL
	;

ALTER TABLE "Categories"
ADD
"TitleTag" nvarchar(255) NULL,
CONSTRAINT "ColorsCategories" FOREIGN KEY
	(
	"Color_ID"
	) REFERENCES "Colors"("Color_ID")
	;

ALTER TABLE "CCProcess"
ADD
"Setting1" nvarchar(75) NULL,
"Setting2" nvarchar(75) NULL,
"Setting3" nvarchar(75) NULL,
"Password" nvarchar(75) NULL,
"Username" nvarchar(75) NULL
	;

ALTER TABLE "Certificates"
ADD
"Order_No" int NULL
	;

ALTER TABLE "Colors"
ADD
"PassParam" nvarchar(100) NULL
	;

ALTER TABLE "Countries"
ADD
"AllowUPS" bit NOT NULL DEFAULT 0
	;

ALTER TABLE "Customers"
ADD
"Residence" bit NOT NULL DEFAULT 1,
"County" nvarchar(50) NULL,
"ID_Tag" nvarchar(35) NULL

CREATE  INDEX "Customers_ID_Tag_Idx" ON "Customers" ("ID_Tag")
	;

ALTER TABLE "Discounts"
ADD
"AccessKey" int NULL DEFAULT 0,
"OneTime" bit NOT NULL DEFAULT 0

CREATE INDEX Discounts_AccessKey_Idx ON Discounts(AccessKey)
	;

ALTER TABLE "Features"
ADD
"TitleTag" nvarchar(255) NULL,
"Reviewable" bit NOT NULL DEFAULT 0,
CONSTRAINT "ColorsFeatures" FOREIGN KEY
	(
	"Color_ID"
	) REFERENCES "Colors"("Color_ID")
	;

ALTER TABLE "Groups"
ADD
"TaxExempt" bit NOT NULL DEFAULT 0,
"ShipExempt" bit NOT NULL DEFAULT 0
	;

ALTER TABLE "Intershipper"
ADD
"MerchantZip" nvarchar(20) NULL,
"Logging" bit NOT NULL  DEFAULT 0,
"MaxWeight" int NULL  DEFAULT 0,
"Debug" bit NOT NULL  DEFAULT 0,
"UnitsofMeasure" nvarchar(10) NULL
	;

ALTER TABLE "IntShipTypes"
ADD
"Priority" int NULL DEFAULT 0
	;

ALTER TABLE "Locales"
ADD
"CurrExchange" nvarchar(50) NULL
	;

ALTER TABLE "LocalTax"
ADD
"Code_ID" int NOT NULL  DEFAULT 0,
"EndZip" nvarchar(20) NULL

CREATE  INDEX LocalTax_Code_ID_Idx ON LocalTax(Code_ID)
	;

ALTER TABLE "Memberships"
ADD
"Recur_Product_ID" int NULL  DEFAULT 0,
"Next_Membership_ID" smallint NULL  DEFAULT 0,
"Recur" bit NOT NULL DEFAULT 0,
"Suspend_Begin_Date" datetime NULL,
"ID_Tag" nvarchar(35) NULL

CREATE  INDEX Memberships_Next_Membership_ID_Idx ON Memberships(Next_Membership_ID)

CREATE  INDEX Memberships_Recur_Product_ID_Idx ON Memberships(Recur_Product_ID)

CREATE  INDEX Memberships_ID_Tag_Idx ON Memberships(ID_Tag)
	;

ALTER TABLE "Order_No"
ADD
"InvDone" bit NOT NULL DEFAULT 0,
"PO_Number" nvarchar(30) NULL,
"CodesSent" bit NULL DEFAULT 0,
"Freight" int NOT NULL DEFAULT 0,
"CustomText1" nvarchar(255) NULL,
"CustomText2" nvarchar(255) NULL,
"CustomText3" nvarchar(50) NULL,
"CustomSelect1" nvarchar(100) NULL,
"CustomSelect2" nvarchar(100) NULL,
"ID_Tag" nvarchar(35) NULL

CREATE  INDEX "Order_No_ID_Tag_Idx" ON "Order_No" ("ID_Tag")
	;

ALTER TABLE "Order_PO"
ADD "ID_Tag" nvarchar(35) NULL

CREATE  INDEX "Order_PO_ID_Tag_Idx" ON "Order_PO" ("ID_Tag")
	;
	
ALTER TABLE "OrderSettings"
ADD
"AllowPO" bit NOT NULL DEFAULT 0,
"UsePayPal" bit NOT NULL DEFAULT 0,
"Giftwrap" bit NOT NULL DEFAULT 0,
"CustomChoices1" ntext NULL,
"CustomText1" nvarchar(255) NULL,
"CustomChoices2" ntext NULL,
"CustomText2" nvarchar(255) NULL,
"CustomText3" nvarchar(255) NULL,
"CustomSelect1" nvarchar(100) NULL,
"CustomSelect2" nvarchar(100) NULL,
"SkipAddressForm" bit NOT NULL DEFAULT 0,
"CustomSelect_Req" nvarchar(50) NULL,
"PayPalLog" bit NOT NULL DEFAULT 0,
"AgreeTerms" ntext NULL,
"CustomText_Req" nvarchar(50) NULL,
"ShowBasket" bit NOT NULL DEFAULT 0,
"PayPalEmail" nvarchar(100) NULL
	;

UPDATE Pages
SET Pages.Color_ID = NULL
WHERE Pages.Color_ID = 0;

ALTER TABLE "Pages"
ADD
"Metadescription" nvarchar(255) NULL,
"Keywords" nvarchar(255) NULL,
"TitleTag" nvarchar(255) NULL,
"PageAction" nvarchar(30) NULL,
CONSTRAINT "Pages_FK01" FOREIGN KEY
	(
	"Color_ID"
	) REFERENCES "Colors"("Color_ID")
	;

ALTER TABLE "Picklists"
ADD
"Review_Editorial" ntext NULL,
"GiftRegistry_Type" ntext NULL
	;
	
UPDATE ProdAddons
SET ProdAddons.Required = 0
WHERE ProdAddons.Required is NULL;

UPDATE ProdAddons
SET ProdAddons.ProdMult = 0
WHERE ProdAddons.ProdMult is NULL;

ALTER TABLE "ProdAddons"
	ALTER COLUMN "Required" bit NOT NULL
	;

ALTER TABLE "ProdAddons"
	ALTER COLUMN "ProdMult" bit NOT NULL
	;

ALTER TABLE "Products"
ADD
"Goog_Brand" nvarchar(100) NULL,
"Pack_Width" float NULL DEFAULT 0,
"Recur_Product_ID" int NULL DEFAULT 0,
"GiftWrap" bit NOT NULL DEFAULT 0,
"Recur" bit NOT NULL DEFAULT 0,
"Freight_Dom" float NULL DEFAULT 0,
"Enlrg_Image" nvarchar(100) NULL,
"Promotions" ntext NULL,
"UseforPOTD" bit NOT NULL DEFAULT 0,
"Mult_Min" bit NOT NULL DEFAULT 0,
"Freight_Intl" float NULL DEFAULT 0,
"Min_Order" int NULL DEFAULT 0,
"Goog_Prodtype" nvarchar(100) NULL,
"ShowPromotions" bit NOT NULL DEFAULT 0,
"TaxCodes" nvarchar(50) NULL,
"Pack_Height" float NULL DEFAULT 0,
"Goog_Condition" nvarchar(100) NULL,
"TitleTag" nvarchar(255) NULL,
"Goog_Expire" datetime NULL,
"User_ID" int NULL DEFAULT 0,
"Pack_Length" float NULL DEFAULT 0,
"Reviewable" bit NOT NULL DEFAULT 0,
CONSTRAINT "Products_FK00" FOREIGN KEY
	(
	"Color_ID"
	) REFERENCES "Colors"("Color_ID")

ALTER TABLE "Products"
	ALTER COLUMN "Lg_Image" nvarchar(255)

ALTER TABLE "Products"
	ALTER COLUMN "Discounts" ntext

DROP INDEX Products.NumChoices

DROP INDEX Products.NumOptions

CREATE  INDEX Products_User_ID_Idx ON Products(User_ID)

CREATE  INDEX Products_Recur_Product_ID_Idx ON Products(Recur_Product_ID)
	;

ALTER TABLE "Settings"
ADD
"Default_Fuseaction" nvarchar(50) NULL,
"SizeUnit" nvarchar(50) NULL,
"Editor" nvarchar(20) NULL,
"SiteLogo" nvarchar(100) NULL,
"UseSES" bit NOT NULL DEFAULT 0,
"CurrExchange" nvarchar(30) NULL,
"CurrExLabel" nvarchar(30) NULL,
"GiftRegistry" bit NOT NULL DEFAULT 0,
"CachedProds" bit NOT NULL  DEFAULT 0,
"FeatureReviews" bit NOT NULL DEFAULT 0,
"FeatureReview_Approve" bit NOT NULL DEFAULT 0,
"FeatureReview_Flag" bit NOT NULL DEFAULT 0,
"FeatureReview_Add" int NULL DEFAULT 0,
"ProductReviews" bit NOT NULL DEFAULT 0,
"ProductReview_Add" int NULL DEFAULT 0,
"ProductReview_Rate" bit NOT NULL DEFAULT 0,
"ProductReview_Flag" bit NOT NULL DEFAULT 0,
"ProductReviews_Page" int NULL DEFAULT 0,
"ProductReview_Approve" bit NOT NULL DEFAULT 0
	;
	
ALTER TABLE "Settings"
	ALTER COLUMN "Email_Server" nvarchar(255) NULL;

ALTER TABLE "ShipSettings"
ADD
"ShowEstimator" bit NOT NULL DEFAULT 0,
"ShowFreight" bit NOT NULL DEFAULT 0,
"InStorePickup" bit NOT NULL DEFAULT 0,
"UseDropShippers" bit NOT NULL DEFAULT 0
	;

ALTER TABLE "StdAddons"
ADD
"User_ID" int NULL  DEFAULT 0

CREATE  INDEX StdAddons_User_ID_Idx ON StdAddons(User_ID)
	;


ALTER TABLE "StdOptions"
ADD
"User_ID" int NULL DEFAULT 0

CREATE  INDEX StdOptions_User_ID_Idx ON StdOptions(User_ID)
	;

ALTER TABLE "TempBasket"
ADD
CONSTRAINT DBX_OptQuant_24160 DEFAULT 0 FOR OptQuant,
"PromoQuant" int NULL DEFAULT 0,
"Promo_Code" nvarchar(50) NULL,
"GiftItem_ID" int NULL,
"PromoAmount" float NULL,
"Disc_Code" nvarchar(50) NULL,
"ChoiceID_List" nvarchar(255) NULL,
"OptWeight" float NULL DEFAULT 0,
"OptChoice" int NULL DEFAULT 0,
"Promotion" int NULL,
"OptPrice" float NULL DEFAULT 0,
"OptionID_List" nvarchar(255) NULL,
"DiscAmount" float NULL

ALTER TABLE "TempBasket"
	ALTER COLUMN "OptQuant" int NOT NULL
	;

ALTER TABLE "TempCustomer"
ADD
"Residence" bit NULL DEFAULT 0,
"County" nvarchar(50) NULL
	;

ALTER TABLE "TempOrder"
ADD
"GiftCard" nvarchar(255) NULL,
"Freight" int NULL DEFAULT 0,
"CustomText1" nvarchar(255) NULL,
"CustomText2" nvarchar(255) NULL,
"CustomText3" nvarchar(255) NULL,
"CustomSelect1" nvarchar(100) NULL,
"CustomSelect2" nvarchar(100) NULL,
"Comments" nvarchar(255) NULL,
"Delivery" nvarchar(50) NULL
	;

ALTER TABLE "TempShipTo"
ADD
"Residence" bit NULL DEFAULT 0,
"County" nvarchar(50) NULL
	;

ALTER TABLE "UPS_Settings"
ADD
"Accesskey" nvarchar(100) NULL,
"OrigCity" nvarchar(75) NULL,
"Logging" bit NULL DEFAULT 0,
"Packaging" nvarchar(20) NULL,
"OrigCountry" nvarchar(10) NULL,
"MaxWeight" int NULL DEFAULT 0,
"Debug" bit NULL DEFAULT 0,
"Origin" nvarchar(10) NULL,
"Pickup" nvarchar(20) NULL,
"OrigZip" nvarchar(20) NULL,
"UnitsofMeasure" nvarchar(20) NULL,
"AccountNo" nvarchar(20) NULL,
"Password" nvarchar(100) NULL,
"Username" nvarchar(150) NULL,
"UseAV" bit NULL DEFAULT 0,
"CustomerClass" nvarchar(20) NULL
	;

ALTER TABLE "Users"
ADD
"Disable" bit NULL DEFAULT 0,
"EncryptedCard" nvarchar(75) NULL,
"FailedLogins" int NOT NULL DEFAULT 0,
"LastAttempt" datetime NULL,
"CardisValid" bit NULL DEFAULT 0,
"LastUpdate" datetime NULL,
"LoginsDay" int NOT NULL DEFAULT 0,
"AdminNotes" ntext NULL,
"LoginsTotal" int NOT NULL DEFAULT 0,
"ID_Tag" nvarchar(35) NULL

CREATE  INDEX "Users_ID_Tag_Idx" ON "Users" ("ID_Tag")
	;

ALTER TABLE "Users"
	ALTER COLUMN "CardExpire" datetime NULL;


ALTER TABLE "UserSettings"
ADD
"MaxFailures" int NULL DEFAULT 0,
"RequireCounty" bit NULL DEFAULT 0,
"StrictLogins" bit NULL DEFAULT 0,
"AllowAffs" bit NULL DEFAULT 0,
"MemberNotify" bit NULL DEFAULT 0,
"UseResidential" bit NULL DEFAULT 0,
"AllowWholesale" bit NULL DEFAULT 0,
"AffPercent" float NULL DEFAULT 0,
"MaxDailyLogins" int NULL DEFAULT 0
	;

ALTER TABLE Categories ADD CONSTRAINT Colors_Categories_FK FOREIGN KEY (Color_ID) 
	REFERENCES Colors (Color_ID)

ALTER TABLE Counties ADD CONSTRAINT States_Counties_FK FOREIGN KEY (State) 
	REFERENCES States (Abb)

ALTER TABLE Counties ADD CONSTRAINT TaxCodes_Counties_FK FOREIGN KEY (Code_ID) 
	REFERENCES TaxCodes (Code_ID)

ALTER TABLE CountryTax ADD CONSTRAINT Countries_CountryTax_FK FOREIGN KEY (Country_ID) 
	REFERENCES Countries (ID)

ALTER TABLE CountryTax ADD CONSTRAINT TaxCodes_CountryTax_FK FOREIGN KEY (Code_ID) 
	REFERENCES TaxCodes (Code_ID)

ALTER TABLE Discount_Categories ADD CONSTRAINT Categories_Discount_Categories_FK FOREIGN KEY (Category_ID) 
	REFERENCES Categories (Category_ID)

ALTER TABLE Discount_Categories ADD CONSTRAINT Discounts_Discount_Categories_FK FOREIGN KEY (Discount_ID)
	REFERENCES Discounts (Discount_ID)

ALTER TABLE Discount_Groups ADD CONSTRAINT Groups_Discount_Groups_FK FOREIGN KEY (Group_ID) 
	REFERENCES Groups (Group_ID)

ALTER TABLE Discount_Products ADD CONSTRAINT Discounts_Discount_Products_FK FOREIGN KEY (Discount_ID)
	REFERENCES Discounts (Discount_ID)

ALTER TABLE Discount_Products ADD CONSTRAINT Products_Discount_Products_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID)

ALTER TABLE FeatureReviews ADD CONSTRAINT Features_FeatureReviews_FK FOREIGN KEY (Feature_ID)
	REFERENCES Features (Feature_ID)

ALTER TABLE Features ADD CONSTRAINT Colors_Features_FK FOREIGN KEY (Color_ID)
	REFERENCES Colors (Color_ID)

ALTER TABLE GiftItems ADD CONSTRAINT GiftRegistry_GiftItems_FK FOREIGN KEY (GiftRegistry_ID)
	REFERENCES GiftRegistry (GiftRegistry_ID)

ALTER TABLE GiftItems ADD CONSTRAINT Products_GiftItems_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID)

ALTER TABLE GiftRegistry ADD CONSTRAINT Users_GiftRegistry_FK FOREIGN KEY (User_ID)
	REFERENCES Users (User_ID)

ALTER TABLE LocalTax ADD CONSTRAINT TaxCodes_LocalTax_FK FOREIGN KEY (Code_ID)
	REFERENCES TaxCodes (Code_ID)

ALTER TABLE Order_Items ADD CONSTRAINT Order_No_Orders_FK FOREIGN KEY (Order_No)
	REFERENCES Order_No (Order_No)

ALTER TABLE OrderTaxes ADD CONSTRAINT Order_No_OrderTaxes_FK FOREIGN KEY (Order_No)
	REFERENCES Order_No (Order_No)

ALTER TABLE OrderTaxes ADD CONSTRAINT TaxCodes_OrderTaxes_FK FOREIGN KEY (Code_ID)
	REFERENCES TaxCodes (Code_ID)

ALTER TABLE Pages ADD CONSTRAINT Colors_Pages_FK FOREIGN KEY (Color_ID)
	REFERENCES Colors (Color_ID)

ALTER TABLE Permissions ADD CONSTRAINT Permission_Groups_Permissions_FK FOREIGN KEY (Group_ID)
	REFERENCES Permission_Groups (Group_ID)

ALTER TABLE Prod_CustInfo ADD CONSTRAINT Prod_CustomFields_Prod_CustInfo_FK FOREIGN KEY (Custom_ID)
	REFERENCES Prod_CustomFields (Custom_ID)

ALTER TABLE Prod_CustInfo ADD CONSTRAINT Products_Prod_CustInfo_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID)

ALTER TABLE ProdGrpPrice ADD CONSTRAINT Groups_ProdGrpPrice_FK FOREIGN KEY (Group_ID)
	REFERENCES Groups (Group_ID)

ALTER TABLE ProdGrpPrice ADD CONSTRAINT Products_ProdGrpPrice_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID)

ALTER TABLE ProdOpt_Choices ADD CONSTRAINT Product_Options_ProdOpt_Choices_FK FOREIGN KEY (Option_ID)
	REFERENCES Product_Options (Option_ID)

ALTER TABLE Product_Options ADD CONSTRAINT Products_Product_Options_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID)

ALTER TABLE ProductReviews ADD CONSTRAINT Products_ProductReviews_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID)

ALTER TABLE ProductReviewsHelpful ADD CONSTRAINT Products_ProductReviewsHelpful_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID)

ALTER TABLE Products ADD CONSTRAINT Colors_Products_FK FOREIGN KEY (Color_ID)
	REFERENCES Colors (Color_ID)

ALTER TABLE Promotion_Groups ADD CONSTRAINT Groups_Promotion_Groups_FK FOREIGN KEY (Group_ID)
	REFERENCES Groups (Group_ID)

ALTER TABLE Promotion_Groups ADD CONSTRAINT Promotions_Promotion_Groups_FK FOREIGN KEY (Promotion_ID)
	REFERENCES Promotions (Promotion_ID)

ALTER TABLE Promotion_Qual_Products ADD CONSTRAINT Products_Promotion_Qual_Products_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID)

ALTER TABLE Promotion_Qual_Products ADD CONSTRAINT Promotions_Promotion_Qual_Products_FK FOREIGN KEY (Promotion_ID)
	REFERENCES Promotions (Promotion_ID)

ALTER TABLE StateTax ADD CONSTRAINT States_StateTax_FK FOREIGN KEY (State)
	REFERENCES States (Abb)

ALTER TABLE StateTax ADD CONSTRAINT TaxCodes_StateTax_FK FOREIGN KEY (Code_ID)
	REFERENCES TaxCodes (Code_ID)

ALTER TABLE StdOpt_Choices ADD CONSTRAINT StdOptions_StdOpt_Choices_FK FOREIGN KEY (Std_ID)
	REFERENCES StdOptions (Std_ID)
	
	;

COMMIT

