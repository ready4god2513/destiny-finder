
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page outputs a search form header able to filter and sort the product list. It can be used on either category or page listings. Used by catcore_products.cfm
 Any product search criteria can be used.  This is provided as a sample. ---->
 
 <!--- Set these to determine search fields to show --->
<cfparam name="attributes.showavailable" default="0">
<cfparam name="attributes.showname" default="1">
<cfparam name="attributes.showkeywords" default="1">
<cfparam name="attributes.showsort" default="1">

<!--- Output search form header --->
<cfinclude template="../queries/qry_getpicklists.cfm">	

<cfoutput>
<form action="#XHTMLFormat(Request.currentURL)#" method="post" name="productbrowseform">
<table cellspacing="0" cellpadding="3" width="100%" class="formtextsmall" border="0" align="center">
<tbody>
	<tr>
<!--- <input type="hidden" name="fuseaction" value="#attributes.fuseaction#"/>
<input type="hidden" name="category_ID" value="#attributes.category_ID#"/>
<cfif isdefined("attributes.page_ID")>
<input type="hidden" name="page_ID" value="#attributes.page_ID#"/>
</cfif> --->

<cfif attributes.showavailable>
	<!---- Availability ---->
	<td>Product Availability:  
		<select name="availability" size="1" class="formfield">
		<option value="" #doSelected(attributes.availability,'')#></option>
		<cfmodule template="../customtags/form/dropdown.cfm"
		mode="valuelist"
		valuelist="#qry_getpicklists.product_Availability#"
		selected="#attributes.Availability#"
		/>
		</select></td>
</cfif>
		
<cfif attributes.showname>
 	<td>Product Name:  <input type="text" name="Name" value="#HTMLEditFormat(attributes.name)#" class="formfield" size="30"/></td>
</cfif>

<cfif attributes.showkeywords>
 	<td>Keywords:  <input type="text" name="search_string" value="#HTMLEditFormat(attributes.search_string)#"  class="formfield" size="30"/></td>
</cfif>
			
<cfif attributes.showsort>
		<!---- Sort ---->
		<td> &nbsp;Sort Results by: <select name="sortby" size="1" class="formfield">
			<option value="" #doSelected(attributes.sortby, '')#></option>
			<option value="name" #doSelected(attributes.sortby, 'name')#>product name</option>
			<option value="sku" #doSelected(attributes.sortby, 'sku')#>product ID</option>
			<option value="low" #doSelected(attributes.sortby, 'low')#>lowest price</option>
			<option value="high" #doSelected(attributes.sortby, 'high')#>highest price</option>
			</select></td>
</cfif>
			
		<td><br/>
		<input type="submit" name="" class="formbutton" value="go"/>
		</td>
	</tr>
</tbody>
</table>
</form>

<cfif len(pt_pagethru)>
<div align="right">#pt_pagethru#</div>
</cfif>

<cfif attributes.thickline>
<cfmodule template="../customtags/putline.cfm" linetype="thick"/>
</cfif>

</cfoutput>
