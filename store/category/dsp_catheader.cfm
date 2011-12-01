
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to create the header for the category pages. Sets the meta tags, titles, top text and admin links for the page. Called by category.display --->

<!--- Set Metatags for this page ----------->
<cfif len(request.qry_get_cat.metadescription)>
	<cfset metadescription = request.qry_get_cat.metadescription>
</cfif>

<cfif len(request.qry_get_cat.keywords)>
	<cfset keywords = request.qry_get_cat.keywords>
</cfif>

<cfif len(request.qry_get_cat.titletag)>
	<cfset Webpage_title = request.qry_get_cat.titletag>
<cfelse>
	<cfset Webpage_title = request.qry_get_cat.Name>
</cfif>


<!----- Set this category page for Keep Shopping button ------->
<cfset Session.Page = Request.currentURL>

<!--- Output Large Image, if any --->
<cfparam name="attributes.currentpage" default=1>

<cfif len(request.qry_get_cat.Lg_Image)>
	<cfmodule template="../customtags/putimage.cfm" filename="#request.qry_get_cat.Lg_Image#" align="left" style="margin-right: 10; margin-bottom: 8;">
</cfif>

<cfif not isdefined("attributes.notitle")>
	<!--- Output Title as Image or HTML --->
	<cfif len(request.qry_get_cat.Lg_Title)><cfmodule template="../customtags/putimage.cfm" filename="#request.qry_get_cat.Lg_Title#" filealt="#request.qry_get_cat.Name#">
	<cfelse><cfmodule template="../customtags/puttitle.cfm" TitleText="#request.qry_get_cat.Name#" class="category">
	</cfif>
</cfif>

<!--- Output long description --->
<cfif len(request.qry_get_cat.Long_Desc) AND attributes.currentpage is 1>
<cfmodule template="../customtags/puttext.cfm" Text="#request.qry_get_cat.Long_Desc#" Token="#Request.Token1#" class="cat_text_large">
</cfif>

<!--- Include Admin Links ---->
<!--- Category Permission 1 = cat admin --->

<cfset attributes.catcore_id = request.qry_get_cat.catcore_id>
<cfinclude template="qry_get_catcore.cfm">

<span class="menu_admin">
<cfmodule template="../access/secure.cfm"
keyname="category"
requiredPermission="1"
>	
<cfoutput>| <a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=category.admin&category=edit&CID=#request.qry_get_cat.category_id##Request.AddToken#')#"  #doAdmin()#>EDIT CATEGORY #request.qry_get_cat.category_id#</a> | <a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=category.admin&category=add&PID=#request.qry_get_cat.category_id##Request.AddToken#')#" #doAdmin()#>ADD SUB-CAT</a>
| <a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=category.admin&category=listform&PID=#request.qry_get_cat.category_id##Request.AddToken#')#" #doAdmin()#>EDIT SUB-CAT LIST</a> 
</cfoutput>
</cfmodule>


<cfmodule template="../access/secure.cfm"
	keyname="product"
	requiredPermission="1"
	>
<cfif qry_get_catCore.products is 1><cfoutput> | <a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=product.admin&do=add&cid=#request.qry_get_cat.category_id##Request.AddToken#')#" #doAdmin()#>ADD PRODUCT</a> | <a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=product.admin&do=listform&cid=#request.qry_get_cat.category_id#&Parent_ID=0#Request.AddToken#')#" #doAdmin()#>EDIT PRODUCT LIST</a>
</cfoutput>
</cfif> 
</cfmodule>

<!--- Feature Admin Menu ---->
<cfif qry_get_catCore.features is 1>
	<cfmodule template="../access/secure.cfm"
	keyname="feature"
	requiredPermission="1,2,4"
	><br/>
	<cfoutput> | <a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=feature.admin&feature=add&CID=#request.qry_get_cat.category_id##Request.AddToken#')#" #doAdmin()#>ADD FEATURE</a> </cfoutput>
	</cfmodule>

	<cfmodule template="../access/secure.cfm"
	keyname="feature"
	requiredPermission="1,2"
	>
	<cfoutput> | <a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=feature.admin&feature=listform&CID=#request.qry_get_cat.category_id##Request.AddToken#')#"  #doAdmin()#>EDIT FEATURE LIST</a> |</cfoutput>
	</cfmodule>
</cfif>

</span>


