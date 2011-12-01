
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called by various category templates to output the product listing for the category. The products can be output into columns according to the category or default store settings. --->

<!--- The parameter listing=short|standard|vertical is used to determine the type of product display to use --->

<!--- Set the number of columns by attribute, category, application --->
<cfparam name="attributes.productCols" default="#request.appsettings.PColumns#">

<cfif isdefined("request.qry_get_cat.pcolumns") and request.qry_get_cat.pcolumns is not "">
	<cfset attributes.productCols = request.qry_get_cat.pcolumns>
</cfif>

<!--- Loop for each product to be output --->
<cfloop query="qry_get_products" startrow="#pt_StartRow#" endrow="#pt_EndRow#">

	<!--- Toggles the setting for product reviews --->
	<cfset rating_shown = false>

	<cfif pt_StartRow MOD attributes.productCols IS 0>
		<cfset CheckRow = qry_get_products.CurrentRow + 1>
	<cfelse>
		<cfset CheckRow = qry_get_products.CurrentRow>
	</cfif>
	
	<!--- Output table to hold columns of products --->
	<cfoutput>
	<cfif attributes.productCols LTE 1 OR CheckRow MOD attributes.productCols IS 1>
		<table cellpadding="6" cellspacing="0" border="0" width="100%">
		<tr>
	</cfif> 
	
	<td valign="top" width="#Round(100/attributes.productCols)#%" <cfif ListFind("short,vertical,gallery", attributes.listing)>align="center"</cfif>>	
	<cfif len(attributes.listing)>
		<cfinclude template="listings\put_#attributes.listing#.cfm">
	<cfelse>
		<cfinclude template="listings\put_standard.cfm">
	</cfif>
	</td>
	
	<cfset NumList = NumList - 1>
	
	<cfif attributes.productCols LTE 1 OR CheckRow MOD attributes.productCols IS 0>
	
		</tr></table>
	
		<cfif NumList Is NOT 0 and (currentrow is not pt_endrow) and attributes.thinline>
			<cfmodule template="../customtags/putline.cfm" linetype="Thin"/>
		</cfif>
	
	<cfelseif qry_get_products.CurrentRow IS pt_EndRow>
		<cfloop index = "num" from="1" to="#(attributes.productCols - pt_EndRow MOD attributes.productCols)#">
			<td width="#Round(100/attributes.productCols)#%">&nbsp;</td>
		</cfloop>
		
		</tr></table>
		
		<cfif NumList is NOT 0 and attributes.thinline>
			<cfmodule template="../customtags/putline.cfm" linetype="Thin"/>
		</cfif>
	
	</cfif>	
	
	</cfoutput>

</cfloop>


