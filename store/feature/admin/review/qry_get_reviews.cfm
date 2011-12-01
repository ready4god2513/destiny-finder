<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of reviews. Filters according to the search parameters that are passed. Called by Feature.admin&review=list|listform --->

<cfloop index="namedex" list="uid,uname,search_string,feature_ID,editorial,sortby,rating,display_status,approved,needsCheck,recent_days">
	<cfoutput><cfparam name="attributes.#namedex#" default=""></cfoutput>
</cfloop>

<cfif attributes.display_status is "check">
	<cfset attributes.needsCheck = 1>
<cfelseif attributes.display_status is "pending">
	<cfset attributes.approved = 0>
<cfelseif attributes.display_status is "day">
	<cfset attributes.recent_days = 1>
<cfelseif attributes.display_status is "week">
	<cfset attributes.recent_days = 7>
<cfelseif attributes.display_status is "month">
	<cfset attributes.recent_days = 30>
</cfif>

<cfswitch expression="#attributes.sortby#">
	<cfcase value="newest">
		<!--- Newest are grouped by editorial type --->
		<cfset attributes.sort = "Posted">
		<cfset attributes.order = "DESC">
	</cfcase>
	<cfcase value="oldest">
		<cfset attributes.sort = "Posted">
		<cfset attributes.order = "ASC">
	</cfcase>
	<cfcase value="highest">
		<cfset attributes.sort = "Rating">
		<cfset attributes.order = "DESC">
	</cfcase>
	<cfcase value="lowest">
		<cfset attributes.sort = "Rating">
		<cfset attributes.order = "ASC">
	</cfcase>
	<cfdefaultcase>
		<cfif len(attributes.sortby)>
			<cfset attributes.sort = "#attributes.sortby#">
		<cfelse>
			<cfset attributes.sort = "Review_ID">
		</cfif>
		<cfparam name="attributes.order" default="DESC">
	</cfdefaultcase>
</cfswitch>


<cfquery name="qry_get_reviews"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT  R.Review_ID, R.Feature_ID, R.Posted, R.Updated, R.Title, R.Comment, R.Rating, R.Editorial, R.User_ID, R.Anonymous, R.Anon_Name, R.Anon_Loc, R.Anon_Email, R.NeedsCheck, U.Username, R.Approved, F.Name AS Feature_Name, 
(SELECT count(*) FROM #Request.DB_Prefix#FeatureReviews FR 
	WHERE FR.Parent_ID = R.Review_ID
	AND FR.Parent_ID <> 0) AS children

FROM (#Request.DB_Prefix#FeatureReviews R 
INNER JOIN #Request.DB_Prefix#Features F ON R.Feature_ID = F.Feature_ID) 
LEFT JOIN #Request.DB_Prefix#Users U ON R.User_ID = U.User_ID
WHERE 
	<cfif len(attributes.UID)>R.User_ID = #attributes.UID# AND 
		<cfif fusebox.fuseaction is not "manager">R.Anonymous <> 1 AND</cfif>
	<cfelseif len(attributes.uname)>
		 (U.Username Like '%#attributes.uname#%' OR R.Anon_Name LIKE '%#attributes.uname#%') AND
	</cfif> 
	<cfif len(attributes.search_string)>
		(R.Title LIKE '%#attributes.search_string#%'	
		 OR R.Comment LIKE '%#attributes.search_string#%'
		 OR F.Name LIKE '%#attributes.search_string#%'
		 ) AND
	</cfif>

	<cfif len(attributes.Feature_ID)>R.Feature_ID = #attributes.Feature_ID# AND</cfif>
	<cfif len(attributes.editorial)>R.Editorial = '#attributes.editorial#' AND</cfif> 
	
	
	<cfif len(attributes.rating)>Rating = #attributes.rating# AND</cfif>
	<cfif Len(attributes.recent_days)>
	R.posted >= #DateAdd("y",-attributes.recent_days,Now())# AND</cfif>	
	
	<cfif attributes.display_status is "editor">
		(R.Approved = 0 OR	R.NeedsCheck = 1) AND
	<cfelse>
		<cfif len(attributes.approved)>R.Approved = #attributes.approved# AND</cfif>
		<cfif len(attributes.needscheck)>R.NeedsCheck = #attributes.needscheck# AND</cfif>
	</cfif>
		
	1 = 1
ORDER BY
	#attributes.sort# #attributes.order# 
</cfquery>
	

