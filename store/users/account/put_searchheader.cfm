<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Outputs the header for the accounts listings, called by catcore_accounts.cfm and dsp_results.cfm --->

<!--- remove page, sort and from query string ---->
<cfparam name="querystring" default="currentpage=#Val(attributes.currentpage)##addedpath#">

<cfset replacetext = "currentpage=#Val(attributes.currentpage)#&">
	<cfset querystring=Replace(querystring,replacetext,'')>
<cfset replacetext = "&sortby=#attributes.sortby#">
	<cfset querystring=Replace(querystring,replacetext,'')>
<cfset replacetext = "&order=#attributes.order#">
	<cfset querystring=Replace(querystring,replacetext,'')>
	
<cfset action = "#self#?#querystring##Request.Token2#">
	
<cfif NOT len(attributes.order)>
	<cfset name_order_by = "DESC">
	<cfset city_order_by = "DESC">
<cfelseif attributes.sortby is "name">
	<cfset name_order_by = "ASC">
	<cfset city_order_by = "DESC">
<cfelse>
	<cfset name_order_by = "DESC">
	<cfset city_order_by = "ASC">
</cfif>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr><td valign="bottom" height="20" class="section_footer">

<cfoutput>		
	Sort by 
	<a href="#XHTMLFormat('#action#&sortby=name&order=#name_order_by#')#" class="section_footer" #doMouseover('Sort by Name')#><cfif attributes.sortby is "name"><b>Name</b><cfelse>Name</cfif></a> | 
	<a href="#XHTMLFormat('#action#&sortby=city&order=#city_order_by#')#" class="section_footer" #doMouseover('Sort by Location')#><cfif attributes.sortby is "city"><b>Location</b><cfelse>Location</cfif></a>

<!--------
|
	
<cfif attributes.sort is "type1" and not len(attributes.order)>
	<a href="#self#?#querystring#&sort=type1&order=ASC#Request.Token2#" class="section_footer"><cfif attributes.sort is "type1"><b>Type</b><cfelse>Type</cfif></a>
   	<cfelse><a href="#self#?#querystring#&sort=type1#Request.Token2#" class="section_footer"><cfif attributes.sort is "type1"><b>Type</b><cfelse>Type</cfif></a></cfif> 
-------->
</td></tr>

<cfif len(pt_pagethru)>
<tr><td valign="bottom"  height="20" align="right" class="section_footer">
#pt_pagethru#
</td></tr>
</cfif>

</cfoutput>

</table>

<cfif attributes.thickline>
	<cfmodule template="../../customtags/putline.cfm" linetype="Thick" width="100%">	
</cfif>
