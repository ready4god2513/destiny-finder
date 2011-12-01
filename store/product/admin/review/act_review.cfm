<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin functions for product reviews: add, update, delete --->

<!--- Check user's product review permission level --->
<cfmodule template="../../../access/secure.cfm" keyname="product" requiredPermission="64">
<cfif NOT ispermitted>
	<cfset attributes.UID = Session.User_ID>
<cfelse>
	<cfparam name="attributes.UID" default="#Session.User_ID#">
</cfif>

<cfparam name="attributes.submit_review" default="">
<cfparam name="attributes.product_ID" default="0">

<cfif attributes.submit_review is "Delete">
	<cfset attributes.delete = attributes.Review_ID>
	<cfset attributes.XFA_success = "fuseaction=product.admin&review=list">
</cfif>

<cfset attributes.error_message = "">

<cfif len(attributes.submit_Review) or isdefined("attributes.delete")>

	<cfif isdefined("attributes.Delete")>

		<cfset attributes.error_message = "">

		<!--- Error checking goes here ---->
		<cfquery name="Check_Review"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				SELECT Review_ID FROM #Request.DB_Prefix#ProductReviews
				WHERE Review_ID = <cfqueryparam value="#attributes.delete#" cfsqltype="CF_SQL_INTEGER">
				<cfif NOT ispermitted>
           		AND User_ID = <cfqueryparam value="#attributes.UID#" cfsqltype="CF_SQL_INTEGER">
				</cfif>
			</cfquery>
			
		<cfif NOT Check_Review.RecordCount>
			<cfset attributes.error_message = "Sorry, you do not have permission to delete this review.">
		</cfif>
		
		<cfif not len(attributes.error_message)>
		
			<cfquery name="Delete_Helpful"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#ProductReviewsHelpful
				WHERE Review_ID = <cfqueryparam value="#attributes.delete#" cfsqltype="CF_SQL_INTEGER">
				</cfquery>	
		
			<cfquery name="Delete_Review"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#ProductReviews
				WHERE Review_ID = <cfqueryparam value="#attributes.delete#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>	
		
		</cfif>
		
		<cfparam name="attributes.XFA_success" default="fuseaction=product.admin&review=list">
		<cfset attributes.product_ID = "">
		
	<!--- Add or Edit --->	
	<cfelse>	

		<cfloop list="uname,Anonymous,Anon_Name,Anon_Loc,Anon_email,Editorial,Rating,updated" index="counter">
			<cfparam name="attributes.#counter#" default="">
		</cfloop>	

		<cfif NOT len(attributes.updated)>
			<cfset attributes.Updated = now()>
		</cfif>
		
		<!--- Strip paragraph tags at beginning and end, if found. --->
		<cfset attributes.Comment = ReReplace(attributes.Comment, "^\s*<p>", "")>
		<cfset attributes.Comment = ReReplace(attributes.Comment, "</p>\s*$", "")>
		
		<cfif request.appsettings.ProductReview_Approve>
			<cfparam name="attributes.Approved" default="0">
		<cfelse>
			<cfparam name="attributes.Approved" default="1">
		</cfif>

		<cfif len(attributes.uname) AND ispermitted>
			<cfquery name="finduser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT User_ID FROM #Request.DB_Prefix#Users
			WHERE Username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.UName#">
			</cfquery>
			<cfif finduser.recordcount>
				<cfset attributes.UID = finduser.user_ID>
			<cfelse>
				<cfset attributes.error_message = "OOPS! The user name entered is not valid.">
			</cfif>	
		</cfif>		

		
		<cfif not len(attributes.error_message)>
	
		<cfif attributes.Review_ID IS 0>		

				<cfquery name="Add_Review" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#ProductReviews
				(Product_ID, User_ID, Anonymous, Anon_Name, Anon_Loc, Anon_Email, Title, Comment, Rating,
				Posted, Updated, Approved, NeedsCheck, Helpful_Total, Helpful_Yes)
				VALUES(
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.UID#">,
				<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#attributes.Anonymous#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Anon_Name#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Anon_Loc#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Anon_email#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Title#">,
				<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#attributes.Comment#">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Rating#" null="#YesNoFormat(NOT Len(attributes.Rating))#">,
				<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#attributes.Updated#">,
				<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#attributes.Updated#">,
				<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#attributes.Approved#">,
				<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#iif(isDefined('attributes.NeedsCheck'), Evaluate(DE('attributes.NeedsCheck')), 0)#">, 0, 0 )
				</cfquery>
				
		<cfelse>

			<cfquery name="Update_Review" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#ProductReviews
			SET 	
			User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.UID#">,
			Anonymous = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#attributes.Anonymous#">,
			Anon_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Anon_Name#">,
			Anon_Loc = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Anon_Loc#">,
			Anon_Email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Anon_email#">,
			Title = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Title#">,
			Comment = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#attributes.Comment#">,
			Approved = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#attributes.Approved#">,
			Rating = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Rating#" null="#YesNoFormat(NOT Len(attributes.Rating))#">,
			<cfif isdefined("attributes.posted")>
				Posted = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#attributes.Posted#">,
			</cfif>
			<cfif isdefined("attributes.NeedsCheck")>
				NeedsCheck = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#attributes.NeedsCheck#">,
			</cfif>
			<cfif isdefined("attributes.Helpful_Total")>
				Helpful_Total = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Helpful_Total#">,
			</cfif>
			<cfif isdefined("attributes.Helpful_Yes")>
				Helpful_Yes = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Helpful_Yes#">,
			</cfif>
					
			Updated = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#attributes.Updated#">
			WHERE Review_ID = <cfqueryparam value="#attributes.Review_ID#" cfsqltype="CF_SQL_INTEGER">
		
			</cfquery>
		
			<cfparam name="attributes.XFA_success" default="fuseaction=product.admin&review=list">
			
		</cfif><!--- Add or edit --->			
				
		</cfif><!--- Error Message Check --->
	
		<cfset attributes.UID = "">
			
	</cfif>
	
</cfif>

<!--- update admin menu  --->
<cfif FindNoCase(".admin", attributes.XFA_success)>
	<cfset attributes.admin_reload = "reviewcount">
</cfif>

<cfsetting enablecfoutputonly="no">