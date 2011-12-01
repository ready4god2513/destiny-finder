
UPDATE `CatCore` SET 
	`PassParams` = 'noline=1,notitle=1'
	WHERE `CatCore_ID` = 0 ;
UPDATE `CatCore` SET 
	`PassParams` = 'noline=1,notitle=1'
	WHERE `CatCore_ID` = 1 ;
UPDATE `CatCore` SET 
	`PassParams` = 'topcats, searchform,new,onsale,hot,notsold,ProdofDay,listing,notitle,columns=x'
	WHERE `CatCore_ID` = 2 ;
UPDATE `CatCore` SET 
	`PassParams` = 'new=1,onsale=1,notsold=1,notitle=1,columns=x'
	WHERE `CatCore_ID` = 3 ;
UPDATE `CatCore` SET
	`PassParams` = 'noline=1,EmailTo=email@address.com, BoxTitle=Title,Subject=Email Subject Line'
	WHERE `CatCore_ID` = 4 ;
UPDATE `CatCore` SET 
	`PassParams` = 'noline=1,notitle=1'
	WHERE `CatCore_ID` = 5 ;
UPDATE `CatCore` SET 
	`PassParams` = 'noline=1,notitle=1'
	WHERE `CatCore_ID` = 6 ;
UPDATE `CatCore` SET 
	`PassParams` = 'noline=1,notitle=1'
	WHERE `CatCore_ID` = 7 ;
UPDATE `CatCore` SET 
	`PassParams` = 'listing=vertical|short, displaycount=x, productcols=x,searchheader=1,searchheader=form,alpha=1,notitle=1'
	WHERE `CatCore_ID` = 8 ;
UPDATE `CatCore` SET 
	`PassParams` = 'noline=1,notitle=1,searchform=1, displaycount=x'
	WHERE `CatCore_ID` = 9 ;
UPDATE `CatCore` SET 
	`PassParams` = 'noline=1,notitle=1'
	WHERE `CatCore_ID` = 11 ;
UPDATE `CatCore` SET 
	`PassParams` = 'noline=1,notitle=1,listing=short|vertical'
	WHERE `CatCore_ID` = 12 ;
UPDATE `CatCore` SET 
	`PassParams` = 'noline=1,notitle=1,displaycount,accountcols,sort,order,type1'
	WHERE `CatCore_ID` = 13 ;
UPDATE `CatCore` SET 
	`PassParams` = 'noline=1,alpha=1,notitle=1'
	WHERE `CatCore_ID` = 14 ;
	
UPDATE `Countries` SET 
	`AllowUPS` = 1 ;

UPDATE `Countries` SET 
	`Name` = 'Virgin Islands (British)'
	WHERE `Abbrev` = 'VG' ;
UPDATE `Countries` SET 
	`Name` = 'Russian Federation'
	WHERE `Abbrev` = 'RU' ;
UPDATE `Countries` SET 
	`Name` = 'Samoa'
	WHERE `Abbrev` = 'WS' ;
UPDATE `Countries` SET 
	`Name` = 'Korea (South)'
	WHERE `Abbrev` = 'KR' ;
UPDATE `Countries` SET 
	`Name` = 'Virgin Islands (U.S.)'
	WHERE `Abbrev` = 'VI' ;
UPDATE `Countries` SET 	
	`Name` = 'Great Britain (UK)'
	WHERE `Abbrev` = 'GB' ;
UPDATE `Countries` SET 
	`Name` = 'Afghanistan'
	WHERE `Abbrev` = 'AF' ;
UPDATE `Countries` SET 	
	`Name` = 'Angola'
	WHERE `Abbrev` = 'AO' ;
UPDATE `Countries` SET 	
	`Name` = 'Western Sahara'
	WHERE `Abbrev` = 'EH' ;
	

INSERT INTO `Countries`(`Abbrev`,`Name`,`Shipping`,`AddShipAmount`)
	VALUES 	('AM','Armenia',0,0) ,
	 		('BL','Bonaire',0,0) ,
			('BV','Bouvet Island',0,0) ,
			('IO','British Indian Ocean Terr.',0,0) ,
			('CD','Channel Islands',0,0) ,
			('CX','Christmas Island',0,0) ,
			('CC','Cocos (Keeling) Islands',0,0),
			('CB','Curacao',0,0),
			('TP','East Timor',0,0) ,
			('EN','England',0,0),
			('FK','Falkland Islands',0,0),
			('TF','French Southern Territories',0,0) ,
			('HM','Heard Island',0,0) ,
			('KO','Kosrae',0,0) ,
			('YT','Mayotte',0,0),
			('MM','Myanmar',0,0) ,
			('NR','Nauru',0,0),
			('NT','Neutral Zone',0,0),
			('NU','Niue',0,0) ,
			('NB','Northern Ireland',0,0) ,
			('PN','Pitcairn',0,0) ,
			('PO','Ponape',0,0),
			('PR','Puerto Rico',0,0),
			('RT','Rota',0,0) ,
			('SS','Saba',0,0) ,
			('SP','Saipan',0,0) ,
			('ST','Sao Tome and Principe',0,0) ,
			('SF','Scotland',0,0) ,
			('GS','South Georgia',0,0) ,
			('SW','St. Christopher',0,0) ,
			('EU','St. Eustatius',0,0) ,
			('SH','St. Helena',0,0) ,
			('MB','St. Maarten',0,0) ,
			('TB','St. Martin',0,0) ,
			('PM','St. Pierre and Miquelon',0,0) ,
			('SD','Sudan',0,0) ,
			('SJ','Svalbard and Jan Mayen Islands',0,0) ,
			('TI','Tinian',0,0) ,
			('TK','Tokelau',0,0) ,
			('TU','Truk',0,0) ,
			('UM','US Minor Outlying Islands',0,0) ,
			('SU','USSR (former)',0,0) ,
			('VA','Vatican City State',0,0) ,
			('YA','Yap',0,0) ;

