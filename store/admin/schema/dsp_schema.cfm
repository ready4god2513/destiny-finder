
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the database schema Called by home.admin&schema=list --->

<cfoutput>
<br/><br/>
<!--- looping throughout the table names --->
<cfloop query="GetTableNames">

	<cfinclude template="qry_columns.cfm">
	
<cfmodule template="../../customtags/format_admin_form.cfm"
	box_title="#tablename#"
	width="500"
	required_Fields="0"
	>
	<tr>
		<td><strong>Order</strong></td>
		<td><strong>Column Name</strong></td>
		<td align="center"><strong>Default</strong></td>
		<td><strong>Data Type</strong></td>
		<td><strong>Nulls</strong></td>
		<cfif Request.dbtype IS "MSSQL">
		<td><strong>length</strong></td>
		<td><strong>prec</strong></td>
		<cfelse>
		<td><strong>key</strong></td>
		<td><strong>extra</strong></td>
		</cfif>
	</tr>

	<cfloop query="GetColumnDetails">
		<tr>
			<cfif Request.dbtype IS "MSSQL">
			<td>#ORDINAL_POSITION#&nbsp;</td>
			<td>#COLUMN_NAME#&nbsp;</td>
			<td align="center">#COLUMN_DEFAULT#&nbsp;</td>
			<td>#DATA_TYPE#&nbsp;</td>
			<td>#IS_NULLABLE#</td>
			<td>#CHARACTER_MAXIMUM_LENGTH#&nbsp;</td>
			<td>#NUMERIC_PRECISION#&nbsp;</td>
			<cfelse>
			<td>#Currentrow#&nbsp;</td>
			<td>#Field#&nbsp;</td>
			<td align="center">#Default#&nbsp;</td>
			<td>#Type#&nbsp;</td>
			<td>#Null#</td>
			<td>#Key#&nbsp;</td>
			<td>#Extra#&nbsp;</td>
			</cfif>
		</tr>
	</cfloop>
	</cfmodule>
	<br/>
</cfloop>

</cfoutput>

