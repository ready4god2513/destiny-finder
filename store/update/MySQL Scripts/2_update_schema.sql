
-- Updates the base schema for CFWebstore from Version 5 to Version 6 on MySQL

ALTER TABLE `Account` ADD COLUMN `Map_URL` longtext;
ALTER TABLE `Account` ADD COLUMN `ID_Tag` varchar (35);
ALTER TABLE `Account` ADD INDEX `Account_ID_Tag_Idx` (`ID_Tag` );

ALTER TABLE `Affiliates` ADD COLUMN `Aff_Site` varchar (255);
ALTER TABLE `Affiliates` ADD COLUMN `ID_Tag` varchar (35);
ALTER TABLE `Affiliates` ADD INDEX `Affiliates_ID_Tag_Idx` (`ID_Tag` );

ALTER TABLE `CCProcess` ADD COLUMN `Username` varchar (75);
ALTER TABLE `CCProcess` ADD COLUMN `Password` varchar (75);
ALTER TABLE `CCProcess` ADD COLUMN `Setting1` varchar (75);
ALTER TABLE `CCProcess` ADD COLUMN `Setting2` varchar (75);
ALTER TABLE `CCProcess` ADD COLUMN `Setting3` varchar (75);

ALTER TABLE `CardData` ADD COLUMN `EncryptedCard` varchar (100);
ALTER TABLE `CardData` ADD COLUMN `ID_Tag` varchar (35);
ALTER TABLE `CardData` ADD INDEX `CardData_ID_Tag_Idx` (`ID_Tag` );

ALTER TABLE `Categories` ADD COLUMN `TitleTag` varchar (255);
ALTER TABLE `Categories` CHANGE COLUMN `Color_ID` `Color_ID` integer (11) NULL ;

ALTER TABLE `Certificates` ADD COLUMN `Order_No` integer (11) DEFAULT '0';

ALTER TABLE `Colors` ADD COLUMN `PassParam` varchar (100);

CREATE TABLE `Counties` 
(
	`County_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Code_ID` integer (11) NOT NULL DEFAULT 0, 
	`State` varchar (2) NOT NULL, 
	`Name` varchar (50) NOT NULL, 
	`TaxRate` double NOT NULL DEFAULT 0, 
	`TaxShip` tinyint (1) NOT NULL DEFAULT 0,
	INDEX `Counties_Code_ID_Idx` (`Code_ID`),
  	INDEX `Counties_State_Idx` (`State`),
	PRIMARY KEY (`County_ID`)
) TYPE=InnoDB;

ALTER TABLE `Countries` ADD COLUMN `AllowUPS` tinyint (1) NOT NULL  DEFAULT '0';

CREATE TABLE `CountryTax` 
(
	`Tax_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Code_ID` integer (11) NOT NULL DEFAULT 0, 
	`Country_ID` integer (11) NOT NULL DEFAULT 0, 
	`TaxRate` double NOT NULL DEFAULT 0, 
	`TaxShip` tinyint (1) NOT NULL DEFAULT 0,
	INDEX `CountryTax_Code_ID_Idx` (`Code_ID`),
  	INDEX `CountryTax_Country_ID_Idx` (`Country_ID`),
	PRIMARY KEY (`Tax_ID`)
) TYPE=InnoDB;

CREATE TABLE `CustomMethods` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Name` VARCHAR(50) NULL,
  `Amount` DOUBLE NOT NULL DEFAULT 0,
  `Used` BOOL NOT NULL DEFAULT 0,
  `Priority` INT NULL DEFAULT 0,
  `Domestic` BOOL NOT NULL DEFAULT 0,
  `International` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID` ASC),
  INDEX `CustomMethods_Used_Idx` (`Used` ASC)
) TYPE=InnoDB;

