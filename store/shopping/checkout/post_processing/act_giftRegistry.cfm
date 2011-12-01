<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Check to see if cart item was added as part of a gift registry. If so, update registry quantities to reflect purchase. --->

<cfif qry_get_basket.GiftRegistry_ID IS NOT 0>

	<!--- Update Quantity --->
	<cfquery name="UpdateGiftItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#GiftItems
		SET Quantity_Purchased = Quantity_Purchased + <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Quantity#">
		WHERE GiftItem_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.GiftItem_ID#">
	</cfquery>

	<!--- Send Order Notification if Requested ---->
	<cfquery name="EmailInfo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT GR.User_ID, GR.Event_Name, GR.Event_Date, GR.Order_Notification
		FROM #Request.DB_Prefix#GiftItems GI, #Request.DB_Prefix#GiftRegistry GR
		WHERE GI.GiftRegistry_ID = GR.GiftRegistry_ID
		AND GI.GiftItem_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.GiftItem_ID#">
	</cfquery>
	
	<cfif EmailInfo.RecordCount AND EmailInfo.Order_Notification is 1>
	
		<cfset LineBreak = Chr(13) & Chr(10)>
		<cfset Message = "">
	
		<cfset Message =  "Registry: " &  EmailInfo.Event_Name & LineBreak
		&  "Date: " &  EmailInfo.Event_Date & LineBreak & LineBreak
		& "Item: " &  qry_get_basket.Name & LineBreak 
		& "SKU: " &  qry_get_basket.sku & LineBreak 
		& "Quantity: " &  qry_get_basket.Quantity & LineBreak & LineBreak 
		& "Purchased by: " &  GetCustomer.FirstName & " " & GetCustomer.Lastname & LineBreak 
		>
		
		<cftry>

			<cfinvoke component="#Request.CFCMapping#.global" 
				method="sendAutoEmail" UID="#EmailInfo.User_ID#"
				MailAction="GiftRegistryPurchase" MergeContent="#Message#">

			<cfcatch type="ANY">
			</cfcatch>
		</cftry>
	
	</cfif>
	
</cfif>

<cfsetting enablecfoutputonly="no">
