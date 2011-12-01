
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to add and delete related categories for a discount. Called by product.admin&discount=categories --->

<cfif isdefined("attributes.submit_related")>

	<cfif attributes.submit_related is "Add Categories" and isdefined("attributes.add_related") and attributes.add_related is not "">
	
		<cfloop index="thisID" list="#attributes.add_related#">
			
			<!--- Confirm that category is not already in the table ---->
			<cfquery name="check_relations"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			SELECT Category_ID
			FROM #Request.DB_Prefix#Discount_Categories
			WHERE Discount_ID = #attributes.discount_ID#
			AND Category_ID = #thisID#
			</cfquery>		
		
			<cfif check_relations.recordcount is 0>
				
				<cfquery name="Add_Related" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#Discount_Categories
				(Discount_ID, Category_ID)
				VALUES(#attributes.discount_id#, #thisID#)
				</cfquery>
		
			</cfif>
			
			<!--- Update the discounts for products in this category --->
			<cfset attributes.CID = thisID>
			<cfinclude template="../../../category/admin/act_update_proddiscounts.cfm">
			
		</cfloop>
		
	<cfelseif IsNumeric(attributes.submit_related)>
	
		<cfquery name="delete_related"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Discount_Categories
		WHERE Discount_ID = #attributes.discount_ID#
		AND Category_ID = #submit_related#
		</cfquery>			
		
		<!--- Update the discounts for products in this category --->
		<cfset attributes.CID = submit_related>
		<cfinclude template="../../../category/admin/act_update_proddiscounts.cfm">
	
	</cfif>

</cfif>
				


				
				
				
				
				
				
				

				
				
