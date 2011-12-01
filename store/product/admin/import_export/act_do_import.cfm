
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Process the file import after verifying the data. Called by product.admin&do=import --->

<cfif isDefined("attributes.do_import")>
	
	<!--- Check user's access level --->
	<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

	<cfif NOT ispermitted>
		<cfset prod_user = Session.User_ID>
	<cfelse>	
		<cfset prod_user = 0>
	</cfif>
	
	<cfset attributes.error_message = "">
	<cfset attributes.message = "Products Imported!">
	<cfset attributes.XFA_success = "fuseaction=product.admin&do=import">
	
	<cfset qryFailed = QueryNew(attributes.fieldlist)>

		<!--- Convert the WDDX to a CFM query --->
	<cfwddx action="WDDX2CFML" input="#attributes.passinfo#" output="importQry">
	
		<!--- loop through the array and import into the products table --->
	<cfset numrecords = importQry.Recordcount>
	
	<cfloop query="importQry">
	
		<cfscript>
			insertstring = "";
			numfields = ListLen(attributes.fieldlist);
			// construct the insert string 
			
			//convert the query row to a struct
			rowStruct = queryRowToStruct(importQry, currentrow);
			
		</cfscript>
		
		<cftry>
		
		<cfscript>			
		for (x=1; x lte numfields; x=x+1) {
			currtype = ListGetAt(attributes.fieldtypes, x);
			currField = ListGetAt(attributes.fieldlist, x);
			currtext = Evaluate("rowStruct.#currField#");
			if (Len(Trim(currtext)) IS 0)
				currtext = "NULL";
			else if (currtype IS "varchar")
				currtext = "'#Replace(currtext, "'", "''", "ALL")#'";	
			else if (currtype IS "date")
				currtext = "'#CreateODBCDate(currtext)#'";		
			else
				currtext = "#Val(currtext)#";		
			insertstring = ListAppend(insertstring, currtext);
		}
		</cfscript>
		
		<cftransaction isolation="SERIALIZABLE">
 		<cfquery name="insertRecord" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#"> 
			INSERT INTO #Request.DB_Prefix#Products
			(#attributes.fieldlist#,User_ID,DateAdded
			<cfif NOT ListFindNoCase(attributes.fieldlist, "prod_type")>,Prod_Type</cfif>)
			VALUES
			(#PreserveSingleQuotes(insertstring)#,#prod_user#,#CreateODBCDate(Now())#
			<cfif NOT ListFindNoCase(attributes.fieldlist, "prod_type")>,'product'</cfif>)
		</cfquery>
		
		<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			SELECT MAX(Product_ID) AS maxid 
			FROM #Request.DB_Prefix#Products
		</cfquery>
	
		<cfset Prod_ID = get_id.maxid>		
		</cftransaction>
		
		<!--- Add the product to the selected categories --->
		<cfloop index="thisID" list="#attributes.cid_list#">
			<cfquery name="Add_Product_Category" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#Product_Category
				(Product_ID, Category_ID)
				VALUES(#Prod_ID#, #thisID#)
			</cfquery>
		</cfloop>
		
	<cfcatch>
	<!--- if there's an error in the insert, write the data to the failed query --->
	<cfscript>
		QueryAddRow(qryFailed);
		for (i=1; i lte numfields; i=i+1) {
			colName = ListGetAt(attributes.fieldlist, i);
			QuerySetCell(qryFailed, colName, rowStruct[colName]);		
		}
	</cfscript>
	</cfcatch>
	
	</cftry>
	</cfloop>
	
</cfif>