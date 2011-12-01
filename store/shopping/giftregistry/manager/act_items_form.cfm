
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates the Registry Item list. --->

<!--- User Check ----->
<cfloop index="GiftItem_ID" list="#attributes.ItemList#">

<cfset Quantity_Add = Evaluate("attributes.Quantity_Add#GiftItem_ID#")>
<cfset Quantity_Requested = Evaluate("attributes.Quantity_Requested#GiftItem_ID#")>
<cfset Quantity_Purchased = Evaluate("attributes.Quantity_Purchased#GiftItem_ID#")>
<cfset remove = iif(isDefined("attributes.remove#GiftItem_ID#"),1,0)>

<!--- Check if this is a recurring item and still found in the database --->
<cfquery name="qry_check_recur" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT P.Recur FROM #Request.DB_Prefix#GiftItems G, #Request.DB_Prefix#Products P
WHERE G.GiftItem_ID = <cfqueryparam value="#GiftItem_ID#" cfsqltype="CF_SQL_INTEGER">
AND G.Product_ID = P.Product_ID
</cfquery>

<cfif NOT qry_check_recur.Recordcount>
	<cfset remove = 1>
<cfelseif qry_check_recur.recur>
	<cfset Quantity_Add = 0>
</cfif>
	
<!--- If Remove and nothing purchased, delete item --->
<cfif remove AND NOT Quantity_Purchased>

	<cfquery name="RemoveItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#GiftItems
	WHERE GiftItem_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GiftItem_ID#">
	</cfquery>

<!--- Update Item Quantity --->
<cfelseif remove OR len(Quantity_Add)>

	<cfif Remove>
		<cfset NewQuantity = Quantity_Purchased>
	<cfelse>
		<cfset NewQuantity = Quantity_Requested + Quantity_Add>
	</cfif>	

	<cfquery name="UpdateItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#GiftItems
	SET 
	Quantity_Requested = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#NewQuantity#">
	WHERE GiftItem_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GiftItem_ID#">
	</cfquery>

</cfif>

</cfloop>
			
