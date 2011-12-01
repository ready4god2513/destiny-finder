<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfparam name="attributes.do" default="display">
<!--- Used to check for invalid query strings --->
<cfparam name="invalid" default="0">

<!--- If on the edit page, check the user's permission level --->
<cfmodule template="../../access/secure.cfm" keyname="feature" requiredPermission="8" />

<cfif ListFind("write,delete", attributes.do) AND NOT ispermitted>
	<cfset attributes.UID = Session.User_ID>
<cfelseif ListFind("write,delete", attributes.do)>
	<cfparam name="attributes.UID" default="#Session.User_ID#">
</cfif>

<!--- Get the review --->	
<cfparam name="attributes.Review_ID" default="0">
<cfparam name="attributes.Feature_ID" default="0">

<cftry>

	<cfquery name="qry_get_review"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT R.Review_ID, R.Feature_ID, R.Anonymous, R.Anon_Name, R.Anon_Loc, R.Anon_Email, R.Posted, R.Title, R.Comment, R.Rating, R.NeedsCheck, U.Username, R.User_ID
	FROM #Request.DB_Prefix#FeatureReviews R 
	LEFT JOIN #Request.DB_Prefix#Users U on R.User_ID = U.User_ID
	WHERE R.Review_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Review_ID#">
	<cfif request.appsettings.FeatureReview_Add is "2" AND attributes.do is not "manager">
		AND U.EmailLock = 'verified'
	</cfif>		
	<cfif ListFind("write,delete", attributes.do)>
		<!--- Disable edits, not allowed for users, admin has separate form --->
		AND 0 = 1
		<!--- AND R.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.UID#"> --->
	<cfelse>
		AND R.Approved = 1
	</cfif>
	</cfquery>
			
	<cfif qry_get_review.recordcount>
		<cfset attributes.Feature_ID = qry_get_review.Feature_ID>
	<cfelse>
		<cfset attributes.Review_ID = 0>
	</cfif>
	
	<!--- Get Item record for header --->		
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


<cfcatch type="Any">
	<cfset invalid = 1>
</cfcatch>
</cftry>
