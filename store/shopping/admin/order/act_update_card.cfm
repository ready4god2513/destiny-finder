<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page takes the full credit card data and updates it to only save the last 4 digits. Called from act_order.cfm and act_order_shipping.cfm --->

<!--- Remove full credit card information --->
<cfquery name="GetCard" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT Card_ID FROM #Request.DB_Prefix#Order_No 
WHERE Order_No = #attributes.Order_No#
</cfquery>        

<cfquery name="GetCardData" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#CardData
SET EncryptedCard = Null
WHERE ID = #Getcard.Card_ID#
</cfquery>





