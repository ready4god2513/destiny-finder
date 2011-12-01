
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the updates from the List Edit Form for categories. Called by category.admin&category=actform --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=category.admin&category=list">
<cfloop list="pid,cid,catcore_id,name,accesskey,display,highlight,sale" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>	


<cfloop index="Category_ID" list="#attributes.CategoryList#">

<cfset Priority = Evaluate("attributes.Priority#Category_ID#")>
<cfset CColumns = Trim(Evaluate("attributes.CColumns#Category_ID#"))>
<cfset PColumns = Trim(Evaluate("attributes.PColumns#Category_ID#"))>
<cfset Display = iif(isDefined("attributes.Display#Category_ID#"),1,0)>
<cfset Highlight = iif(isDefined("attributes.Highlight#Category_ID#"),1,0)>
<cfset Sale = iif(isDefined("attributes.Sale#Category_ID#"),1,0)>


<cfif NOT isNumeric(Priority) OR Priority IS 0>
<cfset Priority = 9999>
</cfif>

<cfquery name="UpdateCategory" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#Categories
SET Priority = #Priority#,
CColumns = <cfif len(CColumns) AND CColumns GTE 1>#CColumns#,<cfelse>NULL,</cfif>
PColumns = <cfif len(PColumns) AND PColumns GTE 1>#PColumns#,<cfelse>NULL,</cfif>
Display = #Display#,
Highlight = #Highlight#, 
Sale = #Sale#
WHERE Category_ID = #Category_ID#
</cfquery>
</cfloop>

<!--- Reset cached query --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfinclude template="../../category/qry_get_topcats.cfm">


		

		
			