UPDATE `CreditCards` SET 
	`CardName` = 'Mastercard'
	WHERE `CardName` = 'MasterCard' ;
	
UPDATE `CreditCards` SET 
	`CardName` = 'Visa'
	WHERE `CardName` = 'VISA' ;
	
UPDATE `CreditCards` SET 
	`CardName` = 'Amex'
	WHERE `CardName` = 'American Express' ;
	
INSERT INTO `CustomMethods`(`ID`, `Name`, `Amount`, `Used`, `Priority`, `Domestic`, `International`)
VALUES (1, 'Next Day Air', 10.0, 1, 3, 1, 0),
  (2, '2nd Day Air', 5.5, 1, 2, 1, 0),
  (3, 'Ground Shipping', 0.0, 1, 1, 1, 0),
  (4, 'Airmail', 20.0, 1, 4, 0, 1);  

INSERT INTO `CustomShipSettings`(`ShowShipTable`,`MultPerItem`,`CumulativeAmounts`,`MultMethods`,`Debug`)
	VALUES (1,1,1,0,0) ;
	
UPDATE `Customers` SET 
	`Residence` = 1 ;
	
UPDATE `Discounts` SET
`AccessKey` = 0,
`OneTime` = 0 ;
	
UPDATE `Features` SET
`Reviewable` = 1 ;

INSERT INTO `FedEx_Dropoff`(`FedEx_Code`, `Description`)
VALUES ('BUSINESSSERVICE CENTER', 'Business Service Center'),
  ('DROPBOX', 'Drop Box'),
  ('REGULARPICKUP', 'Regular Pickup'),
  ('REQUESTCOURIER', 'Request Courier'),
  ('STATION', 'Station');

INSERT INTO `FedEx_Packaging`(`FedEx_Code`, `Description`)
VALUES ('FEDEX10KGBOX', 'FedEx<sup>&reg;</sup> 10kb Box'),
  ('FEDEX25KGBOX', 'FedEx<sup>&reg;</sup> 25kg Box'),
  ('FEDEXBOX', 'FedEx<sup>&reg;</sup> Box'),
  ('FEDEXENVELOPE', 'FedEx<sup>&reg;</sup> Letter'),
  ('FEDEXPAK', 'FedEx<sup>&reg;</sup> Pak'),
  ('FEDEXTUBE', 'FedEx<sup>&reg;</sup> Tube'),
  ('YOURPACKAGING', 'Your Packaging');
	
INSERT INTO `FedEx_Settings`(`AccountNo`,`MeterNum`,`MaxWeight`,`UnitsofMeasure`,`Dropoff`,`Packaging`,`OrigZip`,`OrigState`,`OrigCountry`,`Debug`,`UseGround`,`UseExpress`,`Logging`)
	VALUES (NULL,NULL,150,'KGS/CM','REGULARPICKUP','YOURPACKAGING','00000','NY','US',0,1,1,0)
	;
	
INSERT INTO `FedExMethods`(`ID`, `Name`, `Used`, `Shipper`, `Code`, `Priority`)
VALUES (1, 'FedEx<sup>&reg;</sup> Ground', 1, 'FDXG', 'FEDEXGROUND', 1),
  (2, 'FedEx<sup>&reg;</sup> Home Delivery', 1, 'FDXG', 'GROUNDHOMEDELIVERY', 2),
  (3, 'FedEx Priority Overnight<sup>&reg;</sup>', 1, 'FDXE', 'PRIORITYOVERNIGHT', 4),
  (4, 'FedEx 2 Day<sup>&reg;</sup>', 1, 'FDXE', 'FEDEX2DAY', 3),
  (5, 'FedEx First Overnight<sup>&reg;</sup>', 1, 'FDXE', 'FIRSTOVERNIGHT', 5),
  (6, 'FedEx Express Saver<sup>&reg;</sup>', 1, 'FDXE', 'FEDEXEXPRESSSAVER', 6),
  (7, 'FedEx Standard Overnight<sup>&reg;</sup>', 1, 'FDXE', 'STANDARDOVERNIGHT', 7),
  (8, 'FedEx International Priority<sup>&reg;</sup>', 1, 'FDXE', 'INTERNATIONALPRIORITY', 8),
  (9, 'FedEx International Economy<sup>&reg;</sup>', 1, 'FDXE', 'INTERNATIONALECONOMY', 9);
	

UPDATE `Groups` SET `TaxExempt` = 0  ;
UPDATE `Groups` SET `ShipExempt` = 0  ;

UPDATE `Intershipper` SET 
	`UnitsofMeasure` = 'LBS/IN',
	`MaxWeight` = 150,
	`Logging` = 0,
	`Debug` = 0
	;
	
UPDATE `IntShipTypes` SET `Priority` = 99 ;

