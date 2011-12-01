
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to add and delete related products for a feature. Called by feature.admin&feature=related_prod --->

<cfif isdefined("attributes.submit_related")>

	<cfif attributes.submit_related is "Add Products" and isdefined("attributes.add_related") and attributes.add_related is not "">
	
		<cfloop index="thisID" list="#attributes.add_related#">
			
			<!--- Confirm that product is not already there ---->
			<cfquery name="check_relations"  datasource="#Request.ds#" 
			username="#Request.user#" password="#Request.pass#">
			SELECT Feature_Product_ID
			FROM #Request.DB_Prefix#Feature_Product
			WHERE Feature_ID = #attributes.feature_ID#
			AND Product_ID = #thisID#
			</cfquery>		
		
			<cfif check_relations.recordcount is 0>
				
				<cfquery name="Add_Related" datasource="#Request.ds#" 
				username="#Request.user#"  password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#Feature_Product
				(Feature_ID, Product_ID)
				VALUES(#attributes.feature_id#, #thisID#)
				</cfquery>
		
			</cfif>
			
		</cfloop>
		
	<cfelseif IsNumeric(attributes.submit_related)>
	
		<cfquery name="delete_related"  datasource="#Request.ds#" 
		username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Feature_Product
		WHERE Feature_ID = #attributes.feature_ID#
		AND Product_ID = #submit_related#
		</cfquery>			
	
	</cfif>

</cfif>
				


				
				
				
				
				
				
				

				
				
