
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page was designed to be used by sites selling memberships. It places a product in the shopping cart then forwards immediately to checkout. 

If the user is logged in, it will go directly to the payment page if it can.

If the user is not logged in, it will go to the Member Register page which will then forward to checkout.

Called by shopping.express

NOT CURRENTLY USED WITH VERSION 6
 --->

<cfset Numbers = "">

<cfset attributes.xfa_LoginAction = "shopping.basket">

<cfloop index="num" from="1" to="10">
	<cfif len(attributes['item' & num]) AND isNumeric(attributes['quant' & num])>
		<cfset ItemInfo = Trim(attributes['item' & num])>
	
		<!--- Search for this product --->
		<cfquery name="Product" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
		SELECT P.Product_ID 
		FROM #Request.DB_Prefix#Products P
		LEFT JOIN #Request.DB_Prefix#Prod_CustInfo PC ON PC.Product_ID = P.Product_ID
		WHERE P.SKU = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ItemInfo#">
		OR PC.CustomInfo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ItemInfo#">
		AND P.Display = 1
		</cfquery>
		
		<cfif Product.Recordcount>
			<cfset attributes.Product_ID = Product.Product_ID>
			<cfset attributes.Quantity = attributes['quant' & num]>
		
			<cfinclude template="act_add_item.cfm">
		<cfelse>
	
			<cfif len(attributes['item' & num])>
				<cfset Numbers = ListAppend(Numbers, " " & num)>
			</cfif>
		</cfif>
	
	<cfelseif len(attributes['item' & num])>
		<cfset Numbers = ListAppend(Numbers, " " & num)>
	</cfif>
	
	</cfif>

</cfloop>

<cfif len(Numbers)>
	<cfset Message = "Sorry, Invalid SKU">
</cfif>


