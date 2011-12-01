
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to add and delete related user groups for a discount. Called by product.admin&discount=groups --->

<cfif isdefined("attributes.submit_related")>

	<cfif attributes.submit_related is "Add Groups" and isdefined("attributes.add_related") and attributes.add_related is not "">
	
		<cfloop index="thisID" list="#attributes.add_related#">
			
			<!--- Confirm that group is not already in the table ---->
			<cfquery name="check_relations"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			SELECT Discount_ID
			FROM #Request.DB_Prefix#Discount_Groups
			WHERE Discount_ID = #attributes.discount_ID#
			AND Group_ID = #thisID#
			</cfquery>		
		
			<cfif check_relations.recordcount is 0>
				
				<cfquery name="Add_Related" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#Discount_Groups
				(Discount_ID, Group_ID)
				VALUES(#attributes.discount_id#, #thisID#)
				</cfquery>
				
				<!----- RESET Discount Groups query ---->
				<cfinvoke component="#Request.CFCMapping#.shopping.discounts"
					method="qryGroupDiscounts" Group_ID="#thisID#" reset="yes">
		
			</cfif>
			
		</cfloop>
		
	<cfelseif IsNumeric(attributes.submit_related)>
	
		<cfquery name="delete_related"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Discount_Groups
		WHERE Discount_ID = #attributes.discount_ID#
		AND Group_ID = #submit_related#
		</cfquery>		
		
		<!----- RESET Discount Groups query ---->
		<cfinvoke component="#Request.CFCMapping#.shopping.discounts"
			method="qryGroupDiscounts" Group_ID="#submit_related#" reset="yes">
	
	
	</cfif>

</cfif>
				


				
				
				
				
				
				
				

				
				
