
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to update the cached queries with the promotion data set by group. Called by product.admin&promotion=act --->

<cfquery name="get_groups"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT Group_ID FROM #Request.DB_Prefix#Groups
</cfquery>		

<cfloop query="get_groups">

	<!----- RESET Promotion Groups query ---->
	<cfset Application.objPromotions.qryGroupPromotions(get_groups.Group_ID, 'yes')>

</cfloop>
	
<!----- RESET Promotion Groups query for un-logged in visitors ---->
<cfset Application.objPromotions.qryGroupPromotions(0, 'yes')>

			
				