UPDATE `IntShipTypes` SET 
	`Name` = 'UPS Next Day Air'
	WHERE `Code` = 'UND' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS 2nd Day Air'
	WHERE `Code` = 'U2D' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS Canadian Expedited Service'
	WHERE `Code` = 'UCX' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS Canadian Express Service'
	WHERE `Code` = 'UCE' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS 3-Day Select'
	WHERE `Code` = 'U3S' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS Next Day Air Saver'
	WHERE `Code` = 'UNS' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS Next Day Air Early AM'
	WHERE `Code` = 'UNA' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS Ground'
	WHERE `Code` = 'UGN' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'U.S.P.S.Priority Mail'
	WHERE `Code` = 'PPM' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'U.S.P.S. Parcel Post Machine'
	WHERE `Code` = 'PGM' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'U.S.P.S.Express Mail'
	WHERE `Code` = 'PEA' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'U.S.P.S. Parcel Post Non-Machine'
	WHERE `Code` = 'PGN' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx Priority Overnight'
	WHERE `Code` = 'FPN' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx 2nd Day'
	WHERE `Code` = 'F2D' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx Express Saver'
	WHERE `Code` = 'FES' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx Ground'
	WHERE `Code` = 'FGN' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx Standard Overnight'
	WHERE `Code` = 'FSO' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'DHL Overnight'
	WHERE `Code` = 'DON' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS Canadian Express Plus Service'
	WHERE `Code` = 'UCP' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS Standard Canadian Service'
	WHERE `Code` = 'UCS' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx First Overnight'
	WHERE `Code` = 'FON' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx Canadian Ground'
	WHERE `Code` = 'FCG' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx Canadian International Economy'
	WHERE `Code` = 'FCE' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx Canadian International Priority'
	WHERE `Code` = 'FCP' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx Canadian International First'
	WHERE `Code` = 'FCF' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS 2nd Day Air AM'
	WHERE `Code` = 'U2A' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx International Economy'
	WHERE `Code` = 'FIE' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx International First'
	WHERE `Code` = 'FIF' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'FedEx International Priority'
	WHERE `Code` = 'FIP' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'U.S.P.S. Express Mail Intl.'
	WHERE `Code` = 'PEM' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS WorldWide Expedited'
	WHERE `Code` = 'UWX' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS WorldWide Express'
	WHERE `Code` = 'UWE' ;
UPDATE `IntShipTypes` SET 
	`Name` = 'UPS WorldWide Express Plus'
	WHERE `Code` = 'UWP' ;
	
INSERT INTO `IntShipTypes`(`Name`, `Shipper`, `Used`, `Code`, `Priority`)	
  VALUES ('U.S.P.S.Express Mail PO', 'U.S.P.S.', 0, 'PEO', 99),
  ('U.S.P.S. Global Express Guaranteed', 'U.S.P.S.', 1, 'PEG', 99),
  ('U.S.P.S. Priority Mail Intl.', 'U.S.P.S.', 1, 'PMI', 99),
  ('U.S.P.S. First Class Mail Intl.', 'U.S.P.S.', 1, 'PFI', 99)
 ;
	
DELETE FROM `IntShipTypes` 
	WHERE `Code` = 'PAP' ;
DELETE FROM `IntShipTypes` 
	WHERE `Code` = 'PEP' ;
DELETE FROM `IntShipTypes` 
	WHERE `Code` = 'PGD' ;
DELETE FROM `IntShipTypes` 
	WHERE `Code` = 'PGP' ;
	
	
UPDATE `Locales` SET 
	`Name` = 'Dutch (Belgian)',
	`CurrExchange` = 'Netherlands'
	WHERE `ID` = 1 ;
UPDATE `Locales` SET 
	`Name` = 'Dutch (Standard)',
	`CurrExchange` = 'Euro'
	WHERE `ID` = 2 ;
UPDATE `Locales` SET 
	`Name` = 'English (Australian)',
	`CurrExchange` = 'Australia'
	WHERE `ID` = 3 ;
UPDATE `Locales` SET 
	`Name` = 'English (Canadian)',
	`CurrExchange` = 'Canada'
	WHERE `ID` = 4 ;
UPDATE `Locales` SET 
	`Name` = 'English (New Zealand)',
	`CurrExchange` = 'New Zealand'
	WHERE `ID` = 5 ;
UPDATE `Locales` SET 
	`Name` = 'English (UK)',
	`CurrExchange` = 'UK'
	WHERE `ID` = 6 ;
UPDATE `Locales` SET 
	`Name` = 'English (US)',
	`CurrExchange` = 'US'
	WHERE `ID` = 7 ;
UPDATE `Locales` SET 
	`Name` = 'French (Belgian)',
	`CurrExchange` = 'Belgium'
	WHERE `ID` = 8 ;
UPDATE `Locales` SET 
	`Name` = 'French (Canadian)',
	`CurrExchange` = 'Canada'
	WHERE `ID` = 9 ;
UPDATE `Locales` SET 
	`Name` = 'French (Standard)',
	`CurrExchange` = 'France'
	WHERE `ID` = 10 ;
UPDATE `Locales` SET 
	`Name` = 'French (Swiss)',
	`CurrExchange` = 'Switzerland'
	WHERE `ID` = 11 ;
UPDATE `Locales` SET 
	`Name` = 'German (Austrian)',
	`CurrExchange` = 'Austria'
	WHERE `ID` = 12 ;
UPDATE `Locales` SET 
	`Name` = 'German (Standard)',
	`CurrExchange` = 'Germany'
	WHERE `ID` = 13 ;
UPDATE `Locales` SET 
	`Name` = 'German (Swiss)',
	`CurrExchange` = 'Switzerland'
	WHERE `ID` = 14 ;
UPDATE `Locales` SET 
	`Name` = 'Italian (Standard)',
	`CurrExchange` = 'Italy'
	WHERE `ID` = 15 ;
UPDATE `Locales` SET 
	`Name` = 'Italian (Swiss)',
	`CurrExchange` = 'Switzerland'
	WHERE `ID` = 16 ;
UPDATE `Locales` SET 
	`Name` = 'Norwegian (Bokmal)',
	`CurrExchange` = 'Norway'
	WHERE `ID` = 17 ;
UPDATE `Locales` SET 
	`Name` = 'Norwegian (Nynorsk)',
	`CurrExchange` = 'Norway'
	WHERE `ID` = 18 ;
UPDATE `Locales` SET 
	`Name` = 'Portuguese (Brazilian)',
	`CurrExchange` = 'Portugal'
	WHERE `ID` = 19 ;
