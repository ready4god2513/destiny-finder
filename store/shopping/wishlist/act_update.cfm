
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates the wishlist with the user comments and desired quantities or deletes selected items. Called by shopping.wishlist --->

<!--- Make sure user is still logged in --->

<!--- Check if update, if not, check which item to delete --->

<cfif NOT isDefined("attributes.Update")>

	<cfloop index="ProdID" list="#attributes.ProdList#">
	
		<cfif isDefined(Evaluate(DE("attributes.Delete#ProdID#")))>
		<!--- Delete this product from the wishlist --->
		
			<cfquery name="DeleteProd" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
			DELETE FROM #Request.DB_Prefix#WishList
			WHERE ListNum = 1
			AND User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
			AND Product_ID = <cfqueryparam value="#ProdID#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
		
		</cfif>
	
	</cfloop>

</cfif>

<!--- Loop through the list and update all the fields --->
<cfloop index="ProdID" list="#attributes.ProdList#">
	<cfif StructKeyExists(attributes, 'NumDesired' & ProdID)>
		<!--- Update product's information on the wishlist --->
		
			<cfset NumDesired = attributes['NumDesired' & ProdID]>
			<cfset Comments = attributes['Comment' & ProdID]>
			
			<cfif NOT isNumeric(NumDesired)>
				<cfset NumDesired = 1>
			</cfif> 
		
			<cfquery name="UpdateProd" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
			UPDATE #Request.DB_Prefix#WishList
			SET NumDesired = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#NumDesired#">,
			Comments = <cfqueryparam  cfsqltype="CF_SQL_LONGVARCHAR" value="#Comments#" null="#YesNoFormat(NOT len(Comments))#">
			WHERE ListNum = 1
			AND User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
			AND Product_ID = <cfqueryparam value="#ProdID#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
		
		</cfif>

</cfloop>

<!--- present confirmation if updating, not deleting --->
<cfif isDefined("attributes.Update")>

<script type="text/javascript">
	alert('Wishlist Updated!')
</script>
	
</cfif>

