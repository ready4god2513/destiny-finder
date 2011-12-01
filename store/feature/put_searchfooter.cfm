<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Outputs a footer for feature listing pages. Includes navigation links to return to the page top, to the parent category, to the feature home category, and page thru links.  --->

<cfif attributes.thickline>
	<cfmodule template="../customtags/putline.cfm" linetype="thick" width="100%"/>
</cfif>

<cfoutput>
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="section_footer">
	<tr>
		<td><img src="#Request.AppSettings.defaultimages#/icons/up.gif" border="0" valign="baseline" alt="" hspace="2" vspace="0" /><a href="#XHTMLFormat(Request.currentURL)###top" class="section_footer" #doMouseover('top of page')#>top</a> 
<cfif attributes.fuseaction is "category.display">
<cfif Request.AppSettings.UseSES>
	<cfset catlast = "#Request.SESindex#category/#listlast(request.qry_get_cat.parentids)#/index.cfm#Request.Token1#">
	<cfset cathome = "#Request.SESindex#category/#request.appsettings.featureroot#/index.cfm#Request.Token1#">
<cfelse>
	<cfset catlast = "#self#?fuseaction=category.display&category_id=#listlast(request.qry_get_cat.parentids)##Request.Token2#">
	<cfset cathome = "#self#?fuseaction=category.display&category_id=#request.appsettings.featureroot##Request.Token2#">
</cfif>
<cfif len(request.qry_get_cat.parentnames)>
|<img src="#Request.AppSettings.defaultimages#/icons/left.gif" border="0" valign="middle" alt="" hspace="2" vspace="0" /><a href="#XHTMLFormat(catlast)#" class="section_footer" #doMouseover('back')#>#listlast(request.qry_get_cat.parentnames,":")#</a>
<cfelseif request.appsettings.featureroot gt 0>|<img src="#Request.AppSettings.defaultimages#/icons/left.gif" border="0" valign="middle" alt="" hspace="2" vspace="0" /><a href="#XHTMLFormat(cathome)#" class="section_footer">features home</a>
</cfif>
</cfif>
</td>
		<td align="right">
		#pt_pagethru#
		</td>
	</tr>
<tr><td colspan="2"><img src="#Request.AppSettings.defaultimages#/spacer.gif" height="8" width="1" border="0" alt="" hspace="0" vspace="0" /></td></tr>
</table>
</cfoutput>