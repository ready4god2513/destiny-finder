
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to update the discounted product for a promotion. Called by product.admin&promotion=disc_product --->

<cfparam name="attributes.parent" default="0">

<cfif isdefined("attributes.Action") AND attributes.Action IS "select_product" AND IsDefined("attributes.Product_ID")>
	
	<!--- Add the selected product --->
	<cfquery name="Add_Related" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Promotions
		SET Disc_Product = #attributes.Product_ID#
		WHERE Promotion_ID = #attributes.Promotion_ID#
	</cfquery>
	
<!--- change category selector --->
<cfelseif isdefined("attributes.Action") AND attributes.Action IS "view_subcats">

	<cfset attributes.parent = attributes.pid>
	<cfset attributes.pid = attributes.cid>
	
<!--- parent category selector --->
<cfelseif isdefined("attributes.Action") AND attributes.Action IS "view_parent">

	<cfset attributes.pid = attributes.cid>

</cfif>

<!----- RESET Promotion Application query ---->
<cflock scope="APPLICATION" timeout="15" type="EXCLUSIVE">
	<cfinvoke component="#Request.CFCMapping#.shopping.promotions" method="getallPromotions"
		returnvariable="Application.GetPromotions">	
</cflock>	
	

