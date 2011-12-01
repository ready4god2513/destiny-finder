
-- Creates the base schema for CFWebstore Version 6 on MySQL

CREATE TABLE `AccessKeys` (
  `AccessKey_ID` INT NOT NULL  AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `Keyring` VARCHAR(50) NULL,
  `System` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`AccessKey_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Account` (
  `Account_ID` INT NOT NULL  AUTO_INCREMENT,
  `User_ID` INT NULL DEFAULT 0,
  `Customer_ID` INT NOT NULL DEFAULT 0,
  `Account_Name` VARCHAR(50) NOT NULL,
  `Type1` VARCHAR(50) NOT NULL,
  `Description` LONGTEXT NULL,
  `Policy` LONGTEXT NULL,
  `Logo` VARCHAR(50) NULL,
  `Rep` VARCHAR(50) NULL,
  `Terms` VARCHAR(50) NULL,
  `LastUsed` DATETIME NULL,
  `Directory_Live` BOOL NOT NULL DEFAULT 0,
  `Web_URL` VARCHAR(75) NULL,
  `Dropship_Email` VARCHAR(100) NULL,
  `PO_Text` VARCHAR(50) NULL,
  `Map_URL` LONGTEXT NULL,
  `ID_Tag` VARCHAR(35) NULL,
  KEY `Account_Customer_ID_Idx` (`Customer_ID` ASC),
  KEY `Account_ID_Tag_Idx` (`ID_Tag` ASC),
  PRIMARY KEY (`Account_ID` ASC),
  KEY `Account_User_ID_Idx` (`User_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Affiliates` (
  `Affiliate_ID` INT NOT NULL  AUTO_INCREMENT,
  `AffCode` INT NOT NULL DEFAULT 0,
  `AffPercent` DOUBLE NOT NULL DEFAULT 0,
  `Aff_Site` VARCHAR(255) NULL,
  `ID_Tag` VARCHAR(35) NULL,
  KEY `Affiliates_AffCode_Idx` (`AffCode` ASC),
  KEY `Affiliates_ID_Tag_Idx` (`ID_Tag` ASC),
  PRIMARY KEY (`Affiliate_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Customers` (
  `Customer_ID` INT NOT NULL  AUTO_INCREMENT,
  `User_ID` INT NOT NULL DEFAULT 0,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(150) NOT NULL,
  `Company` VARCHAR(150) NULL,
  `Address1` VARCHAR(150) NOT NULL,
  `Address2` VARCHAR(150) NULL,
  `City` VARCHAR(150) NOT NULL,
  `County` VARCHAR(50) NULL,
  `State` VARCHAR(50) NOT NULL,
  `State2` VARCHAR(50) NULL,
  `Zip` VARCHAR(50) NOT NULL,
  `Country` VARCHAR(50) NOT NULL,
  `Phone` VARCHAR(50) NULL,
  `Phone2` VARCHAR(50) NULL,
  `Fax` VARCHAR(50) NULL,
  `Email` VARCHAR(150) NULL,
  `Residence` BOOL NOT NULL DEFAULT 1,
  `LastUsed` DATETIME NULL,
  `ID_Tag` VARCHAR(35) NULL,
  PRIMARY KEY (`Customer_ID` ASC),  
  KEY `Customers_ID_Tag_Idx` (`ID_Tag` ASC),
  KEY `Customers_User_ID_Idx` (`User_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Discounts` (
  `Discount_ID` INT NOT NULL  AUTO_INCREMENT,
  `Type1` INT NOT NULL DEFAULT 1,
  `Type2` INT NOT NULL DEFAULT 1,
  `Type3` INT NOT NULL DEFAULT 0,
  `Type4` INT NOT NULL DEFAULT 0,
  `Type5` INT NOT NULL DEFAULT 0,
  `Coup_Code` VARCHAR(50) NULL,
  `OneTime` BOOL NOT NULL DEFAULT 0,
  `Name` VARCHAR(255) NOT NULL,
  `Display` VARCHAR(255) NULL,
  `Amount` DOUBLE NOT NULL DEFAULT 0,
  `MinOrder` DOUBLE NOT NULL DEFAULT 0,
  `MaxOrder` DOUBLE NOT NULL DEFAULT 0,
  `StartDate` DATETIME NULL,
  `EndDate` DATETIME NULL,
  `AccessKey` INT NULL DEFAULT 0,
  KEY `Discounts_AccessKey_Idx` (`AccessKey` ASC),
  KEY `Discounts_Coup_Code_Idx` (`Coup_Code` ASC),
  PRIMARY KEY (`Discount_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Users` (
  `User_ID` INT NOT NULL  AUTO_INCREMENT,
  `Username` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(50) NULL,
  `EmailIsBad` BOOL NOT NULL DEFAULT 0,
  `EmailLock` VARCHAR(50) NULL,
  `Subscribe` BOOL NOT NULL DEFAULT 0,
  `Customer_ID` INT NOT NULL DEFAULT 0,
  `ShipTo` INT NOT NULL DEFAULT 0,
  `Group_ID` INT NOT NULL DEFAULT 0,
  `Account_ID` INT NULL DEFAULT 0,
  `Affiliate_ID` INT NULL DEFAULT 0,
  `Basket` VARCHAR(30) NULL,
  `Birthdate` DATETIME NULL,
  `CardisValid` BOOL NOT NULL DEFAULT 0,
  `CardType` VARCHAR(50) NULL,
  `NameonCard` VARCHAR(75) NULL,
  `CardNumber` VARCHAR(50) NULL,
  `CardExpire` DATETIME NULL,
  `CardZip` VARCHAR(50) NULL,
  `EncryptedCard` VARCHAR(75) NULL,
  `CurrentBalance` INT NULL DEFAULT 0,
  `LastLogin` DATETIME NULL,
  `Permissions` VARCHAR(255) NULL,
  `AdminNotes` LONGTEXT NULL,
  `Disable` BOOL NOT NULL DEFAULT 0,
  `LoginsTotal` INT NULL DEFAULT 0,
  `LoginsDay` INT NULL DEFAULT 0,
  `FailedLogins` INT NULL DEFAULT 0,
  `LastAttempt` DATETIME NULL,
  `Created` DATETIME NULL,
  `LastUpdate` DATETIME NULL,
  `ID_Tag` VARCHAR(35) NULL,
  KEY `Users_Account_ID_Idx` (`Account_ID` ASC),
  KEY `Users_Affiliate_ID_Idx` (`Affiliate_ID` ASC),
  KEY `Users_Customer_ID_Idx` (`Customer_ID` ASC),
  KEY `Users_Group_ID_Idx` (`Group_ID` ASC),
  KEY `Users_ID_Tag_Idx` (`ID_Tag` ASC),
  PRIMARY KEY (`User_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `CCProcess` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `CCServer` VARCHAR(150) NULL,
  `Transtype` VARCHAR(75) NULL,
  `Username` VARCHAR(75) NULL,
  `Password` VARCHAR(75) NULL,
  `Setting1` VARCHAR(75) NULL,
  `Setting2` VARCHAR(75) NULL,
  `Setting3` VARCHAR(75) NULL,
  PRIMARY KEY (`ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Certificates` (
  `Cert_ID` INT NOT NULL  AUTO_INCREMENT,
  `Cert_Code` VARCHAR(50) NOT NULL,
  `Cust_Name` VARCHAR(255) NULL,
  `CertAmount` DOUBLE NOT NULL DEFAULT 0,
  `InitialAmount` DOUBLE NULL DEFAULT 0,
  `StartDate` DATETIME NULL,
  `EndDate` DATETIME NULL,
  `Valid` BOOL NOT NULL DEFAULT 0,
  `Order_No` INT NULL DEFAULT 0,
  KEY `Certificates_Cert_Code_Idx` (`Cert_Code` ASC),
  PRIMARY KEY (`Cert_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `CatCore` (
  `CatCore_ID` INT NOT NULL DEFAULT 0,
  `Catcore_Name` VARCHAR(50) NOT NULL,
  `PassParams` VARCHAR(150) NULL,
  `Template` VARCHAR(50) NOT NULL,
  `Category` BOOL NOT NULL DEFAULT 0,
  `Products` BOOL NOT NULL DEFAULT 0,
  `Features` BOOL NOT NULL DEFAULT 0,
  `Page` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`CatCore_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `States` (
  `Abb` VARCHAR(2) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Abb` ASC)
) TYPE=InnoDB;

CREATE TABLE `Countries` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Abbrev` VARCHAR(2) NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `AllowUPS` BOOL NOT NULL DEFAULT 0,
  `Shipping` INT NOT NULL DEFAULT 0,
  `AddShipAmount` DOUBLE NOT NULL DEFAULT 0,
  UNIQUE KEY `Countries_Abbrev_Idx` (`Abbrev` ASC),
  PRIMARY KEY (`ID` ASC),
  KEY `Countries_Shipping_Idx` (`Shipping` ASC)
) TYPE=InnoDB;

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

CREATE TABLE `CreditCards` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `CardName` VARCHAR(50) NOT NULL,
  `Used` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Order_No` (
  `Order_No` INT NOT NULL  AUTO_INCREMENT,
  `Filled` BOOL NOT NULL DEFAULT 0,
  `Process` BOOL NOT NULL DEFAULT 0,
  `Void` BOOL NULL DEFAULT 0,
  `InvDone` BOOL NOT NULL DEFAULT 0,
  `Customer_ID` INT NOT NULL DEFAULT 0,
  `User_ID` INT NULL DEFAULT 0,
  `Card_ID` INT NULL DEFAULT 0,
  `ShipTo` INT NULL DEFAULT 0,
  `DateOrdered` DATETIME NOT NULL,
  `OrderTotal` DOUBLE NOT NULL DEFAULT 0,
  `Tax` DOUBLE NOT NULL DEFAULT 0,
  `ShipType` VARCHAR(75) NULL,
  `Shipping` DOUBLE NOT NULL DEFAULT 0,
  `Freight` INT NOT NULL DEFAULT 0,
  `Comments` VARCHAR(255) NULL,
  `AuthNumber` VARCHAR(50) NULL,
  `InvoiceNum` VARCHAR(75) NULL,
  `TransactNum` VARCHAR(50) NULL,
  `Shipper` VARCHAR(50) NULL,
  `Tracking` VARCHAR(255) NULL,
  `Giftcard` VARCHAR(255) NULL,
  `Delivery` VARCHAR(50) NULL,
  `OrderDisc` DOUBLE NOT NULL DEFAULT 0,
  `Credits` DOUBLE NOT NULL DEFAULT 0,
  `AddonTotal` DOUBLE NOT NULL DEFAULT 0,
  `Coup_Code` VARCHAR(50) NULL,
  `Cert_Code` VARCHAR(50) NULL,
  `Affiliate` INT NULL,
  `Referrer` VARCHAR(255) NULL,
  `CustomText1` VARCHAR(255) NULL,
  `CustomText2` VARCHAR(255) NULL,
  `CustomText3` VARCHAR(50) NULL,
  `CustomSelect1` VARCHAR(100) NULL,
  `CustomSelect2` VARCHAR(100) NULL,
  `DateFilled` DATETIME NULL,
  `PayPalStatus` VARCHAR(30) NULL,
  `Reason` LONGTEXT NULL,
  `OfflinePayment` VARCHAR(50) NULL,
  `PO_Number` VARCHAR(30) NULL,
  `Notes` LONGTEXT NULL,
  `Admin_Updated` DATETIME NULL,
  `Admin_Name` VARCHAR(50) NULL,
  `AdminCredit` DOUBLE NOT NULL DEFAULT 0,
  `AdminCreditText` VARCHAR(50) NULL,
  `Printed` INT NOT NULL DEFAULT 0,
  `Status` VARCHAR(50) NULL,
  `Paid` BOOL NOT NULL DEFAULT 0,
  `CodesSent` BOOL NOT NULL DEFAULT 0,
  `ID_Tag` VARCHAR(35) NULL,
  KEY `Order_No_Coup_Code_Idx` (`Coup_Code` ASC),
  KEY `Order_No_Customer_ID_Idx` (`Customer_ID` ASC),
  PRIMARY KEY (`Order_No` ASC),
  KEY `Order_No_User_ID_Idx` (`User_ID` ASC),
  KEY `Order_No_ID_Tag_Idx` (`ID_Tag` ASC),
  CONSTRAINT `Customers_Order_No_FK` FOREIGN KEY (`Customer_ID`) REFERENCES `Customers` (`Customer_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
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
  KEY `CustomMethods_Used_Idx` (`Used` ASC)
) TYPE=InnoDB;

CREATE TABLE `CustomShipSettings` (
  `Setting_ID` INT NOT NULL  AUTO_INCREMENT,
  `ShowShipTable` BOOL NOT NULL DEFAULT 0,
  `MultPerItem` BOOL NOT NULL DEFAULT 0,
  `CumulativeAmounts` BOOL NOT NULL DEFAULT 0,
  `MultMethods` BOOL NOT NULL DEFAULT 0,
  `Debug` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`Setting_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Colors` (
  `Color_ID` INT NOT NULL  AUTO_INCREMENT,
  `Bgcolor` VARCHAR(10) NULL,
  `Bgimage` VARCHAR(100) NULL,
  `MainTitle` VARCHAR(10) NULL,
  `MainText` VARCHAR(10) NULL,
  `MainLink` VARCHAR(10) NULL,
  `MainVLink` VARCHAR(10) NULL,
  `BoxHBgcolor` VARCHAR(10) NULL,
  `BoxHText` VARCHAR(10) NULL,
  `BoxTBgcolor` VARCHAR(10) NULL,
  `BoxTText` VARCHAR(10) NULL,
  `InputHBgcolor` VARCHAR(10) NULL,
  `InputHText` VARCHAR(10) NULL,
  `InputTBgcolor` VARCHAR(10) NULL,
  `InputTText` VARCHAR(10) NULL,
  `OutputHBgcolor` VARCHAR(10) NULL,
  `OutputHText` VARCHAR(10) NULL,
  `OutputTBgcolor` VARCHAR(10) NULL,
  `OutputTText` VARCHAR(10) NULL,
  `OutputTAltcolor` VARCHAR(10) NULL,
  `OutputTHighlight` VARCHAR(10) NULL,
  `LineColor` VARCHAR(10) NULL,
  `HotImage` VARCHAR(50) NULL,
  `SaleImage` VARCHAR(50) NULL,
  `NewImage` VARCHAR(50) NULL,
  `MainLineImage` VARCHAR(50) NULL,
  `MinorLineImage` VARCHAR(50) NULL,
  `Palette_Name` VARCHAR(50) NULL,
  `FormReq` VARCHAR(10) NULL,
  `LayoutFile` VARCHAR(50) NULL,
  `FormReqOB` VARCHAR(10) NULL,
  `PassParam` VARCHAR(100) NULL,
  PRIMARY KEY (`Color_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Groups` (
  `Group_ID` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Description` LONGTEXT NULL,
  `Permissions` VARCHAR(255) NULL,
  `Wholesale` BOOL NOT NULL DEFAULT 0,
  `Group_Code` VARCHAR(20) NULL,
  `TaxExempt` BOOL NOT NULL DEFAULT 0,
  `ShipExempt` BOOL NOT NULL DEFAULT 0,
  KEY `Groups_Name_Idx` (`Name` ASC),
  PRIMARY KEY (`Group_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Products` (
  `Product_ID` INT NOT NULL  AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Short_Desc` LONGTEXT NULL,
  `Long_Desc` LONGTEXT NULL,
  `SKU` VARCHAR(50) NULL,
  `Vendor_SKU` VARCHAR(50) NULL,
  `Retail_Price` DOUBLE NULL DEFAULT 0,
  `Base_Price` DOUBLE NOT NULL DEFAULT 0,
  `Wholesale` DOUBLE NOT NULL DEFAULT 0,
  `Dropship_Cost` DOUBLE NULL DEFAULT 0,
  `Weight` DOUBLE NULL DEFAULT 0,
  `Shipping` BOOL NOT NULL DEFAULT 1,
  `TaxCodes` VARCHAR(50) NULL,
  `AccessKey` INT NULL DEFAULT 0,
  `Sm_Image` VARCHAR(100) NULL,
  `Lg_Image` VARCHAR(255) NULL,
  `Enlrg_Image` VARCHAR(100) NULL,
  `Sm_Title` VARCHAR(100) NULL,
  `Lg_Title` VARCHAR(100) NULL,
  `PassParam` VARCHAR(100) NULL,
  `Color_ID` INT NULL,
  `Display` BOOL NOT NULL DEFAULT 1,
  `Priority` INT NOT NULL DEFAULT 9999,
  `NumInStock` INT NULL DEFAULT 0,
  `ShowOrderBox` BOOL NOT NULL DEFAULT 0,
  `ShowPrice` BOOL NOT NULL DEFAULT 1,
  `ShowDiscounts` BOOL NOT NULL DEFAULT 1,
  `ShowPromotions` BOOL NOT NULL DEFAULT 0,
  `Highlight` BOOL NOT NULL DEFAULT 0,
  `NotSold` BOOL NOT NULL DEFAULT 0,
  `Reviewable` BOOL NOT NULL DEFAULT 0,
  `UseforPOTD` BOOL NOT NULL DEFAULT 0,
  `Sale` BOOL NOT NULL DEFAULT 0,
  `Hot` BOOL NOT NULL DEFAULT 0,
  `DateAdded` DATETIME NULL,
  `OptQuant` INT NOT NULL DEFAULT 0,
  `Reorder_Level` INT NULL DEFAULT 0,
  `Min_Order` INT NULL DEFAULT 0,
  `Mult_Min` BOOL NOT NULL DEFAULT 0,
  `Sale_Start` DATETIME NULL,
  `Sale_End` DATETIME NULL,
  `Discounts` VARCHAR(255) NULL,
  `Promotions` VARCHAR(255) NULL,
  `Account_ID` INT NULL DEFAULT 0,
  `Mfg_Account_ID` INT NULL DEFAULT 0,
  `Prod_Type` VARCHAR(50) NULL,
  `Content_URL` VARCHAR(75) NULL,
  `MimeType` VARCHAR(50) NULL,
  `Access_Count` INT NULL DEFAULT 0,
  `Num_Days` INT NULL DEFAULT 0,
  `Access_Keys` VARCHAR(50) NULL,
  `Recur` BOOL NOT NULL DEFAULT 0,
  `Recur_Product_ID` INT NULL DEFAULT 0,
  `VertOptions` BOOL NOT NULL DEFAULT 0,
  `Metadescription` VARCHAR(255) NULL,
  `Keywords` VARCHAR(255) NULL,
  `TitleTag` VARCHAR(255) NULL,
  `GiftWrap` BOOL NOT NULL DEFAULT 0,
  `Availability` VARCHAR(75) NULL,
  `Freight_Dom` DOUBLE NULL DEFAULT 0,
  `Freight_Intl` DOUBLE NULL DEFAULT 0,
  `Pack_Width` DOUBLE NULL DEFAULT 0,
  `Pack_Height` DOUBLE NULL DEFAULT 0,
  `Pack_Length` DOUBLE NULL DEFAULT 0,
  `User_ID` INT NULL DEFAULT 0,
  `Goog_Brand` VARCHAR(100) NULL,
  `Goog_Condition` VARCHAR(100) NULL,
  `Goog_Expire` DATETIME NULL,
  `Goog_Prodtype` VARCHAR(100) NULL,
  KEY `Products_AccessKey_Idx` (`AccessKey` ASC),
  KEY `Products_Account_ID_Idx` (`Account_ID` ASC),
  KEY `Products_Highlight_Idx` (`Highlight` ASC),
  KEY `Products_NumInStock_Idx` (`NumInStock` ASC),
  PRIMARY KEY (`Product_ID` ASC),
  KEY `Products_Recur_Product_ID_Idx` (`Recur_Product_ID` ASC),
  KEY `Products_User_ID_Idx` (`User_ID` ASC),
  CONSTRAINT `Colors_Products_FK` FOREIGN KEY (`Color_ID`) REFERENCES `Colors` (`Color_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Categories` (
  `Category_ID` INT NOT NULL  AUTO_INCREMENT,
  `Parent_ID` INT NOT NULL DEFAULT 0,
  `CatCore_ID` INT NOT NULL DEFAULT 1,
  `Name` VARCHAR(255) NOT NULL,
  `Short_Desc` LONGTEXT NULL,
  `Long_Desc` LONGTEXT NULL,
  `Sm_Image` VARCHAR(100) NULL,
  `Lg_Image` VARCHAR(100) NULL,
  `Sm_Title` VARCHAR(100) NULL,
  `Lg_Title` VARCHAR(100) NULL,
  `PassParam` VARCHAR(100) NULL,
  `AccessKey` INT NULL DEFAULT 0,
  `CColumns` SMALLINT NULL,
  `PColumns` SMALLINT NULL,
  `Display` BOOL NOT NULL DEFAULT 1,
  `ProdFirst` BOOL NOT NULL DEFAULT 0,
  `Priority` INT NOT NULL DEFAULT 9999,
  `Highlight` BOOL NOT NULL DEFAULT 0,
  `ParentIDs` VARCHAR(50) NULL,
  `ParentNames` LONGTEXT NULL,
  `Sale` BOOL NOT NULL DEFAULT 0,
  `DateAdded` DATETIME NULL,
  `Color_ID` INT NULL,
  `Metadescription` VARCHAR(255) NULL,
  `Keywords` VARCHAR(255) NULL,
  `TitleTag` VARCHAR(255) NULL,
  KEY `Categories_CatCore_ID_Idx` (`CatCore_ID` ASC),
  PRIMARY KEY (`Category_ID` ASC),
  KEY `Category_Color_ID_Idx` (`Color_ID` ASC),
  KEY `Category_Parent_ID_Idx` (`Parent_ID` ASC),
  CONSTRAINT `CatCore_Categories_FK` FOREIGN KEY (`CatCore_ID`) REFERENCES `CatCore` (`CatCore_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Colors_Categories_FK` FOREIGN KEY (`Color_ID`) REFERENCES `Colors` (`Color_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Features` (
  `Feature_ID` INT NOT NULL  AUTO_INCREMENT,
  `User_ID` INT NULL DEFAULT 0,
  `Feature_Type` VARCHAR(50) NULL,
  `Name` VARCHAR(125) NOT NULL,
  `Author` VARCHAR(50) NULL,
  `Copyright` VARCHAR(50) NULL,
  `Display` BOOL NOT NULL DEFAULT 0,
  `Approved` BOOL NOT NULL DEFAULT 0,
  `Start` DATETIME NULL,
  `Expire` DATETIME NULL,
  `Priority` INT NULL DEFAULT 9999,
  `AccessKey` INT NULL DEFAULT 0,
  `Highlight` BOOL NOT NULL DEFAULT 0,
  `Display_Title` BOOL NOT NULL DEFAULT 0,
  `Reviewable` BOOL NOT NULL DEFAULT 0,
  `Sm_Title` VARCHAR(150) NULL,
  `Sm_Image` VARCHAR(150) NULL,
  `Short_Desc` LONGTEXT NULL,
  `Lg_Title` VARCHAR(150) NULL,
  `Lg_Image` VARCHAR(150) NULL,
  `Long_Desc` LONGTEXT NULL,
  `PassParam` VARCHAR(150) NULL,
  `Color_ID` INT NULL,
  `Created` DATETIME NULL,
  `Metadescription` VARCHAR(255) NULL,
  `Keywords` VARCHAR(255) NULL,
  `TitleTag` VARCHAR(255) NULL,
  KEY `Features_AccessKey_Idx` (`AccessKey` ASC),
  KEY `Features_Color_ID_Idx` (`Color_ID` ASC),
  PRIMARY KEY (`Feature_ID` ASC),
  KEY `Features_User_ID_Idx` (`User_ID` ASC),
  CONSTRAINT `Colors_Features_FK` FOREIGN KEY (`Color_ID`) REFERENCES `Colors` (`Color_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Users_Features_FK` FOREIGN KEY (`User_ID`) REFERENCES `Users` (`User_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Feature_Product` (
  `Feature_Product_ID` INT NOT NULL  AUTO_INCREMENT,
  `Product_ID` INT NOT NULL,
  `Feature_ID` INT NOT NULL,
  KEY `Feature_Product_Feature_ID_Idx` (`Feature_ID` ASC),
  PRIMARY KEY (`Feature_Product_ID` ASC),
  KEY `Feature_Product_Product_ID_Idx` (`Product_ID` ASC),
  CONSTRAINT `Features_Feature_Product_FK` FOREIGN KEY (`Feature_ID`) REFERENCES `Features` (`Feature_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Products_Feature_Product_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `FeatureReviews` (
  `Review_ID` INT NOT NULL AUTO_INCREMENT,
  `Feature_ID` INT NOT NULL,
  `Parent_ID` INT NULL DEFAULT 0,
  `User_ID` INT NULL DEFAULT 0,
  `Anonymous` BOOL NOT NULL DEFAULT 0,
  `Anon_Name` VARCHAR(100) NULL,
  `Anon_Loc` VARCHAR(100) NULL,
  `Anon_Email` VARCHAR(100) NULL,
  `Editorial` VARCHAR(50) NULL,
  `Title` VARCHAR(75) NULL,
  `Comment` LONGTEXT NULL,
  `Rating` SMALLINT NULL DEFAULT 0,
  `Recommend` BOOL NOT NULL DEFAULT 0,
  `Posted` DATETIME NOT NULL,
  `Updated` DATETIME NULL,
  `Approved` BOOL NOT NULL DEFAULT 0,
  `NeedsCheck` BOOL NOT NULL DEFAULT 0,
  KEY `FeatureReviews_Feature_ID_Idx` (`Feature_ID` ASC),
  KEY `FeatureReviews_Parent_ID_Idx` (`Parent_ID` ASC),
  PRIMARY KEY (`Review_ID` ASC),
  KEY `FeatureReviews_Posted_Idx` (`Posted` ASC),
  KEY `FeatureReviews_Rating_Idx` (`Rating` ASC),
  KEY `FeatureReviews_User_ID_Idx` (`User_ID` ASC),
  CONSTRAINT `Features_FeatureReviews_FK` FOREIGN KEY (`Feature_ID`) REFERENCES `Features` (`Feature_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Feature_Category` (
  `Feature_Category_ID` INT NOT NULL  AUTO_INCREMENT,
  `Feature_ID` INT NOT NULL,
  `Category_ID` INT NOT NULL,
  KEY `Feature_Category_Category_ID_Idx` (`Category_ID` ASC),
  KEY `Feature_Category_Feature_ID_Idx` (`Feature_ID` ASC),
  PRIMARY KEY (`Feature_Category_ID` ASC),
  CONSTRAINT `Categories_Feature_Category_FK` FOREIGN KEY (`Category_ID`) REFERENCES `Categories` (`Category_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Features_Feature_Category_FK` FOREIGN KEY (`Feature_ID`) REFERENCES `Features` (`Feature_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Product_Category` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Product_ID` INT NOT NULL,
  `Category_ID` INT NOT NULL,
  KEY `Product_Category_Category_ID_Idx` (`Category_ID` ASC),
  PRIMARY KEY (`ID` ASC),
  KEY `Product_Category_Product_ID_Idx` (`Product_ID` ASC),
  CONSTRAINT `Categories_Product_Category_FK` FOREIGN KEY (`Category_ID`) REFERENCES `Categories` (`Category_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Products_Product_Category_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `FedEx_Dropoff` (
  `FedEx_Code` VARCHAR(30) NOT NULL,
  `Description` VARCHAR(50) NULL,
  PRIMARY KEY (`FedEx_Code` ASC)
) TYPE=InnoDB;

CREATE TABLE `FedEx_Packaging` (
  `FedEx_Code` VARCHAR(20) NOT NULL,
  `Description` VARCHAR(50) NULL,
  PRIMARY KEY (`FedEx_Code` ASC)
) TYPE=InnoDB;

CREATE TABLE `FedEx_Settings` (
  `Fedex_ID` INT NOT NULL  AUTO_INCREMENT,
  `AccountNo` VARCHAR(20) NULL,
  `MeterNum` VARCHAR(20) NULL,
  `MaxWeight` INT NULL DEFAULT 0,
  `UnitsofMeasure` VARCHAR(20) NULL,
  `Dropoff` VARCHAR(20) NULL,
  `Packaging` VARCHAR(20) NULL,
  `OrigZip` VARCHAR(20) NULL,
  `OrigState` VARCHAR(75) NULL,
  `OrigCountry` VARCHAR(10) NULL,
  `Debug` BOOL NOT NULL DEFAULT 0,
  `UseGround` BOOL NOT NULL DEFAULT 0,
  `UseExpress` BOOL NOT NULL DEFAULT 0,
  `Logging` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`Fedex_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `FedExMethods` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Name` VARCHAR(75) NULL,
  `Used` BOOL NOT NULL DEFAULT 0,
  `Shipper` VARCHAR(10) NULL,
  `Code` VARCHAR(75) NULL,
  `Priority` INT NULL DEFAULT 0,
  KEY `FedExMethods_Code_Idx` (`Code` ASC),
  PRIMARY KEY (`ID` ASC),
  KEY `FedExMethods_Used_Idx` (`Used` ASC)
) TYPE=InnoDB;

CREATE TABLE `GiftRegistry` (
  `GiftRegistry_ID` INT NOT NULL  AUTO_INCREMENT,
  `User_ID` INT NOT NULL DEFAULT 0,
  `Registrant` VARCHAR(75) NULL,
  `OtherName` VARCHAR(50) NULL,
  `GiftRegistry_Type` VARCHAR(50) NULL,
  `Event_Date` DATETIME NULL,
  `Event_Name` VARCHAR(50) NULL,
  `Event_Descr` VARCHAR(255) NULL,
  `Private` BOOL NOT NULL DEFAULT 0,
  `Order_Notification` BOOL NOT NULL DEFAULT 0,
  `Live` BOOL NOT NULL DEFAULT 0,
  `Approved` BOOL NOT NULL DEFAULT 0,
  `City` VARCHAR(150) NULL,
  `State` VARCHAR(50) NULL,
  `Created` DATETIME NULL,
  `Expire` DATETIME NULL,
  `ID_Tag` VARCHAR(35) NULL,
  PRIMARY KEY (`GiftRegistry_ID` ASC),
  KEY `GiftRegistry_User_ID_Idx` (`User_ID` ASC),
  KEY `GiftRegistry_ID_Tag_Idx` (`ID_Tag` ASC),
  CONSTRAINT `Users_GiftRegistry_FK` FOREIGN KEY (`User_ID`) REFERENCES `Users` (`User_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `GiftItems` (
  `GiftItem_ID` INT NOT NULL AUTO_INCREMENT,
  `GiftRegistry_ID` INT NOT NULL,
  `Product_ID` INT NOT NULL DEFAULT 0,
  `Options` LONGTEXT NULL,
  `Addons` LONGTEXT NULL,
  `AddonMultP` DOUBLE NULL DEFAULT 0,
  `AddonNonMultP` DOUBLE NULL DEFAULT 0,
  `AddonMultW` DOUBLE NULL DEFAULT 0,
  `AddonNonMultW` DOUBLE NULL DEFAULT 0,
  `OptPrice` DOUBLE NOT NULL DEFAULT 0,
  `OptWeight` DOUBLE NOT NULL DEFAULT 0,
  `OptQuant` INT NOT NULL DEFAULT 0,
  `OptChoice` SMALLINT NOT NULL DEFAULT 0,
  `OptionID_List` VARCHAR(255) NULL,
  `ChoiceID_List` VARCHAR(255) NULL,
  `SKU` VARCHAR(100) NULL,
  `Price` DOUBLE NOT NULL DEFAULT 0,
  `Weight` DOUBLE NOT NULL DEFAULT 0,
  `Quantity_Requested` SMALLINT NOT NULL DEFAULT 0,
  `Quantity_Purchased` SMALLINT NOT NULL DEFAULT 0,
  `DateAdded` DATETIME NULL,
  KEY `GiftItems_GiftRegistry_ID_Idx` (`GiftRegistry_ID` ASC),
  PRIMARY KEY (`GiftItem_ID` ASC),
  KEY `GiftItems_Product_ID_Idx` (`Product_ID` ASC),
  CONSTRAINT `GiftRegistry_GiftItems_FK` FOREIGN KEY (`GiftRegistry_ID`) REFERENCES `GiftRegistry` (`GiftRegistry_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Products_GiftItems_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Giftwrap` (
  `Giftwrap_ID` INT NOT NULL  AUTO_INCREMENT,
  `Name` VARCHAR(60) NOT NULL,
  `Short_Desc` LONGTEXT NULL,
  `Sm_Image` VARCHAR(150) NULL,
  `Price` DOUBLE NOT NULL DEFAULT 0,
  `Weight` DOUBLE NOT NULL DEFAULT 0,
  `Priority` SMALLINT NOT NULL DEFAULT 0,
  `Display` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`Giftwrap_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `ProdGrpPrice` (
  `Product_ID` INT NOT NULL,
  `GrpPrice_ID` INT NOT NULL,
  `Group_ID` INT NOT NULL,
  `Price` DOUBLE NOT NULL DEFAULT 0,
  KEY `ProdGrpPrice_Group_ID_Idx` (`Group_ID` ASC),
  PRIMARY KEY (`Product_ID` ASC,`GrpPrice_ID` ASC),
  KEY `ProdGrpPrice_Product_ID_Idx` (`Product_ID` ASC),
  CONSTRAINT `Groups_ProdGrpPrice_FK` FOREIGN KEY (`Group_ID`) REFERENCES `Groups` (`Group_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Products_ProdGrpPrice_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Intershipper` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Password` VARCHAR(50) NULL,
  `Residential` BOOL NOT NULL DEFAULT 0,
  `Pickup` VARCHAR(5) NOT NULL,
  `UnitsofMeasure` VARCHAR(10) NOT NULL,
  `MaxWeight` INT NULL DEFAULT 0,
  `Carriers` VARCHAR(50) NOT NULL,
  `UserID` VARCHAR(100) NULL,
  `Classes` VARCHAR(100) NULL,
  `MerchantZip` VARCHAR(20) NULL,
  `Logging` BOOL NOT NULL DEFAULT 0,
  `Debug` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `IntShipTypes` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `Used` BOOL NOT NULL DEFAULT 0,
  `Code` VARCHAR(10) NOT NULL,
  `Priority` INT NULL DEFAULT 0,
  PRIMARY KEY (`ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Locales` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL,
  `CurrExchange` VARCHAR(50) NULL,
  UNIQUE KEY `Locales_Name_Idx` (`Name` ASC),
  PRIMARY KEY (`ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `LocalTax` (
  `Local_ID` INT NOT NULL  AUTO_INCREMENT,
  `Code_ID` INT NOT NULL DEFAULT 0,
  `ZipCode` VARCHAR(20) NOT NULL,
  `Tax` DOUBLE NOT NULL DEFAULT 0,
  `EndZip` VARCHAR(20) NULL,
  `TaxShip` BOOL NOT NULL DEFAULT 0,
  KEY `LocalTax_Code_ID_Idx` (`Code_ID` ASC),
  PRIMARY KEY (`Local_ID` ASC),
  KEY `LocalTax_ZipCode_Idx` (`ZipCode` ASC),
  CONSTRAINT `TaxCodes_LocalTax_FK` FOREIGN KEY (`Code_ID`) REFERENCES `TaxCodes` (`Code_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `MailText` (
  `MailText_ID` INT NOT NULL  AUTO_INCREMENT,
  `MailText_Name` VARCHAR(50) NULL,
  `MailText_Message` LONGTEXT NULL,
  `MailText_Subject` VARCHAR(75) NULL,
  `MailText_Attachment` VARCHAR(255) NULL,
  `System` BOOL NOT NULL DEFAULT 0,
  `MailAction` VARCHAR(50) NULL,
  PRIMARY KEY (`MailText_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Memberships` (
  `Membership_ID` INT NOT NULL  AUTO_INCREMENT,
  `User_ID` INT NULL DEFAULT 0,
  `Order_ID` INT NULL,
  `Product_ID` INT NULL DEFAULT 0,
  `Membership_Type` VARCHAR(50) NULL,
  `AccessKey_ID` VARCHAR(50) NULL,
  `Start` DATETIME NULL,
  `Time_Count` INT NULL DEFAULT 0,
  `Access_Count` INT NULL DEFAULT 0,
  `Expire` DATETIME NULL,
  `Valid` BOOL NOT NULL DEFAULT 0,
  `Date_Ordered` DATETIME NULL,
  `Access_Used` INT NULL DEFAULT 0,
  `Recur` BOOL NOT NULL DEFAULT 0,
  `Recur_Product_ID` INT NULL DEFAULT 0,
  `Suspend_Begin_Date` DATETIME NULL,
  `Next_Membership_ID` INT NULL DEFAULT 0,
  `ID_Tag` VARCHAR(35) NULL,
  KEY `Memberships_AccessKey_ID_Idx` (`AccessKey_ID` ASC),
  KEY `Memberships_Next_Membership_ID_Idx` (`Next_Membership_ID` ASC),
  PRIMARY KEY (`Membership_ID` ASC),
  KEY `Memberships_Recur_Product_ID_Idx` (`Recur_Product_ID` ASC),
  KEY `Memberships_User_ID_Idx` (`User_ID` ASC),
  KEY `Memberships_ID_Tag_Idx` (`ID_Tag` ASC),
  CONSTRAINT `Users_Memberships_FK` FOREIGN KEY (`User_ID`) REFERENCES `Users` (`User_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Order_PO` (
  `Order_PO_ID` INT NOT NULL  AUTO_INCREMENT,
  `Order_No` INT NOT NULL,
  `PO_No` VARCHAR(30) NOT NULL,
  `Account_ID` INT NOT NULL DEFAULT 0,
  `PrintDate` DATETIME NULL,
  `Notes` VARCHAR(255) NULL,
  `PO_Status` VARCHAR(50) NULL,
  `PO_Open` BOOL NOT NULL DEFAULT 0,
  `ShipDate` DATETIME NULL,
  `Shipper` VARCHAR(50) NULL,
  `Tracking` VARCHAR(50) NULL,
  `ID_Tag` VARCHAR(35) NULL,
  KEY `Order_PO_Account_ID_Idx` (`Account_ID` ASC),
  KEY `Order_PO_Order_No_Idx` (`Order_No` ASC),
  KEY `Order_PO_ID_Tag_Idx` (`ID_Tag` ASC),
  PRIMARY KEY (`Order_PO_ID` ASC),
  CONSTRAINT `Order_No_Order_PO_FK` FOREIGN KEY (`Order_No`) REFERENCES `Order_No` (`Order_No`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `OrderTaxes` (
  `Order_No` INT NOT NULL DEFAULT 0,
  `Code_ID` INT NOT NULL DEFAULT 0,
  `ProductTotal` DOUBLE NOT NULL DEFAULT 0,
  `CodeName` VARCHAR(50) NULL,
  `AddressUsed` VARCHAR(20) NULL,
  `AllUserTax` DOUBLE NOT NULL DEFAULT 0,
  `StateTax` DOUBLE NOT NULL DEFAULT 0,
  `CountyTax` DOUBLE NOT NULL DEFAULT 0,
  `LocalTax` DOUBLE NOT NULL DEFAULT 0,
  `CountryTax` DOUBLE NOT NULL DEFAULT 0,
  KEY `OrderTaxes_Order_No_Idx` (`Order_No` ASC),
  PRIMARY KEY (`Order_No` ASC,`Code_ID` ASC),
  CONSTRAINT `Order_No_OrderTaxes_FK` FOREIGN KEY (`Order_No`) REFERENCES `Order_No` (`Order_No`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `TaxCodes_OrderTaxes_FK` FOREIGN KEY (`Code_ID`) REFERENCES `TaxCodes` (`Code_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Order_Items` (
  `Order_No` INT NOT NULL,
  `Item_ID` INT NOT NULL,
  `Product_ID` INT NOT NULL DEFAULT 0,
  `Options` LONGTEXT NULL,
  `Addons` LONGTEXT NULL,
  `AddonMultP` DOUBLE NULL DEFAULT 0,
  `AddonNonMultP` DOUBLE NULL DEFAULT 0,
  `Price` DOUBLE NOT NULL DEFAULT 0,
  `Quantity` INT NOT NULL DEFAULT 0,
  `OptPrice` DOUBLE NOT NULL DEFAULT 0,
  `SKU` VARCHAR(50) NULL,
  `OptQuant` INT NOT NULL DEFAULT 0,
  `OptChoice` INT NULL,
  `OptionID_List` VARCHAR(255) NULL,
  `ChoiceID_List` VARCHAR(255) NULL,
  `DiscAmount` DOUBLE NULL,
  `Disc_Code` VARCHAR(50) NULL,
  `PromoAmount` DOUBLE NULL DEFAULT 0,
  `PromoQuant` INT NULL DEFAULT 0,
  `Promo_Code` VARCHAR(50) NULL,
  `Name` VARCHAR(255) NULL,
  `Dropship_Account_ID` INT NULL,
  `Dropship_Qty` INT NULL DEFAULT 0,
  `Dropship_SKU` VARCHAR(50) NULL,
  `Dropship_Cost` DOUBLE NULL DEFAULT 0,
  `Dropship_Note` VARCHAR(75) NULL,
  KEY `Order_Items_Disc_Code_Idx` (`Disc_Code` ASC),
  KEY `Order_Items_Order_No_Idx` (`Order_No` ASC),
  PRIMARY KEY (`Order_No` ASC,`Item_ID` ASC),
  KEY `Order_Items_Product_ID_Idx` (`Product_ID` ASC),
  KEY `Order_Items_Promo_Code_Idx` (`Promo_Code` ASC),
  CONSTRAINT `Order_No_Orders_FK` FOREIGN KEY (`Order_No`) REFERENCES `Order_No` (`Order_No`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `OrderSettings` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `AllowInt` BOOL NOT NULL DEFAULT 0,
  `AllowOffline` BOOL NOT NULL DEFAULT 0,
  `OnlyOffline` BOOL NOT NULL DEFAULT 0,
  `OfflineMessage` LONGTEXT NULL,
  `CCProcess` VARCHAR(50) NULL,
  `AllowPO` BOOL NOT NULL DEFAULT 0,
  `EmailAdmin` BOOL NOT NULL DEFAULT 0,
  `EmailUser` BOOL NOT NULL DEFAULT 0,
  `EmailAffs` BOOL NOT NULL DEFAULT 0,
  `EmailDrop` BOOL NOT NULL DEFAULT 0,
  `OrderEmail` VARCHAR(100) NULL,
  `DropEmail` VARCHAR(100) NULL,
  `EmailDropWhen` VARCHAR(15) NOT NULL,
  `Giftcard` BOOL NOT NULL DEFAULT 0,
  `Delivery` BOOL NOT NULL DEFAULT 0,
  `Coupons` BOOL NOT NULL DEFAULT 0,
  `Backorders` BOOL NOT NULL DEFAULT 0,
  `BaseOrderNum` INT NOT NULL DEFAULT 0,
  `StoreCardInfo` BOOL NOT NULL DEFAULT 0,
  `UseCVV2` BOOL NOT NULL DEFAULT 0,
  `MinTotal` INT NOT NULL DEFAULT 0,
  `NoGuests` BOOL NOT NULL DEFAULT 0,
  `UseBilling` BOOL NOT NULL DEFAULT 0,
  `UsePayPal` BOOL NOT NULL DEFAULT 0,
  `PayPalEmail` VARCHAR(100) NULL,
  `PayPalLog` BOOL NOT NULL DEFAULT 0,
  `CustomText1` VARCHAR(255) NULL,
  `CustomText2` VARCHAR(255) NULL,
  `CustomText3` VARCHAR(255) NULL,
  `CustomSelect1` VARCHAR(100) NULL,
  `CustomSelect2` VARCHAR(100) NULL,
  `CustomChoices1` LONGTEXT NULL,
  `CustomChoices2` LONGTEXT NULL,
  `CustomText_Req` VARCHAR(50) NULL,
  `CustomSelect_Req` VARCHAR(50) NULL,
  `AgreeTerms` LONGTEXT NULL,
  `Giftwrap` BOOL NOT NULL DEFAULT 0,
  `ShowBasket` BOOL NOT NULL DEFAULT 1,
  `SkipAddressForm` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `CardData` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Customer_ID` INT NOT NULL DEFAULT 0,
  `CardType` VARCHAR(50) NOT NULL,
  `NameonCard` VARCHAR(150) NOT NULL,
  `CardNumber` VARCHAR(50) NOT NULL,
  `Expires` VARCHAR(50) NOT NULL,
  `EncryptedCard` VARCHAR(100) NULL,
  `ID_Tag` VARCHAR(35) NULL,
  KEY `CardData_Customer_ID_Idx` (`Customer_ID` ASC),
  KEY `CardData_ID_Tag_Idx` (`ID_Tag` ASC),
  PRIMARY KEY (`ID` ASC),
  CONSTRAINT `Customers_CardData_FK` FOREIGN KEY (`Customer_ID`) REFERENCES `Customers` (`Customer_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Discount_Categories` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Discount_ID` INT NOT NULL,
  `Category_ID` INT NOT NULL,
  KEY `Discount_Categories_Category_ID_Idx` (`Category_ID` ASC),
  KEY `Discount_Categories_Discount_ID_Idx` (`Discount_ID` ASC),
  PRIMARY KEY (`ID` ASC),
  CONSTRAINT `Categories_Discount_Categories_FK` FOREIGN KEY (`Category_ID`) REFERENCES `Categories` (`Category_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Discounts_Discount_Categories_FK` FOREIGN KEY (`Discount_ID`) REFERENCES `Discounts` (`Discount_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Permission_Groups` (
  `Group_ID` INT NOT NULL  AUTO_INCREMENT,
  `Name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Group_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Permissions` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Group_ID` INT NOT NULL,
  `Name` VARCHAR(30) NOT NULL,
  `BitValue` INT NULL DEFAULT 0,
  KEY `Permissions_Group_ID_Idx` (`Group_ID` ASC),
  PRIMARY KEY (`ID` ASC),
  CONSTRAINT `Permission_Groups_Permissions_FK` FOREIGN KEY (`Group_ID`) REFERENCES `Permission_Groups` (`Group_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `PickLists` (
  `Picklist_ID` INT NOT NULL  AUTO_INCREMENT,
  `Feature_Type` LONGTEXT NULL,
  `Acc_Rep` LONGTEXT NULL,
  `Acc_Type1` LONGTEXT NULL,
  `Acc_Descr1` LONGTEXT NULL,
  `Product_Availability` LONGTEXT NULL,
  `Shipping_Status` LONGTEXT NULL,
  `PO_Status` LONGTEXT NULL,
  `GiftRegistry_Type` LONGTEXT NULL,
  `Review_Editorial` LONGTEXT NULL,
  PRIMARY KEY (`Picklist_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Prod_CustomFields` (
  `Custom_ID` INT NOT NULL,
  `Custom_Name` VARCHAR(50) NULL,
  `Custom_Display` BOOL NOT NULL DEFAULT 0,
  `Google_Use` BOOL NOT NULL DEFAULT 0,
  `Google_Code` VARCHAR(50) NULL,
  PRIMARY KEY (`Custom_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Prod_CustInfo` (
  `Product_ID` INT NOT NULL,
  `Custom_ID` INT NOT NULL,
  `CustomInfo` VARCHAR(150) NULL,
  PRIMARY KEY (`Product_ID` ASC,`Custom_ID` ASC),
  KEY `Prod_CustInfo_Product_ID_Idx` (`Product_ID` ASC),
  CONSTRAINT `Prod_CustomFields_Prod_CustInfo_FK` FOREIGN KEY (`Custom_ID`) REFERENCES `Prod_CustomFields` (`Custom_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Products_Prod_CustInfo_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `ProdAddons` (
  `Addon_ID` INT NOT NULL  AUTO_INCREMENT,
  `Product_ID` INT NOT NULL,
  `Standard_ID` INT NOT NULL,
  `Prompt` VARCHAR(100) NULL,
  `AddonDesc` VARCHAR(100) NULL,
  `AddonType` VARCHAR(10) NULL,
  `Display` BOOL NOT NULL DEFAULT 1,
  `Priority` INT NOT NULL DEFAULT 9999,
  `Price` DOUBLE NULL DEFAULT 0,
  `Weight` DOUBLE NULL DEFAULT 0,
  `ProdMult` BOOL NOT NULL DEFAULT 0,
  `Required` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`Addon_ID` ASC),
  KEY `ProdAddons_Product_ID_Idx` (`Product_ID` ASC),
  KEY `ProdAddons_Standard_ID_Idx` (`Standard_ID` ASC),
  CONSTRAINT `Products_ProdAddons_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `ProdDisc` (
  `Product_ID` INT NOT NULL,
  `ProdDisc_ID` INT NOT NULL,
  `Wholesale` BOOL NOT NULL DEFAULT 0,
  `QuantFrom` INT NOT NULL DEFAULT 0,
  `QuantTo` INT NOT NULL DEFAULT 0,
  `DiscountPer` DOUBLE NOT NULL DEFAULT 0,
  PRIMARY KEY (`Product_ID` ASC,`ProdDisc_ID` ASC),
  KEY `ProdDisc_Product_ID_Idx` (`Product_ID` ASC),
  CONSTRAINT `Products_ProdDisc_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Promotions` (
  `Promotion_ID` INT NOT NULL  AUTO_INCREMENT,
  `Type1` INT NOT NULL DEFAULT 1,
  `Type2` INT NOT NULL DEFAULT 1,
  `Type3` INT NOT NULL DEFAULT 0,
  `Type4` INT NOT NULL DEFAULT 0,
  `Coup_Code` VARCHAR(50) NULL,
  `OneTime` BOOL NOT NULL DEFAULT 0,
  `Name` VARCHAR(255) NOT NULL,
  `Display` VARCHAR(255) NULL,
  `Amount` DOUBLE NOT NULL DEFAULT 0,
  `QualifyNum` DOUBLE NOT NULL DEFAULT 0,
  `DiscountNum` DOUBLE NOT NULL DEFAULT 0,
  `Multiply` BOOL NOT NULL DEFAULT 0,
  `StartDate` DATETIME NULL,
  `EndDate` DATETIME NULL,
  `Disc_Product` INT NOT NULL DEFAULT 0,
  `Add_DiscProd` BOOL NOT NULL DEFAULT 0,
  `AccessKey` INT NULL DEFAULT 0,
  KEY `Promotions_AccessKey_Idx` (`AccessKey` ASC),
  KEY `Promotions_Coup_Code_Idx` (`Coup_Code` ASC),
  PRIMARY KEY (`Promotion_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Product_Options` (
  `Option_ID` INT NOT NULL  AUTO_INCREMENT,
  `Product_ID` INT NOT NULL,
  `Std_ID` INT NOT NULL DEFAULT 0,
  `Prompt` VARCHAR(50) NULL,
  `OptDesc` VARCHAR(50) NULL,
  `ShowPrice` VARCHAR(10) NULL,
  `Display` BOOL NOT NULL DEFAULT 0,
  `Priority` INT NULL DEFAULT 0,
  `TrackInv` BOOL NOT NULL DEFAULT 0,
  `Required` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`Option_ID` ASC),
  KEY `Product_Options_Product_ID_Idx` (`Product_ID` ASC),
  KEY `Product_Options_Std_ID_Idx` (`Std_ID` ASC),
  CONSTRAINT `Products_Product_Options_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Product_Images` (
  `Product_Image_ID` INT NOT NULL,
  `Product_ID` INT NOT NULL,
  `Image_File` VARCHAR(150) NOT NULL,
  `Gallery` VARCHAR(50) NULL,
  `File_Size` INT NULL DEFAULT 0,
  `Caption` VARCHAR(100) NULL,
  `Priority` INT NULL DEFAULT 0,
  PRIMARY KEY (`Product_Image_ID` ASC),
  KEY `Product_Images_Product_ID_Idx` (`Product_ID` ASC),
  CONSTRAINT `Products_Product_Images_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Product_Item` (
  `Product_Item_ID` INT NOT NULL  AUTO_INCREMENT,
  `Product_ID` INT NOT NULL,
  `Item_ID` INT NOT NULL,
  KEY `Product_Item_Item_ID_Idx` (`Item_ID` ASC),
  PRIMARY KEY (`Product_Item_ID` ASC),
  KEY `Product_Item_Product_ID_Idx` (`Product_ID` ASC),
  CONSTRAINT `Products_Product_Item_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Products_Product_Item_FK_2` FOREIGN KEY (`Item_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `ProdOpt_Choices` (
  `Option_ID` INT NOT NULL DEFAULT 0,
  `Choice_ID` INT NOT NULL DEFAULT 0,
  `ChoiceName` VARCHAR(50) NULL,
  `Price` DOUBLE NOT NULL DEFAULT 0,
  `Weight` DOUBLE NOT NULL DEFAULT 0,
  `SKU` VARCHAR(50) NULL,
  `NumInStock` INT NULL DEFAULT 0,
  `Display` BOOL NOT NULL DEFAULT 0,
  `SortOrder` INT NULL DEFAULT 0,
  KEY `ProdOpt_Choices_Option_ID_Idx` (`Option_ID` ASC),
  PRIMARY KEY (`Option_ID` ASC,`Choice_ID` ASC),
  CONSTRAINT `Product_Options_ProdOpt_Choices_FK` FOREIGN KEY (`Option_ID`) REFERENCES `Product_Options` (`Option_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `ProductReviews` (
  `Review_ID` INT NOT NULL AUTO_INCREMENT,
  `Product_ID` INT NOT NULL,
  `User_ID` INT NULL DEFAULT 0,
  `Anonymous` BOOL NOT NULL DEFAULT 0,
  `Anon_Name` VARCHAR(50) NULL,
  `Anon_Loc` VARCHAR(50) NULL,
  `Anon_Email` VARCHAR(75) NULL,
  `Editorial` VARCHAR(50) NULL,
  `Title` VARCHAR(75) NOT NULL,
  `Comment` LONGTEXT NOT NULL,
  `Rating` SMALLINT NOT NULL DEFAULT 0,
  `Recommend` BOOL NOT NULL DEFAULT 0,
  `Posted` DATETIME NOT NULL,
  `Updated` DATETIME NULL,
  `Approved` BOOL NOT NULL DEFAULT 0,
  `NeedsCheck` BOOL NOT NULL DEFAULT 0,
  `Helpful_Total` INT NOT NULL DEFAULT 0,
  `Helpful_Yes` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Review_ID` ASC),
  KEY `ProductReviews_Posted_Idx` (`Posted` ASC),
  KEY `ProductReviews_Product_ID_Idx` (`Product_ID` ASC),
  KEY `ProductReviews_Rating_Idx` (`Rating` ASC),
  KEY `ProductReviews_User_ID_Idx` (`User_ID` ASC),
  CONSTRAINT `Products_ProductReviews_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `ProductReviewsHelpful` (
  `Helpful_ID` varchar (35) NOT NULL , 
  `Product_ID` INT NOT NULL,
  `Review_ID` INT NOT NULL,
  `Helpful` BOOL NOT NULL DEFAULT 0,
  `User_ID` INT NULL DEFAULT 0,
  `Date_Stamp` DATETIME NULL,
  `IP` VARCHAR(30) NULL,
  KEY `ProductReviewsHelpful_IP_Idx` (`IP` ASC),
  PRIMARY KEY (`Helpful_ID` ASC),
  KEY `ProductReviewsHelpful_Product_ID_Idx` (`Product_ID` ASC),
  KEY `ProductReviewsHelpful_Review_ID_Idx` (`Review_ID` ASC),
  KEY `ProductReviewsHelpful_User_ID_Idx` (`User_ID` ASC),
  CONSTRAINT `Products_ProductReviewsHelpful_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Promotion_Qual_Products` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Promotion_ID` INT NOT NULL,
  `Product_ID` INT NOT NULL,
  PRIMARY KEY (`ID` ASC),
  KEY `Promotion_Qual_Products_Product_ID_Idx` (`Product_ID` ASC),
  KEY `Promotion_Qual_Products_Promotion_ID_Idx` (`Promotion_ID` ASC),
  CONSTRAINT `Products_Promotion_Qual_Products_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Promotions_Promotion_Qual_Products_FK` FOREIGN KEY (`Promotion_ID`) REFERENCES `Promotions` (`Promotion_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `WishList` (
  `User_ID` INT NOT NULL,
  `ListNum` INT NOT NULL DEFAULT 1,
  `ItemNum` INT NOT NULL DEFAULT 0,
  `ListName` VARCHAR(50) NULL,
  `Product_ID` INT NOT NULL DEFAULT 0,
  `DateAdded` DATETIME NULL,
  `NumDesired` INT NULL DEFAULT 0,
  `Comments` VARCHAR(255) NULL,
  PRIMARY KEY (`User_ID` ASC,`ListNum` ASC,`ItemNum` ASC),
  KEY `WishList_Product_ID_Idx` (`Product_ID` ASC),
  KEY `WishList_User_ID_Idx` (`User_ID` ASC),
  CONSTRAINT `Products_WishList_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Users_WishList_FK` FOREIGN KEY (`User_ID`) REFERENCES `Users` (`User_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Discount_Groups` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Discount_ID` INT NOT NULL,
  `Group_ID` INT NOT NULL,
  KEY `Discount_Groups_Discount_ID_Idx` (`Discount_ID` ASC),
  KEY `Discount_Groups_Group_ID_Idx` (`Group_ID` ASC),
  PRIMARY KEY (`ID` ASC),
  CONSTRAINT `DiscountsDiscount_Groups` FOREIGN KEY (`Discount_ID`) REFERENCES `Discounts` (`Discount_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Groups_Discount_Groups_FK` FOREIGN KEY (`Group_ID`) REFERENCES `Groups` (`Group_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Discount_Products` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Discount_ID` INT NOT NULL,
  `Product_ID` INT NOT NULL,
  KEY `Discount_Products_Discount_ID_Idx` (`Discount_ID` ASC),
  PRIMARY KEY (`ID` ASC),
  KEY `Discount_Products_Product_ID_Idx` (`Product_ID` ASC),
  CONSTRAINT `Discounts_Discount_Products_FK` FOREIGN KEY (`Discount_ID`) REFERENCES `Discounts` (`Discount_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Products_Discount_Products_FK` FOREIGN KEY (`Product_ID`) REFERENCES `Products` (`Product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Promotion_Groups` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Promotion_ID` INT NOT NULL,
  `Group_ID` INT NOT NULL,
  KEY `Promotion_Groups_Group_ID_Idx` (`Group_ID` ASC),
  PRIMARY KEY (`ID` ASC),
  KEY `Promotion_Groups_Promotion_ID_Idx` (`Promotion_ID` ASC),
  CONSTRAINT `Groups_Promotion_Groups_FK` FOREIGN KEY (`Group_ID`) REFERENCES `Groups` (`Group_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Promotions_Promotion_Groups_FK` FOREIGN KEY (`Promotion_ID`) REFERENCES `Promotions` (`Promotion_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Settings` (
  `SettingID` INT NOT NULL  AUTO_INCREMENT,
  `SiteName` VARCHAR(50) NULL,
  `SiteLogo` VARCHAR(100) NULL,
  `Merchant` LONGTEXT NULL,
  `HomeCountry` VARCHAR(100) NULL,
  `MerchantEmail` VARCHAR(150) NULL,
  `Webmaster` VARCHAR(150) NULL,
  `DefaultImages` VARCHAR(100) NULL,
  `FilePath` VARCHAR(150) NULL,
  `MimeTypes` VARCHAR(255) NULL,
  `MoneyUnit` VARCHAR(50) NULL,
  `WeightUnit` VARCHAR(50) NULL,
  `SizeUnit` VARCHAR(50) NULL,
  `InvLevel` VARCHAR(50) NULL,
  `ShowInStock` BOOL NOT NULL DEFAULT 0,
  `OutofStock` BOOL NOT NULL DEFAULT 1,
  `ShowRetail` BOOL NOT NULL DEFAULT 1,
  `ItemSort` VARCHAR(50) NULL,
  `Wishlists` BOOL NOT NULL DEFAULT 0,
  `OrderButtonText` VARCHAR(50) NULL,
  `OrderButtonImage` VARCHAR(100) NULL,
  `AllowWholesale` BOOL NOT NULL DEFAULT 0,
  `UseVerity` BOOL NOT NULL DEFAULT 0,
  `CollectionName` VARCHAR(50) NULL,
  `CColumns` INT NOT NULL DEFAULT 0,
  `PColumns` INT NOT NULL DEFAULT 0,
  `MaxProds` INT NOT NULL DEFAULT 9999,
  `ProdRoot` INT NULL DEFAULT 0,
  `CachedProds` BOOL NOT NULL DEFAULT 0,
  `FeatureRoot` INT NULL DEFAULT 0,
  `MaxFeatures` SMALLINT NULL DEFAULT 0,
  `Locale` VARCHAR(30) NULL,
  `CurrExchange` VARCHAR(30) NULL,
  `CurrExLabel` VARCHAR(30) NULL,
  `Color_ID` SMALLINT NULL DEFAULT 0,
  `Metadescription` VARCHAR(255) NULL,
  `Keywords` VARCHAR(255) NULL,
  `Email_Server` VARCHAR(255) NULL,
  `Email_Port` INT NULL DEFAULT 0,
  `Admin_New_Window` BOOL NOT NULL DEFAULT 0,
  `UseSES` BOOL NOT NULL DEFAULT 0,
  `Default_Fuseaction` VARCHAR(50) NULL,
  `Editor` VARCHAR(20) NULL,
  `ProductReviews` BOOL NOT NULL DEFAULT 0,
  `ProductReview_Approve` BOOL NOT NULL DEFAULT 0,
  `ProductReview_Flag` BOOL NOT NULL DEFAULT 0,
  `ProductReview_Add` INT NOT NULL DEFAULT 1,
  `ProductReview_Rate` BOOL NOT NULL DEFAULT 1,
  `ProductReviews_Page` INT NOT NULL DEFAULT 4,
  `FeatureReviews` BOOL NOT NULL DEFAULT 0,
  `FeatureReview_Add` INT NOT NULL DEFAULT 1,
  `FeatureReview_Flag` BOOL NOT NULL DEFAULT 0,
  `FeatureReview_Approve` BOOL NOT NULL DEFAULT 1,
  `GiftRegistry` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`SettingID` ASC)
) TYPE=InnoDB;

CREATE TABLE `Shipping` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `MinOrder` DOUBLE NOT NULL DEFAULT 0,
  `MaxOrder` DOUBLE NOT NULL DEFAULT 0,
  `Amount` DOUBLE NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `ShipSettings` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `ShipType` VARCHAR(50) NULL,
  `ShipBase` DOUBLE NOT NULL DEFAULT 0,
  `MerchantZip` VARCHAR(10) NULL,
  `InStorePickup` BOOL NOT NULL DEFAULT 0,
  `AllowNoShip` BOOL NOT NULL DEFAULT 0,
  `NoShipMess` LONGTEXT NULL,
  `NoShipType` VARCHAR(50) NULL,
  `ShipHand` DOUBLE NOT NULL DEFAULT 0,
  `Freeship_Min` INT NULL DEFAULT 0,
  `Freeship_ShipIDs` VARCHAR(50) NULL,
  `ShowEstimator` BOOL NOT NULL DEFAULT 0,
  `ShowFreight` BOOL NOT NULL DEFAULT 0,
  `UseDropShippers` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `StateTax` (
  `Tax_ID` INT NOT NULL  AUTO_INCREMENT,
  `Code_ID` INT NOT NULL DEFAULT 0,
  `State` VARCHAR(2) NOT NULL,
  `TaxRate` DOUBLE NOT NULL DEFAULT 0,
  `TaxShip` BOOL NOT NULL DEFAULT 0,
  KEY `StateTax_Code_ID_Idx` (`Code_ID` ASC),
  PRIMARY KEY (`Tax_ID` ASC),
  KEY `StateTax_State_Idx` (`State` ASC),
  CONSTRAINT `States_StateTax_FK` FOREIGN KEY (`State`) REFERENCES `States` (`Abb`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `TaxCodes_StateTax_FK` FOREIGN KEY (`Code_ID`) REFERENCES `TaxCodes` (`Code_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `Counties` (
  `County_ID` INT NOT NULL  AUTO_INCREMENT,
  `Code_ID` INT NOT NULL DEFAULT 0,
  `State` VARCHAR(2) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `TaxRate` DOUBLE NOT NULL DEFAULT 0,
  `TaxShip` BOOL NOT NULL DEFAULT 0,
  KEY `Counties_Code_ID_Idx` (`Code_ID` ASC),
  PRIMARY KEY (`County_ID` ASC),
  KEY `Counties_State_Idx` (`State` ASC),
  CONSTRAINT `States_Counties_FK` FOREIGN KEY (`State`) REFERENCES `States` (`Abb`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `TaxCodes_Counties_FK` FOREIGN KEY (`Code_ID`) REFERENCES `TaxCodes` (`Code_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `StdAddons` (
  `Std_ID` INT NOT NULL  AUTO_INCREMENT,
  `Std_Name` VARCHAR(50) NOT NULL,
  `Std_Prompt` VARCHAR(100) NOT NULL,
  `Std_Desc` VARCHAR(100) NULL,
  `Std_Type` VARCHAR(10) NOT NULL,
  `Std_Display` BOOL NOT NULL DEFAULT 0,
  `Std_Price` DOUBLE NOT NULL DEFAULT 0,
  `Std_Weight` DOUBLE NOT NULL DEFAULT 0,
  `Std_ProdMult` BOOL NOT NULL DEFAULT 0,
  `Std_Required` BOOL NULL DEFAULT 0,
  `User_ID` INT NULL DEFAULT 0,
  PRIMARY KEY (`Std_ID` ASC),
  KEY `StdAddons_User_ID_Idx` (`User_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `StdOptions` (
  `Std_ID` INT NOT NULL  AUTO_INCREMENT,
  `Std_Name` VARCHAR(50) NOT NULL,
  `Std_Prompt` VARCHAR(50) NOT NULL,
  `Std_Desc` VARCHAR(50) NULL,
  `Std_ShowPrice` VARCHAR(10) NOT NULL,
  `Std_Display` BOOL NOT NULL DEFAULT 0,
  `Std_Required` BOOL NOT NULL DEFAULT 0,
  `User_ID` INT NULL DEFAULT 0,
  PRIMARY KEY (`Std_ID` ASC),
  KEY `StdOptions_User_ID_Idx` (`User_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `StdOpt_Choices` (
  `Std_ID` INT NOT NULL,
  `Choice_ID` INT NOT NULL,
  `ChoiceName` VARCHAR(50) NULL,
  `Price` DOUBLE NOT NULL DEFAULT 0,
  `Weight` DOUBLE NOT NULL DEFAULT 0,
  `Display` BOOL NOT NULL DEFAULT 0,
  `SortOrder` INT NULL DEFAULT 0,
  PRIMARY KEY (`Std_ID` ASC,`Choice_ID` ASC),
  KEY `StdOpt_Choices_Std_ID_Idx` (`Std_ID` ASC),
  CONSTRAINT `StdOptions_StdOpt_Choices_FK` FOREIGN KEY (`Std_ID`) REFERENCES `StdOptions` (`Std_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `CountryTax` (
  `Tax_ID` INT NOT NULL  AUTO_INCREMENT,
  `Code_ID` INT NOT NULL DEFAULT 0,
  `Country_ID` INT NOT NULL DEFAULT 0,
  `TaxRate` DOUBLE NOT NULL DEFAULT 0,
  `TaxShip` BOOL NOT NULL DEFAULT 0,
  KEY `CountryTax_Code_ID_Idx` (`Code_ID` ASC),
  KEY `CountryTax_Country_ID_Idx` (`Country_ID` ASC),
  PRIMARY KEY (`Tax_ID` ASC),
  CONSTRAINT `Countries_CountryTax_FK` FOREIGN KEY (`Country_ID`) REFERENCES `Countries` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `TaxCodes_CountryTax_FK` FOREIGN KEY (`Code_ID`) REFERENCES `TaxCodes` (`Code_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `TempBasket` (
  `Basket_ID` VARCHAR(60) NOT NULL,
  `BasketNum` VARCHAR(30) NOT NULL,
  `Product_ID` INT NOT NULL,
  `Options` LONGTEXT NULL,
  `Addons` LONGTEXT NULL,
  `AddonMultP` DOUBLE NULL DEFAULT 0,
  `AddonNonMultP` DOUBLE NULL DEFAULT 0,
  `AddonMultW` DOUBLE NULL DEFAULT 0,
  `AddonNonMultW` DOUBLE NULL DEFAULT 0,
  `OptPrice` DOUBLE NOT NULL DEFAULT 0,
  `OptWeight` DOUBLE NOT NULL DEFAULT 0,
  `SKU` VARCHAR(100) NULL,
  `Price` DOUBLE NULL DEFAULT 0,
  `Weight` DOUBLE NULL DEFAULT 0,
  `Quantity` INT NULL DEFAULT 0,
  `OptQuant` INT NOT NULL DEFAULT 0,
  `OptChoice` INT NULL DEFAULT 0,
  `OptionID_List` VARCHAR(255) NULL,
  `ChoiceID_List` VARCHAR(255) NULL,
  `GiftItem_ID` INT NULL DEFAULT 0,
  `Discount` INT NULL DEFAULT 0,
  `DiscAmount` DOUBLE NULL DEFAULT 0,
  `Disc_Code` VARCHAR(50) NULL,
  `QuantDisc` DOUBLE NULL DEFAULT 0,
  `Promotion` INT NULL DEFAULT 0,
  `PromoAmount` DOUBLE NULL DEFAULT 0,
  `PromoQuant` INT NULL DEFAULT 0,
  `Promo_Code` VARCHAR(50) NULL,
  `DateAdded` DATETIME NULL,
  KEY `TempBasket_BasketNum_Idx` (`BasketNum` ASC),
  PRIMARY KEY (`Basket_ID` ASC),
  KEY `TempBasket_Product_ID_Idx` (`Product_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `TempCustomer` (
  `TempCust_ID` VARCHAR(30) NOT NULL,
  `FirstName` VARCHAR(50) NULL,
  `LastName` VARCHAR(100) NULL,
  `Company` VARCHAR(150) NULL,
  `Address1` VARCHAR(150) NULL,
  `Address2` VARCHAR(150) NULL,
  `City` VARCHAR(150) NULL,
  `County` VARCHAR(50) NULL,
  `State` VARCHAR(50) NULL,
  `State2` VARCHAR(50) NULL,
  `Zip` VARCHAR(50) NULL,
  `Country` VARCHAR(50) NULL,
  `Phone` VARCHAR(50) NULL,
  `Email` VARCHAR(150) NULL,
  `ShipToYes` BOOL NULL DEFAULT 0,
  `DateAdded` DATETIME NULL,
  `Phone2` VARCHAR(50) NULL,
  `Fax` VARCHAR(50) NULL,
  `Residence` BOOL NULL DEFAULT 0,
  PRIMARY KEY (`TempCust_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `TempOrder` (
  `BasketNum` VARCHAR(30) NOT NULL,
  `OrderTotal` DOUBLE NULL DEFAULT 0,
  `Tax` DOUBLE NULL DEFAULT 0,
  `ShipType` VARCHAR(75) NULL,
  `Shipping` DOUBLE NULL DEFAULT 0,
  `Freight` INT NULL DEFAULT 0,
  `OrderDisc` DOUBLE NULL DEFAULT 0,
  `Credits` DOUBLE NULL DEFAULT 0,
  `AddonTotal` DOUBLE NULL DEFAULT 0,
  `DateAdded` DATETIME NULL,
  `Affiliate` INT NULL DEFAULT 0,
  `Referrer` VARCHAR(255) NULL,
  `GiftCard` VARCHAR(255) NULL,
  `Delivery` VARCHAR(50) NULL,
  `Comments` VARCHAR(255) NULL,
  `CustomText1` VARCHAR(255) NULL,
  `CustomText2` VARCHAR(255) NULL,
  `CustomText3` VARCHAR(255) NULL,
  `CustomSelect1` VARCHAR(100) NULL,
  `CustomSelect2` VARCHAR(100) NULL,
  PRIMARY KEY (`BasketNum` ASC)
) TYPE=InnoDB;

CREATE TABLE `TempShipTo` (
  `TempShip_ID` VARCHAR(30) NOT NULL,
  `FirstName` VARCHAR(50) NULL,
  `LastName` VARCHAR(150) NULL,
  `Company` VARCHAR(150) NULL,
  `Address1` VARCHAR(150) NULL,
  `Address2` VARCHAR(150) NULL,
  `City` VARCHAR(150) NULL,
  `County` VARCHAR(50) NULL,
  `State` VARCHAR(50) NULL,
  `State2` VARCHAR(50) NULL,
  `Zip` VARCHAR(50) NULL,
  `Country` VARCHAR(50) NULL,
  `DateAdded` DATETIME NULL,
  `Phone` VARCHAR(50) NULL,
  `Email` VARCHAR(150) NULL,
  `Residence` BOOL NULL DEFAULT 0,
  PRIMARY KEY (`TempShip_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `UPS_Origins` (
  `UPS_Code` VARCHAR(10) NOT NULL,
  `Description` VARCHAR(20) NULL,
  `OrderBy` INT NULL DEFAULT 0,
  PRIMARY KEY (`UPS_Code` ASC)
) TYPE=InnoDB;

CREATE TABLE `UPS_Packaging` (
  `UPS_Code` VARCHAR(10) NOT NULL,
  `Description` VARCHAR(50) NULL,
  PRIMARY KEY (`UPS_Code` ASC)
) TYPE=InnoDB;

CREATE TABLE `UPS_Pickup` (
  `UPS_Code` VARCHAR(10) NOT NULL,
  `Description` VARCHAR(50) NULL,
  PRIMARY KEY (`UPS_Code` ASC)
) TYPE=InnoDB;

CREATE TABLE `UPS_Settings` (
  `UPS_ID` INT NOT NULL  AUTO_INCREMENT,
  `ResRates` BOOL NOT NULL DEFAULT 0,
  `Username` VARCHAR(150) NULL,
  `Password` VARCHAR(100) NULL,
  `Accesskey` VARCHAR(100) NULL,
  `AccountNo` VARCHAR(20) NULL,
  `Origin` VARCHAR(10) NULL,
  `MaxWeight` INT NOT NULL DEFAULT 0,
  `UnitsofMeasure` VARCHAR(20) NULL,
  `CustomerClass` VARCHAR(20) NULL,
  `Pickup` VARCHAR(20) NULL,
  `Packaging` VARCHAR(20) NULL,
  `OrigZip` VARCHAR(20) NULL,
  `OrigCity` VARCHAR(75) NULL,
  `OrigCountry` VARCHAR(10) NULL,
  `Debug` BOOL NOT NULL DEFAULT 0,
  `UseAV` BOOL NOT NULL DEFAULT 0,
  `Logging` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`UPS_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `UPSMethods` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Name` VARCHAR(75) NULL,
  `USCode` VARCHAR(5) NULL,
  `EUCode` VARCHAR(5) NULL,
  `CACode` VARCHAR(5) NULL,
  `PRCode` VARCHAR(5) NULL,
  `MXCode` VARCHAR(5) NULL,
  `OOCode` VARCHAR(5) NULL,
  `Used` BOOL NOT NULL DEFAULT 0,
  `Priority` INT NULL DEFAULT 0,
  PRIMARY KEY (`ID` ASC),
  KEY `UPSMethods_Used_Idx` (`Used` ASC)
) TYPE=InnoDB;

CREATE TABLE `Feature_Item` (
  `Feature_Item_ID` INT NOT NULL  AUTO_INCREMENT,
  `Feature_ID` INT NOT NULL,
  `Item_ID` INT NOT NULL,
  KEY `Feature_Item_Feature_ID_Idx` (`Feature_ID` ASC),
  KEY `Feature_Item_Item_ID_Idx` (`Item_ID` ASC),
  PRIMARY KEY (`Feature_Item_ID` ASC),
  CONSTRAINT `Features_Feature_Item_FK` FOREIGN KEY (`Feature_ID`) REFERENCES `Features` (`Feature_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Features_Feature_Item_FK_2` FOREIGN KEY (`Item_ID`) REFERENCES `Features` (`Feature_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;

CREATE TABLE `UserSettings` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `UseRememberMe` BOOL NOT NULL DEFAULT 0,
  `EmailAsName` BOOL NOT NULL DEFAULT 0,
  `UseStateList` BOOL NOT NULL DEFAULT 1,
  `UseStateBox` BOOL NOT NULL DEFAULT 1,
  `RequireCounty` BOOL NOT NULL DEFAULT 0,
  `UseCountryList` BOOL NOT NULL DEFAULT 1,
  `UseResidential` BOOL NOT NULL DEFAULT 0,
  `UseGroupCode` BOOL NOT NULL DEFAULT 0,
  `UseBirthdate` BOOL NOT NULL DEFAULT 0,
  `UseTerms` BOOL NOT NULL DEFAULT 0,
  `TermsText` LONGTEXT NULL,
  `UseCCard` BOOL NOT NULL DEFAULT 0,
  `UseEmailConf` BOOL NOT NULL DEFAULT 0,
  `UseEmailNotif` BOOL NOT NULL DEFAULT 0,
  `MemberNotify` BOOL NOT NULL DEFAULT 0,
  `UseShipTo` BOOL NOT NULL DEFAULT 1,
  `UseAccounts` BOOL NOT NULL DEFAULT 0,
  `ShowAccount` BOOL NOT NULL DEFAULT 1,
  `ShowDirectory` BOOL NOT NULL DEFAULT 1,
  `ShowSubscribe` BOOL NOT NULL DEFAULT 1,
  `StrictLogins` BOOL NOT NULL DEFAULT 0,
  `MaxDailyLogins` INT NOT NULL DEFAULT 0,
  `MaxFailures` INT NOT NULL DEFAULT 5,
  `AllowAffs` BOOL NOT NULL DEFAULT 0,
  `AffPercent` DOUBLE NULL DEFAULT 0,
  `AllowWholesale` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `USPS_Settings` (
  `USPS_ID` INT NOT NULL  AUTO_INCREMENT,
  `UserID` VARCHAR(30) NOT NULL,
  `Server` VARCHAR(75) NOT NULL,
  `MerchantZip` VARCHAR(20) NULL,
  `MaxWeight` INT NOT NULL DEFAULT 50,
  `Logging` BOOL NOT NULL DEFAULT 0,
  `Debug` BOOL NOT NULL DEFAULT 0,
  `UseAV` BOOL NOT NULL DEFAULT 0,
  PRIMARY KEY (`USPS_ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `USPSCountries` (
  `ID` INT NOT NULL,
  `Abbrev` VARCHAR(2) NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  KEY `USPSCountries_Abbrev_Idx` (`Abbrev` ASC),
  PRIMARY KEY (`ID` ASC)
) TYPE=InnoDB;

CREATE TABLE `USPSMethods` (
  `ID` INT NOT NULL  AUTO_INCREMENT,
  `Name` VARCHAR(75) NULL,
  `Used` BOOL NOT NULL DEFAULT 0,
  `Code` VARCHAR(225) NULL,
  `Type` VARCHAR(20) NULL,
  `Priority` INT NULL DEFAULT 0,
  PRIMARY KEY (`ID` ASC),
  KEY `USPSMethods_Used_Idx` (`Used` ASC)
) TYPE=InnoDB;

CREATE TABLE `Pages` (
  `Page_ID` INT NOT NULL,
  `Page_URL` VARCHAR(75) NULL,
  `CatCore_ID` INT NULL DEFAULT 0,
  `PassParam` VARCHAR(100) NULL,
  `Display` BOOL NOT NULL DEFAULT 0,
  `PageAction` VARCHAR(30) NULL,
  `Page_Name` VARCHAR(100) NOT NULL,
  `Page_Title` VARCHAR(75) NULL,
  `Sm_Image` VARCHAR(100) NULL,
  `Lg_Image` VARCHAR(100) NULL,
  `Sm_Title` VARCHAR(100) NULL,
  `Lg_Title` VARCHAR(100) NULL,
  `Color_ID` INT NULL,
  `PageText` LONGTEXT NULL,
  `System` BOOL NOT NULL DEFAULT 0,
  `Href_Attributes` VARCHAR(50) NULL,
  `AccessKey` INT NULL DEFAULT 0,
  `Priority` INT NULL DEFAULT 9999,
  `Parent_ID` INT NULL DEFAULT 0,
  `Title_Priority` INT NULL DEFAULT 0,
  `Metadescription` VARCHAR(255) NULL,
  `Keywords` VARCHAR(255) NULL,
  `TitleTag` VARCHAR(255) NULL,
  KEY `Pages_AccessKey_Idx` (`AccessKey` ASC),
  KEY `Pages_CatCore_ID_Idx` (`CatCore_ID` ASC),
  KEY `Pages_Color_ID_Idx` (`Color_ID` ASC),
  PRIMARY KEY (`Page_ID` ASC),
  CONSTRAINT `CatCore_Pages_FK` FOREIGN KEY (`CatCore_ID`) REFERENCES `CatCore` (`CatCore_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Colors_Pages_FK` FOREIGN KEY (`Color_ID`) REFERENCES `Colors` (`Color_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) TYPE=InnoDB;
