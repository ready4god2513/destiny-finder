<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Feature Reviews provide a way for readers and staff to place comments on Feature Articles. Reviews can be identified with an Editorial designation (Staff, Spotlight, ect., the available options are in a picklist). The Comments are displayed in a forum-type tree.

Feature.Reviews Fuseactions: DO = 

.INLINE				Custom tag for inserting reviews/comments on the Feature detail page.	
				
	Feature_ID		Required 

	
.LIST				List of all Feature comments by 
					Latest Comments
					OR all reviews by a specific author (user_ID)
						
	Format			Table (summary in tablular format) or List (full review text)
					
	UID				The author's User_ID (optional)
	Feature_ID		(optional)
	sortby			newest | oldest | highest | lowest | desc
					- sortby will set both attributes.sort and attributes.order in qry_get_reviews.cfm
					- listings are grouped by Editorial type when sorted by 'newest'
	recent_days		show reviews added in the last X number of days (New Reviews)	
	editorial		grouped by Editorial designation (staff, spotlight, etc.)

  	- Additional Attributes for use when calling list as a custom tag:
	maxrows			number of rows to return - default is 100 (qry_get_reviews.cfm)
	displaycount	number of rows per page - default is 10	(act_pagethrough.cfm)
	
				
.DISPLAY 			Detail page for single review.  
	
	Review_ID	REQUIRED

.MANAGER			Lists all reviews user has authored; allow editing and deletion of review.

.FLAG				Action that Flags a review for Admin review. A Flag link can be placed in the
					review so users can mark a review as needing to be checked by the editor. 
					Here's the link:
					<a href="#self#?fuseaction=Feature.reviews&do=flag&Review_ID=#Review_ID##request.token2#">Flag for Editor Review</a>

	Review_ID		Required
	
	
.WRITE 				Form for adding or editing a review

	Feature_ID		Required

.UPDATE				Action for review.write

.DELETE				Confirm a review deletion

---->


<cfparam name="attributes.do" default="list">  

<cfif CompareNoCase(attributes.do, "inline") IS 0>
	<!---Custom tag for inserting reviews/comments on the Feature detail page. 
	Feature_ID		Required
	--->
	<cfparam name="attributes.feature_ID" default="0">
	<cfinclude template="qry_get_reviews.cfm">	
	<cfinclude template="dsp_reviews_inline.cfm">
		
<cfelseif CompareNoCase(attributes.do, "display") IS 0>
	<!---- Displays a Specific Review --->
	<cfinclude template="qry_get_review.cfm">		
	<cfif not invalid and qry_get_review.recordcount>	
		<cfinclude template="qry_get_reviews.cfm">	
		<cfinclude template="dsp_review.cfm">
	<cfelse>
		<cfinclude template="../../errors/dsp_notfound.cfm">
	</cfif>
	
<cfelseif CompareNoCase(attributes.do, "write") IS 0>
	<cfset ispermitted = 0>
	<!---- check that a user is allowed to review this Feature --->
	<cfif request.appsettings.FeatureReview_Add is 0>
		<cfset ispermitted = 1>
	<cfelse>	
		<cfmodule template="../../access/secure.cfm"
		keyname="login"
		requiredPermission="#request.appsettings.FeatureReview_Add#"
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
		<cfset attributes.box_title="Feature Review">
		<cfinclude template="../../includes/form_confirmation.cfm">			
	</cfif>
	
<cfelseif CompareNoCase(attributes.do, "delete") IS 0>	
	<cfinclude template="qry_get_review.cfm">
	<cfif not invalid>				
		<cfinclude template="dsp_delete.cfm">
	<cfelse>
		<cflocation url="#URLDecode(Session.Page)#">
	</cfif>
	
		
<cfelseif CompareNoCase(attributes.do, "update") IS 0>
	<!---- Process User Edits --->
	<cfset ispermitted = 0>
	<!---- check that a user is logged in --->
	<cfif request.appsettings.FeatureReview_Add is 0>
		<cfset ispermitted = 1>
	<cfelse>	
		<cfmodule template="../../access/secure.cfm"
		keyname="login"
		requiredPermission="#request.appsettings.FeatureReview_Add#"
		>			
	</cfif>
	
	<cfif ispermitted>		
		<!--- To prevent hacking of other people's reviews --->
		<cfset attributes.uid = Session.User_ID>	
		<cfif request.appsettings.FeatureReview_Flag is 1>
			<cfset attributes.NeedsCheck = 1>
		</cfif>
				
		<cfparam name="attributes.XFA_success" default="fuseaction=feature.display&Feature_ID=#Val(attributes.Feature_ID)#">
		<cfinclude template="../admin/review/act_review.cfm">
	
		<cfset attributes.box_title="Talk Back">
		<cfif request.appsettings.FeatureReview_Approve is 1>
			<cfset attributes.message = "Thanks for your comment. It will posted after review by one of our editors.">
		</cfif>
		<cfinclude template="../../includes/form_confirmation.cfm">	
	
	<cfelse>
		<cfparam name="attributes.error_message" default="Please go to 'My Account' and verify your email address before submitting a review.">
		<cfset attributes.box_title="Feature Review">
		<cfinclude template="../../includes/form_confirmation.cfm">			
	</cfif>

<cfelseif CompareNoCase(attributes.do, "flag") IS 0>	
	<cfinclude template="act_flag.cfm">

<cfelseif CompareNoCase(attributes.do, "list") IS 0>	
	<!--- List reviews by user ID - linked from reviewer name --->
	<cfinclude template="qry_get_reviews.cfm">	
	<cfinclude template="dsp_reviews_table.cfm">	

<cfelse>
	<cfmodule template="../../#self#" fuseaction="page.pageNotFound">

</cfif>