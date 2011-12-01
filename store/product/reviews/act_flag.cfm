<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template flags a review for Admin review. It is invoked by a link in the product review:
<a href="#self#?fuseaction=product.reviews&do=flag&Product_ID=#Product_ID#&Review_ID=#Review_ID##request.token2#">Flag for Editor Review</a>
 --->

<cfparam name="attributes.Review_ID" default="0">
<cfparam name="attributes.Product_ID" default="0">

<cfif attributes.Review_ID AND isNumeric(attributes.Review_ID)>

	<cfquery name="Flag_Review" datasource="#request.ds#" username="#request.user#" password="#request.pass#">
	UPDATE #Request.DB_Prefix#ProductReviews
	SET	NeedsCheck = 1
	WHERE Review_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Review_ID#">
	</cfquery>

	<!--- Alert confirmation --->
	<cfparam name = "attributes.message" default="This Review has been flagged for Editor Review.">
	<cfparam name = "attributes.error_message" default="">
	<cfparam name = "attributes.box_title" default="Thanks">
	<cfparam name = "attributes.XFA_success" default="#Replace(session.page,self & '?','','ALL')#">
	<cfinclude template="../../includes/form_confirmation.cfm">
	
	<!---- Use the following if you don't want the alert confirmation 
	<cflocation url="#session.page#" addtoken="NO">
	---->

</cfif>
