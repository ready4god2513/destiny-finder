<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Saves the Product Review Settings. Called from produts.admin&review=settings. --->

<cfquery name="EditUserSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Settings
	SET 
	ProductReviews = #attributes.ProductReviews#,
	ProductReview_Approve = #attributes.ProductReview_Approve#,
	ProductReview_Flag = #attributes.ProductReview_Flag#,
	ProductReview_Add = #attributes.ProductReview_Add#,
	ProductReview_Rate = #attributes.ProductReview_Rate#,
	ProductReviews_Page = #attributes.ProductReviews_Page#
</cfquery>

<!--- Get New Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfinclude template="../../../queries/qry_getsettings.cfm">