CREATE TABLE `CustomShipSettings` 
(
	`Setting_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`ShowShipTable` tinyint (1) NOT NULL DEFAULT 0, 
	`MultPerItem` tinyint (1) NOT NULL DEFAULT 0, 
	`CumulativeAmounts` tinyint (1) NOT NULL DEFAULT 0, 
	`MultMethods` tinyint (1) NOT NULL DEFAULT 0, 
	`Debug` tinyint (1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`Setting_ID`)
) TYPE=InnoDB;

ALTER TABLE `Customers` ADD COLUMN `County` varchar (50);
ALTER TABLE `Customers` ADD COLUMN `Residence` tinyint (1) NOT NULL  DEFAULT '1';
ALTER TABLE `Customers` ADD COLUMN `ID_Tag` varchar (35);
ALTER TABLE `Customers` ADD INDEX `Customers_ID_Tag_Idx` (`ID_Tag` );

CREATE TABLE `Discount_Categories` 
(
	`ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Discount_ID` integer (11) NOT NULL DEFAULT 0, 
	`Category_ID` integer (11) NOT NULL DEFAULT 0,
	INDEX `Discount_Categories_Category_ID_Idx` (`Category_ID`),
  	INDEX `Discount_Categories_Discount_ID_Idx` (`Discount_ID`),
	PRIMARY KEY (`ID`)
) TYPE=InnoDB;

CREATE TABLE `Discount_Groups` 
(
	`ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Discount_ID` integer (11) NOT NULL DEFAULT 0, 
	`Group_ID` integer (11) NOT NULL DEFAULT 0,
	INDEX `Discount_Groups_Discount_ID_Idx` (`Discount_ID`),
  	INDEX `Discount_Groups_Group_ID_Idx` (`Group_ID`),
	PRIMARY KEY (`ID`)
) TYPE=InnoDB;

CREATE TABLE `Discount_Products` 
(
	`ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Discount_ID` integer (11) NOT NULL DEFAULT 0, 
	`Product_ID` integer (11) NOT NULL DEFAULT 0,
	INDEX `Discount_Products_Discount_ID_Idx` (`Discount_ID`),
  	INDEX `Discount_Products_Product_ID_Idx` (`Product_ID`),
	PRIMARY KEY (`ID`)
) TYPE=InnoDB;

ALTER TABLE `Discounts` ADD COLUMN `OneTime` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Discounts` ADD COLUMN `AccessKey` integer (11) DEFAULT '0';
ALTER TABLE `Discounts` ADD INDEX `Discounts_AccessKey_Idx` (`AccessKey` );

CREATE TABLE `FeatureReviews` 
(
	`Review_ID` integer (11) NOT NULL AUTO_INCREMENT,
	`Feature_ID` integer (11) NOT NULL, 
	`Parent_ID` integer (11) DEFAULT 0, 
	`User_ID` integer (11) DEFAULT 0, 
	`Anonymous` tinyint (1) NOT NULL DEFAULT 0, 
	`Anon_Name` varchar (100), 
	`Anon_Loc` varchar (100), 
	`Anon_Email` varchar (100), 
	`Editorial` varchar (50), 
	`Title` varchar (75), 
	`Comment` longtext, 
	`Rating` smallint (6) DEFAULT 0, 
	`Recommend` tinyint (1) NOT NULL DEFAULT 0, 
	`Posted` datetime NOT NULL, 
	`Updated` datetime, 
	`Approved` tinyint (1) NOT NULL DEFAULT 0, 
	`NeedsCheck` tinyint (1) NOT NULL DEFAULT 0,
	INDEX `FeatureReviews_Feature_ID_Idx` (`Feature_ID`),
  	INDEX `FeatureReviews_Parent_ID_Idx` (`Parent_ID`),
  	PRIMARY KEY (`Review_ID`),
  	INDEX `FeatureReviews_Posted_Idx` (`Posted`),
  	INDEX `FeatureReviews_Rating_Idx` (`Rating`),
  	INDEX `FeatureReviews_User_ID_Idx` (`User_ID`)
)TYPE=InnoDB;

ALTER TABLE `Features` ADD COLUMN `Reviewable` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Features` ADD COLUMN `TitleTag` varchar (255);

CREATE TABLE `FedExMethods` 
(
	`ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Name` varchar (75), 
	`Used` tinyint (1) NOT NULL DEFAULT 0, 
	`Shipper` varchar (10), 
	`Code` varchar (75), 
	`Priority` integer (11) DEFAULT 0,
	INDEX `FedExMethods_Code_Idx` (`Code`),
  	PRIMARY KEY (`ID`),
  	INDEX `FedExMethods_Used_Idx` (`Used`)
) TYPE=InnoDB;

CREATE TABLE `FedEx_Dropoff` 
(
	`FedEx_Code` varchar (30) NOT NULL, 
	`Description` varchar (50),
	PRIMARY KEY (`FedEx_Code`)
) TYPE=InnoDB;

CREATE TABLE `FedEx_Packaging` 
(
	`FedEx_Code` varchar (20) NOT NULL, 
	`Description` varchar (50),
	PRIMARY KEY (`FedEx_Code`)
) TYPE=InnoDB;

CREATE TABLE `FedEx_Settings` 
(
	`Fedex_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`AccountNo` varchar (20), 
	`MeterNum` varchar (20), 
	`MaxWeight` integer (11) DEFAULT 0, 
	`UnitsofMeasure` varchar (20), 
	`Dropoff` varchar (20), 
	`Packaging` varchar (20), 
	`OrigZip` varchar (20), 
	`OrigState` varchar (75), 
	`OrigCountry` varchar (10), 
	`Debug` tinyint (1) NOT NULL DEFAULT 0, 
	`UseGround` tinyint (1) NOT NULL DEFAULT 0, 
	`UseExpress` tinyint (1) NOT NULL DEFAULT 0, 
	`Logging` tinyint (1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`Fedex_ID`)
) TYPE=InnoDB;

CREATE TABLE `GiftItems` 
(
	`GiftItem_ID` integer (11) NOT NULL AUTO_INCREMENT, 
	`GiftRegistry_ID` integer (11) NOT NULL, 
	`Product_ID` integer (11) NOT NULL DEFAULT 0, 
	`Options` longtext, 
	`Addons` longtext, 
	`AddonMultP` double DEFAULT 0, 
	`AddonNonMultP` double DEFAULT 0, 
	`AddonMultW` double DEFAULT 0, 
	`AddonNonMultW` double DEFAULT 0, 
	`OptPrice` double NOT NULL DEFAULT 0, 
	`OptWeight` double NOT NULL DEFAULT 0, 
	`OptQuant` integer (11) NOT NULL DEFAULT 0, 
	`OptChoice` smallint (6) NOT NULL DEFAULT 0, 
	`OptionID_List` varchar (255), 
	`ChoiceID_List` varchar (255), 
	`SKU` varchar (100), 
	`Price` double NOT NULL DEFAULT 0, 
	`Weight` double NOT NULL DEFAULT 0, 
	`Quantity_Requested` smallint (6) NOT NULL DEFAULT 0, 
	`Quantity_Purchased` smallint (6) NOT NULL DEFAULT 0, 
	`DateAdded` datetime,
	INDEX `GiftItems_GiftRegistry_ID_Idx` (`GiftRegistry_ID`),
  	INDEX `GiftItems_Product_ID_Idx` (`Product_ID`),
	PRIMARY KEY (`GiftItem_ID`)
) TYPE=InnoDB;

CREATE TABLE `GiftRegistry` 
(
	`GiftRegistry_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`User_ID` integer (11) NOT NULL DEFAULT 0, 
	`Registrant` varchar (75), 
	`OtherName` varchar (50), 
	`GiftRegistry_Type` varchar (50), 
	`Event_Date` datetime, 
	`Event_Name` varchar (50), 
	`Event_Descr` varchar (50), 
	`Private` tinyint (1) NOT NULL DEFAULT 0, 
	`Order_Notification` tinyint (1) NOT NULL DEFAULT 0, 
	`Live` tinyint (1) NOT NULL DEFAULT 0, 
	`Approved` tinyint (1) NOT NULL DEFAULT 0, 
	`City` varchar (150), 
	`State` varchar (50), 
	`Created` datetime, 
	`Expire` datetime,
  	`ID_Tag` varchar (35),
	PRIMARY KEY (`GiftRegistry_ID`),
	INDEX `GiftRegistry_User_ID_Idx` (`User_ID`),
	INDEX `GiftRegistry_ID_Tag_Idx` (`ID_Tag`)
) TYPE=InnoDB;

CREATE TABLE `Giftwrap` 
(
	`Giftwrap_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Name` varchar (60) NOT NULL, 
	`Short_Desc` longtext, 
	`Sm_Image` varchar (150), 
	`Price` double NOT NULL DEFAULT 0, 
	`Weight` double NOT NULL DEFAULT 0, 
	`Priority` smallint (6) NOT NULL DEFAULT 0, 
	`Display` tinyint (1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`Giftwrap_ID`)
) TYPE=InnoDB;

ALTER TABLE `Groups` ADD COLUMN `TaxExempt` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Groups` ADD COLUMN `ShipExempt` tinyint (1) NOT NULL  DEFAULT '0';

ALTER TABLE `IntShipTypes` ADD COLUMN `Priority` integer (11) DEFAULT '0';

ALTER TABLE `Intershipper` ADD COLUMN `UnitsofMeasure` varchar (10) NOT NULL ;
ALTER TABLE `Intershipper` ADD COLUMN `MaxWeight` integer (11) DEFAULT '0';
ALTER TABLE `Intershipper` ADD COLUMN `MerchantZip` varchar (20);
ALTER TABLE `Intershipper` ADD COLUMN `Logging` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Intershipper` ADD COLUMN `Debug` tinyint (1) NOT NULL  DEFAULT '0';

ALTER TABLE `LocalTax` ADD COLUMN `Code_ID` integer (11) NOT NULL  DEFAULT '0';
ALTER TABLE `LocalTax` ADD COLUMN `EndZip` varchar (20);
ALTER TABLE `Locales` ADD COLUMN `CurrExchange` varchar (50);
ALTER TABLE `LocalTax` ADD INDEX `LocalTax_Code_ID_Idx` (`Code_ID` );

CREATE TABLE `MailText` 
(
	`MailText_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`MailText_Name` varchar (50), 
	`MailText_Message` longtext, 
	`MailText_Subject` varchar (75), 
	`MailText_Attachment` varchar (255), 
	`System` tinyint (1) NOT NULL DEFAULT 0, 
	`MailAction` varchar (50),
	PRIMARY KEY (`MailText_ID`)
) TYPE=InnoDB;