UPDATE `Locales` SET 
	`Name` = 'Portuguese (Standard)',
	`CurrExchange` = 'Portugal'
	WHERE `ID` = 20 ;
UPDATE `Locales` SET 
	`Name` = 'Spanish (Mexican)',
	`CurrExchange` = 'Mexico'
	WHERE `ID` = 21 ;
UPDATE `Locales` SET 
	`Name` = 'Spanish (Standard)',
	`CurrExchange` = 'Spain'
	WHERE `ID` = 22 ;
UPDATE `Locales` SET 
	`Name` = 'Swedish',
	`CurrExchange` = 'Sweden'
	WHERE `ID` = 23 ;
	

INSERT INTO `MailText`(`MailText_ID`, `MailText_Name`, `MailText_Message`, `MailText_Subject`, `MailText_Attachment`, `System`, `MailAction`)
VALUES (2, 'Email Confirmation', 'Welcome to %SiteName%.\r\nTo complete the Email Confirmation process please click on the link below:\r\n%SiteURL%index.cfm?fuseaction=users.unlock&amp;email=%Email%&amp;emaillock=%EmailLock%\r\nIf the link does not appear in your email as a clickable link, just copy and paste the complete URL into your browser\'s location bar and hit enter.\r\nYou can also complete the process by copying the following code into the Email Confirmation form.\r\nYour Code:\r\n%EmailLock%\r\nTo access the Email Confirmation form just sign in and click on \"My Account\".\r\nYou only need to confirm your email address once.\r\nSee you online!\r\n-- %SiteName%', '%SiteName% Email Confirmation Code', NULL, 1, 'EmailConfirmation'),
  (3, 'New Member Admin Notification', 'A new member has registered on %SiteName%:\r\n\r\n%MergeContent%', 'New Member Registration on  %SiteName%', NULL, 1, 'NewMemberNotice'),
  (4, 'Forgot Password', 'Your password for %SiteName% has been reset to: %MergeContent%<br>\r\n<br>\r\nAfter logging in at %SiteURL% you can change this temporary password by clicking on \"My Account\".<br>\r\n<br>\r\nSee you online!', 'Login Information', NULL, 1, 'ForgotPassword'),
  (5, 'Order Received Affiliate Notice', 'Here is a summary of an order received through your site! %Mergecontent%', 'Affiliate Order Received!', NULL, 1, 'OrderRecvdAffiliate'),
  (6, 'Order Received Customer Notice', 'Here is a summary of your order, thanks for shopping with us! %mergecontent%', 'Order Received!', NULL, 1, 'OrderRecvdCustomer'),
  (7, 'Gift Registry Purchase Notification', 'The following Gift Registry item was purchased: %Mergecontent%', '%SiteName% Gift Registry Purchase', NULL, 1, 'GiftRegistryPurchase'),
  (8, 'Membership Auto-Renewal Billed', NULL, NULL, NULL, 1, 'MembershipAutoRenewBilled'),
  (9, 'Membership Auto-Renewal Cancel', '<p>Your membership at %SiteName% has been cancelled as requested. Thanks for visiting!</p>', NULL, NULL, 1, 'MembershipAutoRenewCancel'),
  (10, 'Membership Renewal Reminder', 'Just a quick reminder that it is time to renew your %sitename%\r\nmembership due to expire in just a few days. You can renew your\r\nmembership at %SiteURL%. <br>\r\n<br>\r\nSee you online!', NULL, NULL, 1, 'MembershipRenewReminder'),
  (13, 'Order Shipping/Tracking Information', 'Shipping information for your order from %SiteName%<br />\r\n<br />\r\n%mergecontent%<br />\r\n<br />\r\n%Merchant%', '%SiteName% Order Shipped!', NULL, 1, 'OrderShipped'),
  (14, 'Custom Newsletter', 'Here\'s an example of a custom newsletter. Inform your customers of what is going on at %SiteName%!<br />\r\n<br />\r\n%Merchant%', '%SiteName% Newsletter', NULL, 0, 'Newsletter'),
  (15, 'Gift Certificate Purchase', '<p>Thanks for your purchase of a gift certificate from %SiteName%! Just enter the code when you are checking out to receive credits towards your purchase.</p>\r\n<p>%Mergecontent%</p>', '%SiteName% Gift Certificate Purchase', NULL, 1, 'GiftCertPurchase'),
  (16, 'New Affiliate Admin Notification', 'A new affiliate has registered on %SiteName%:\r\n<br><br>%MergeContent%', 'New Affiliate Registration on', NULL, 1, 'NewAffiliateNotice');
	

UPDATE `Memberships` SET
`Recur_Product_ID` = 0,
`Next_Membership_ID` = 0,
`Recur` = 0
	;
	
UPDATE `Order_No` SET
`InvDone` = 1,
`CodesSent` = 1,
`Freight` = 0
	;

UPDATE `Pages` SET 
	`PageAction` = 'home'
	WHERE `Page_ID` = 1 ;
UPDATE `Pages` SET 
	`PageAction` = 'manager'
	WHERE `Page_ID` = 2 ;
UPDATE `Pages` SET 
	`PageAction` = 'basket',
	`TitleTag` = 'Shopping Cart'
	WHERE `Page_ID` = 3 ;
UPDATE `Pages` SET 
	`PageAction` = 'search'
	WHERE `Page_ID` = 4 ;
UPDATE `Pages` SET 
	`Page_URL` = 'index.cfm?fuseaction=page.searchresults',
	`PageAction` = 'searchResults'
	WHERE `Page_ID` = 5 ;
UPDATE `Pages` SET 
	`Page_URL` = 'index.cfm?fuseaction=page.new',
	`PageAction` = 'new'
	WHERE `Page_ID` = 6 ;
