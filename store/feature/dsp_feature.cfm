<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to display a feature detail page. Called by feature.display and feature.print --->

<cfparam name="attributes.RelatedFeatTitle" default="Read More...">
<cfparam name="attributes.RelatedProdTitle" default="Products">

<!--- Set Metatags for this page ----------->
<cfif len(qry_get_feature.metadescription)>
	<cfset metadescription = qry_get_feature.metadescription>
</cfif>

<cfif len(qry_get_feature.keywords)>
	<cfset keywords = qry_get_feature.keywords>
</cfif>

<cfif len(qry_get_feature.titletag)>
	<cfset Webpage_title = qry_get_feature.titletag>
<cfelse>
	<cfset Webpage_title = qry_get_feature.Name>
</cfif>


<!--- Feature Title - large title image or text--->
<cfhtmlhead text="<script type='text/javascript' src='includes/openwin.js'></script>">

<!--- Feature image - large or small --->
<cfif len(qry_get_feature.Lg_Image)>
	<cfmodule template="../customtags/putimage.cfm" filename="#qry_get_feature.Lg_Image#" 	
	filealt="#qry_get_feature.Name#" align="left" style="margin-right: 10; margin-bottom: 8;">
<cfelseif len(qry_get_feature.Sm_Image)>
	<cfmodule template="../customtags/putimage.cfm" filename="#qry_get_feature.Sm_Image#" 
	filealt="#qry_get_feature.Name#" align="left">
</cfif>

<!--- Title - Image or HTML --->
<cfif len(qry_get_feature.Lg_Title)>
	<cfmodule template="../customtags/putimage.cfm" filename="#qry_get_feature.Lg_Title#" filealt="#qry_get_feature.Name#">
<cfelse>
	<cfmodule template="../customtags/puttitle.cfm" TitleText="#qry_get_feature.Name#" class="feature">
</cfif>


	<cfoutput query="qry_get_feature">
<div class="featurebyline">
	<cfif len(author)> by #author#<br/></cfif>
	<cfif len(copyright)>#copyright#<cfif len(created)>, </cfif></cfif>
	<cfif len(created)>#dateformat(created,'mm/dd/yy')#</cfif>
</div>
	</cfoutput>

<cfif len(qry_get_feature.long_Desc)>
	<cfmodule template="../customtags/puttext.cfm" Text="#qry_get_feature.long_Desc#" Token="#Request.Token1#">
<cfelse>
	<br/><cfmodule template="../customtags/puttext.cfm" Text="#qry_get_feature.short_Desc#" Token="#Request.Token1#">
</cfif>
<br/>

<cfif fusebox.fuseaction IS NOT "print">
<!--- Feature Reviews --->
<cfif request.appsettings.featurereviews AND qry_get_Feature.reviewable>
	<cfset attributes.do = "inline">
	<cfset fusebox.nextaction="feature.reviews">
	<cfinclude template="../lbb_runaction.cfm">
</cfif>

<!--- Put related features/products --->
<cfset attributes.detail_id = attributes.feature_ID>

<cfset attributes.detail_type = "Item">
<cfset attributes.SectionTitle = attributes.RelatedFeatTitle>
<cfset fusebox.nextaction="feature.related">
<cfinclude template="../lbb_runaction.cfm">

<cfset attributes.detail_type = "Feature">
<cfset attributes.SectionTitle = attributes.RelatedProdTitle>
<cfset fusebox.nextaction="product.related">
<cfinclude template="../lbb_runaction.cfm">


<cfinclude template="put_page_footer.cfm">


<cfif not fusebox.IsHomeCircuit>
	<br/>
	<cfset fusebox.nextaction="category.related">
	<cfinclude template="../lbb_runaction.cfm">
</cfif>

<!--- ADMIN EDIT LINK--->
<!--- feature Permission 1 = feature admin --->
<cfset ispermitted =0>
<cfmodule template="../access/secure.cfm"
keyname="feature"
requiredPermission="1,2"
><cfset ispermitted =1></cfmodule>

<cfif ispermitted OR qry_get_feature.user_id is Session.User_ID>
	<cfoutput><br/>
<span class="menu_admin">[<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=feature.admin&feature=edit&feature_id=#attributes.feature_id##Request.AddToken#')#"  #doAdmin()#>EDIT FEATURE #attributes.Feature_id#</a>]</span></cfoutput>
</cfif>

<cfelse>
<!--- print window, add window.print function --->
<script type="text/javascript">
<!--
window.print()
//-->
</script>


</cfif>



