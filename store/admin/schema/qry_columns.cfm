<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Getting column details for specific table --->
<cfif Request.dbtype IS "MSSQL">
	<cfquery name="GetColumnDetails" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM INFORMATION_SCHEMA.Columns
		WHERE Table_Name = '#GetTableNames.Table_Name#'
		ORDER BY ORDINAL_POSITION
	</cfquery>	
	<cfset tablename = GetTableNames.table_name>
<cfelse>
	<cfset resultset = ListGetAt(GetTableNames.columnList,1)>
	<cfset tablename = GetTableNames[resultset][currentrow]>
	<cfquery name="GetColumnDetails" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DESCRIBE #tablename#
	</cfquery>
</cfif>
	
	