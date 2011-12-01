<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template displays product reviews on the product detail page. 

The template outputs ProductReviews_Page number of reviews. If there are more than ProductReviews_Page records, a link to display all reviews is shown. --->

<!--- This named anchor allow direct linking to the reviews on the product detail page. ---->
<cfoutput><a name="reviews"></a></cfoutput>

<cfset reviewlink = "#self#?fuseaction=product.reviews&product_ID=#attributes.product_ID#">

<!--- Display Reviews --->
<cfif qry_get_reviews.recordcount>
	
	<!-------------------------->
<!--- 	<cfmodule template="../../customtags/putline.cfm" linetype="Thick">

<div style="margin-bottom: 5px; margin-left: 5px; margin-top: 5px;" class="mainpage">
		<cfinclude template="put_rating.cfm">
		<br/>
		<cfoutput>
		<a href="#self#?fuseaction=product.reviews&do=write&product_ID=#attributes.product_ID##PCatNoSES##request.token2#">Write an online review</a> and share your thoughts with other customers.
	</cfoutput>
		</div> --->
	<cfset reviewcount = 0>
	
	<cfoutput query="qry_get_reviews" group="editorial">
	
		<cfmodule template="../../customtags/putline.cfm" linetype="Thin"/>
		
		<!--- Editorial Group Title --->
		<div class="section_title" style="margin-top:5px;">
		<cfif len(editorial)>#Editorial#<cfelse>Customer</cfif> Reviews</div><br/>

	<!--- Check if review summary already displayed --->
	<cfif NOT isDefined("rating_shown")>
		<cfparam name="rating_shown" default="yes">
		<div class="mainpage" style="margin-top:5px;">
			<cfif NOT len(editorial)>
				<cfinclude template="put_rating.cfm">
				<a href="#XHTMLFormat('#reviewlink#&do=write#PCatNoSES##request.token2#')#"  #doMouseover('Write a Review')#>Write an online review</a> and share your thoughts with other customers.
			</cfif>
		
		</div><br/>
	</cfif>
	
		<!--- Output Reviews --->
		
		<!--- Set counter for each group of review types --->
		<cfset numoutput = 0>
		
		<cfoutput>
			<cfif numoutput LT Request.AppSettings.ProductReviews_Page>
				<cfset numoutput = numoutput + 1>
				<!--- increment total counter --->
				<cfset reviewcount = reviewcount + 1>
				<!---- optional line 
				<cfmodule template="../../customtags/putline.cfm" linetype="thin"/> ---->
				<cfinclude template="put_review_inline.cfm">
				<br/>
			</cfif>
			
		</cfoutput>

	</cfoutput>
	
	<!--- Put link to all reviews if there are additional reviews --->
	<cfif qry_get_reviews.recordcount gt reviewcount>

		<cfoutput><p><a href="#XHTMLFormat('#reviewlink#&do=list&format=list#PCatNoSES##request.token2#')#" #doMouseover('All Reviews')#>Read All #qry_get_reviews.recordcount# Product Reviews</a></p></cfoutput>	

	</cfif>


<!--- Message if no reviews --->
<cfelse>

	<cfmodule template="../../customtags/putline.cfm" linetype="thin"/>
	
	<cfoutput>
	<div class="section_title">Customer Reviews</div>
	<br/>
	<div class="mainpage">Be the first to <a href="#XHTMLFormat('#reviewlink#&do=write#PCatNoSES##request.token2#')#" #doMouseover('Write a Review')#>write a review</a> of this product.<br/><br/></div>
	</cfoutput>

</cfif><!--- Review count check --->