UPDATE `Pages` SET 
	`Page_URL` = 'index.cfm?fuseaction=page.membersOnly',
	`PageAction` = 'membersOnly',
	`Keywords` = 'members, login',
	`TitleTag` = 'Members Only Page'
	WHERE `Page_ID` = 7 ;
UPDATE `Pages` SET 
	`Page_URL` = 'index.cfm?fuseaction=page.contactUs',
	`PassParam` = 'noline=1,BoxTitle=Email Us',
	`PageAction` = 'contactUs'
	WHERE `Page_ID` = 8 ;
UPDATE `Pages` SET 
	`Page_URL` = 'index.cfm?fuseaction=page.sitemap',
	`PageAction` = 'sitemap'
	WHERE `Page_ID` = 9 ;
UPDATE `Pages` SET 
	`PageAction` = 'wishlist'
	WHERE `Page_ID` = 10 ;
UPDATE `Pages` SET 
	`Page_URL` = 'index.cfm?fuseaction=page.cvv2help',
	`PageAction` = 'cvv2help'
	WHERE `Page_Name` = 'cvv2help' ;
UPDATE `Pages` SET 
	`Page_URL` = 'index.cfm?fuseaction=page.receipt',
	`PageAction` = 'receipt'
	WHERE `Page_Name` = 'receipt' ;
	

INSERT INTO `Permission_Groups`(`Group_ID`, `Name`)
VALUES (1, 'Access'),
  (2, 'Category'),
  (3, 'Feature'),
  (4, 'Product'),
  (5, 'Shopping'),
  (6, 'Users'),
  (7, 'Page');

INSERT INTO `Permissions`(`ID`, `Group_ID`, `Name`, `BitValue`)
VALUES (1, 1, 'Assign Permissions', 1),
  (2, 1, 'Manage Access Keys', 2),
  (3, 1, 'Manage Memberships', 4),
  (4, 2, 'Category Admin', 1),
  (5, 3, 'Feature Admin', 1),
  (6, 3, 'Feature Editor', 2),
  (7, 3, 'Feature Author', 4),
  (8, 4, 'Full Product Admin', 1),
  (9, 4, 'User Products Admin', 2),
  (10, 4, 'Discount Admin', 4),
  (11, 4, 'Promotion Admin', 8),
  (12, 5, 'Cart Admin', 1),
  (13, 5, 'Order Access', 2),
  (14, 5, 'Gift Certs Admin', 4),
  (15, 5, 'Order Approve', 8),
  (16, 5, 'Order Process', 16),
  (17, 5, 'Order Dropship', 32),
  (18, 5, 'Order Edit', 64),
  (19, 5, 'Order Reports', 128),
  (20, 6, 'Site Admin', 1),
  (21, 6, 'Admin Menu', 2),
  (22, 6, 'Group & User Admin', 4),
  (23, 6, 'User Export', 8),
  (24, 7, 'Page Admin', 1),
  (25, 4, 'Product Import', 16),
  (26, 4, 'Product Export', 32),
  (27, 4, 'Site Feeds', 128),
  (28, 5, 'Order Search', 256),
  (29, 4, 'Product Reviews', 64),
  (30, 3, 'Feature Reviews', 8),
  (31, 5, 'Gift Registry Admin', 512);
	

UPDATE `PickLists` SET 
	`GiftRegistry_Type` = 'wedding,christmas,birthday,baby',
	`Review_Editorial` = 'Editor,Spotlight'
	;
	
UPDATE `Products` SET 
	`Reviewable` = 0,
	`UseforPOTD` = 0,
	ShowPromotions = ShowDiscounts,
	Pack_Width = 0,
	Pack_Height = 0,
	Pack_Length = 0,
	Recur_Product_ID = 0,
	Recur = 0,
	GiftWrap = 0,
	Freight_Dom = 0,
	Freight_Intl = 0,
	Min_Order = 0,
	Mult_Min = 0,
	User_ID = 0
	;
	
UPDATE `Products` SET 
	`Reviewable` = 1,
	`UseforPOTD` = 1,
	`GiftWrap` = 1
	WHERE `Prod_Type` = 'product'
	;
	
UPDATE `Settings` SET 
	`SizeUnit` = 'Inches',
	`CurrExchange` = 'None',
	`CurrExLabel` = NULL,
	`UseSES` = 0,
	`Default_Fuseaction` = 'page.home',
	`Editor` = 'Default',
	`ProductReviews` = 0,
	`ProductReview_Approve` = 0,
	`ProductReview_Flag` = 0,
	`ProductReview_Add` = 1,
	`ProductReview_Rate` = 1,
	`ProductReviews_Page` = 3,
	`FeatureReviews` = 0,
	`FeatureReview_Add` = 1,
	`FeatureReview_Flag` = 0,
	`FeatureReview_Approve` = 0,
	`GiftRegistry` = 0
	;

UPDATE `ShipSettings` SET 
	`InStorePickup` = 0,
	`ShowEstimator` = 0,
	`ShowFreight` = 0,
	`UseDropShippers` = 0
	;
	
UPDATE `StdAddons` SET 
	`User_ID` = 0
	;
	
UPDATE `StdOptions` SET 
	`User_ID` = 0
	;
	
INSERT INTO `TaxCodes`(`CodeName`,`DisplayName`,`CalcOrder`,`Cumulative`,`TaxAddress`,`TaxAll`,`TaxRate`,`TaxShipping`,`ShowonProds`)
	VALUES ('Taxes','Taxes',0,0,'Shipping',0,0,0,0)
	;
	
UPDATE `LocalTax` SET 
	`Code_ID` = 1
	;
	
