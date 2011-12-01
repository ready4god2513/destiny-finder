<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to output subcategories listed in a two column box. A 4 column table is used, cols 1 & 3 are spacers. No category images are used. The Sm_Title will be used if for the category name if available, otherwise a text title is used. Sm_Descr will be included under the name if available. --->

<!--- Used on some search pages --->

<!--- Create the four column box. --->
<cfoutput>
<table width="100%" cellspacing="2" cellpadding="2">
<tr>
	<td width="10%"><img src="#Request.AppSettings.defaultimages#/spacer.gif" width="25" height="1"></td>
	<td valign="top" width="40%">
</cfoutput>

<cfset colchange = request.qry_get_subcats.recordcount / 2>
<cfif colchange lt 1>
	<cfset colchange = 1>
</cfif>

<cfloop query="request.qry_get_subcats" startrow="1" endrow="#colchange#">

<cfif Request.AppSettings.UseSES>
	<cfset catlink = "#Request.SESindex#category/#request.qry_get_subcats.Category_ID#/#SESFile(request.qry_get_subcats.Name)##Request.Token1#">
<cfelse>
	<cfset catlink = "#self#?fuseaction=category.display&category_ID=#request.qry_get_subcats.Category_ID##Request.Token2#">
</cfif>

<cfif len(Sm_Title)>

	<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Title#" filealt="#Name#" imglink="#catlink#" hspace="3" vspace="2" class="cat_title_list">

<cfelse>
	<cfoutput><a class="cat_title_list" href="#XHTMLFormat(catlink)#">#Name#</a></cfoutput>

</cfif>

<cfoutput><cfif Sale is 1>#request.SaleImage#</cfif> 
<cfif Highlight is 1>#request.NewImage#</cfif><br></cfoutput>

<!--- Check for short description --->
<cfif len(Short_Desc)>
<cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token2#" class="cat_text_list">
</cfif>


</cfloop>

<!--- close first half of table and open the second --->
<cfoutput>
	</td>
	<td width="10%"><img src="#Request.AppSettings.defaultimages#/spacer.gif" width="25" height="1"></td>
	<td valign="top" width="40%">
</cfoutput>

<cfset colchange = colchange + 1>

<cfloop query="request.qry_get_subcats" startrow="#colchange#" endrow = "#request.qry_get_subcats.recordcount#">

<cfif Request.AppSettings.UseSES>
	<cfset catlink = "#Request.SESindex#category/#request.qry_get_subcats.Category_ID#/#SESFile(request.qry_get_subcats.Name)##Request.Token1#">
<cfelse>
	<cfset catlink = "#self#?fuseaction=category.display&category_ID=#request.qry_get_subcats.Category_ID##Request.Token2#">
</cfif>

<cfif len(Sm_Title)>
	<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Title#" filealt="#Name#" imglink="#catlink#" hspace="3" vspace="2">

<cfelse>
	<cfoutput>
	<a class="cat_title_list" href="#XHTMLFormat(catlink)#">#Name#</a>
	</cfoutput>
</cfif>

<cfoutput><cfif Sale>#request.SaleImage#</cfif> 
<cfif Highlight>#request.NewImage#</cfif><br></cfoutput>

<!--- Check for short description --->
<cfif len(Short_Desc)>
<cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token2#" class="cat_text_list">
</cfif>

</cfloop>

<!--- close table --->
<cfoutput>
</td></tr></table>
</cfoutput>










