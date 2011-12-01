
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to create a box to highlighted selected products. Called by product.tease --->

<!--- See the fbx_switch page for the list of parameters, some used by the query page, some are used by this page --->


<cfparam name="attributes.more" default="">
<cfparam name="attributes.box_title" default="Products">
<cfif not isdefined("self")>
	<cfset self = caller.self>
</cfif>


<cfmodule template="../customtags/format_box.cfm"
box_title="#attributes.box_title#"
TBgcolor="###Request.GetColors.BoxHBgcolor#"
more="#attributes.more#"
float=""
>

<cfscript>
	if (isDefined("attributes.category_ID") and isNumeric(attributes.category_ID)) {
		PCatSES = "_#attributes.Category_ID#";
		PCatNoSES = "&ParentCat=#attributes.Category_ID#";
	}
	else {
		PCatSES = "";
		PCatNoSES = "";
	}
</cfscript>
<table width="100%" cellspacing="0" cellpadding="4">
	<tr>

	<cfoutput query="qry_get_products_tease" maxrows="#attributes.maxrows#">
	<cfif Request.AppSettings.UseSES>
		<cfset prodlink = "#Request.SESindex#product/#Product_ID##PCatSES#/#SESFile(Name)##Request.Token1#">
	<cfelse>
		<cfset prodlink = "#self#?fuseaction=product.display&Product_ID=#product_id##PCatNoSES##Request.Token2#">
	</cfif>
		<td bgcolor="###Request.GetColors.BoxTBgcolor#" class="cat_title_list" align="center">
<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" imglink="#XHTMLFormat(prodlink)#" hspace="2" vspace="1" addbr="yes" User="#User_ID#" />
<a href="#XHTMLFormat(prodlink)#" #doMouseover(Name)#>#Name#</a>
		</td>
	</cfoutput>
	</tr>
</table>
</cfmodule>	
