
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to add and delete related products for a product. Called by product.admin&do=related --->

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
	
	<cfif isdefined("attributes.submit_related")>
	
		<cfif attributes.submit_related is "Add Products"  AND isDefined("attributes.add_related") and attributes.add_related is not "">
		
			<cfloop index="thisID" list="#attributes.add_related#">
				
				<!--- Confirm that product is not already there ---->
				<cfquery name="check_relations"  datasource="#Request.ds#" 
				username="#Request.user#" password="#Request.pass#">
				SELECT Product_Item_ID
				FROM #Request.DB_Prefix#Product_Item
				WHERE 
					Item_ID = #attributes.Product_ID#
					AND Product_ID = #thisID#
				</cfquery>		
			
				<cfif check_relations.recordcount is 0>
					
					<cfquery name="Add_Related" datasource="#Request.ds#" 
					username="#Request.user#"  password="#Request.pass#">
					INSERT INTO #Request.DB_Prefix#Product_Item
					(Product_ID, Item_ID)
					VALUES(#thisID#, #attributes.Product_ID#)
					</cfquery>
			
				</cfif>
				
			</cfloop>
			
		<cfelseif IsNumeric(attributes.submit_related)>
		
			<cfquery name="delete_related"  datasource="#Request.ds#" 
			username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Product_Item
			WHERE 
				Item_ID = #attributes.Product_ID#
				AND Product_ID = #submit_related#
			</cfquery>			
		
		</cfif>
	
	</cfif>
				
</cfif>		

