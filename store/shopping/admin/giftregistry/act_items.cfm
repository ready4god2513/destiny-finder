
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates the Registry Item list. --->

<!--- User Check ----->
<cfloop index="GiftItem_ID" list="#attributes.ItemList#">
<cfset Quantity_Requested = Evaluate("attributes.Quantity_Requested#GiftItem_ID#")>
<cfset Quantity_Purchased = Evaluate("attributes.Quantity_Purchased#GiftItem_ID#")>
<cfset remove = iif(isDefined("attributes.remove#GiftItem_ID#"),1,0)>

<!--- If Remove and nothing purchased, delete item --->
<cfif remove AND NOT Quantity_Purchased>

	<cfquery name="RemoveItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#GiftItems
	WHERE GiftItem_ID = #GiftItem_ID#
	</cfquery>

<!--- Update Item Quantity --->
<cfelse>

	<cfquery name="UpdateItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#GiftItems
	SET 
	Quantity_Requested = #Quantity_Requested#,
	Quantity_Purchased = #Quantity_Purchased#
	WHERE GiftItem_ID = #GiftItem_ID#
	</cfquery>

</cfif>

</cfloop>
			
