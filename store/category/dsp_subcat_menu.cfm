<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to output a menu of subcategories. Called by category.subcatmenu --->

<cfparam name="attributes.class" default="menu_category">

<cfif Request.AppSettings.UseSES>
	<cfset catlink = "#Request.StoreURL##Request.SESindex#category/#request.qry_get_subcats.Category_ID#/#SESFile(request.qry_get_subcats.Name)##Request.Token1#">
<cfelse>
	<cfset catlink = "#Request.StoreURL##self#?fuseaction=category.display&category_ID=#request.qry_get_subcats.Category_ID##Request.Token2#">
</cfif>

<cfloop query="request.qry_get_subcats">
	<cfif len(Sm_Title) and not attributes.menu_text>
		<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Title#" filealt="#Name#" imglink="#XHTMLFormat(catlink)#">
	<cfelse>
		<cfoutput>
		<a href="#XHTMLFormat(catlink)#" class="#attributes.class#" #doMouseover(request.qry_get_subcats.Name)#>#request.qry_get_subcats.Name#</a>
		</cfoutput>
	</cfif><br/>
</cfloop>


