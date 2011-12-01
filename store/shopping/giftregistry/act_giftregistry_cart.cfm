
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template adds content of gift registry to the cart --->

<!--- Loop through the registry items --->
<cfloop index="num" list="#attributes.ItemList#">

	<!--- Fulfilled items will not have form field --->
	<cfparam name="attributes.Quantity_Add#num#" default="">

	<!--- If Quantity then add to cart --->
	<cfif isNumeric(attributes['Quantity_Add' & num])>

	 	<cfset attributes.Quantity = attributes['Quantity_Add' & num]>
		
	 	<!--- Look up the item --->
		<cfquery name="Item" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
			SELECT * FROM #Request.DB_Prefix#GiftItems
			WHERE GiftItem_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#num#">
		</cfquery>
	 
		<!--- Add item to the basket --->
	 	<cfif Item.Recordcount>
		
			<!--- Move the item information into attributes scope --->
			<cfloop index="fieldname" list="#Item.ColumnList#">
				<cfset attributes[fieldname] = Item[fieldname][1]>
			</cfloop> 
			
			<cfset Application.objCart.doAddCartItem(argumentcollection=attributes)>
			
		</cfif>
		
	</cfif>
	
</cfloop>

