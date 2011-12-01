
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for the product quantity discounts: add, update, delete. Called by product.admin&do=Qty_Discounts --->

<!--- Check user's access level --->
<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<!--- if not full product admin, make sure they have access to this product --->
<cfif NOT ispermitted>
	<cfmodule template="../../../access/useraccess.cfm" ID="#attributes.Product_ID#">
	<cfset editproduct = useraccess>
<cfelse>
	<cfset editproduct = "yes">
</cfif>

<cfif editproduct>	
	
	<cfif isdefined("attributes.Submit_discount")>
	
		<cfset Discountper = iif(isNumeric(attributes.Discountper), attributes.Discountper, 0)>	
	
		<cfif attributes.prodDisc_ID is 0>
	
			<cftransaction isolation="SERIALIZABLE">
				<cfquery name="getID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					SELECT MAX(ProdDisc_ID) AS maxid
					FROM #Request.DB_Prefix#ProdDisc 
					WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.product_ID#">
					</cfquery>
					
				<cfquery name="AddDiscount" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					INSERT INTO #Request.DB_Prefix#ProdDisc 
					(ProdDisc_ID, Product_ID, Wholesale, QuantFrom, QuantTo, DiscountPer)
					VALUES 
					(#iif(isNumeric(getID.maxid), Evaluate(DE('getID.maxid+1')), 1)#,
					#attributes.Product_id#, #attributes.Wholesale#,
					 #attributes.Quantfrom#, #attributes.Quantto#, #Discountper#)
				</cfquery>
			</cftransaction>
		
		<cfelse>
			
			<cfquery name="UpdateDiscount" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#ProdDisc
				SET
				Wholesale = #attributes.Wholesale#,
				QuantFrom = #attributes.Quantfrom#,
				QuantTo = #attributes.Quantto#,
				DiscountPer = #Discountper#
				WHERE ProdDisc_ID = #attributes.prodDisc_ID#
				AND Product_ID = #attributes.Product_id#
			</cfquery>
			
		</cfif>
		
	<cfelseif isdefined("attributes.delete")>
	
		<cfquery name="delete_record"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#ProdDisc
			WHERE ProdDisc_ID = #attributes.delete#
			AND Product_ID = #attributes.Product_id#
		</cfquery>
	</cfif>


</cfif>