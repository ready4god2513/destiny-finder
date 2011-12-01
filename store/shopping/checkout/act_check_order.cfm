<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Verify that nothing new has been added to the shopping cart, prevents user from adding items to the cart from a separate window while checking out. Called by shopping.checkout (step=receipt) --->

<!--- Get Order Start Times --->
<cfquery name="GetStartTime" datasource="#Request.DS#" username="#Request.user#" 		
password="#Request.pass#">
SELECT DateAdded FROM #Request.DB_Prefix#TempCustomer
WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>		
		
<cfquery name="GetLast" datasource="#Request.DS#" username="#Request.user#" 
password="#Request.pass#">
SELECT MAX(DateAdded) AS ItemDate 
FROM #Request.DB_Prefix#TempBasket 
WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>

<cfif DateCompare(GetLast.ItemDate, GetStartTime.DateAdded, "s") IS 1>
	<!--- Clear checkout variables and restart checkout from shipping page --->
	<cfset StructDelete(Session, "CheckoutVars")>
	
	<!--- Update Customer date --->
	<cfquery name="GetStartTime" datasource="#Request.DS#" username="#Request.user#" 		
	password="#Request.pass#">
		UPDATE #Request.DB_Prefix#TempCustomer
		SET DateAdded = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
		WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>	
	
	<cflocation url="#self#?fuseaction=shopping.checkout&step=shipping#Request.Token2#" addtoken="No"> 
</cfif>
