
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the updates from the List Edit Form for pages. Called by page.admin&do=actform --->

<cfparam name="attributes.cid" default="">

<cfloop index="page_ID" list="#attributes.pageList#">

<cfset Priority = Evaluate("attributes.Priority#page_ID#")>
<cfset Display = iif(isDefined("attributes.Display#page_ID#"),1,0)>
<cfset Parent_id = evaluate("attributes.Parent_id#page_ID#")>

<cfif parent_id is 0 and page_id is not 0>
	<cfset title_priority = 0>
	<cfif NOT isNumeric(Priority) OR Priority IS 0>
		<cfset Priority = 9999>
	</cfif>
<cfelseif page_id is Parent_id>
	<cfset title_priority = priority>
	<cfset priority = 0>
<cfelse>
	<cfset title_priority = 0>
	<cfif NOT isNumeric(Priority) OR Priority IS 0>
		<cfset Priority = 9999>
	</cfif>
</cfif>
	
				
<cfquery name="Updatepage" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Pages
	SET 
	<cfif page_id is not "0">
	Display = #Display#,
	</cfif>
	Priority = #Priority#,
	Title_Priority = #title_priority#
	WHERE Page_ID = #page_ID#
</cfquery>

</cfloop>