INSERT INTO `UPS_Origins`(`UPS_Code`, `Description`, `OrderBy`)
VALUES ('CA', 'Canada', 2),
  ('EU', 'European Union', 5),
  ('MX', 'Mexico', 4),
  ('OO', 'All Other Origins', 6),
  ('PR', 'Puerto Rico', 3),
  ('US', 'United States', 1);

INSERT INTO `UPS_Packaging`(`UPS_Code`, `Description`)
VALUES ('01', 'UPS Letter'),
  ('02', 'Your Package'),
  ('03', 'UPS Tube'),
  ('04', 'UPS Pak'),
  ('21', 'UPS Express Box'),
  ('24', 'UPS 25kg Box'),
  ('25', 'UPS 10Kg Box');

INSERT INTO `UPS_Pickup`(`UPS_Code`, `Description`)
VALUES ('01', 'Daily Pickup'),
  ('03', 'Customer Counter'),
  ('11', 'Suggested Retail Rates (UPS Store)');
	
UPDATE `UPS_Settings` SET 
	`Origin` = 'US',
	`MaxWeight` = 150,
	`UnitsofMeasure` = 'LBS/IN',
	`CustomerClass` = '01',
	`Pickup` = '01',
	`Packaging` = '02',
	`OrigZip` = '00000',
	`OrigCity` = '',
	`OrigCountry` = 'US',
	`Debug` = 0,
	`UseAV` = 1,
	`Logging` = 0
	;

INSERT INTO `UPSMethods`(`ID`, `Name`, `USCode`, `EUCode`, `CACode`, `PRCode`, `MXCode`, `OOCode`, `Used`, `Priority`)
VALUES (1, 'Next Day Air<sup>&reg;</sup>', '01', '00', '00', '01', '00', '00', 1, 4),
  (2, '2nd Day Air<sup>&reg;</sup>', '02', '00', '00', '02', '00', '00', 1, 3),
  (3, 'Ground', '03', '00', '00', '03', '00', '00', 1, 1),
  (4, 'Worldwide Express<sup><small>SM</small></sup>', '07', '00', '07', '07', '00', '07', 1, 99),
  (5, 'Worldwide Expedited<sup><small>SM</small></sup>', '08', '00', '08', '08', '00', '08', 1, 99),
  (6, 'Express', '00', '07', '00', '00', '07', '00', 0, 99),
  (7, 'Expedited', '00', '08', '00', '00', '08', '00', 0, 99),
  (8, 'Standard', '11', '11', '11', '00', '00', '00', 1, 99),
  (9, '3 Day Select<sup><small>SM</small></sup>', '12', '00', '12', '00', '00', '00', 1, 2),
  (10, 'Next Day Air Saver<sup>&reg;</sup>', '13', '00', '00', '00', '00', '00', 0, 99),
  (11, 'Express Saver', '00', '65', '13', '00', '00', '00', 0, 99),
  (12, 'Next Day Air<sup>&reg;</sup> Early A.M.<sup>&reg;</sup>', '14', '00', '00', '14', '00', '00', 0, 99),
  (13, 'Express Early A.M.', '00', '00', '14', '00', '00', '00', 0, 99),
  (14, 'Worldwide Express Plus<sup><small>SM</small></sup>', '54', '54', '54', '54', '00', '54', 0, 99),
  (15, 'Express Plus', '00', '00', '00', '00', '54', '00', 0, 99),
  (16, '2nd Day Air A.M.<sup>&reg;</sup>', '59', '00', '00', '00', '00', '00', 0, 99),
  (17, 'Worldwide Saver<sup><small>SM</small></sup>', '65', '00', '65', '65', '65', '65', 1, 99),
  (18, 'Express Saver<sup><small>SM</small></sup>', '00', '65', '13', '00', '00', '00', 0, 99);
	
INSERT INTO `USPS_Settings`(`UserID`,`Server`,`MerchantZip`,`MaxWeight`,`Logging`,`Debug`,`UseAV`)
	VALUES ('userid','http://production.shippingapis.com/ShippingAPI.dll','00000',150,0,0,0)
	;
	

