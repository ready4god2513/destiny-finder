<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called as a custom tag to put a Review summary on product detail page: 
	"Avg rating: based on _ reviews" plus an optional link to Reviews. --->

<!--- Toggles whether rating summary has been shown --->
<cfparam name="rating_shown" default="false">	

<cfif NOT rating_shown>

<cfset rating_shown = true>

<cfif isDefined("qry_get_products.product_ID")>
	<cfset Product_ID = qry_get_products.product_ID>
<cfelse>
	<cfset Product_ID = attributes.product_ID>
</cfif>
	
<cfif NOT isDefined("PCatNoSES") OR NOT isDefined("prodlink")>
	<cfinclude template="../listings/do_prodlinks.cfm">
</cfif>

<cfset reviewlink = "#self#?fuseaction=product.reviews&product_ID=#product_ID##request.token2#">

<cfif len(qry_prod_reviews.avg_rating)>
	<cfoutput>
	Overall Rating: <img src="#request.appsettings.defaultimages#/icons/#round(qry_prod_reviews.avg_rating)#_med_stars.gif" alt="#round(qry_prod_reviews.avg_rating)# Stars" /><br/>
	based on #qry_prod_reviews.total_ratings# review<cfif qry_prod_reviews.total_ratings neq 1>s</cfif><br/>
	</cfoutput>
</cfif>

<cfoutput>
<cfif attributes.putlink is "ThisPage">
	[<a href="#XHTMLFormat(prodlink)###reviews" #doMouseover('Read Reviews')#>Read Reviews</a>] 
	[<a href="#XHTMLFormat('#reviewlink#&do=write#PCatNoSES#')#" #doMouseover('Write a Review')#>Write A Review</a>]

<cfelseif attributes.putlink is "reviews">
[<a href="#XHTMLFormat('#reviewlink#&do=list#PCatNoSES#')#" #doMouseover('Read Reviews')#>Read Reviews</a>] 
[<a href="#XHTMLFormat('#reviewlink#&do=write#PCatNoSES#')#" #doMouseover('Write a Review')#>Write A Review</a>]
</cfif>

<br/>
</cfoutput>

</cfif>