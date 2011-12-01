<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Query by 
	attributes.UID 			(user_ID)
	attributes.editorial	staff reviews, etc. (choices defined in picklist)
	attributes.Feature_ID	optional
	attributes.sortby		newest|oldest|highest|lowest|mosthelp|leasthelp
	attributes.order		DESC|asc
	attributes.maxrows		number of rows to return
	attributes.expandtree	if 0, only top level comments are show (parent_id = 0)
--->

<cfparam name="attributes.Feature_ID" default="">	
<cfparam name="attributes.parent_ID" default="">
<cfparam name="attributes.editorial" default="">
<cfparam name="attributes.rating" default="">
<cfparam name="attributes.recommend" default="">
<cfparam name="attributes.recent_days" default="">
<cfparam name="attributes.sortby" default="newest"> 
<cfparam name="attributes.order" default="">

<cfparam name="attributes.maxrows" default="100">
<cfparam name="attributes.approved" default="1">
<cfparam name="attributes.needscheck" default="">
<cfparam name="attributes.UID" default="">

<!--- Prevent any SQL Injection attempts --->
<cfset attributes.sortby = Trim(sanitize(attributes.sortby))>
<cfset attributes.order = Trim(sanitize(attributes.order))>
<cfset attributes.editorial = Trim(sanitize(attributes.editorial))>
<cfset attributes.rating = Trim(sanitize(attributes.rating))>
<cfset attributes.recent_days = Trim(sanitize(attributes.recent_days))>


<!--- create search results header --->
<cfset searchheader = "comments">
<cfif len(attributes.editorial)>
	<cfset searchheader =  "<strong>#attributes.editorial#</strong>" & searchheader>
</cfif>
<cfif len(attributes.rating)>
	<cfset searchheader = searchheader & " with a rating of <strong>#attributes.rating# stars</strong>">
</cfif>
<cfif Len(attributes.recent_days)>
	<cfset searchheader = "#searchheader# added in the last <b>#attributes.recent_days# days</b>">
</cfif>

<cfswitch expression="#attributes.sortby#">
	<cfcase value="newest">
		<!--- Newest are grouped by editorial type --->
		<cfset attributes.sort = "R.Editorial DESC, Posted">
		<cfset attributes.order = "DESC">
		<cfset searchheader = "<strong>Newest</strong> " & searchheader>
	</cfcase>
	<cfcase value="oldest">
		<cfset attributes.sort = "Posted">
		<cfset attributes.order = "ASC">
		<cfset searchheader = "<strong>Oldest</strong> " & searchheader>
	</cfcase>
	<cfcase value="highest">
		<cfset attributes.sort = "Rating">
		<cfset attributes.order = "DESC">
		<cfset searchheader = "<strong>Highest Rated</strong> " & searchheader>
	</cfcase>
	<cfcase value="lowest">
		<cfset attributes.sort = "Rating">
		<cfset attributes.order = "ASC">
		<cfset searchheader = "<strong>Lowest Rated</strong> " & searchheader>
	</cfcase>
	<cfdefaultcase>
		<cfparam name="attributes.sort" default="#attributes.sortby#">
	</cfdefaultcase>
</cfswitch>

<cftry>

	<cfquery name="qry_get_reviews"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="#attributes.maxrows#">
	SELECT R.Review_ID, R.Parent_ID, R.Feature_ID, R.Posted, R.Title, R.Comment, R.Rating, R.Editorial, U.Username, R.User_ID, R.Anonymous, R.Anon_Name, R.Anon_Loc, R.Anon_Email, R.NeedsCheck, F.Name AS Feature_Name
	
	FROM (#Request.DB_Prefix#FeatureReviews R 
	INNER JOIN #Request.DB_Prefix#Features F ON R.Feature_ID = F.Feature_ID) 
	LEFT JOIN #Request.DB_Prefix#Users U ON R.User_ID = U.User_ID
	
	WHERE 
		<cfif len(attributes.UID)>
			R.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.UID#"> AND 
			<cfif attributes.do is not "manager">R.Anonymous <> 1 AND</cfif>
		</cfif> 
		<cfif len(attributes.Feature_ID)>
			R.Feature_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Feature_ID#"> AND
		</cfif>
		<cfif len(attributes.rating)>
			R.Rating = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.rating#"> AND
		</cfif>
		<cfif len(attributes.editorial)>
			R.Editorial = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.editorial#"> AND
		</cfif> 
		<cfif Len(attributes.recent_days)>
			R.Posted >= <cfqueryparam cfsqltype="CF_SQL_DATE" value="#DateAdd("y",-attributes.recent_days,Now())#"> AND
		</cfif>		
		<cfif request.appsettings.FeatureReview_Add is "2" AND attributes.do is not "manager">
			U.EmailLock = 'verified' AND
		</cfif>		
		<cfif len(attributes.approved)>
			R.Approved = <cfqueryparam value="#attributes.approved#" cfsqltype="#Request.SQL_Bit#">
		<cfelse>
			1=1
		</cfif>
	ORDER BY
		#attributes.sort# #attributes.order# 
	</cfquery>
			
	<cfif Len(attributes.UID)>
		<cfset searchheader = searchheader & " by <strong>">
		<cfif len(qry_get_reviews.Anon_Name[1])>
			<cfset searchheader = searchheader & qry_get_reviews.Anon_Name[1]>
		<cfelse>
			<cfset searchheader = searchheader & qry_get_reviews.Username[1]>
		</cfif>
		<cfset searchheader = searchheader & "</strong>">
	</cfif>		


<cfcatch type="Any">
	<!--- Return a blank query if errors found --->
	<cfset qry_get_reviews = QueryNew('Review_ID,Parent_ID')>
	<cfset PCatSES = "">
	<cfset PCatNoSES = "">
</cfcatch>
</cftry>

	
<!--- Comments are output as a Tree (like a forum). This tag will sort the query into parent/child format. The new tree level of a review is specified in the added field called "maketreesortlevel". Use if displaying comments on a feature page. --->

<cfif isNumeric(attributes.Feature_ID)>
	<cfmodule template="../../customtags/make_tree.cfm"
		Query="#qry_get_reviews#"     
		Result="qry_get_reviews"     
		Unique="Review_ID"     
		Parent="Parent_ID"
		> 
		
	<cfquery name="GetDetail"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT Feature_ID, Name, Sm_Image, Sm_Title, Short_Desc
	FROM #Request.DB_Prefix#Features 
	WHERE Feature_ID =  <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Feature_ID#">
	</cfquery>
		
	<cfscript>
		Feature_ID = attributes.Feature_ID;
	
		// Set Parent ID text strings
		if (isDefined("attributes.ParentCat") and isNumeric(attributes.ParentCat) AND attributes.ParentCat IS NOT 0) {
			PCatSES = "_#attributes.ParentCat#";
			PCatNoSES = "&ParentCat=#attributes.ParentCat#";
		}
		else {
			PCatSES = "";
			PCatNoSES = "";
		}
	
		if (Request.AppSettings.UseSES)
			featurelink = "#Request.SESindex#feature/#feature_ID##PCatSES#/#SESFile(GetDetail.Name)##Request.Token1#";
		else
			featurelink = "#self#?fuseaction=feature.display&feature_ID=#feature_ID##PCatNoSES##Request.Token2#";
	</cfscript>

</cfif>

<cfsetting enablecfoutputonly="no">
