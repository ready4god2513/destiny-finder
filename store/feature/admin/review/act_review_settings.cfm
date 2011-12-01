<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Saves the Feature Review Settings. Called from produts.admin&review=settings. --->

<cfquery name="EditUserSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Settings
	SET 
	FeatureReviews = <cfif len(attributes.FeatureReviews)>#attributes.FeatureReviews#<cfelse>0</cfif>,
	FeatureReview_Approve = #attributes.FeatureReview_Approve#,
	FeatureReview_Flag = #attributes.FeatureReview_Flag#,
	FeatureReview_Add = #attributes.FeatureReview_Add#
</cfquery>

<!--- Get New Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfinclude template="../../../queries/qry_getsettings.cfm">