ALTER TABLE `Memberships` ADD COLUMN `Recur` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Memberships` ADD COLUMN `Recur_Product_ID` integer (11) DEFAULT '0';
ALTER TABLE `Memberships` ADD COLUMN `Suspend_Begin_Date` datetime;
ALTER TABLE `Memberships` ADD COLUMN `Next_Membership_ID` integer (11) DEFAULT '0';
ALTER TABLE `Memberships` ADD COLUMN `ID_Tag` varchar (35);
ALTER TABLE `Memberships` ADD INDEX `Memberships_Next_Membership_ID_Idx` (`Next_Membership_ID` );
ALTER TABLE `Memberships` ADD INDEX `Memberships_Recur_Product_ID_Idx` (`Recur_Product_ID` );
ALTER TABLE `Memberships` ADD INDEX `Memberships_ID_Tag_Idx` (`ID_Tag` );

ALTER TABLE `OrderSettings` ADD COLUMN `AllowPO` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `OrderSettings` ADD COLUMN `UsePayPal` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `OrderSettings` ADD COLUMN `PayPalEmail` varchar (100);
ALTER TABLE `OrderSettings` ADD COLUMN `PayPalLog` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `OrderSettings` ADD COLUMN `CustomText1` varchar (255);
ALTER TABLE `OrderSettings` ADD COLUMN `CustomText2` varchar (255);
ALTER TABLE `OrderSettings` ADD COLUMN `CustomText3` varchar (255);
ALTER TABLE `OrderSettings` ADD COLUMN `CustomSelect1` varchar (100);
ALTER TABLE `OrderSettings` ADD COLUMN `CustomSelect2` varchar (100);
ALTER TABLE `OrderSettings` ADD COLUMN `CustomChoices1` longtext;
ALTER TABLE `OrderSettings` ADD COLUMN `CustomChoices2` longtext;
ALTER TABLE `OrderSettings` ADD COLUMN `CustomText_Req` varchar (50);
ALTER TABLE `OrderSettings` ADD COLUMN `CustomSelect_Req` varchar (50);
ALTER TABLE `OrderSettings` ADD COLUMN `AgreeTerms` longtext;
ALTER TABLE `OrderSettings` ADD COLUMN `Giftwrap` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `OrderSettings` ADD COLUMN `ShowBasket` tinyint (1) NOT NULL  DEFAULT '1';
ALTER TABLE `OrderSettings` ADD COLUMN `SkipAddressForm` tinyint (1) NOT NULL  DEFAULT '0';

CREATE TABLE `OrderTaxes` 
(
	`Order_No` integer (11) NOT NULL DEFAULT 0, 
	`Code_ID` integer (11) NOT NULL DEFAULT 0, 
	`ProductTotal` double NOT NULL DEFAULT 0, 
	`CodeName` varchar (50), 
	`AddressUsed` varchar (20), 
	`AllUserTax` double NOT NULL DEFAULT 0, 
	`StateTax` double NOT NULL DEFAULT 0, 
	`CountyTax` double NOT NULL DEFAULT 0, 
	`LocalTax` double NOT NULL DEFAULT 0, 
	`CountryTax` double NOT NULL DEFAULT 0,	
	INDEX `OrderTaxes_Order_No_Idx` (`Order_No`),
	PRIMARY KEY (`Order_No`, `Code_ID`)
) TYPE=InnoDB;

CREATE TABLE `Order_Items` 
(
	`Order_No` integer (11) NOT NULL DEFAULT 0, 
	`Item_ID` integer (11) NOT NULL DEFAULT 0, 
	`Product_ID` integer (11) NOT NULL DEFAULT 0, 
	`Options` longtext, 
	`Addons` longtext, 
	`AddonMultP` double DEFAULT 0, 
	`AddonNonMultP` double DEFAULT 0, 
	`Price` double NOT NULL DEFAULT 0, 
	`Quantity` integer (11) NOT NULL DEFAULT 0, 
	`OptPrice` double NOT NULL DEFAULT 0, 
	`SKU` varchar (50), 
	`OptQuant` integer (11) NOT NULL DEFAULT 0, 
	`OptChoice` integer (11), 
	`OptionID_List` varchar (255), 
	`ChoiceID_List` varchar (255), 
	`DiscAmount` double, 
	`Disc_Code` varchar (50), 
	`PromoAmount` double DEFAULT 0, 
	`PromoQuant` integer (11) DEFAULT 0, 
	`Promo_Code` varchar (50), 
	`Name` varchar (255), 
	`Dropship_Account_ID` integer (11), 
	`Dropship_Qty` integer (11) DEFAULT 0, 
	`Dropship_SKU` varchar (50), 
	`Dropship_Cost` double DEFAULT 0, 
	`Dropship_Note` varchar (75),
  	INDEX `Order_Items_Disc_Code_Idx` (`Disc_Code`),
  	INDEX `Order_Items_Order_No_Idx` (`Order_No`),
  	PRIMARY KEY (`Order_No`,`Item_ID`),
  	INDEX `Order_Items_Product_ID_Idx` (`Product_ID`),
  	INDEX `Order_Items_Promo_Code_Idx` (`Promo_Code`)
) TYPE=InnoDB;

ALTER TABLE `Order_No` ADD COLUMN `InvDone` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Order_No` ADD COLUMN `Freight` integer (11) NOT NULL  DEFAULT '0';
ALTER TABLE `Order_No` ADD COLUMN `CustomText1` varchar (255);
ALTER TABLE `Order_No` ADD COLUMN `CustomText2` varchar (255);
ALTER TABLE `Order_No` ADD COLUMN `CustomText3` varchar (50);
ALTER TABLE `Order_No` ADD COLUMN `CustomSelect1` varchar (100);
ALTER TABLE `Order_No` ADD COLUMN `CustomSelect2` varchar (100);
ALTER TABLE `Order_No` ADD COLUMN `PO_Number` varchar (30);
ALTER TABLE `Order_No` ADD COLUMN `CodesSent` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Order_No` ADD COLUMN `ID_Tag` varchar (35);
ALTER TABLE `Order_No` ADD INDEX `Order_No_ID_Tag_Idx` (`ID_Tag` );

ALTER TABLE `Order_PO` ADD COLUMN `ID_Tag` varchar (35);
ALTER TABLE `Order_PO` ADD INDEX `Order_PO_ID_Tag_Idx` (`ID_Tag` );

ALTER TABLE `Pages` ADD COLUMN `PageAction` varchar (30);
ALTER TABLE `Pages` ADD COLUMN `Metadescription` varchar (255);
ALTER TABLE `Pages` ADD COLUMN `Keywords` varchar (255);
ALTER TABLE `Pages` ADD COLUMN `TitleTag` varchar (255);

UPDATE Pages
SET Pages.Color_ID = NULL
WHERE Pages.Color_ID = 0;

CREATE TABLE `Permission_Groups` 
(
	`Group_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Name` varchar (20) NOT NULL,
	PRIMARY KEY (`Group_ID`)
) TYPE=InnoDB;

CREATE TABLE `Permissions` 
(
	`ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Group_ID` integer (11) NOT NULL DEFAULT 0, 
	`Name` varchar (30) NOT NULL, 
	`BitValue` integer (11) DEFAULT 0,
	INDEX `Permissions_Group_ID_Idx` (`Group_ID`),
	PRIMARY KEY (`ID`)
) TYPE=InnoDB;

ALTER TABLE `PickLists` ADD COLUMN `GiftRegistry_Type` longtext;
ALTER TABLE `PickLists` ADD COLUMN `Review_Editorial` longtext;

UPDATE ProdAddons
SET ProdAddons.Required = 0
WHERE ProdAddons.Required is NULL;

UPDATE ProdAddons
SET ProdAddons.ProdMult = 0
WHERE ProdAddons.ProdMult is NULL;

ALTER TABLE `ProdDisc` DROP PRIMARY KEY;
ALTER TABLE `ProdDisc` ADD PRIMARY KEY (`Product_ID`,`ProdDisc_ID` );
ALTER TABLE `ProdDisc` ADD INDEX `ProdDisc_Product_ID_Idx` (`Product_ID` );

CREATE TABLE `ProdGrpPrice` 
(
	`Product_ID` integer (11) NOT NULL DEFAULT 0, 
	`GrpPrice_ID` integer (11) NOT NULL DEFAULT 0, 
	`Group_ID` integer (11) NOT NULL DEFAULT 0, 
	`Price` double NOT NULL DEFAULT 0,
	INDEX `ProdGrpPrice_Group_ID_Idx` (`Group_ID`),
 	INDEX `ProdGrpPrice_Product_ID_Idx` (`Product_ID`),
	PRIMARY KEY (`Product_ID`, `GrpPrice_ID`)
) TYPE=InnoDB;

CREATE TABLE `ProdOpt_Choices` 
(
	`Option_ID` integer (11) NOT NULL DEFAULT 0, 
	`Choice_ID` integer (11) NOT NULL DEFAULT 0, 
	`ChoiceName` varchar (50), 
	`Price` double NOT NULL DEFAULT 0, 
	`Weight` double NOT NULL DEFAULT 0, 
	`SKU` varchar (50), 
	`NumInStock` integer (11) DEFAULT 0, 
	`Display` tinyint (1) NOT NULL DEFAULT 0, 
	`SortOrder` integer (11) DEFAULT 0,
	INDEX `ProdOpt_Choices_Option_ID_Idx` (`Option_ID`),
	PRIMARY KEY (`Option_ID`, `Choice_ID`)
) TYPE=InnoDB;

CREATE TABLE `Prod_CustInfo` 
(
	`Product_ID` integer (11) NOT NULL DEFAULT 0, 
	`Custom_ID` integer (11) NOT NULL DEFAULT 0, 
	`CustomInfo` varchar (150),
	INDEX `Prod_CustInfo_Product_ID_Idx` (`Product_ID`),
	PRIMARY KEY (`Product_ID`, `Custom_ID`)
) TYPE=InnoDB;

CREATE TABLE `Prod_CustomFields` 
(
	`Custom_ID` integer (11) NOT NULL DEFAULT 0, 
	`Custom_Name` varchar (50), 
	`Custom_Display` tinyint (1) NOT NULL DEFAULT 0, 
	`Google_Use` tinyint (1) NOT NULL DEFAULT 0, 
	`Google_Code` varchar (50),
	PRIMARY KEY (`Custom_ID`)
) TYPE=InnoDB;

CREATE TABLE `ProductReviews` 
(
	`Review_ID` integer (11) NOT NULL AUTO_INCREMENT, 
	`Product_ID` integer (11) NOT NULL , 
	`User_ID` integer (11) DEFAULT 0, 
	`Anonymous` tinyint (1) NOT NULL DEFAULT 0, 
	`Anon_Name` varchar (50), 
	`Anon_Loc` varchar (50), 
	`Anon_Email` varchar (75), 
	`Editorial` varchar (50), 
	`Title` varchar (75) NOT NULL, 
	`Comment` longtext NOT NULL, 
	`Rating` smallint (6) NOT NULL DEFAULT 0, 
	`Recommend` tinyint (1) NOT NULL DEFAULT 0, 
	`Posted` datetime NOT NULL, 
	`Updated` datetime, 
	`Approved` tinyint (1) NOT NULL DEFAULT 0, 
	`NeedsCheck` tinyint (1) NOT NULL DEFAULT 0, 
	`Helpful_Total` integer (11) NOT NULL DEFAULT 0, 
	`Helpful_Yes` integer (11) NOT NULL DEFAULT 0,
	INDEX `ProductReviews_Posted_Idx` (`Posted`),
  	INDEX `ProductReviews_Product_ID_Idx` (`Product_ID`),
  	INDEX `ProductReviews_Rating_Idx` (`Rating`),
  	INDEX `ProductReviews_User_ID_Idx` (`User_ID`),
	PRIMARY KEY (`Review_ID`)
) TYPE=InnoDB;

CREATE TABLE `ProductReviewsHelpful` 
(
	`Helpful_ID` varchar (35) NOT NULL , 
	`Product_ID` integer (11) NOT NULL DEFAULT 0, 
	`Review_ID` integer (11) NOT NULL DEFAULT 0, 
	`Helpful` tinyint (1) NOT NULL DEFAULT 0, 
	`User_ID` integer (11) DEFAULT 0, 
	`Date_Stamp` datetime, 
	`IP` varchar (30),
	INDEX `ProductReviewsHelpful_IP_Idx` (`IP`),
  	INDEX `ProductReviewsHelpful_Product_ID_Idx` (`Product_ID`),
  	INDEX `ProductReviewsHelpful_Review_ID_Idx` (`Review_ID`),
  	INDEX `ProductReviewsHelpful_User_ID_Idx` (`User_ID`),
	PRIMARY KEY (`Helpful_ID`)
) TYPE=InnoDB;

CREATE TABLE `Product_Options` 
(
	`Option_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Product_ID` integer (11) NOT NULL DEFAULT 0, 
	`Std_ID` integer (11) NOT NULL DEFAULT 0, 
	`Prompt` varchar (50), 
	`OptDesc` varchar (50), 
	`ShowPrice` varchar (10), 
	`Display` tinyint (1) NOT NULL DEFAULT 0, 
	`Priority` integer (11) DEFAULT 0, 
	`TrackInv` tinyint (1) NOT NULL DEFAULT 0, 
	`Required` tinyint (1) NOT NULL DEFAULT 0,
	INDEX `Product_Options_Product_ID_Idx` (`Product_ID`),
  	INDEX `Product_Options_Std_ID_Idx` (`Std_ID`),
	PRIMARY KEY (`Option_ID`)
) TYPE=InnoDB;

ALTER TABLE `Products` ADD COLUMN `TaxCodes` varchar (50);
ALTER TABLE `Products` CHANGE COLUMN `Lg_Image` `Lg_Image` varchar (255);
ALTER TABLE `Products` ADD COLUMN `Enlrg_Image` varchar (100);
ALTER TABLE `Products` ADD COLUMN `ShowPromotions` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Reviewable` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `UseforPOTD` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Min_Order` integer (11) DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Mult_Min` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Promotions` varchar (255);
ALTER TABLE `Products` ADD COLUMN `Recur` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Recur_Product_ID` integer (11) DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `TitleTag` varchar (255);
ALTER TABLE `Products` ADD COLUMN `GiftWrap` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Freight_Dom` double DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Freight_Intl` double DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Pack_Width` double DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Pack_Height` double DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Pack_Length` double DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `User_ID` integer (11) DEFAULT '0';
ALTER TABLE `Products` ADD COLUMN `Goog_Brand` varchar (100);
ALTER TABLE `Products` ADD COLUMN `Goog_Condition` varchar (100);
ALTER TABLE `Products` ADD COLUMN `Goog_Expire` datetime;
ALTER TABLE `Products` ADD COLUMN `Goog_Prodtype` varchar (100);
ALTER TABLE `Products` ADD INDEX `Products_Recur_Product_ID_Idx` (`Recur_Product_ID` );
ALTER TABLE `Products` ADD INDEX `Products_User_ID_Idx` (`User_ID` );

CREATE TABLE `Promotion_Groups` 
(
	`ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Promotion_ID` integer (11) NOT NULL DEFAULT 0, 
	`Group_ID` integer (11) NOT NULL DEFAULT 0,
	INDEX `Promotion_Groups_Group_ID_Idx` (`Group_ID`),
  	INDEX `Promotion_Groups_Promotion_ID_Idx` (`Promotion_ID`),
	PRIMARY KEY (`ID`)
) TYPE=InnoDB;

CREATE TABLE `Promotion_Qual_Products` 
(
	`ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Promotion_ID` integer (11) NOT NULL DEFAULT 0, 
	`Product_ID` integer (11) NOT NULL DEFAULT 0,
	INDEX `Promotion_Qual_Products_Product_ID_Idx` (`Product_ID`),
  	INDEX `Promotion_Qual_Products_Promotion_ID_Idx` (`Promotion_ID`),
	PRIMARY KEY (`ID`)
) TYPE=InnoDB;

CREATE TABLE `Promotions` 
(
	`Promotion_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Type1` integer (11) NOT NULL DEFAULT 1, 
	`Type2` integer (11) NOT NULL DEFAULT 1, 
	`Type3` integer (11) NOT NULL DEFAULT 0, 
	`Type4` integer (11) NOT NULL DEFAULT 0, 
	`Coup_Code` varchar (50), 
	`OneTime` tinyint (1) NOT NULL DEFAULT 0, 
	`Name` varchar (255) NOT NULL, 
	`Display` varchar (255), 
	`Amount` double NOT NULL DEFAULT 0, 
	`QualifyNum` double NOT NULL DEFAULT 0, 
	`DiscountNum` double NOT NULL DEFAULT 0, 
	`Multiply` tinyint (1) NOT NULL DEFAULT 0, 
	`StartDate` datetime, 
	`EndDate` datetime, 
	`Disc_Product` integer (11) NOT NULL DEFAULT 0, 
	`Add_DiscProd` tinyint (1) NOT NULL DEFAULT 0, 
	`AccessKey` integer (11) DEFAULT 0,
	INDEX `Promotions_AccessKey_Idx` (`AccessKey`),
  	INDEX `Promotions_Coup_Code_Idx` (`Coup_Code`),
	PRIMARY KEY (`Promotion_ID`)
) TYPE=InnoDB;

ALTER TABLE `Settings` ADD COLUMN `SiteLogo` varchar (100);
ALTER TABLE `Settings` ADD COLUMN `SizeUnit` varchar (50);
ALTER TABLE `Settings` ADD COLUMN `CachedProds` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Settings` ADD COLUMN `CurrExchange` varchar (30);
ALTER TABLE `Settings` ADD COLUMN `CurrExLabel` varchar (30);
ALTER TABLE `Settings` ADD COLUMN `UseSES` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Settings` ADD COLUMN `Default_Fuseaction` varchar (50);
ALTER TABLE `Settings` ADD COLUMN `Editor` varchar (20);
ALTER TABLE `Settings` ADD COLUMN `ProductReviews` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Settings` ADD COLUMN `ProductReview_Approve` tinyint (1) NOT NULL DEFAULT '0';
ALTER TABLE `Settings` ADD COLUMN `ProductReview_Flag` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Settings` ADD COLUMN `ProductReview_Add` integer (11) NOT NULL  DEFAULT '1';
ALTER TABLE `Settings` ADD COLUMN `ProductReview_Rate` tinyint (1) NOT NULL  DEFAULT '1';
ALTER TABLE `Settings` ADD COLUMN `ProductReviews_Page` integer (11) NOT NULL  DEFAULT '4';
ALTER TABLE `Settings` ADD COLUMN `FeatureReviews` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Settings` ADD COLUMN `FeatureReview_Add` integer (11) NOT NULL  DEFAULT '1';
ALTER TABLE `Settings` ADD COLUMN `FeatureReview_Flag` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Settings` ADD COLUMN `FeatureReview_Approve` tinyint (1) NOT NULL  DEFAULT '1';
ALTER TABLE `Settings` ADD COLUMN `GiftRegistry` tinyint (1) NOT NULL  DEFAULT '0';

ALTER TABLE `Settings` MODIFY COLUMN `Email_Server` varchar (255) NULL ;

ALTER TABLE `ShipSettings` ADD COLUMN `InStorePickup` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `ShipSettings` ADD COLUMN `ShowEstimator` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `ShipSettings` ADD COLUMN `ShowFreight` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `ShipSettings` ADD COLUMN `UseDropShippers` tinyint (1) NOT NULL  DEFAULT '0';

CREATE TABLE `StateTax` 
(
	`Tax_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Code_ID` integer (11) NOT NULL DEFAULT 0, 
	`State` varchar (2) NOT NULL, 
	`TaxRate` double NOT NULL DEFAULT 0, 
	`TaxShip` tinyint (1) NOT NULL DEFAULT 0,
	INDEX `StateTax_Code_ID_Idx` (`Code_ID`),
	INDEX `StateTax_State_Idx` (`State`),
	PRIMARY KEY (`Tax_ID`)
) TYPE=InnoDB;

ALTER TABLE `StdAddons` ADD COLUMN `User_ID` integer (11) DEFAULT '0';
ALTER TABLE `StdAddons` ADD INDEX `StdAddons_User_ID_Idx` (`User_ID` );

CREATE TABLE `StdOpt_Choices` 
(
	`Std_ID` integer (11) NOT NULL DEFAULT 0, 
	`Choice_ID` integer (11) NOT NULL DEFAULT 0, 
	`ChoiceName` varchar (50), 
	`Price` double NOT NULL DEFAULT 0, 
	`Weight` double NOT NULL DEFAULT 0, 
	`Display` tinyint (1) NOT NULL DEFAULT 0, 
	`SortOrder` integer (11) DEFAULT 0,
	INDEX `StdOpt_Choices_Std_ID_Idx` (`Std_ID`),
	PRIMARY KEY (`Std_ID`, `Choice_ID`)
) TYPE=InnoDB;

ALTER TABLE `StdOptions` ADD COLUMN `User_ID` integer (11) DEFAULT '0';
ALTER TABLE `StdOptions` ADD INDEX `StdOptions_User_ID_Idx` (`User_ID` );

CREATE TABLE `TaxCodes` (
  `Code_ID` INT NOT NULL  AUTO_INCREMENT,
  `CodeName` VARCHAR(50) NOT NULL,
  `DisplayName` VARCHAR(50) NULL,
  `CalcOrder` INT NULL DEFAULT 0,
  `Cumulative` BOOL NOT NULL DEFAULT 0,
  `TaxAddress` VARCHAR(25) NULL,
  `TaxAll` BOOL NOT NULL DEFAULT 0,
  `TaxRate` DOUBLE NULL DEFAULT 0,
  `TaxShipping` BOOL NOT NULL DEFAULT 0,
  `ShowonProds` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`Code_ID` ASC)
) TYPE=InnoDB;

ALTER TABLE `TempBasket` ADD COLUMN `OptPrice` double NOT NULL  DEFAULT '0';
ALTER TABLE `TempBasket` ADD COLUMN `OptWeight` double NOT NULL  DEFAULT '0';
ALTER TABLE `TempBasket` ADD COLUMN `OptChoice` integer (11) DEFAULT '0';
ALTER TABLE `TempBasket` ADD COLUMN `OptionID_List` varchar (255);
ALTER TABLE `TempBasket` ADD COLUMN `ChoiceID_List` varchar (255);
ALTER TABLE `TempBasket` ADD COLUMN `GiftItem_ID` integer (11) DEFAULT '0';
ALTER TABLE `TempBasket` ADD COLUMN `DiscAmount` double DEFAULT '0';
ALTER TABLE `TempBasket` ADD COLUMN `Disc_Code` varchar (50);
ALTER TABLE `TempBasket` ADD COLUMN `Promotion` integer (11) DEFAULT '0';
ALTER TABLE `TempBasket` ADD COLUMN `PromoAmount` double DEFAULT '0';
ALTER TABLE `TempBasket` ADD COLUMN `PromoQuant` integer (11) DEFAULT '0';
ALTER TABLE `TempBasket` ADD COLUMN `Promo_Code` varchar (50);
ALTER TABLE `TempCustomer` ADD COLUMN `County` varchar (50);
ALTER TABLE `TempCustomer` ADD COLUMN `Residence` tinyint (1) DEFAULT '0';

ALTER TABLE `TempOrder` ADD COLUMN `Freight` integer (11) DEFAULT '0';
ALTER TABLE `TempOrder` ADD COLUMN `GiftCard` varchar (255);
ALTER TABLE `TempOrder` ADD COLUMN `Delivery` varchar (50);
ALTER TABLE `TempOrder` ADD COLUMN `Comments` varchar (255);
ALTER TABLE `TempOrder` ADD COLUMN `CustomText1` varchar (255);
ALTER TABLE `TempOrder` ADD COLUMN `CustomText2` varchar (255);
ALTER TABLE `TempOrder` ADD COLUMN `CustomText3` varchar (255);
ALTER TABLE `TempOrder` ADD COLUMN `CustomSelect1` varchar (100);
ALTER TABLE `TempOrder` ADD COLUMN `CustomSelect2` varchar (100);

ALTER TABLE `TempShipTo` ADD COLUMN `County` varchar (50);
ALTER TABLE `TempShipTo` ADD COLUMN `Residence` tinyint (1) DEFAULT '0';

CREATE TABLE `UPSMethods` 
(
	`ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Name` varchar (75), 
	`USCode` varchar (5), 
	`EUCode` varchar (5), 
	`CACode` varchar (5), 
	`PRCode` varchar (5), 
	`MXCode` varchar (5), 
	`OOCode` varchar (5), 
	`Used` tinyint (1) NOT NULL DEFAULT 0, 
	`Priority` integer (11) DEFAULT 0,
	INDEX `UPSMethods_Used_Idx` (`Used`),
	PRIMARY KEY (`ID`)
) TYPE=InnoDB;

CREATE TABLE `UPS_Origins` 
(
	`UPS_Code` varchar (10) NOT NULL, 
	`Description` varchar (20), 
	`OrderBy` integer (11) DEFAULT 0,
	PRIMARY KEY (`UPS_Code`)
) TYPE=InnoDB;

CREATE TABLE `UPS_Packaging` 
(
	`UPS_Code` varchar (10) NOT NULL, 
	`Description` varchar (50),
	PRIMARY KEY (`UPS_Code`)
) TYPE=InnoDB;

CREATE TABLE `UPS_Pickup` 
(
	`UPS_Code` varchar (10) NOT NULL, 
	`Description` varchar (50),
	PRIMARY KEY (`UPS_Code`)
) TYPE=InnoDB;

ALTER TABLE `UPS_Settings` ADD COLUMN `Username` varchar (150);
ALTER TABLE `UPS_Settings` ADD COLUMN `Password` varchar (100);
ALTER TABLE `UPS_Settings` ADD COLUMN `Accesskey` varchar (100);
ALTER TABLE `UPS_Settings` ADD COLUMN `AccountNo` varchar (20);
ALTER TABLE `UPS_Settings` ADD COLUMN `Origin` varchar (10);
ALTER TABLE `UPS_Settings` ADD COLUMN `MaxWeight` integer (11) NOT NULL  DEFAULT '0';
ALTER TABLE `UPS_Settings` ADD COLUMN `UnitsofMeasure` varchar (20);
ALTER TABLE `UPS_Settings` ADD COLUMN `CustomerClass` varchar (20);
ALTER TABLE `UPS_Settings` ADD COLUMN `Pickup` varchar (20);
ALTER TABLE `UPS_Settings` ADD COLUMN `Packaging` varchar (20);
ALTER TABLE `UPS_Settings` ADD COLUMN `OrigZip` varchar (20);
ALTER TABLE `UPS_Settings` ADD COLUMN `OrigCity` varchar (75);
ALTER TABLE `UPS_Settings` ADD COLUMN `OrigCountry` varchar (10);
ALTER TABLE `UPS_Settings` ADD COLUMN `Debug` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `UPS_Settings` ADD COLUMN `UseAV` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `UPS_Settings` ADD COLUMN `Logging` tinyint (1) NOT NULL  DEFAULT '0';

CREATE TABLE `USPSCountries` 
(
	`ID` integer (11) NOT NULL DEFAULT 0, 
	`Abbrev` varchar (2) NOT NULL, 
	`Name` varchar (255) NOT NULL,
	INDEX `USPSCountries_Abbrev_Idx` (`Abbrev`),
	PRIMARY KEY (`ID`)
) TYPE=InnoDB;

CREATE TABLE `USPSMethods` 
(
	`ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`Name` varchar (75), 
	`Used` tinyint (1) NOT NULL DEFAULT 0, 
	`Code` varchar (225), 
	`Type` varchar (20), 
	`Priority` integer (11) DEFAULT 0,
	INDEX `USPSMethods_Used_Idx` (`Used`),
	PRIMARY KEY (`ID`)
) TYPE=InnoDB;

