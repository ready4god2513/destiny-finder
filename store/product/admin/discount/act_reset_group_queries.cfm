
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to update the cached queries with the discount data set by group. Called by product.admin&discount=act --->

<cfquery name="get_groups"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT Group_ID FROM #Request.DB_Prefix#Groups
</cfquery>		

<cfloop query="get_groups">

	<!----- RESET Discount Groups query ---->
	<cfset Application.objDiscounts.qryGroupDiscounts(get_groups.Group_ID, 'yes')>

</cfloop>
	
<!----- RESET Discount Groups query for un-logged in visitors ---->
<cfset Application.objDiscounts.qryGroupDiscounts(0, 'yes')>	
