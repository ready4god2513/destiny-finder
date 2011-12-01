<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!--- Outputs a QuickBooks and/or Order Export data feed 

attributes:
	index.cfm?fuseaction=shopping.admin &order=download &
		FromOrder=	 LAST or #: All orders greater than and including FromOrder
		ToOrder=
		FromDate=
		ToDate=

Here are the fields saved per order:

  OrderTotal =  Sum of all Extended Price of Cart Items (see below)
  + AddonTotal
  - OrderDisc
  + Tax
  + Shipping
  - Credits
  - AdminCredit 

Each product line is calculated as:

	Extended price of Cart Item = ((Price + AddonMultP - DiscAmount) * Quantity)]
  
The Data Fields:  
  
Order_No 				A sequential order number
DateOrdered             Date/Time field
InvoiceNum                          
Affiliate           	Used for Affiliate program, probably not for QuickBooks
OrderTotal              $   Amount after all calculations (amount billed to card)
AddonTotal              $   A debit adjustment to order total pre-shipping & tax
OrderDisc               $   Order discount amount
Tax                     $   Amount of tax charged
Shipping                $   Amount charged for shipping
ShipType                (ex: "UPS Ground (Residential)")
Credits                 $          
Coupon_Code             Text "code" of any coupon used
Cert_Code               Text "code" of any gift certificate used to pay for order. 
AdminCredit             $   An additional credit adjustment by Admin after order is placed
AdminCreditText         Text description of AdminCredit
GiftCard                Customer comment - gift card text
Delivery                Customer defined - deliver by/on
Comments                Customer comment - from checkout
offlinePayment          Type of payment: "Online","PayPal","OffLine"(check, on account, etc.) 
CardType                Mastercard,Visa,etc.
NameonCard
CardNumber				CC Number (last 4 digits only)
Expires                 Date
AuthNumber              Credit card authorization code
TransactNum             Credit card transaction number
Paid                    y/n - Flag indictating if order was paid for.
Void                    y/n
Customer_ID             ID number of Address record

Billto_FirstName
Billto_LastName
Billto_Company
Billto_Address1
Billto_Address2
Billto_City
Billto_State			Either state or state2
Billto_Zip
Billto_Country
Billto_Phone
Billto_Phone2
Billto_Fax
Billto_Email
Billto_Resident         Residential/Commercial flag

ShipTo                  ID number of Address record
Shipto_FirstName
Shipto_LastName
Shipto_Company
Shipto_Address1
Shipto_Address2
Shipto_City
Shipto_State			either State or State2
Shipto_Zip
Shipto_Country
Shipto_Phone
Shipto_Phone2
Shipto_Fax
Shipto_Email
Shipto_Resident          Residential/Commercial flag

Product_ID
SKU
Name
Options                  Text description of product modifiers (size:XL; color:red)
Addons                   Text description of product addons (+ extended warranty)
Price                    $   Unit Price including cost of options
AddonMultP               $   Debit adjustment on price
DiscAmount               $   Credit adjustment (Discount) on price
Quantity
----->


<!---- PROCESS FORM ----->
<cfif cgi.request_method is "post">
	
	<cfinclude template="qry_order_download.cfm">
	
	<cfparam name="attributes.downloadformat" default="orderline">
	<cfinclude template="act_download_#attributes.downloadformat#.cfm">

<!--- Do Download ---->
<cfelse>

	<!--- Read the last order number from file --->
	<cfinclude template="act_lastordernumber.cfm">
	
	<cfinclude template="dsp_download_form.cfm">

</cfif>
