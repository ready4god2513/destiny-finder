<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Processes a user's vote if the review was helpful or not. --->

<cfparam name="attributes.Review_ID" default="0">

<cfif isdefined("attributes.rate") AND isNumeric(attributes.Review_ID)>

	<!--- Users can only rate one time. Check to see if they've rated before --->
	<cfquery name="duplicateCheck" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Helpful_ID
		FROM #Request.DB_Prefix#ProductReviewsHelpful 
		WHERE Review_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Review_ID#">
		<cfif Session.User_ID IS NOT 0>
			AND (User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">
			OR IP = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cgi.REMOTE_HOST#">)
		<cfelse>
			AND IP = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cgi.REMOTE_HOST#">
		</cfif>
	</cfquery>

	<cfif duplicateCheck.recordcount is not 0>
	
		<cfset attributes.error_message="You have already voted on this review, thanks!">
		
	<cfelse>
		
		<!--- UUID for the primary key --->
		<cfset NewIDTag = CreateUUID()>
		<!--- Remove dashes --->
		<cfset NewIDTag = Replace(NewIDTag, "-", "", "All")>	
				
		<cftry>
		<cfquery name="Record_Helpful"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#ProductReviewsHelpful
			(Helpful_ID, Review_ID, Product_ID, Helpful, User_ID, Date_Stamp, IP ) 
			VALUES (
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NewIDTag#">,
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Review_ID#">,
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.product_ID#">,
			<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#attributes.rate#">,
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">,
			<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cgi.REMOTE_HOST#">
			)
		</cfquery>

		<cfquery name="Update_Review" datasource="#request.ds#" username="#request.user#" password="#request.pass#">
		UPDATE #Request.DB_Prefix#ProductReviews
		SET
		<cfif attributes.rate is 1>
			Helpful_Yes = (Helpful_Yes + 1),
		</cfif>
			Helpful_Total = (Helpful_Total + 1)
			WHERE Review_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Review_ID#">
			</cfquery>
			
		<cfcatch type="Any">
			<cfset attributes.error_message = "There was a problem with your rating, this product may not be available anymore">
		</cfcatch>
		</cftry>
		
	</cfif>

</cfif>

<!--- Alert Confirmation --->
<cfparam name = "attributes.message" default="Thank You for your opinion.">
<cfparam name = "attributes.error_message" default="">
<cfparam name = "attributes.box_title" default="Thanks">
<cfparam name = "attributes.XFA_success" default="#Replace(session.page,self & '?','','ALL')#">
<cfinclude template="../../includes/form_confirmation.cfm">

<!---- Use the following if you don't want the alert confirmation 
<cflocation url="#session.page#" addtoken="NO">
---->

<cfsetting enablecfoutputonly="no">
