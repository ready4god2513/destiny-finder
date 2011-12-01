
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the updates from the List Edit Form for features. Called by feature.admin&feature=actform --->

<cfparam name="attributes.cid" default="">

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=Feature.admin&Feature=list">
	<cfloop list="uid,username,search_string,feature_type,accesskey,display_status,highlight,order,cid" index="counter">
<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
	<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
</cfif>
</cfloop>

<cfloop index="Feature_ID" list="#attributes.FeatureList#">

<cfset Priority = Evaluate("attributes.Priority#Feature_ID#")>
<cfset start = Trim(Evaluate("attributes.start#Feature_ID#"))>
<cfset expire = Trim(Evaluate("attributes.expire#Feature_ID#"))>
<cfset Display = iif(isDefined("attributes.Display#Feature_ID#"),1,0)>
<cfset Highlight = iif(isDefined("attributes.Highlight#Feature_ID#"),1,0)>
<cfset Approved = iif(isDefined("attributes.approved#Feature_ID#"),1,0)>


<cfif NOT isNumeric(Priority) OR Priority IS 0>
	<cfset Priority = 9999>
</cfif>

<cfquery name="UpdateFeature" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Features
	SET Priority = #Priority#,
	Start = <cfif isDate(start)>#CreateODBCDate(start)#,<cfelse>NULL,</cfif>
	Expire = <cfif isDate(expire)>#CreateODBCDate(expire)#,<cfelse>NULL,</cfif>
	Display = #Display#,
	Highlight = #Highlight#, 
	Approved = #Approved#
	WHERE Feature_ID = #Feature_ID#
</cfquery>
</cfloop>

			


