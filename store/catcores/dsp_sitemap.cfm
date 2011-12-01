<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Default file used for the 'sitemap' page template. Called directly from sitemap.cfm --->

<!--- This page creates links to all the main store pages using search-engine friendly links --->

<!--- Pass the parameter alpha=1 to turn on the alphabetic search function, used for stores with lots of items --->

<cfparam name="attributes.alpha" default="0">

<!--- check if using alphabetic links --->
<cfif attributes.alpha>
<cfparam name="alphasearch" default="A">
<table border="0" width="100%" align="center">
<tr>
        <td>
                <cfoutput>
                        <p align="center" style="font-size: 7pt;">
						<a href="#self#/fuseaction/page.sitemap/alphaSearch/Num/#self##Request.Token1#" class="<cfif alphaSearch eq "Num">alphaon<cfelse>alphaoff</cfif>">##'s</a> |
                        <cfloop from="65" to="90" index="num">
                        <a href="#self#/fuseaction/page.sitemap/alphaSearch/#Chr(num)#/#self##Request.Token1#" class="<cfif alphaSearch eq Chr(num)>alphaon<cfelse>alphaoff</cfif>">#Chr(num)#</a> |
                        </cfloop>
                        <a href="#self#/fuseaction/page.sitemap/alphaSearch/All/#self##Request.Token1#" class="<cfif alphaSearch eq "All">alphaon<cfelse>alphaoff</cfif>">All</a>
                        </p>
                </cfoutput>
        </td>
</tr>
</table>
</cfif>

<!---- LIST CATEGORIES ------------------------------>

<div class="header">Categories</div><a name="categories"><br/>

<cfinclude template="../category/qry_get_allcats.cfm">

<cfoutput query="qry_get_allcats">
	<a href="#Request.SESindex#category/#category_ID#/#SESFile(Name)##Request.Token1#" class="cat_title_featured"><strong>#Name#</strong></a><br/>
	<cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" class="cat_text_small"><p>
</cfoutput>

<cfoutput><img src="#Request.AppSettings.defaultimages#/icons/up.gif" border="0" valign="baseline" alt="" hspace="2" vspace="0" /> <a href="#XHTMLFormat('#self##cgi.path_info##Request.Token1#')###top">top</a></cfoutput>
<p>

<!---- LIST PRODUCTS  ----------------------------------->

	<div class="header">Products</div><a name="products"><br/>
	
	<cfset attributes.sort = "sitemap">
	<cfinclude template="../product/queries/qry_get_products.cfm">

	<cfoutput query="qry_Get_Products">
		<a href="#Request.SESindex#product/#product_ID#/#SESFile(Name)##Request.Token1#" class="cat_title_featured"><strong>#Name#</strong></a><br/>
		<cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" class="cat_text_featured"><p>
	</cfoutput>

<cfoutput><img src="#Request.AppSettings.defaultimages#/icons/up.gif" border="0" valign="baseline" alt="" hspace="2" vspace="0" /> <a href="#XHTMLFormat('#self##cgi.path_info##Request.Token1#')###top">top</a></cfoutput>
<p>


<!---- LIST FEATURES  ---------------------------------->

	<div class="header">Feature Articles</div><a name="features"><br/>

	<cfinclude template="../feature/qry_get_features.cfm">

	<cfoutput query="qry_Get_features">
		<a href="#Request.SESindex#feature/#feature_ID#/#SESFile(Name)##Request.Token1#" class="cat_title_featured"><strong>#Name#</strong></a> by #author#<br/>
		<cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" class="cat_text_featured"><p>
	</cfoutput>

<cfoutput><img src="#Request.AppSettings.defaultimages#/icons/up.gif" border="0" valign="baseline" alt="" hspace="2" vspace="0" /> <a href="#XHTMLFormat('#self##cgi.path_info##Request.Token1#')###top">top</a></cfoutput>
<p>

<p>&nbsp;</p>
