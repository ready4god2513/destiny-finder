BEGIN TRANSACTION

UPDATE "CatCore" SET 
	"PassParams" = 'noline=1,notitle=1'
	WHERE "CatCore_ID" = 0
UPDATE "CatCore" SET 
	"PassParams" = 'noline=1,notitle=1'
	WHERE "CatCore_ID" = 1
UPDATE "CatCore" SET 
	"PassParams" = 'topcats, searchform,new,onsale,hot,notsold,ProdofDay,listing,notitle,columns=x'
	WHERE "CatCore_ID" = 2
UPDATE "CatCore" SET 
	"PassParams" = 'new=1,onsale=1,notsold=1,notitle=1,columns=x'
	WHERE "CatCore_ID" = 3
UPDATE "CatCore" SET
	"PassParams" = 'noline=1,EmailTo=email@address.com, BoxTitle=Title,Subject=Email Subject Line'
	WHERE "CatCore_ID" = 4
UPDATE "CatCore" SET 
	"PassParams" = 'noline=1,notitle=1'
	WHERE "CatCore_ID" = 5
UPDATE "CatCore" SET 
	"PassParams" = 'noline=1,notitle=1'
	WHERE "CatCore_ID" = 6
UPDATE "CatCore" SET 
	"PassParams" = 'noline=1,notitle=1'
	WHERE "CatCore_ID" = 7
UPDATE "CatCore" SET 
	"PassParams" = 'listing=vertical|short, displaycount=x, productcols=x,searchheader=1,searchheader=form,alpha=1,notitle=1'
	WHERE "CatCore_ID" = 8
UPDATE "CatCore" SET 
	"PassParams" = 'noline=1,notitle=1,searchform=1, displaycount=x'
	WHERE "CatCore_ID" = 9
UPDATE "CatCore" SET 
	"PassParams" = 'noline=1,notitle=1'
	WHERE "CatCore_ID" = 11
UPDATE "CatCore" SET 
	"PassParams" = 'noline=1,notitle=1,listing=short|vertical'
	WHERE "CatCore_ID" = 12
UPDATE "CatCore" SET 
	"PassParams" = 'noline=1,notitle=1,displaycount,accountcols,sort,order,type1'
	WHERE "CatCore_ID" = 13
UPDATE "CatCore" SET 
	"PassParams" = 'noline=1,alpha=1,notitle=1'
	WHERE "CatCore_ID" = 14
	;
	
UPDATE "Countries" SET 
	"AllowUPS" = 1
	;

UPDATE "Countries" SET 
	"Name" = 'Virgin Islands (British)'
	WHERE "Abbrev" = 'VG'
UPDATE "Countries" SET 
	"Name" = 'Russian Federation'
	WHERE "Abbrev" = 'RU'
UPDATE "Countries" SET 
	"Name" = 'Samoa'
	WHERE "Abbrev" = 'WS'
UPDATE "Countries" SET 
	"Name" = 'Korea (South)'
	WHERE "Abbrev" = 'KR'
UPDATE "Countries" SET 
	"Name" = 'Virgin Islands (U.S.)'
	WHERE "Abbrev" = 'VI'
UPDATE "Countries" SET 	
	"Name" = 'Great Britain (UK)'
	WHERE "Abbrev" = 'GB'
UPDATE "Countries" SET 
	"Name" = 'Afghanistan'
	WHERE "Abbrev" = 'AF'
UPDATE "Countries" SET 	
	"Name" = 'Angola'
	WHERE "Abbrev" = 'AO'
UPDATE "Countries" SET 	
	"Name" = 'Western Sahara'
	WHERE "Abbrev" = 'EH'
	;
	

INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('AM','Armenia',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('BL','Bonaire',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('BV','Bouvet Island',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('IO','British Indian Ocean Terr.',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('CD','Channel Islands',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('CX','Christmas Island',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('CC','Cocos (Keeling) Islands',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('CB','Curacao',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('TP','East Timor',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('EN','England',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('FK','Falkland Islands',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('TF','French Southern Territories',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('HM','Heard Island',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('KO','Kosrae',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('YT','Mayotte',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('MM','Myanmar',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('NR','Nauru',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('NT','Neutral Zone',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('NU','Niue',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('NB','Northern Ireland',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('PN','Pitcairn',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('PO','Ponape',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('PR','Puerto Rico',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('RT','Rota',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('SS','Saba',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('SP','Saipan',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('ST','Sao Tome and Principe',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('SF','Scotland',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('GS','South Georgia',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('SW','St. Christopher',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('EU','St. Eustatius',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('SH','St. Helena',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('MB','St. Maarten',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('TB','St. Martin',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('PM','St. Pierre and Miquelon',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('SD','Sudan',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('SJ','Svalbard and Jan Mayen Islands',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('TI','Tinian',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('TK','Tokelau',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('TU','Truk',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('UM','US Minor Outlying Islands',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('SU','USSR (former)',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('VA','Vatican City State',0,0)
INSERT INTO "Countries"("Abbrev","Name","Shipping","AddShipAmount")
	VALUES ('YA','Yap',0,0)
	;

UPDATE "CreditCards" SET 
	"CardName" = 'Mastercard'
	WHERE "CardName" = 'MasterCard'
	
UPDATE "CreditCards" SET 
	"CardName" = 'Visa'
	WHERE "CardName" = 'VISA'
	
UPDATE "CreditCards" SET 
	"CardName" = 'Amex'
	WHERE "CardName" = 'American Express'
	;
	
INSERT INTO "CustomMethods"("Name","Amount","Used","Priority","Domestic","International")
	VALUES ('Next Day Air',10,1,3,1,0)
INSERT INTO "CustomMethods"("Name","Amount","Used","Priority","Domestic","International")
	VALUES ('2nd Day Air',5.5,1,2,1,0)
INSERT INTO "CustomMethods"("Name","Amount","Used","Priority","Domestic","International")
	VALUES ('Ground Shipping',0,1,1,1,0)
INSERT INTO "CustomMethods"("Name","Amount","Used","Priority","Domestic","International")
	VALUES ('Airmail',20,1,4,0,1)
	;
	
INSERT INTO "CustomShipSettings"("ShowShipTable","MultPerItem","CumulativeAmounts","MultMethods","Debug")
	VALUES (1,1,1,0,0)
	;
	
UPDATE "Customers" SET 
	"Residence" = 1
	;
	
UPDATE "Discounts" SET
"AccessKey" = 0,
"OneTime" = 0
	;
	
UPDATE "Features" SET
"Reviewable" = 1
	;
	
INSERT INTO "FedEx_Dropoff"("FedEx_Code","Description")
	VALUES ('BUSINESSSERVICE CENTER','Business Service Center')
INSERT INTO "FedEx_Dropoff"("FedEx_Code","Description")
	VALUES ('DROPBOX','Drop Box')
INSERT INTO "FedEx_Dropoff"("FedEx_Code","Description")
	VALUES ('REGULARPICKUP','Regular Pickup')
INSERT INTO "FedEx_Dropoff"("FedEx_Code","Description")
	VALUES ('REQUESTCOURIER','Request Courier')
INSERT INTO "FedEx_Dropoff"("FedEx_Code","Description")
	VALUES ('STATION','Station')
	;
	
INSERT INTO "FedEx_Packaging"("FedEx_Code","Description")
	VALUES ('FEDEX10KGBOX','FedEx<sup>&reg;</sup> 10kb Box')
INSERT INTO "FedEx_Packaging"("FedEx_Code","Description")
	VALUES ('FEDEX25KGBOX','FedEx<sup>&reg;</sup> 25kg Box')
INSERT INTO "FedEx_Packaging"("FedEx_Code","Description")
	VALUES ('FEDEXBOX','FedEx<sup>&reg;</sup> Box')
INSERT INTO "FedEx_Packaging"("FedEx_Code","Description")
	VALUES ('FEDEXENVELOPE','FedEx<sup>&reg;</sup> Letter')
INSERT INTO "FedEx_Packaging"("FedEx_Code","Description")
	VALUES ('FEDEXPAK','FedEx<sup>&reg;</sup> Pak')
INSERT INTO "FedEx_Packaging"("FedEx_Code","Description")
	VALUES ('FEDEXTUBE','FedEx<sup>&reg;</sup> Tube')
INSERT INTO "FedEx_Packaging"("FedEx_Code","Description")
	VALUES ('YOURPACKAGING','Your Packaging')
	;
	
INSERT INTO "FedEx_Settings"("AccountNo","MeterNum","MaxWeight","UnitsofMeasure","Dropoff","Packaging","OrigZip","OrigState","OrigCountry","Debug","UseGround","UseExpress","Logging")
	VALUES (NULL,NULL,150,'KGS/CM','REGULARPICKUP','YOURPACKAGING','00000','NY','US',0,1,1,0)
	;
	
INSERT INTO "FedExMethods"("Name","Used","Shipper","Code","Priority")
	VALUES ('FedEx<sup>&reg;</sup> Ground',1,'FDXG','FEDEXGROUND',1)
INSERT INTO "FedExMethods"("Name","Used","Shipper","Code","Priority")
	VALUES ('FedEx<sup>&reg;</sup> Home Delivery',1,'FDXG','GROUNDHOMEDELIVERY',2)
INSERT INTO "FedExMethods"("Name","Used","Shipper","Code","Priority")
	VALUES ('FedEx Priority Overnight<sup>&reg;</sup>',1,'FDXE','PRIORITYOVERNIGHT',4)
INSERT INTO "FedExMethods"("Name","Used","Shipper","Code","Priority")
	VALUES ('FedEx 2 Day<sup>&reg;</sup>',1,'FDXE','FEDEX2DAY',3)
INSERT INTO "FedExMethods"("Name","Used","Shipper","Code","Priority")
	VALUES ('FedEx First Overnight<sup>&reg;</sup>',1,'FDXE','FIRSTOVERNIGHT',5)
INSERT INTO "FedExMethods"("Name","Used","Shipper","Code","Priority")
	VALUES ('FedEx Express Saver<sup>&reg;</sup>',1,'FDXE','FEDEXEXPRESSSAVER',6)
INSERT INTO "FedExMethods"("Name","Used","Shipper","Code","Priority")
	VALUES ('FedEx Standard Overnight<sup>&reg;</sup>',1,'FDXE','STANDARDOVERNIGHT',7)
INSERT INTO "FedExMethods"("Name","Used","Shipper","Code","Priority")
	VALUES ('FedEx International Priority<sup>&reg;</sup>',1,'FDXE','INTERNATIONALPRIORITY',8)
INSERT INTO "FedExMethods"("Name","Used","Shipper","Code","Priority")
	VALUES ('FedEx International Economy<sup>&reg;</sup>',1,'FDXE','INTERNATIONALECONOMY',9)
	;
	
UPDATE "Groups" SET "TaxExempt" = 0 
UPDATE "Groups" SET "ShipExempt" = 0 
	;

UPDATE "Intershipper" SET 
	"UnitsofMeasure" = 'LBS/IN',
	"MaxWeight" = 150,
	"Logging" = 0,
	"Debug" = 0
	;
	
UPDATE "IntShipTypes" SET "Priority" = 99
	;

UPDATE "IntShipTypes" SET 
	"Name" = 'UPS Next Day Air'
	WHERE "Code" = 'UND'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS 2nd Day Air'
	WHERE "Code" = 'U2D'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS Canadian Expedited Service'
	WHERE "Code" = 'UCX'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS Canadian Express Service'
	WHERE "Code" = 'UCE'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS 3-Day Select'
	WHERE "Code" = 'U3S'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS Next Day Air Saver'
	WHERE "Code" = 'UNS'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS Next Day Air Early AM'
	WHERE "Code" = 'UNA'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS Ground'
	WHERE "Code" = 'UGN'
UPDATE "IntShipTypes" SET 
	"Name" = 'U.S.P.S.Priority Mail'
	WHERE "Code" = 'PPM'
UPDATE "IntShipTypes" SET 
	"Name" = 'U.S.P.S. Parcel Post Machine'
	WHERE "Code" = 'PGM'
UPDATE "IntShipTypes" SET 
	"Name" = 'U.S.P.S.Express Mail'
	WHERE "Code" = 'PEA'
UPDATE "IntShipTypes" SET 
	"Name" = 'U.S.P.S. Parcel Post Non-Machine'
	WHERE "Code" = 'PGN'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx Priority Overnight'
	WHERE "Code" = 'FPN'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx 2nd Day'
	WHERE "Code" = 'F2D'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx Express Saver'
	WHERE "Code" = 'FES'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx Ground'
	WHERE "Code" = 'FGN'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx Standard Overnight'
	WHERE "Code" = 'FSO'
UPDATE "IntShipTypes" SET 
	"Name" = 'DHL Overnight'
	WHERE "Code" = 'DON'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS Canadian Express Plus Service'
	WHERE "Code" = 'UCP'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS Standard Canadian Service'
	WHERE "Code" = 'UCS'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx First Overnight'
	WHERE "Code" = 'FON'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx Canadian Ground'
	WHERE "Code" = 'FCG'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx Canadian International Economy'
	WHERE "Code" = 'FCE'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx Canadian International Priority'
	WHERE "Code" = 'FCP'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx Canadian International First'
	WHERE "Code" = 'FCF'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS 2nd Day Air AM'
	WHERE "Code" = 'U2A'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx International Economy'
	WHERE "Code" = 'FIE'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx International First'
	WHERE "Code" = 'FIF'
UPDATE "IntShipTypes" SET 
	"Name" = 'FedEx International Priority'
	WHERE "Code" = 'FIP'
UPDATE "IntShipTypes" SET 
	"Name" = 'U.S.P.S. Express Mail Intl.'
	WHERE "Code" = 'PEM'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS WorldWide Expedited'
	WHERE "Code" = 'UWX'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS WorldWide Express'
	WHERE "Code" = 'UWE'
UPDATE "IntShipTypes" SET 
	"Name" = 'UPS WorldWide Express Plus'
	WHERE "Code" = 'UWP'
	;
	
INSERT INTO "IntShipTypes"("Name","Shipper","Used","Code","Priority")
	VALUES ('U.S.P.S. Express Mail PO','U.S.P.S.',0,'PEO',99)
INSERT INTO "IntShipTypes"("Name","Shipper","Used","Code","Priority")
	VALUES ('U.S.P.S. Global Express Guaranteed','U.S.P.S.',1,'PEG',99)
INSERT INTO "IntShipTypes"("Name","Shipper","Used","Code","Priority")
	VALUES ('U.S.P.S. Priority Mail Intl.','U.S.P.S.',1,'PMI',99)
INSERT INTO "IntShipTypes"("Name","Shipper","Used","Code","Priority")
	VALUES ('U.S.P.S. First Class Mail Intl.','U.S.P.S.',1,'PFI',99)
	;
	
DELETE FROM "IntShipTypes"
	WHERE "Code" = 'PAP'
DELETE FROM "IntShipTypes"
	WHERE "Code" = 'PEP'
DELETE FROM "IntShipTypes"
	WHERE "Code" = 'PGD'
DELETE FROM "IntShipTypes"
	WHERE "Code" = 'PGP'
	;
	
UPDATE "Locales" SET 
	"Name" = 'Dutch (Belgian)',
	"CurrExchange" = 'Netherlands'
	WHERE "ID" = 1
UPDATE "Locales" SET 
	"Name" = 'Dutch (Standard)',
	"CurrExchange" = 'Euro'
	WHERE "ID" = 2
UPDATE "Locales" SET 
	"Name" = 'English (Australian)',
	"CurrExchange" = 'Australia'
	WHERE "ID" = 3
UPDATE "Locales" SET 
	"Name" = 'English (Canadian)',
	"CurrExchange" = 'Canada'
	WHERE "ID" = 4
UPDATE "Locales" SET 
	"Name" = 'English (New Zealand)',
	"CurrExchange" = 'New Zealand'
	WHERE "ID" = 5
UPDATE "Locales" SET 
	"Name" = 'English (UK)',
	"CurrExchange" = 'UK'
	WHERE "ID" = 6
UPDATE "Locales" SET 
	"Name" = 'English (US)',
	"CurrExchange" = 'US'
	WHERE "ID" = 7
UPDATE "Locales" SET 
	"Name" = 'French (Belgian)',
	"CurrExchange" = 'Belgium'
	WHERE "ID" = 8
UPDATE "Locales" SET 
	"Name" = 'French (Canadian)',
	"CurrExchange" = 'Canada'
	WHERE "ID" = 9
UPDATE "Locales" SET 
	"Name" = 'French (Standard)',
	"CurrExchange" = 'France'
	WHERE "ID" = 10
UPDATE "Locales" SET 
	"Name" = 'French (Swiss)',
	"CurrExchange" = 'Switzerland'
	WHERE "ID" = 11
UPDATE "Locales" SET 
	"Name" = 'German (Austrian)',
	"CurrExchange" = 'Austria'
	WHERE "ID" = 12
UPDATE "Locales" SET 
	"Name" = 'German (Standard)',
	"CurrExchange" = 'Germany'
	WHERE "ID" = 13
UPDATE "Locales" SET 
	"Name" = 'German (Swiss)',
	"CurrExchange" = 'Switzerland'
	WHERE "ID" = 14
UPDATE "Locales" SET 
	"Name" = 'Italian (Standard)',
	"CurrExchange" = 'Italy'
	WHERE "ID" = 15
UPDATE "Locales" SET 
	"Name" = 'Italian (Swiss)',
	"CurrExchange" = 'Switzerland'
	WHERE "ID" = 16
UPDATE "Locales" SET 
	"Name" = 'Norwegian (Bokmal)',
	"CurrExchange" = 'Norway'
	WHERE "ID" = 17
UPDATE "Locales" SET 
	"Name" = 'Norwegian (Nynorsk)',
	"CurrExchange" = 'Norway'
	WHERE "ID" = 18
UPDATE "Locales" SET 
	"Name" = 'Portuguese (Brazilian)',
	"CurrExchange" = 'Portugal'
	WHERE "ID" = 19
UPDATE "Locales" SET 
	"Name" = 'Portuguese (Standard)',
	"CurrExchange" = 'Portugal'
	WHERE "ID" = 20
UPDATE "Locales" SET 
	"Name" = 'Spanish (Mexican)',
	"CurrExchange" = 'Mexico'
	WHERE "ID" = 21
UPDATE "Locales" SET 
	"Name" = 'Spanish (Standard)',
	"CurrExchange" = 'Spain'
	WHERE "ID" = 22
UPDATE "Locales" SET 
	"Name" = 'Swedish',
	"CurrExchange" = 'Sweden'
	WHERE "ID" = 23
	;
	
INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Email Confirmation','Welcome to %SiteName%.
To complete the Email Confirmation process please click on the link below:
%SiteURL%index.cfm?fuseaction=users.unlock&amp;email=%Email%&amp;emaillock=%EmailLock%
If the link does not appear in your email as a clickable link, just copy and paste the complete URL into your browser''s location bar and hit enter.
You can also complete the process by copying the following code into the Email Confirmation form.
Your Code:
%EmailLock%
To access the Email Confirmation form just sign in and click on "My Account".
You only need to confirm your email address once.
See you online!
-- %SiteName%','%SiteName% Email Confirmation Code',NULL,1,'EmailConfirmation')

INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('New Member Admin Notification','A new member has registered on %SiteName%:

%MergeContent%','New Member Registration on  %SiteName%',NULL,1,'NewMemberNotice')

INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Forgot Password','Your password for %SiteName% has been reset to: %MergeContent%<br>
<br>
After logging in at %SiteURL% you can change this temporary password by clicking on "My Account".<br>
<br>
See you online!','Login Information',NULL,1,'ForgotPassword')

INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Order Received Affiliate Notice','Here is a summary of an order received through your site! %Mergecontent%','Affiliate Order Received!',NULL,1,'OrderRecvdAffiliate')

INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Order Received Customer Notice','Here is a summary of your order, thanks for shopping with us! %mergecontent%','Order Received!',NULL,1,'OrderRecvdCustomer')

INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Gift Registry Purchase Notification','The following Gift Registry item was purchased: %Mergecontent%','%SiteName% Gift Registry Purchase',NULL,1,'GiftRegistryPurchase')

INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Membership Auto-Renewal Billed',NULL,NULL,NULL,1,'MembershipAutoRenewBilled')
	
INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Membership Auto-Renewal Cancel','<p>Your membership at %SiteName% has been cancelled as requested. Thanks for visiting!</p>',NULL,NULL,1,'MembershipAutoRenewCancel')
	
INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Membership Renewal Reminder','Just a quick reminder that it is time to renew your %sitename%
membership due to expire in just a few days. You can renew your
membership at %SiteURL%. <br>
<br>
See you online!',NULL,NULL,1,'MembershipRenewReminder')

INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Order Shipping/Tracking Information','Shipping information for your order from %SiteName%<br />
<br />
%mergecontent%<br />
<br />
%Merchant%','%SiteName% Order Shipped!',NULL,1,'OrderShipped')

INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Custom Newsletter','Here''s an example of a custom newsletter. Inform your customers of what is going on at %SiteName%!<br />
<br />
%Merchant%','%SiteName% Newsletter',NULL,0,'Newsletter')

INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('Gift Certificate Purchase','<p>Thanks for your purchase of a gift certificate from %SiteName%! Just enter the code when you are checking out to receive credits towards your purchase.</p>
<p>%Mergecontent%</p>','%SiteName% Gift Certificate Purchase',NULL,1,'GiftCertPurchase')

INSERT INTO "MailText"("MailText_Name","MailText_Message","MailText_Subject","MailText_Attachment","System","MailAction")
	VALUES ('New Affiliate Admin Notification','A new affiliate has registered on %SiteName%:
<br><br>%MergeContent%','New Affiliate Registration on',NULL,1,'NewAffiliateNotice')
	;
	

UPDATE "Memberships" SET
"Recur_Product_ID" = 0,
"Next_Membership_ID" = 0,
"Recur" = 0
	;
	
UPDATE "Order_No" SET
"InvDone" = 1,
"CodesSent" = 1,
"Freight" = 0
	;

UPDATE "Pages" SET 
	"PageAction" = 'home'
	WHERE "Page_ID" = 1
UPDATE "Pages" SET 
	"PageAction" = 'manager'
	WHERE "Page_ID" = 2
UPDATE "Pages" SET 
	"PageAction" = 'basket',
	"TitleTag" = 'Shopping Cart'
	WHERE "Page_ID" = 3
UPDATE "Pages" SET 
	"PageAction" = 'search'
	WHERE "Page_ID" = 4
UPDATE "Pages" SET 
	"Page_URL" = 'index.cfm?fuseaction=page.searchresults',
	"PageAction" = 'searchResults'
	WHERE "Page_ID" = 5
UPDATE "Pages" SET 
	"Page_URL" = 'index.cfm?fuseaction=page.new',
	"PageAction" = 'new'
	WHERE "Page_ID" = 6
UPDATE "Pages" SET 
	"Page_URL" = 'index.cfm?fuseaction=page.membersOnly',
	"PageAction" = 'membersOnly',
	"Keywords" = 'members, login',
	"TitleTag" = 'Members Only Page'
	WHERE "Page_ID" = 7
UPDATE "Pages" SET 
	"Page_URL" = 'index.cfm?fuseaction=page.contactUs',
	"PassParam" = 'noline=1,BoxTitle=Email Us',
	"PageAction" = 'contactUs'
	WHERE "Page_ID" = 8
UPDATE "Pages" SET 
	"Page_URL" = 'index.cfm?fuseaction=page.sitemap',
	"PageAction" = 'sitemap'
	WHERE "Page_ID" = 9
UPDATE "Pages" SET 
	"PageAction" = 'wishlist'
	WHERE "Page_ID" = 10
UPDATE "Pages" SET 
	"Page_URL" = 'index.cfm?fuseaction=page.cvv2help',
	"PageAction" = 'cvv2help'
	WHERE "Page_Name" = 'cvv2help'
UPDATE "Pages" SET 
	"Page_URL" = 'index.cfm?fuseaction=page.receipt',
	"PageAction" = 'receipt'
	WHERE "Page_Name" = 'receipt'
	;	
	
INSERT INTO "Permission_Groups"("Name")
	VALUES ('Access')
INSERT INTO "Permission_Groups"("Name")
	VALUES ('Category')
INSERT INTO "Permission_Groups"("Name")
	VALUES ('Feature')
INSERT INTO "Permission_Groups"("Name")
	VALUES ('Product')
INSERT INTO "Permission_Groups"("Name")
	VALUES ('Shopping')
INSERT INTO "Permission_Groups"("Name")
	VALUES ('Users')
INSERT INTO "Permission_Groups"("Name")
	VALUES ('Page')
	;


INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (1,'Assign Permissions',1)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (1,'Manage Access Keys',2)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (1,'Manage Memberships',4)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (2,'Category Admin',1)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (3,'Feature Admin',1)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (3,'Feature Editor',2)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (3,'Feature Author',4)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (4,'Full Product Admin',1)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (4,'User Products Admin',2)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (4,'Discount Admin',4)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (4,'Promotion Admin',8)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (5,'Cart Admin',1)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (5,'Order Access',2)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (5,'Gift Certs Admin',4)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (5,'Order Approve',8)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (5,'Order Process',16)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (5,'Order Dropship',32)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (5,'Order Edit',64)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (5,'Order Reports',128)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (6,'Site Admin',1)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (6,'Admin Menu',2)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (6,'Group & User Admin',4)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (6,'User Export',8)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (7,'Page Admin',1)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (4,'Product Import',16)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (4,'Product Export',32)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (4,'Site Feeds',128)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (5,'Order Search',256)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (4,'Product Reviews',64)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (3,'Feature Reviews',8)
INSERT INTO "Permissions"("Group_ID","Name","BitValue")
	VALUES (5,'Gift Registry Admin',512)
	;
	

UPDATE "PickLists" SET 
	"GiftRegistry_Type" = 'wedding,christmas,birthday,baby',
	"Review_Editorial" = 'Editor,Spotlight'
	;
	
UPDATE "Products" SET 
	"Reviewable" = 0,
	"UseforPOTD" = 0,
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
	
UPDATE "Products" SET 
	"Reviewable" = 1,
	"UseforPOTD" = 1,
	"GiftWrap" = 1
	WHERE "Prod_Type" = 'product'
	;
	
UPDATE "Settings" SET 
	"SizeUnit" = 'Inches',
	"CurrExchange" = 'None',
	"CurrExLabel" = NULL,
	"UseSES" = 0,
	"Default_Fuseaction" = 'page.home',
	"Editor" = 'Default',
	"ProductReviews" = 0,
	"ProductReview_Approve" = 0,
	"ProductReview_Flag" = 0,
	"ProductReview_Add" = 1,
	"ProductReview_Rate" = 1,
	"ProductReviews_Page" = 3,
	"FeatureReviews" = 0,
	"FeatureReview_Add" = 1,
	"FeatureReview_Flag" = 0,
	"FeatureReview_Approve" = 0,
	"GiftRegistry" = 0
	;

UPDATE "ShipSettings" SET 
	"InStorePickup" = 0,
	"ShowEstimator" = 0,
	"ShowFreight" = 0,
	"UseDropShippers" = 0
	;
	
UPDATE "StdAddons" SET 
	"User_ID" = 0
	;
	
UPDATE "StdOptions" SET 
	"User_ID" = 0
	;
	
INSERT INTO "TaxCodes"("CodeName","DisplayName","CalcOrder","Cumulative","TaxAddress","TaxAll","TaxRate","TaxShipping","ShowonProds")
	VALUES ('Taxes','Taxes',0,0,'Shipping',0,0,0,0)
	;
	
UPDATE "LocalTax" SET 
	"Code_ID" = 1
	;
	
INSERT INTO "UPS_Origins"("UPS_Code","Description","OrderBy")
	VALUES ('CA','Canada',2)
INSERT INTO "UPS_Origins"("UPS_Code","Description","OrderBy")
	VALUES ('EU','European Union',5)
INSERT INTO "UPS_Origins"("UPS_Code","Description","OrderBy")
	VALUES ('MX','Mexico',4)
INSERT INTO "UPS_Origins"("UPS_Code","Description","OrderBy")
	VALUES ('OO','All Other Origins',6)
INSERT INTO "UPS_Origins"("UPS_Code","Description","OrderBy")
	VALUES ('PR','Puerto Rico',3)
INSERT INTO "UPS_Origins"("UPS_Code","Description","OrderBy")
	VALUES ('US','United States',1)
	;
	
INSERT INTO "UPS_Packaging"("UPS_Code","Description")
	VALUES ('01','UPS Letter')
INSERT INTO "UPS_Packaging"("UPS_Code","Description")
	VALUES ('02','Your Package')
INSERT INTO "UPS_Packaging"("UPS_Code","Description")
	VALUES ('03','UPS Tube')
INSERT INTO "UPS_Packaging"("UPS_Code","Description")
	VALUES ('04','UPS Pak')
INSERT INTO "UPS_Packaging"("UPS_Code","Description")
	VALUES ('21','UPS Express Box')
INSERT INTO "UPS_Packaging"("UPS_Code","Description")
	VALUES ('24','UPS 25kg Box')
INSERT INTO "UPS_Packaging"("UPS_Code","Description")
	VALUES ('25','UPS 10Kg Box')
	;

INSERT INTO "UPS_Pickup"("UPS_Code","Description")
	VALUES ('01','Daily Pickup')
INSERT INTO "UPS_Pickup"("UPS_Code","Description")
	VALUES ('03','Customer Counter')
INSERT INTO "UPS_Pickup"("UPS_Code","Description")
	VALUES ('11','Suggested Retail Rates (UPS Store)')
	;
	
UPDATE "UPS_Settings" SET 
	"Origin" = 'US',
	"MaxWeight" = 150,
	"UnitsofMeasure" = 'LBS/IN',
	"CustomerClass" = '01',
	"Pickup" = '01',
	"Packaging" = '02',
	"OrigZip" = '00000',
	"OrigCity" = '',
	"OrigCountry" = 'US',
	"Debug" = 0,
	"UseAV" = 1,
	"Logging" = 0
	;


INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Next Day Air<sup>&reg;</sup>','01','00','00','01','00','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('2nd Day Air<sup>&reg;</sup>','02','00','00','02','00','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Ground','03','00','00','03','00','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Worldwide Express<sup><small>SM</small></sup>','07','00','07','07','00','07',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Worldwide Expedited<sup><small>SM</small></sup>','08','00','08','08','00','08',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Express','00','07','00','00','07','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Expedited','00','08','00','00','08','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Standard','11','11','11','00','00','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('3 Day Select<sup><small>SM</small></sup>','12','00','12','00','00','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Next Day Air Saver<sup>&reg;</sup>','13','00','00','00','00','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Express Saver','00','65','13','00','00','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Next Day Air<sup>&reg;</sup> Early A.M.<sup>&reg;</sup>','14','00','00','14','00','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Express Early A.M.','00','00','14','00','00','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Worldwide Express Plus<sup><small>SM</small></sup>','54','54','54','54','00','54',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Express Plus','00','00','00','00','54','00',0,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('2nd Day Air A.M.<sup>&reg;</sup>','59','00','00','00','00','00',0,99)
  INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Worldwide Saver<sup><small>SM</small></sup>','65','00','65','65','65','65',1,99)
INSERT INTO "UPSMethods"("Name","USCode","EUCode","CACode","PRCode","MXCode","OOCode","Used","Priority")
	VALUES ('Express Saver<sup><small>SM</small></sup>','00','65','13','00','00','00',0,99)
	;
	
INSERT INTO "USPS_Settings"("UserID","Server","MerchantZip","MaxWeight","Logging","Debug","UseAV")
	VALUES ('userid','http://production.shippingapis.com/ShippingAPI.dll','00000',150,0,0,0)
	;
	
	
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (2,'AL','Albania')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (3,'DZ','Algeria')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (4,'AD','Andorra')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (6,'AI','Anguilla')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (7,'AG','Antigua and Barbuda')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (8,'AR','Argentina')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (10,'AW','Aruba')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (11,'AU','Australia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (12,'AT','Austria')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (14,'AP','Portugal')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (15,'BS','Bahamas')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (16,'BH','Bahrain')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (17,'BD','Bangladesh')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (18,'BB','Barbados')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (19,'BY','Belarus')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (20,'BE','Belgium')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (21,'BZ','Belize')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (22,'BJ','Benin')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (23,'BM','Bermuda')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (25,'BO','Bolivia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (27,'BW','Botswana')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (28,'BR','Brazil')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (29,'VG','British Virgin Islands')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (30,'BN','Brunei Darussalam')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (31,'BG','Bulgaria')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (32,'BF','Burkina Faso')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (34,'BI','Burundi')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (35,'CM','Cameroon')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (36,'CA','Canada')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (37,'CV','Cape Verde')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (38,'KY','Cayman Islands')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (39,'CF','Central African Republic')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (40,'TD','Chad')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (41,'CL','Chile')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (42,'CN','China')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (43,'CO','Colombia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (45,'CG','Congo (Brazzaville),Republic of the')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (47,'CR','Costa Rica')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (48,'CI','Cote d lvoire (Ivory Coast)')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (49,'HR','Croatia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (50,'CY','Cyprus')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (51,'CZ','Czech Republic')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (52,'DK','Denmark')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (53,'DJ','Djibouti')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (54,'DM','Dominica')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (55,'DO','Dominican Republic')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (56,'EC','Ecuador')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (57,'EG','Egypt')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (58,'SV','El Salvador')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (59,'GQ','Equatorial Guinea')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (60,'ER','Eritrea')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (61,'EE','Estonia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (62,'ET','Ethiopia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (64,'FO','Faroe Islands')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (65,'FJ','Fiji')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (66,'FI','Finland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (67,'FR','France')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (68,'GF','French Guiana')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (69,'PF','French Polynesia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (70,'GA','Gabon')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (71,'GM','Gambia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (72,'GE','Georgia, Republic of')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (73,'DE','Germany')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (74,'GH','Ghana')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (75,'GI','Gibraltar')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (77,'GR','Greece')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (78,'GL','Greenland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (79,'GD','Grenada')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (80,'GP','Guadeloupe')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (81,'GT','Guatemala')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (82,'GN','Guinea')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (83,'GW','Guinea-Bissau')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (84,'GY','Guyana')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (85,'HT','Haiti')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (86,'HN','Honduras')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (87,'HK','Hong Kong')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (88,'HU','Hungary')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (89,'IS','Iceland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (90,'IN','India')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (91,'ID','Indonesia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (95,'IL','Israel')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (96,'IT','Italy')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (97,'JM','Jamaica')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (98,'JP','Japan')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (99,'JO','Jordan')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (100,'KZ','Kazakhstan')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (101,'KE','Kenya')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (102,'KI','Kiribati')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (105,'KW','Kuwait')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (106,'KG','Kyrgyzstan')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (107,'LA','Laos')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (108,'LV','Latvia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (109,'LB','Lebanon')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (110,'LS','Lesotho')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (111,'LR','Liberia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (113,'LI','Liechtenstein')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (114,'LT','Lithuania')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (115,'LU','Luxembourg')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (116,'MO','Macao')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (117,'MK','Macedonia, Republic of')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (118,'MG','Madagascar')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (119,'ME','Portugal')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (120,'MW','Malawi')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (121,'MY','Malaysia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (122,'MV','Maldives')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (123,'ML','Mali')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (124,'MT','Malta')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (125,'MQ','Martinique')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (126,'MR','Mauritania')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (127,'MU','Mauritius')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (128,'MX','Mexico')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (129,'MD','Moldova')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (131,'MS','Montserrat')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (132,'MA','Morocco')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (133,'MZ','Mozambique')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (134,'NA','Namibia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (136,'NP','Nepal')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (137,'NL','Netherlands')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (138,'AN','Netherlands Antilles')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (139,'NC','New Caledonia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (140,'NZ','New Zealand')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (141,'NI','Nicaragua')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (142,'NE','Niger')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (143,'NG','Nigeria')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (144,'NO','Norway')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (145,'OM','Oman')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (146,'PK','Pakistan')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (147,'PA','Panama')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (148,'PG','Papua New Guinea')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (149,'PY','Paraguay')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (150,'PE','Peru')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (151,'PH','Philippines')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (153,'PL','Poland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (154,'PT','Portugal')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (155,'QA','Qatar')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (156,'RE','Reunion')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (157,'RO','Romania')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (158,'RU','Russia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (159,'RW','Rwanda')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (163,'VC','St. Vincent and the Grenadines')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (166,'SA','Saudi Arabia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (167,'SN','Senegal')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (169,'SC','Seychelles')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (170,'SL','Sierra Leone')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (171,'SG','Singapore')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (172,'SK','Slovak Republic')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (173,'SI','Slovenia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (174,'SB','Solomon Islands')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (176,'ZA','South Africa')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (177,'ES','Spain')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (178,'LK','Sri Lanka')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (179,'KN','St. Christopher and Nevis')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (181,'SR','Suriname')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (182,'SZ','Swaziland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (183,'SE','Sweden')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (184,'CH','Switzerland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (185,'SY','Syrian Arab Republic')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (186,'TW','Taiwan')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (187,'TJ','Tajikistan')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (188,'TZ','Tanzania')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (189,'TH','Thailand')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (190,'TG','Togo')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (191,'TO','Tonga')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (192,'TT','Trinidad and Tobago')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (194,'TN','Tunisia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (195,'TR','Turkey')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (197,'TC','Turks and Caicos Islands')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (198,'TV','Tuvalu')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (199,'UG','Uganda')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (200,'UA','Ukraine')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (201,'AE','United Arab Emirates')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (202,'US','United States')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (203,'UY','Uruguay')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (204,'UZ','Uzbekistan')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (205,'VU','Vanuatu')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (207,'VE','Venezuela')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (208,'VN','Vietnam')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (209,'WF','Wallis and Futuna Islands')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (210,'WS','Western Samoa')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (212,'CD','Congo, Democratic Republic of the')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (213,'ZM','Zambia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (214,'ZW','Zimbabwe')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (215,'AS','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (216,'KH','Cambodia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (217,'BL','Netherlands Antilles')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (218,'CE','Spain')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (219,'NN','Great Britain and Northern Ireland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (220,'CK','New Zealand')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (221,'CB','Netherlands Antilles')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (222,'EN','Great Britain and Northern Ireland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (223,'GU','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (224,'KO','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (225,'MH','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (226,'MC','France')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (227,'MM','Burma')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (228,'NF','Australia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (229,'NB','Great Britain and Northern Ireland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (230,'MP','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (231,'PW','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (232,'PO','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (234,'IE','Ireland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (235,'RT','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (236,'SS','Netherlands Antilles')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (237,'SP','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (238,'SF','Great Britain and Northern Ireland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (239,'NT','Guadeloupe')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (240,'SW','St. Christopher and Nevis')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (241,'SX','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (242,'EU','Netherlands Antilles')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (243,'UV','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (244,'LC','St. Lucia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (245,'MB','Netherlands Antilles')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (246,'TB','Guadeloupe')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (247,'VL','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (248,'KR','Korea, Republic of (South Korea)')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (249,'TA','French Polynesia')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (250,'TU','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (252,'VI','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (253,'WK','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (254,'WL','Great Britain and Northern Ireland')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (255,'YA','US Possession')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (256,'BA','Bosnia-Herzegovina')
INSERT INTO "USPSCountries"("ID","Abbrev","Name")
	VALUES (257,'GB','Great Britain and Northern Ireland')
	;
	

INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Priority Mail w/Dlvr. Conf.',1,'Priority Mail','Domestic',1)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Parcel Post w/Dlvr. Conf.',1,'Parcel Post','Domestic',2)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Express Mail',1,'Express Mail PO','Domestic',3)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Express Mail PO',1,'Express Mail PO to Addressee','Domestic',4)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Express Mail PO',1,'Express Mail PO to PO','Domestic',5)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('First Class',1,'First-Class Mail','Domestic',6)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('First Class Parcel',1,'First-Class Mail Parcel','Domestic',7)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('First Class Flat',0,'First-Class Mail Flat','Domestic',8)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Priority Mail Flat-Rate Box',0,'Priority Mail Flat-Rate Box','Domestic',9)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Bound Printed Matter',0,'Bound Printed Matter','Domestic',99)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Media Mail',0,'Media Mail','Domestic',99)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Library Mail',0,'Library Mail','Domestic',99)	
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Global Express Guaranteed',1,'Global Express Guaranteed','International',99)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Express Mail Intl.',1,'Express Mail International (EMS)','International',99)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Express Mail Int Flat Rate Env',0,'Express Mail International (EMS) Flat Rate Envelope','International',99)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Priority Mail Intl.',1,'Priority Mail International','International',99)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Priority Mail Intl Flat Rate Env',0,'Priority Mail International Flat Rate Envelope','International',99)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('Priority Mail Intl Flat Rate Box',0,'Priority Mail International Flat Rate Box','International',99)
INSERT INTO "USPSMethods"("Name","Used","Code","Type","Priority")
	VALUES ('First-Class Mail Intl',1,'First-Class Mail International','International',99)
	;
	
UPDATE "Users" SET 
	"FailedLogins" = 0,
	"Disable" = 0,
	"LastAttempt" = GetDate(),
	"LoginsDay" = 0,
	"LoginsTotal" = 0,	
	"CardisValid" = IsActive
	;
	
	
DELETE FROM "TempBasket"
;
DELETE FROM "TempCustomer"
;
DELETE FROM "TempOrder"
;
DELETE FROM "TempShipTo"
;

	
COMMIT TRANSACTION

