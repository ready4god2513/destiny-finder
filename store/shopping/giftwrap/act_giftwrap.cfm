
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Add Giftwrapping to cart item --->
	
<cfparam name="attributes.item" default="0">
<cfset basket_ID = attributes.item>

<cfquery name="GetCartItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" >	
	SELECT * FROM #Request.DB_Prefix#TempBasket
	WHERE Basket_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#basket_ID#">
</cfquery>
	
		
<cfif GetCartItem.recordcount>

	<cfset addons_new = GetCartItem.addons>
	<cfset addonMultP_new = GetCartItem.addonMultP>
	<cfset addonMultW_new = GetCartItem.addonMultW>
	
	<!--- If this item already has giftwrapping, remove it --->
	<cfif find('Gift Wrap:',GetCartItem.Addons)>
	
		<cfset giftwrap_name = listlast(replace(GetCartItem.addons,'<br/>','^'),'^')>
		
		<!---
		<cfoutput><h1>#GetCartItem.addons# -- #giftwrap_name#</h1></cfoutput>
		<cfabort>
		--->
		<cfset giftwrap_name = Replace(giftwrap_name, 'Gift Wrap: ', '')>
		
		<cfset addons_new = Replace(addons_new, 'Gift Wrap: #giftwrap_name#','')>
				
		<cfquery name="oldwrap" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" >	
			SELECT * FROM #Request.DB_Prefix#Giftwrap
			WHERE Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(giftwrap_name)#">
		</cfquery>
		
		<cfif oldwrap.recordcount>	
			<cfset addonMultP_new = addonMultP_new - oldwrap.Price>
			<cfset addonMultW_new = addonMultW_new - oldwrap.Weight>
		<cfelse>
			<!--- Houston we have a problem. The old wrapping was not found so
			we have no way of knowing how much it cost. --->
		</cfif>
				
	</cfif>
	
	<cfparam name="attributes.giftwrap_ID" default="0">

	<cfquery name="getwrap" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#" >	
		SELECT * FROM #Request.DB_Prefix#Giftwrap
		WHERE Display = 1
		AND Giftwrap_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.giftwrap_ID#">
	</cfquery>
		
	<!--- Update fields --->
	<cfif getwrap.recordcount>
		<cfset addons_new = trim(addons_new) & 'Gift Wrap: #getwrap.name#' >
		<cfset addonMultP_new = addonMultP_new + getwrap.Price>
		<cfset addonMultW_new = addonMultW_new + getwrap.Weight>
	</cfif>
			
	<!--- Update temp basket --->
	<cfquery name="UpdateBasket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#TempBasket
		SET Addons = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#addons_new#">,
		AddonMultP = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#addonMultP_new#">,
		AddonMultW = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#addonMultW_new#"> 
		WHERE Basket_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#basket_ID#">
	</cfquery>

</cfif>

