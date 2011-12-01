
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to create a product export. Called by product.admin&do=export --->

<cfquery name="getfields"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT * FROM #Request.DB_Prefix#Products
</cfquery>

<cfset fieldlist = getfields.ColumnList>
<cfset MetaData = getfields.getMetaData()> 

<!--- Remove reserved fields --->
<cfset reservedlist = "">

<cfloop index="item" list="#reservedlist#">
	<cfset located = ListFindNoCase(fieldlist, item)>
	<cfset fieldlist = ListDeleteAt(fieldlist, located)>
</cfloop>

<!---- get list of categories that hold products ---->
<cfset attributes.catcore_content = "Products">
<cfinclude template="../../../category/qry_get_cat_picklist.cfm">

<cfhtmlhead text="
	<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=home.admin&redirect=yes#request.token2#"";
		}
	</script>
">

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Product Export"
	width="500">
	
<cftry>
<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#">
	<form action="#self#?fuseaction=product.admin&do=doexport#Request.Token2#" method="post"name="exportform" id="exportform">
	<!--- Category_id --->		
	<tr>
		<td align="RIGHT" valign="top"><br/>Export category(s):
		<br/><br/><span class="formtextsmall">CTRL + Click to<br/>select multiple<br/>categories.</span>
		</td>
		<td><br/>
	 	<select name="CID_LIST" size="6" multiple="multiple" class="formfield">	
		<option value="ALL" selected="selected">All Products</option>
		<cfloop query="qry_get_cat_picklist">
		<option value="#category_id#">&raquo;<cfif parentnames is not ""><cfif len(parentnames) gt 50>...</cfif>#Right(replace(parentnames,':','&raquo;'),50)#&raquo;</cfif>#Name#</option>
		</cfloop>
			</select>	
		</td>
	</tr>	
	
	<tr>
		<td colspan="2" align="center"><br/>
		<strong>EXPORT FIELD SELECTOR</strong></td>
	</tr>

<cfset numFields = ListLen(fieldlist)>
	
<cfloop index="num" from="1" to="30">
	<tr>
		<td align="right"><cfif num is 1><br/></cfif>Field #num#:</td>
		<td><cfif num is 1><br/></cfif>
	 	<select name="Field_#Num#" size="1" class="formfield">	
		<option value=""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
		<cfloop list="#fieldlist#" index="theField">
			<cfset DataType = getfields.getColumnTypeName(MetaData.GetColumnType(getfields.findColumn(theField)))>
			<option value="#theField#^#DataType#">#theField#</option>
		</cfloop>
		</select>	
		</td>
</cfloop>
	
	<tr>
		<td align="center" colspan="2"><br/>
		<input type="submit" name="submit_export" value="Create Export" class="formbutton"/> 
		<input type="button" value="Cancel" onclick="CancelForm();" class="formbutton"/>
		</td>
	</tr>
	
	</form>	
	</table>
</cfoutput>

<cfcatch type="ANY">
There has been a problem retrieving the database fields from the products table. This is typically due to using a server such as BlueDragon that does not support the code for determining field types. 

</cfcatch>
</cftry>

</cfmodule>
	
	