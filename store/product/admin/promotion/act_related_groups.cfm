
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to add and delete related user groups for a promotion. Called by product.admin&promotion=groups --->

<cfif isdefined("attributes.submit_related")>

	<cfif attributes.submit_related is "Add Groups" and isdefined("attributes.add_related") and attributes.add_related is not "">
	
		<cfloop index="thisID" list="#attributes.add_related#">
			
			<!--- Confirm that category is not already in the table ---->
			<cfquery name="check_relations"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			SELECT Promotion_ID
			FROM #Request.DB_Prefix#Promotion_Groups
			WHERE Promotion_ID = #attributes.Promotion_ID#
			AND Group_ID = #thisID#
			</cfquery>		
		
			<cfif check_relations.recordcount is 0>
				
				<cfquery name="Add_Related" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#Promotion_Groups
				(Promotion_ID, Group_ID)
				VALUES(#attributes.Promotion_ID#, #thisID#)
				</cfquery>
				
				<!----- RESET Promotion Groups query ---->
				<cfinvoke component="#Request.CFCMapping#.shopping.promotions"
		 			method="qryGroupPromotions" Group_ID="#thisID#" reset="yes">
		
			</cfif>
			
		</cfloop>
		
	<cfelseif IsNumeric(attributes.submit_related)>
	
		<cfquery name="delete_related"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Promotion_Groups
		WHERE Promotion_ID = #attributes.Promotion_ID#
		AND Group_ID = #submit_related#
		</cfquery>	
		
		<!----- RESET Promotion Groups query ---->
		<cfinvoke component="#Request.CFCMapping#.shopping.promotions"
		 	method="qryGroupPromotions" Group_ID="#submit_related#" reset="yes">		
	
	</cfif>

</cfif>

			
						


				
				
				
				
				
				
				

				
				