INSERT INTO `USPSCountries`(`ID`, `Abbrev`, `Name`)
VALUES (2, 'AL', 'Albania'),
  (3, 'DZ', 'Algeria'),
  (4, 'AD', 'Andorra'),
  (6, 'AI', 'Anguilla'),
  (7, 'AG', 'Antigua and Barbuda'),
  (8, 'AR', 'Argentina'),
  (10, 'AW', 'Aruba'),
  (11, 'AU', 'Australia'),
  (12, 'AT', 'Austria'),
  (14, 'AP', 'Portugal'),
  (15, 'BS', 'Bahamas'),
  (16, 'BH', 'Bahrain'),
  (17, 'BD', 'Bangladesh'),
  (18, 'BB', 'Barbados'),
  (19, 'BY', 'Belarus'),
  (20, 'BE', 'Belgium'),
  (21, 'BZ', 'Belize'),
  (22, 'BJ', 'Benin'),
  (23, 'BM', 'Bermuda'),
  (25, 'BO', 'Bolivia'),
  (27, 'BW', 'Botswana'),
  (28, 'BR', 'Brazil'),
  (29, 'VG', 'British Virgin Islands'),
  (30, 'BN', 'Brunei Darussalam'),
  (31, 'BG', 'Bulgaria'),
  (32, 'BF', 'Burkina Faso'),
  (34, 'BI', 'Burundi'),
  (35, 'CM', 'Cameroon'),
  (36, 'CA', 'Canada'),
  (37, 'CV', 'Cape Verde'),
  (38, 'KY', 'Cayman Islands'),
  (39, 'CF', 'Central African Republic'),
  (40, 'TD', 'Chad'),
  (41, 'CL', 'Chile'),
  (42, 'CN', 'China'),
  (43, 'CO', 'Colombia'),
  (45, 'CG', 'Congo (Brazzaville),Republic of the'),
  (47, 'CR', 'Costa Rica'),
  (48, 'CI', 'Cote d lvoire (Ivory Coast)'),
  (49, 'HR', 'Croatia'),
  (50, 'CY', 'Cyprus'),
  (51, 'CZ', 'Czech Republic'),
  (52, 'DK', 'Denmark'),
  (53, 'DJ', 'Djibouti'),
  (54, 'DM', 'Dominica'),
  (55, 'DO', 'Dominican Republic'),
  (56, 'EC', 'Ecuador'),
  (57, 'EG', 'Egypt'),
  (58, 'SV', 'El Salvador'),
  (59, 'GQ', 'Equatorial Guinea'),
  (60, 'ER', 'Eritrea'),
  (61, 'EE', 'Estonia'),
  (62, 'ET', 'Ethiopia'),
  (64, 'FO', 'Faroe Islands'),
  (65, 'FJ', 'Fiji'),
  (66, 'FI', 'Finland'),
  (67, 'FR', 'France'),
  (68, 'GF', 'French Guiana'),
  (69, 'PF', 'French Polynesia'),
  (70, 'GA', 'Gabon'),
  (71, 'GM', 'Gambia'),
  (72, 'GE', 'Georgia, Republic of'),
  (73, 'DE', 'Germany'),
  (74, 'GH', 'Ghana'),
  (75, 'GI', 'Gibraltar'),
  (77, 'GR', 'Greece'),
  (78, 'GL', 'Greenland'),
  (79, 'GD', 'Grenada'),
  (80, 'GP', 'Guadeloupe'),
  (81, 'GT', 'Guatemala'),
  (82, 'GN', 'Guinea'),
  (83, 'GW', 'Guinea-Bissau'),
  (84, 'GY', 'Guyana'),
  (85, 'HT', 'Haiti'),
  (86, 'HN', 'Honduras'),
  (87, 'HK', 'Hong Kong'),
  (88, 'HU', 'Hungary'),
  (89, 'IS', 'Iceland'),
  (90, 'IN', 'India'),
  (91, 'ID', 'Indonesia'),
  (95, 'IL', 'Israel'),
  (96, 'IT', 'Italy'),
  (97, 'JM', 'Jamaica'),
  (98, 'JP', 'Japan'),
  (99, 'JO', 'Jordan'),
  (100, 'KZ', 'Kazakhstan'),
  (101, 'KE', 'Kenya'),
  (102, 'KI', 'Kiribati'),
  (105, 'KW', 'Kuwait'),
  (106, 'KG', 'Kyrgyzstan'),
  (107, 'LA', 'Laos'),
  (108, 'LV', 'Latvia'),
  (109, 'LB', 'Lebanon'),
  (110, 'LS', 'Lesotho'),
  (111, 'LR', 'Liberia'),
  (113, 'LI', 'Liechtenstein'),
  (114, 'LT', 'Lithuania'),
  (115, 'LU', 'Luxembourg'),
  (116, 'MO', 'Macao'),
  (117, 'MK', 'Macedonia, Republic of'),
  (118, 'MG', 'Madagascar'),
  (119, 'ME', 'Portugal'),
  (120, 'MW', 'Malawi'),
  (121, 'MY', 'Malaysia'),
  (122, 'MV', 'Maldives'),
  (123, 'ML', 'Mali'),
  (124, 'MT', 'Malta'),
  (125, 'MQ', 'Martinique'),
  (126, 'MR', 'Mauritania'),
  (127, 'MU', 'Mauritius'),
  (128, 'MX', 'Mexico'),
  (129, 'MD', 'Moldova'),
  (131, 'MS', 'Montserrat'),
  (132, 'MA', 'Morocco'),
  (133, 'MZ', 'Mozambique'),
  (134, 'NA', 'Namibia'),
  (136, 'NP', 'Nepal'),
  (137, 'NL', 'Netherlands'),
  (138, 'AN', 'Netherlands Antilles'),
  (139, 'NC', 'New Caledonia'),
  (140, 'NZ', 'New Zealand'),
  (141, 'NI', 'Nicaragua'),
  (142, 'NE', 'Niger'),
  (143, 'NG', 'Nigeria'),
  (144, 'NO', 'Norway'),
  (145, 'OM', 'Oman'),
  (146, 'PK', 'Pakistan'),
  (147, 'PA', 'Panama'),
  (148, 'PG', 'Papua New Guinea'),
  (149, 'PY', 'Paraguay'),
  (150, 'PE', 'Peru'),
  (151, 'PH', 'Philippines'),
  (153, 'PL', 'Poland'),
  (154, 'PT', 'Portugal'),
  (155, 'QA', 'Qatar'),
  (156, 'RE', 'Reunion'),
  (157, 'RO', 'Romania'),
  (158, 'RU', 'Russia'),
  (159, 'RW', 'Rwanda'),
  (163, 'VC', 'St. Vincent and the Grenadines'),
  (166, 'SA', 'Saudi Arabia'),
  (167, 'SN', 'Senegal'),
  (169, 'SC', 'Seychelles'),
  (170, 'SL', 'Sierra Leone'),
  (171, 'SG', 'Singapore'),
  (172, 'SK', 'Slovak Republic'),
  (173, 'SI', 'Slovenia'),
  (174, 'SB', 'Solomon Islands'),
  (176, 'ZA', 'South Africa'),
  (177, 'ES', 'Spain'),
  (178, 'LK', 'Sri Lanka'),
  (179, 'KN', 'St. Christopher and Nevis'),
  (181, 'SR', 'Suriname'),
  (182, 'SZ', 'Swaziland'),
  (183, 'SE', 'Sweden'),
  (184, 'CH', 'Switzerland'),
  (185, 'SY', 'Syrian Arab Republic'),
  (186, 'TW', 'Taiwan'),
  (187, 'TJ', 'Tajikistan'),
  (188, 'TZ', 'Tanzania'),
  (189, 'TH', 'Thailand'),
  (190, 'TG', 'Togo'),
  (191, 'TO', 'Tonga'),
  (192, 'TT', 'Trinidad and Tobago'),
  (194, 'TN', 'Tunisia'),
  (195, 'TR', 'Turkey'),
  (197, 'TC', 'Turks and Caicos Islands'),
  (198, 'TV', 'Tuvalu'),
  (199, 'UG', 'Uganda'),
  (200, 'UA', 'Ukraine'),
  (201, 'AE', 'United Arab Emirates'),
  (202, 'US', 'United States'),
  (203, 'UY', 'Uruguay'),
  (204, 'UZ', 'Uzbekistan'),
  (205, 'VU', 'Vanuatu'),
  (207, 'VE', 'Venezuela'),
  (208, 'VN', 'Vietnam'),
  (209, 'WF', 'Wallis and Futuna Islands'),
  (210, 'WS', 'Western Samoa'),
  (212, 'CD', 'Congo, Democratic Republic of the'),
  (213, 'ZM', 'Zambia'),
  (214, 'ZW', 'Zimbabwe'),
  (215, 'AS', 'US Possession'),
  (216, 'KH', 'Cambodia'),
  (217, 'BL', 'Netherlands Antilles'),
  (218, 'CE', 'Spain'),
  (219, 'NN', 'Great Britain and Northern Ireland'),
  (220, 'CK', 'New Zealand'),
  (221, 'CB', 'Netherlands Antilles'),
  (222, 'EN', 'Great Britain and Northern Ireland'),
  (223, 'GU', 'US Possession'),
  (224, 'KO', 'US Possession'),
  (225, 'MH', 'US Possession'),
  (226, 'MC', 'France'),
  (227, 'MM', 'Burma'),
  (228, 'NF', 'Australia'),
  (229, 'NB', 'Great Britain and Northern Ireland'),
  (230, 'MP', 'US Possession'),
  (231, 'PW', 'US Possession'),
  (232, 'PO', 'US Possession'),
  (234, 'IE', 'Ireland'),
  (235, 'RT', 'US Possession'),
  (236, 'SS', 'Netherlands Antilles'),
  (237, 'SP', 'US Possession'),
  (238, 'SF', 'Great Britain and Northern Ireland'),
  (239, 'NT', 'Guadeloupe'),
  (240, 'SW', 'St. Christopher and Nevis'),
  (241, 'SX', 'US Possession'),
  (242, 'EU', 'Netherlands Antilles'),
  (243, 'UV', 'US Possession'),
  (244, 'LC', 'St. Lucia'),
  (245, 'MB', 'Netherlands Antilles'),
  (246, 'TB', 'Guadeloupe'),
  (247, 'VL', 'US Possession'),
  (248, 'KR', 'Korea, Republic of (South Korea)'),
  (249, 'TA', 'French Polynesia'),
  (250, 'TU', 'US Possession'),
  (252, 'VI', 'US Possession'),
  (253, 'WK', 'US Possession'),
  (254, 'WL', 'Great Britain and Northern Ireland'),
  (255, 'YA', 'US Possession'),
  (256, 'BA', 'Bosnia-Herzegovina'),
  (257, 'GB', 'Great Britain and Northern Ireland');
	
