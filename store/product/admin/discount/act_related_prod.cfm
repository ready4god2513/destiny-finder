
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to add and delete related products for a discount. Called by product.admin&discount=products --->

<cfif isdefined("attributes.submit_related")>

	<cfif attributes.submit_related is "Add Products" and isdefined("attributes.add_related") and attributes.add_related is not "">
	
		<cfloop index="thisID" list="#attributes.add_related#">
			
			<!--- Confirm that product is not already there ---->
			<cfquery name="check_relations"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			SELECT Product_ID
			FROM #Request.DB_Prefix#Discount_Products
			WHERE Discount_ID = #attributes.discount_ID#
			AND Product_ID = #thisID#
			</cfquery>		
		
			<cfif check_relations.recordcount is 0>
				
				<cfquery name="Add_Related" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#Discount_Products
				(Discount_ID, Product_ID)
				VALUES(#attributes.discount_id#, #thisID#)
				</cfquery>
				
				<!--- Update discount list for the product --->	
				<cfinvoke component="#Request.CFCMapping#.shopping.discounts" 
					method="updProdDiscounts" Product_ID="#thisID#">
		
			</cfif>
			
		</cfloop>
		
	<cfelseif IsNumeric(attributes.submit_related)>
	
		<cfquery name="delete_related"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Discount_Products
		WHERE Discount_ID = #attributes.discount_ID#
		AND Product_ID = #submit_related#
		</cfquery>		
		
		<!--- Update discount list for the product --->	
		<cfinvoke component="#Request.CFCMapping#.shopping.discounts" 
			method="updProdDiscounts" Product_ID="#submit_related#">
	
	</cfif>

</cfif>
				


				
				
				
				
				
				
				

				
				
