
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to add and delete related features for a feature. Called by feature.admin&feature=related --->

<cfif isdefined("attributes.submit_related")>

	<cfif attributes.submit_related is "Add Features" and isdefined("attributes.add_related") and attributes.add_related is not "">
	
		<cfloop index="thisID" list="#attributes.add_related#">
			
			<!--- Confirm that Feature is not already there ---->
			<cfquery name="check_relations"  datasource="#Request.ds#" 
			username="#Request.user#" password="#Request.pass#">
			SELECT Feature_Item_ID
			FROM #Request.DB_Prefix#Feature_Item
			WHERE Item_ID = #attributes.Feature_ID#
			AND Feature_ID = #thisID#
			</cfquery>		
		
			<cfif check_relations.recordcount is 0>
				
				<cfquery name="Add_Related" datasource="#Request.ds#" 
				username="#Request.user#"  password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#Feature_Item
				(Feature_ID, Item_ID)
				VALUES(#thisID#, #attributes.Feature_ID#)
				</cfquery>
		
			</cfif>
			
		</cfloop>
		
	<cfelseif IsNumeric(attributes.submit_related)>
	
		<cfquery name="delete_related"  datasource="#Request.ds#" 
		username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Feature_Item
		WHERE Item_ID = #attributes.Feature_ID#
		AND Feature_ID = #submit_related#
		</cfquery>			
	
	</cfif>

</cfif>
				
				

				
				
				
				
				
				
				

				
				