INSERT INTO `USPSMethods`(`ID`, `Name`, `Used`, `Code`, `Type`, `Priority`)
VALUES (1, 'Priority Mail w/Dlvr. Conf.',1,'Priority Mail','Domestic',1),
(2, 'Parcel Post w/Dlvr. Conf.',1,'Parcel Post','Domestic',2),
(3, 'Express Mail',1,'Express Mail','Domestic',3),
(4, 'Express Mail PO',1,'Express Mail PO to Addressee','Domestic',4),
(5, 'Express Mail PO',1,'Express Mail PO to PO','Domestic',5),
(6, 'First Class',1,'First-Class Mail','Domestic',6),
(7, 'First Class Parcel',1,'First-Class Mail Parcel','Domestic',7),
(8, 'First Class Flat',0,'First-Class Mail Flat','Domestic',8),
(9, 'Priority Mail Flat-Rate Box',0,'Priority Mail Flat-Rate Box','Domestic',9),
(10, 'Bound Printed Matter',0,'Bound Printed Matter','Domestic',99),
(11, 'Media Mail',0,'Media Mail','Domestic',99),
(12, 'Library Mail',0,'Library Mail','Domestic',99),
(13, 'Global Express Guaranteed',1,'Global Express Guaranteed','International',99),
(14, 'Express Mail Intl.',1,'Express Mail International (EMS)','International',99),
(15, 'Express Mail Int Flat Rate Env',0,'Express Mail International (EMS) Flat Rate Envelope','International',99),
(16, 'Priority Mail Intl.',1,'Priority Mail International','International',99),
(17, 'Priority Mail Intl Flat Rate Env',0,'Priority Mail International Flat Rate Envelope','International',99),
(18, 'Priority Mail Intl Flat Rate Box',0,'Priority Mail International Flat Rate Box','International',99),
(19, 'First-Class Mail Intl',1,'First-Class Mail International','International',99);

	
UPDATE `Users` SET 
	`FailedLogins` = 0,
	`Disable` = 0,
	`LastAttempt` = Now(),
	`LoginsDay` = 0,
	`LoginsTotal` = 0,	
	`CardisValid` = IsActive
	;
	
	
DELETE FROM `TempBasket`
;
DELETE FROM `TempCustomer`
;
DELETE FROM `TempOrder`
;
DELETE FROM `TempShipTo`
;



