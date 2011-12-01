<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the updates from the List Edit Form for reviews. Called by product.admin&review=actform --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=product.admin&review=list">
	<cfloop list="uid,uname,search_string,product_ID,rating,recommend,approved,needsCheck,order,sortby,editorial,recent_days" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
	</cfloop>
	
<cfloop index="Review_ID" list="#attributes.reviewList#">
	
	<cfset Editorial = Evaluate("attributes.Editorial#Review_ID#")>
	<cfset NeedsCheck = iif(isDefined("attributes.NeedsCheck#Review_ID#"),1,0)>
	<cfset Approved = iif(isDefined("attributes.approved#Review_ID#"),1,0)>
	
	<cfquery name="Updatereview" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#ProductReviews
		SET Editorial = '#Editorial#',
		NeedsCheck = #NeedsCheck#, 
		Approved = #Approved#
		WHERE Review_ID = #Review_ID#
	</cfquery>
</cfloop>

<!--- update admin menu  --->
<cfset attributes.admin_reload = "reviewcount">


