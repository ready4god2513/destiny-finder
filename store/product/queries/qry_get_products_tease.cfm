
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Searches by... --->
<cfparam name="attributes.category_id" default="">
<cfparam name="attributes.name" default="">
<cfparam name="attributes.type" default="">
<cfparam name="attributes.mfg_account_id" default="">
<cfparam name="attributes.highlight" default="">
<cfparam name="attributes.sale" default="">
<cfparam name="attributes.hot" default="">
<cfparam name="attributes.maxrows" default="10">

<cfif Session.User_ID>
	<cfset key_loc = ListContainsNoCase(session.userPermissions,'contentkey_list',';')>
	<cfif key_loc>
		<cfset accesskeys = ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^')>
		<cfset accesskeys = ListAppend(accesskeys,'0')>
	</cfif>
</cfif>
<cfparam name="accesskeys" default="0">


<!--- Get products --->
<cfquery name="qry_Get_products_tease" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT P.Product_ID, P.Name, Sm_Image, Short_Desc, Long_Desc, SKU, Metadescription, Keywords, Priority, User_ID
FROM #Request.DB_Prefix#Products P<cfif Len(attributes.category_id)>, #Request.DB_Prefix#Product_Category PC</cfif>
WHERE 
	AccessKey IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#accesskeys#" list="Yes">) 
	AND NOT EXISTS (SELECT C.Category_ID FROM #Request.DB_Prefix#Categories C 
		INNER JOIN #Request.DB_Prefix#Product_Category PCat ON C.Category_ID = PCat.Category_ID
		 WHERE PCat.Product_ID = P.Product_ID
		 AND (C.Display = 0 OR (
			C.AccessKey IS NOT NULL AND C.AccessKey <> 0 AND C.AccessKey NOT IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#accesskeys#" list="Yes">)) ) ) 
	AND 
	<cfif isNumeric(attributes.category_id)>
		PC.Product_ID = P.Product_ID AND 
		PC.Category_ID = <cfqueryparam value="#attributes.Category_id#" cfsqltype="CF_SQL_INTEGER"> AND </cfif>
	<cfif Request.AppSettings.InvLevel IS NOT "None" AND NOT Request.AppSettings.OutOfStock>
		P.NumInStock > 0 AND </cfif>
	<cfif Len(attributes.name)>P.Name LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.name#%"> AND </cfif>
	<cfif Len(attributes.type)>P.Prod_Type = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.type#"> AND </cfif>	
	<cfif Len(attributes.sale)>P.Sale = <cfqueryparam value="#attributes.sale#" cfsqltype="#Request.SQL_Bit#"> AND </cfif>	
	<cfif Len(attributes.highlight)>P.Highlight = 
					<cfqueryparam value="#attributes.highlight#" cfsqltype="#Request.SQL_Bit#"> AND </cfif>
	<cfif Len(attributes.mfg_account_id)>P.Mfg_Account_ID = 
					<cfqueryparam value="#attributes.mfg_account_id#" cfsqltype="CF_SQL_INTEGER"> AND </cfif>	
	<cfif Len(attributes.hot)>P.Hot = <cfqueryparam value="#attributes.hot#" cfsqltype="#Request.SQL_Bit#"> AND </cfif>
	(P.Sale_Start is NULL OR P.Sale_Start < <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">) AND 
	(P.Sale_End is NULL OR P.Sale_End > <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">) AND 
	P.Display = 1

ORDER BY P.Priority, P.Name, P.Product_ID
</cfquery>


