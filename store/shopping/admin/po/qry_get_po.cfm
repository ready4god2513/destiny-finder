
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for a specific purchase order. Called by shopping.admin&po=edit|add and from dsp_po_print.cfm --->

<cfquery name="qry_get_po"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT O.Order_PO_ID, O.Order_No, O.PO_No, O.Account_ID, O.PrintDate, O.Notes,
	O.PO_Status, O.PO_Open, O.ShipDate, O.Shipper, O.Tracking, N.Customer_ID, N.ShipTo, N.ShipType, 
	A.Account_Name, A.PO_Text, A.Dropship_Email
	FROM #Request.DB_Prefix#Order_PO O, #Request.DB_Prefix#Order_No N, #Request.DB_Prefix#Account A
	WHERE O.Order_PO_ID = #attributes.order_po_ID#
	AND O.Order_No = N.Order_No
	AND O.Account_ID = A.Account_ID
</cfquery>
		
<cfquery name="qry_get_po_items"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#Order_Items
	WHERE Order_No = #qry_get_po.order_no#
	AND Dropship_Account_ID = #qry_get_po.account_id#
</cfquery>


	
