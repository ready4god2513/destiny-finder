
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to take the select box selections and create the dates. Called by dsp_reports.cfm --->

<cfset StartMonth = attributes.StartMonth>
<cfset StartDay = attributes.StartDay>
<cfset StartYear = attributes.StartYear>
<cfset ToMonth = attributes.ToMonth>
<cfset ToDay = attributes.ToDay>
<cfset ToYear = attributes.ToYear>

<cfset CheckStart = CreateDate(StartYear, StartMonth, 1)>
<cfset CheckTo = CreateDate(ToYear, ToMonth, 1)>

<cfif StartDay LTE DaysInMonth(CheckStart)>
<cfset StartDate = CreateDateTime(StartYear, StartMonth, StartDay, "0", "0", "0")>
<cfelse>
<cfset StartDate = CreateDateTime(StartYear, StartMonth, DaysInMonth(CheckStart), "0", "0", "0")>
</cfif>

<cfif ToDay LTE DaysInMonth(CheckTo)>
<cfset ToDate = CreateDateTime(ToYear, ToMonth, ToDay, "23", "59", "59")>
<cfelse>
<cfset ToDate = CreateDateTime(ToYear, ToMonth, DaysInMonth(CheckTo), "23", "59", "59")>
</cfif>

<cfset printstring = "StartMonth=#StartMonth#&StartDay=#StartDay#&StartYear=#StartYear#&ToMonth=#ToMonth#&ToDay=#ToDay#&ToYear=#ToYear#">

