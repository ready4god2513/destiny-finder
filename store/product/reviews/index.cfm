<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Product Reviews can be created by customers and staff to provide product testimonials. Reviews can be identified with an Editorial designation (Staff, Spotlight, ect., the available options are in a picklist) and users can rank reviews as being helpful or not.

Product.Reviews Fuseactions:

.INLINE				Custom tag for inserting reviews/comments on the product detail page.	
				
	product_ID		Required 
	displaycount	number of rows to return - default is 100 (qry_get_reviews.cfm)				
	Sort			date | Most helpful
	
.LIST				List of all product reviews 
					OR all reviews for a specific product
					OR all reviews by a specific author (user_ID)
						
	Format			Table (summary in tablular format) or List (full review text)
					
	UID				The author's User_ID
	Product_ID		(optional)
	sortby			newest | oldest | highest | lowest | mosthelp | leasthelp, asc | desc
					- sortby will set both attributes.sort and attributes.order in qry_get_reviews.cfm
					- listings are grouped by Editorial type when sorted by 'newest'
	recent_days		show reviews added in the last X number of days (New Reviews)	
	editorial		grouped by Editorial designation (staff, spotlight, etc.)

  	- Additional Attributes for use when calling list as a custom tag:
	maxrows			number of rows to return - default is 100 (qry_get_reviews.cfm)
	displaycount	number of rows per page - default is 10	(act_pagethrough.cfm)
	
				
.DISPLAY 			Detail page for single review.  
	
	Review_ID		REQUIRED


.SUMMARY			Used as a custom tag to put a Review Summary on product detail page: 
					"Avg rating: based on _ reviews" plus an optional link to to Reviews page.
					
	Product_ID		Required
	Putlink 		Thispage - link to reviews at bottom of current page OR
					reviews - link to the review list for this product  
		
.MANAGER			Lists all reviews user has authored; allow editing and deletion of review.

.RATE				Action that allows readers to rate a review as helpful yes|no. Requires login.

	Review_ID		Required
	Rate			1 or 0 - Required
	
.FLAG				Action that Flags a review for Admin review. A Flag link can be placed in the
					review so users can mark a review as needing to be checked by the editor. 
					Here's the link:
					<a href="#self#?fuseaction=product.reviews&do=flag&Product_ID=#Product_ID#&Review_ID=#Review_ID##request.token2#">Flag for Editor Review</a>

	Review_ID		Required
	
	
.WRITE 				Form for adding or editing a review

	Product_ID		Required

.UPDATE				Action for review.write

.DELETE 			Confirm review deletion

---->


<cfparam name="attributes.do" default="list">

<cfif CompareNoCase(attributes.do, "inline") IS 0>
	<!---Custom tag for inserting reviews/comments on the product detail page. 
	product_ID		Required 
	displaycount	number of rows to return - default is 100 (as set in qry_get_reviews.cfm)				
	Sortby			see qry_get_reviews.cfm for list of sort options - defaults to newest 
	--->
	<cfinclude template="qry_get_reviews.cfm">
	<cfinclude template="dsp_reviews_inline.cfm">	

<cfelseif CompareNoCase(attributes.do, "list") IS 0>
	<!--- Format default = Table (list) --->
	<cfparam name="attributes.format" default="table">
	<cfinclude template="qry_get_reviews.cfm">
	<cfinclude template="dsp_reviews_#attributes.format#.cfm">

<cfelseif CompareNoCase(attributes.do, "display") IS 0>
	<!---- Displays a Specific Review --->
	<cfinclude template="qry_get_review.cfm">
	<cfif NOT invalid AND qry_get_review.recordcount>	
		<cfinclude template="dsp_review.cfm">
	<cfelse>
		<cfinclude template="../../errors/dsp_notfound.cfm">
	</cfif>

<cfelseif CompareNoCase(attributes.do, "summary") IS 0>
	<!---  Used as a custom tag to put a Review summary on item detail page: 
		"Avg rating: based on _ reviews" plus a link down the page.
	Putlink = 'ThisPage' (lower on prod detail page) | 'reviews' (review listing) | 'none'  --->
	<cfparam name="attributes.putlink" default="reviews">
	<cfinclude template="dsp_summary.cfm">	

<cfelseif CompareNoCase(attributes.do, "manager") IS 0>
	<!--- Lists all reviews user has authored; allow editing and deletion of review. --->
	<cfmodule template="../../access/secure.cfm"
	keyname="login"
	requiredPermission="1"
	>	
	<cfif ispermitted>	
		
		<!--- if looking at reviews about users, use professional format --->
		<cfparam name="attributes.format" default="table">

		<cfif not isdefined("attributes.uid")>
			<cfset attributes.uid = Session.User_ID>
		</cfif>
		<cfset attributes.approved="">
		<cfinclude template="qry_get_reviews.cfm">	
		<cfinclude template="dsp_reviews_#attributes.format#.cfm">
	</cfif>

