<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Query by 
	attributes.UID 			(user_ID)
	attributes.editorial	staff reviews, etc. (choices defined in picklist)
	attributes.product_ID	optional
	attributes.sortby		newest|oldest|highest|lowest|mosthelp|leasthelp
	attributes.order		DESC|asc
	attributes.maxrows		number of rows to return
--->

<cfparam name="attributes.product_ID" default="">	
<cfparam name="attributes.editorial" default="">
<cfparam name="attributes.rating" default="">
<cfparam name="attributes.recent_days" default="">
<cfparam name="attributes.sortby" default="newest"> 
<cfparam name="attributes.order" default="">
<cfparam name="attributes.do" default="list">

<cfparam name="attributes.maxrows" default="100">
<cfparam name="attributes.approved" default="1">
<cfparam name="attributes.needscheck" default="">
<cfparam name="attributes.UID" default="">

<!--- remove any non-alphanumeric or non-space characters --->
<cfset attributes.sortby = Trim(sanitize(attributes.sortby))>
<cfset attributes.order = Trim(sanitize(attributes.order))>
<cfset attributes.editorial = Trim(sanitize(attributes.editorial))>
<cfset attributes.rating = Trim(sanitize(attributes.rating))>
<cfset attributes.recent_days = Trim(sanitize(attributes.recent_days))>

<!--- create search results header --->
<cfset searchheader = "<strong>Product Reviews</strong>">
<cfif len(attributes.editorial)>
	<cfset searchheader =  "<strong>#attributes.editorial#</strong>" & searchheader >
</cfif>
<cfif isNumeric(attributes.product_ID)>
	<cfquery name="GetDetail"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Product_ID, Name, Sm_Image, Short_Desc, User_ID FROM #Request.DB_Prefix#Products 
	WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.product_ID#">
	</cfquery>
	<cfset searchheader = "#searchheader# for <strong>#GetDetail.Name#</strong>">
	<!--- If listing reviews, make sure the review summary is also available --->
	<cfif NOT isDefined("qry_prod_reviews")>
		<cfquery name="qry_prod_reviews" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT AVG(R.Rating) AS Avg_Rating, COUNT(R.Rating) AS Total_Ratings, R.Product_ID
			FROM #Request.DB_Prefix#ProductReviews R
			LEFT JOIN #Request.DB_Prefix#Users U on R.User_ID = U.User_ID
			WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Product_ID#">
			AND R.Approved = 1
			<cfif request.appsettings.ProductReview_Add is "2">
				AND U.EmailLock = 'verified'
			</cfif>
			GROUP BY R.Product_ID
		</cfquery>
	</cfif>
</cfif>
<cfif len(attributes.rating)>
	<cfset searchheader = searchheader & " with a rating of <strong>#attributes.rating# stars</strong>">
</cfif>
<cfif len(attributes.recent_days)>
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
	<cfcase value="mosthelp">
		<cfset attributes.sort = "1">
		<cfset attributes.order = "DESC">
		<cfset searchheader = "<strong>Most Helpful</strong> " & searchheader>
	</cfcase>
	<cfcase value="leasthelp">
		<cfset attributes.sort = "1">
		<cfset attributes.order = "ASC">
		<cfset searchheader = "<strong>Least Helpful</strong> " & searchheader>
	</cfcase>
	<cfdefaultcase>
		<cfparam name="attributes.sort" default="#attributes.sortby#">
	</cfdefaultcase>
</cfswitch>

<cftry>

	<cfquery name="qry_get_reviews"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="#attributes.maxrows#">
	<cfif Request.dbtype IS "Access">
		SELECT IIF(R.Helpful_Total=0,0,R.Helpful_Yes/R.Helpful_Total) AS Helpful,
	<cfelse>
		SELECT CASE WHEN R.Helpful_Total > 0 THEN R.Helpful_Yes/R.Helpful_Total ELSE 0 END AS Helpful,
	</cfif>
	R.Helpful_Yes, R.Helpful_Total, R.Review_ID, R.Product_ID, R.Posted, R.Title, R.Comment, R.Rating, 
	R.Editorial, U.Username, R.User_ID, R.Anonymous, R.Anon_Name, R.Anon_Loc, R.Anon_Email, R.NeedsCheck, P.Name AS Product_Name
	
	FROM (#Request.DB_Prefix#ProductReviews R 
	INNER JOIN #Request.DB_Prefix#Products P ON R.Product_ID = P.Product_ID) 
	LEFT JOIN #Request.DB_Prefix#Users U on R.User_ID = U.User_ID
	
	WHERE 
		<cfif len(attributes.UID)>R.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.UID#"> AND 
		<cfif attributes.do is not "manager">R.Anonymous <> 1 AND</cfif></cfif> 
		<cfif len(attributes.product_ID)>R.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.product_ID#"> AND</cfif>
		<cfif len(attributes.rating)>Rating = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.rating#"> AND</cfif>
		<cfif len(attributes.editorial)>R.Editorial = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.editorial#"> AND</cfif> 
		<cfif Len(attributes.recent_days)>
		Posted >= <cfqueryparam cfsqltype="CF_SQL_DATE" value="#DateAdd("y",-attributes.recent_days,Now())#"> AND</cfif>	
		
		<cfif request.appsettings.ProductReview_Add is "2" AND attributes.do is not "manager">
		U.EmailLock = 'verified' AND</cfif>
			
		<cfif len(attributes.approved)>R.Approved = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#attributes.approved#">
		<cfelse>1=1</cfif>
		ORDER BY #attributes.sort# #attributes.order# 
	</cfquery>
			
	<cfif Len(attributes.UID)>
		<cfset searchheader = searchheader & " by <strong>#qry_get_reviews.username[1]#</strong>">
	</cfif>

<cfcatch type="Any">
	<!--- Return a blank query if errors found --->
	<cfset qry_get_reviews = QueryNew('Review_ID,Product_ID')>
	<cfset PCatSES = "">
	<cfset PCatNoSES = "">
</cfcatch>
</cftry>


<!--- Set product links if this is a product review page --->
<cfscript>
if (isNumeric(attributes.product_ID)) {
	Product_ID = attributes.Product_ID;

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
		prodlink = "#Request.SESindex#product/#product_ID##PCatSES#/#SESFile(GetDetail.Name)##Request.Token1#";
	else
		prodlink = "#self#?fuseaction=product.display&product_ID=#product_ID##PCatNoSES##Request.Token2#";
		
}
		
else {
	PCatSES = '';
	PCatNoSES = '';
}
</cfscript>

<cfsetting enablecfoutputonly="no">