CREATE TABLE `USPS_Settings` 
(
	`USPS_ID` integer (11) NOT NULL AUTO_INCREMENT , 
	`UserID` varchar (30) NOT NULL, 
	`Server` varchar (75) NOT NULL, 
	`MerchantZip` varchar (20), 
	`MaxWeight` integer (11) NOT NULL DEFAULT 50, 
	`Logging` tinyint (1) NOT NULL DEFAULT 0, 
	`Debug` tinyint (1) NOT NULL DEFAULT 0, 
	`UseAV` tinyint (1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`USPS_ID`)
) TYPE=InnoDB;

ALTER TABLE `UserSettings` ADD COLUMN `RequireCounty` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `UserSettings` ADD COLUMN `UseResidential` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `UserSettings` ADD COLUMN `MemberNotify` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `UserSettings` ADD COLUMN `StrictLogins` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `UserSettings` ADD COLUMN `MaxDailyLogins` integer (11) NOT NULL  DEFAULT '0';
ALTER TABLE `UserSettings` ADD COLUMN `MaxFailures` integer (11) NOT NULL  DEFAULT '5';
ALTER TABLE `UserSettings` ADD COLUMN `AllowAffs` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `UserSettings` ADD COLUMN `AffPercent` double DEFAULT '0';
ALTER TABLE `UserSettings` ADD COLUMN `AllowWholesale` tinyint (1) NOT NULL  DEFAULT '0';


	
UPDATE `Users` SET `CardExpire` = NULL WHERE `CardExpire` = '' ;