<cfelseif CompareNoCase(attributes.do, "rate") IS 0>
	<!--- Processes the "did you find this helpful" link on a review --->
	<!--- Login required. --->
	<cfif request.appsettings.ProductReview_Rate>
		<cfmodule template="../../access/secure.cfm"
		keyname="login"
		requiredPermission="1"
		>	
	<cfelse>
		<cfset ispermitted=1>
	</cfif>
	<cfif ispermitted>		
		<cfparam name="attributes.product_ID" default="0">
		<cfinclude template="act_rate.cfm">
	</cfif>

<cfelseif CompareNoCase(attributes.do, "flag") IS 0>
	<cfinclude template="act_flag.cfm">


<cfelseif CompareNoCase(attributes.do, "write") IS 0>
	<cfset ispermitted = 0>
	<!---- check that a user is allowed to review this product --->
	<cfif request.appsettings.ProductReview_Add is 0>
		<cfset ispermitted = 1>
	<cfelseif request.appsettings.ProductReview_Add is 3>
		<cfif not Session.User_ID>
			<cfset attributes.error_message = "You must sign in to write a product review.">
		<cfelse>
			<cfinclude template="qry_get_purchase.cfm">
			<cfif invalid>
				<cfset attributes.error_message = "Invalid product entered.">
			<cfelseif qry_get_purchase.recordcount gt 0>
				<cfset ispermitted = 1>
			<cfelse>
				<cfset attributes.error_message = "Only purchasers of this product may write a review.">
			</cfif>
		</cfif>
	<cfelse>	
		<cfmodule template="../../access/secure.cfm"
		keyname="login"
		requiredPermission="#request.appsettings.ProductReview_Add#"
		>
		<cfif not ispermitted and Session.User_ID>
			<cfset attributes.error_message = "Please go to 'My Account' and verify your email address before submitting a review.">
		</cfif>
	</cfif>
	
	<cfif ispermitted>		
		<cfinclude template="qry_get_review.cfm">
		<cfif not invalid>			
			<cfinclude template="dsp_edit_form.cfm">
		<cfelse>
			<cfinclude template="../../errors/dsp_notfound.cfm">
		</cfif>
	<cfelseif isdefined("attributes.error_message")>
		<cfset attributes.box_title="Product Review">
		<cfinclude template="../../includes/form_confirmation.cfm">			
	</cfif>

<cfelseif CompareNoCase(attributes.do, "delete") IS 0>	
	<cfinclude template="qry_get_review.cfm">
	<cfif not invalid AND qry_get_review.recordcount>				
		<cfinclude template="dsp_delete.cfm">
	<cfelse>
		<cflocation url="#URLDecode(Session.Page)#">
	</cfif>

<cfelseif CompareNoCase(attributes.do, "update") IS 0>
	<!--- Check if user cancelled from the delete confirmation --->			
	<cfif isDefined("attributes.submit_cancel")>
		<cflocation url="#URLDecode(Session.Page)#">
	<cfelse>
		<!---- Process User Edits --->
		<cfset ispermitted = 0>
		<!---- check that a user is logged in --->
		<cfif request.appsettings.ProductReview_Add is 0>
			<cfset ispermitted = 1>
		<cfelseif request.appsettings.ProductReview_Add is 3>
			<cfif not Session.User_ID>
				<cfset attributes.error_message = "You must sign in to write a product review.">
			<cfelse>
				<cfinclude template="qry_get_purchase.cfm">
				<cfif qry_get_purchase.recordcount gt 0>
					<cfset ispermitted = 1>
				<cfelse>
					<cfset attributes.error_message = "Only purchasers of this product may write a review.">
				</cfif>
			</cfif>
		<cfelse>	
			<cfmodule template="../../access/secure.cfm"
			keyname="login"
			requiredPermission="#request.appsettings.ProductReview_Add#"
			>			
		</cfif>
		
		<cfif ispermitted>	
			<cfif request.appsettings.ProductReview_Flag is 1>
				<cfset attributes.NeedsCheck = 1>
			</cfif>
					
			<cfparam name="attributes.XFA_success" default="fuseaction=product.display&product_ID=#Val(attributes.product_ID)#">
			<cfinclude template="../admin/review/act_review.cfm">
		
			<cfset attributes.box_title="Talk Back">
			<cfinclude template="../../includes/form_confirmation.cfm">
		
		<cfelse>
			<cfparam name="attributes.error_message" default="Please go to 'My Account' and verify your email address before submitting a review.">
			<cfset attributes.box_title="Product Review">
			<cfinclude template="../../includes/form_confirmation.cfm">
		</cfif>
	</cfif>


<cfelse>
	<cfmodule template="../../#self#" fuseaction="page.pageNotFound">

</cfif>

