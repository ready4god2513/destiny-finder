<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for the product group prices: add, update, delete. Called by product.admin&do=grp_price --->

<cfif isdefined("attributes.Submit_price") and attributes.GID IS NOT 0>

	<cfif NOT len(Trim(attributes.Price))>
		<cfset Price = 0>
	<cfelse>
		<!--- Replaced for Blue Dragon 
		<cfset Price = LSParseNumber(attributes.Price)> ---->
		<cfset Price = attributes.Price>
	</cfif>


	<cfif attributes.GrpPrice_ID is "0">
	
		<cftransaction isolation="SERIALIZABLE">
			<cfquery name="getID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT MAX(GrpPrice_ID) AS maxid
				FROM #Request.DB_Prefix#ProdGrpPrice 
				WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.product_ID#">
			</cfquery>
			
			<cfquery name="AddPrice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#ProdGrpPrice 
				(GrpPrice_ID, Product_ID, Group_ID, Price)
				VALUES 
				(#iif(isNumeric(getID.maxid), Evaluate(DE('getID.maxid+1')), 1)#,
					#attributes.Product_id#, #attributes.GID#, #Price#)
			</cfquery>
		</cftransaction>
	
	<cfelse>
		
		<cfquery name="UpdatePrice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#ProdGrpPrice
			SET
			Group_ID = #attributes.GID#,
			Price = #Price#
			WHERE GrpPrice_ID = #attributes.GrpPrice_ID#
			AND Product_ID = #attributes.Product_id#
		</cfquery>
		
	</cfif>
	
<cfelseif isdefined("attributes.delete")>

	<cfquery name="delete_record"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#ProdGrpPrice
		WHERE GrpPrice_ID = #attributes.delete#
		AND Product_ID = #attributes.Product_id#
	</cfquery>
</cfif>