ALTER TABLE `Users` CHANGE COLUMN `UserName` `Username` varchar (50) NOT NULL ;
ALTER TABLE `Users` CHANGE COLUMN `CardExpire` `CardExpire` datetime NULL ;
ALTER TABLE `Users` ADD COLUMN `CardisValid` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Users` ADD COLUMN `EncryptedCard` varchar (75);
ALTER TABLE `Users` ADD COLUMN `AdminNotes` longtext;
ALTER TABLE `Users` ADD COLUMN `Disable` tinyint (1) NOT NULL  DEFAULT '0';
ALTER TABLE `Users` ADD COLUMN `LoginsTotal` integer (11) DEFAULT '0';
ALTER TABLE `Users` ADD COLUMN `LoginsDay` integer (11) DEFAULT '0';
ALTER TABLE `Users` ADD COLUMN `FailedLogins` integer (11) DEFAULT '0';
ALTER TABLE `Users` ADD COLUMN `LastAttempt` datetime;
ALTER TABLE `Users` ADD COLUMN `LastUpdate` datetime;
ALTER TABLE `Users` ADD COLUMN `ID_Tag` varchar (35);
ALTER TABLE `Users` ADD INDEX `Users_ID_Tag_Idx` (`ID_Tag` );

UPDATE `Users` SET `CardExpire` = NULL WHERE `CardExpire` = '0000-00-00 00:00:00';

ALTER TABLE Categories ADD CONSTRAINT Colors_Categories_FK FOREIGN KEY (Color_ID) 
	REFERENCES Colors (Color_ID);

ALTER TABLE Counties ADD CONSTRAINT States_Counties_FK FOREIGN KEY (State) 
	REFERENCES States (Abb);

ALTER TABLE Counties ADD CONSTRAINT TaxCodes_Counties_FK FOREIGN KEY (Code_ID) 
	REFERENCES TaxCodes (Code_ID);

ALTER TABLE CountryTax ADD CONSTRAINT Countries_CountryTax_FK FOREIGN KEY (Country_ID) 
	REFERENCES Countries (ID);

ALTER TABLE CountryTax ADD CONSTRAINT TaxCodes_CountryTax_FK FOREIGN KEY (Code_ID) 
	REFERENCES TaxCodes (Code_ID);

ALTER TABLE Discount_Categories ADD CONSTRAINT Categories_Discount_Categories_FK FOREIGN KEY (Category_ID) 
	REFERENCES Categories (Category_ID);

ALTER TABLE Discount_Categories ADD CONSTRAINT Discounts_Discount_Categories_FK FOREIGN KEY (Discount_ID)
	REFERENCES Discounts (Discount_ID);

ALTER TABLE Discount_Groups ADD CONSTRAINT Groups_Discount_Groups_FK FOREIGN KEY (Group_ID) 
	REFERENCES Groups (Group_ID);

ALTER TABLE Discount_Products ADD CONSTRAINT Discounts_Discount_Products_FK FOREIGN KEY (Discount_ID)
	REFERENCES Discounts (Discount_ID);

ALTER TABLE Discount_Products ADD CONSTRAINT Products_Discount_Products_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID);

ALTER TABLE FeatureReviews ADD CONSTRAINT Features_FeatureReviews_FK FOREIGN KEY (Feature_ID)
	REFERENCES Features (Feature_ID);

ALTER TABLE Features ADD CONSTRAINT Colors_Features_FK FOREIGN KEY (Color_ID)
	REFERENCES Colors (Color_ID);

ALTER TABLE GiftItems ADD CONSTRAINT GiftRegistry_GiftItems_FK FOREIGN KEY (GiftRegistry_ID)
	REFERENCES GiftRegistry (GiftRegistry_ID);

ALTER TABLE GiftItems ADD CONSTRAINT Products_GiftItems_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID);

ALTER TABLE GiftRegistry ADD CONSTRAINT Users_GiftRegistry_FK FOREIGN KEY (User_ID)
	REFERENCES Users (User_ID);

ALTER TABLE LocalTax ADD CONSTRAINT TaxCodes_LocalTax_FK FOREIGN KEY (Code_ID)
	REFERENCES TaxCodes (Code_ID);

ALTER TABLE Order_Items ADD CONSTRAINT Order_No_Orders_FK FOREIGN KEY (Order_No)
	REFERENCES Order_No (Order_No);

ALTER TABLE OrderTaxes ADD CONSTRAINT Order_No_OrderTaxes_FK FOREIGN KEY (Order_No)
	REFERENCES Order_No (Order_No);

ALTER TABLE OrderTaxes ADD CONSTRAINT TaxCodes_OrderTaxes_FK FOREIGN KEY (Code_ID)
	REFERENCES TaxCodes (Code_ID);

ALTER TABLE Pages ADD CONSTRAINT Colors_Pages_FK FOREIGN KEY (Color_ID)
	REFERENCES Colors (Color_ID);

ALTER TABLE Permissions ADD CONSTRAINT Permission_Groups_Permissions_FK FOREIGN KEY (Group_ID)
	REFERENCES Permission_Groups (Group_ID);

ALTER TABLE Prod_CustInfo ADD CONSTRAINT Prod_CustomFields_Prod_CustInfo_FK FOREIGN KEY (Custom_ID)
	REFERENCES Prod_CustomFields (Custom_ID);

ALTER TABLE Prod_CustInfo ADD CONSTRAINT Products_Prod_CustInfo_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID);

ALTER TABLE ProdGrpPrice ADD CONSTRAINT Groups_ProdGrpPrice_FK FOREIGN KEY (Group_ID)
	REFERENCES Groups (Group_ID);

ALTER TABLE ProdGrpPrice ADD CONSTRAINT Products_ProdGrpPrice_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID);

ALTER TABLE ProdOpt_Choices ADD CONSTRAINT Product_Options_ProdOpt_Choices_FK FOREIGN KEY (Option_ID)
	REFERENCES Product_Options (Option_ID);

ALTER TABLE Product_Options ADD CONSTRAINT Products_Product_Options_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID);

ALTER TABLE ProductReviews ADD CONSTRAINT Products_ProductReviews_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID);

ALTER TABLE ProductReviewsHelpful ADD CONSTRAINT Products_ProductReviewsHelpful_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID);

ALTER TABLE Products ADD CONSTRAINT Colors_Products_FK FOREIGN KEY (Color_ID)
	REFERENCES Colors (Color_ID);

ALTER TABLE Promotion_Groups ADD CONSTRAINT Groups_Promotion_Groups_FK FOREIGN KEY (Group_ID)
	REFERENCES Groups (Group_ID);

ALTER TABLE Promotion_Groups ADD CONSTRAINT Promotions_Promotion_Groups_FK FOREIGN KEY (Promotion_ID)
	REFERENCES Promotions (Promotion_ID);

ALTER TABLE Promotion_Qual_Products ADD CONSTRAINT Products_Promotion_Qual_Products_FK FOREIGN KEY (Product_ID)
	REFERENCES Products (Product_ID);

ALTER TABLE Promotion_Qual_Products ADD CONSTRAINT Promotions_Promotion_Qual_Products_FK FOREIGN KEY (Promotion_ID)
	REFERENCES Promotions (Promotion_ID);

ALTER TABLE StateTax ADD CONSTRAINT States_StateTax_FK FOREIGN KEY (State)
	REFERENCES States (Abb);

ALTER TABLE StateTax ADD CONSTRAINT TaxCodes_StateTax_FK FOREIGN KEY (Code_ID)
	REFERENCES TaxCodes (Code_ID);

ALTER TABLE StdOpt_Choices ADD CONSTRAINT StdOptions_StdOpt_Choices_FK FOREIGN KEY (Std_ID)
	REFERENCES StdOptions (Std_ID);
	