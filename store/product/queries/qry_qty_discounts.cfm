
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the quantity discounts for a product. Called by product.qty_discount --->

<cfparam name="attributes.product_id" default="0">

<cfquery name="qry_qty_Discounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#ProdDisc
WHERE Product_ID = <cfqueryparam value="#attributes.Product_ID#" cfsqltype="CF_SQL_INTEGER">
AND Wholesale = <cfqueryparam value="#session.wholesaler#" cfsqltype="#Request.SQL_Bit#">
</cfquery>



