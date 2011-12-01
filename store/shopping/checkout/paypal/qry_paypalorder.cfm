
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieve the Order Number for the complete PayPal transaction. Called by do_checkout.cfm --->

<!--- Get the order information --->
<cfquery name="GetOrderNum" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Order_No FROM #Request.DB_Prefix#Order_No
WHERE (AuthNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AuthNumber#">
		OR TransactNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AuthNumber#">)
</cfquery>

<cfif GetOrderNum.RecordCount IS 0>

	<cfset Webpage_title = "Checkout Error">
	<cfset message = "Sorry, there does not appear to be an order with this number in the database.">

<cfelse>
	
	<!--- Check for downloads --->
	<cfquery name="CheckDownloads" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT OI.Product_ID FROM #Request.DB_Prefix#Order_Items OI, #Request.DB_Prefix#Products P
		WHERE OI.Order_No = #GetOrderNum.Order_No#
		AND OI.Product_ID = P.Product_ID
		AND P.Prod_Type = 'download'		
	</cfquery>

</cfif>

