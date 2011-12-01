<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- If on the edit page, check the user's permission level --->
<cfparam name="attributes.do" default="display">
<!--- Used to check for invalid query strings --->
<cfparam name="invalid" default="0">

<cfmodule template="../../access/secure.cfm" keyname="product" requiredPermission="64">

<cfif ListFind("write,delete", attributes.do) AND NOT ispermitted>
	<cfset attributes.UID = Session.User_ID>
<cfelse>
	<cfparam name="attributes.UID" default="#Session.User_ID#">
</cfif>

<!--- Get the review --->	
<cfparam name="attributes.Review_ID" default="0">
<cfparam name="attributes.product_ID" default="0">

<cftry>
	<cfquery name="qry_get_review"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	<cfif Request.dbtype IS "Access">
		SELECT IIF(R.Helpful_Total=0,0,R.Helpful_Yes/R.Helpful_Total) AS Helpful,
	<cfelse>
		SELECT CASE WHEN R.Helpful_Total > 0 THEN R.Helpful_Yes/R.Helpful_Total ELSE 0 END AS Helpful,
	</cfif>
	R.Helpful_Yes, R.Helpful_Total, R.Review_ID, R.Product_ID, R.Anonymous, R.Anon_Name, 
	R.Anon_Loc, R.Anon_Email, R.Posted, R.Title, R.Rating AS Avg_Rating, R.Comment, R.Rating, R.NeedsCheck, 
	U.Username, R.User_ID, R.Recommend
	FROM #Request.DB_Prefix#ProductReviews R 
	LEFT JOIN #Request.DB_Prefix#Users U ON R.User_ID = U.User_ID
	WHERE R.Review_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Review_ID#">
	<cfif ListFind("write,delete", attributes.do)>
		AND R.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.UID#">
	</cfif>
	</cfquery>
	
	<cfif qry_get_review.recordcount>
		<cfset attributes.product_ID = qry_get_review.product_ID>
	<cfelse>
		<cfset attributes.Review_ID = 0>
	</cfif>
			
	<!--- Get Item record for header --->		
	<cfquery name="GetDetail"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
		SELECT Product_ID, Name, Sm_Image, Short_Desc, User_ID FROM #Request.DB_Prefix#Products 
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.product_ID#">
	</cfquery>
	
	<cfscript>
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
	</cfscript>

<cfcatch type="Any">
	<cfset invalid = 1>
</cfcatch>
</cftry>

		