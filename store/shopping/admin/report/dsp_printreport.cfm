
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Runs the store reports. Displays the form to select the date range and report type and after submitting the form, displays the selected report. Called by shopping.admin&order=reports --->


<cfloop list="startday,startmonth,startyear,today,tomonth,toyear" index="counter">
	<cfparam name="attributes.#counter#" default="">
</cfloop>
				
<cfquery name="GetStartDate" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT MIN(DateOrdered) AS GetDate 
FROM #Request.DB_Prefix#Order_No 
</cfquery>

<cfset StartDate = GetStartDate.GetDate>

<cfset NowMonth = Month(Now())>
<cfset NowYear = Year(Now())>
<cfset NowDays = DaysInMonth(Now())>
<cfset ThisMonth = CreateDate(NowYear, NowMonth, NowDays)>


<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#">		

		<tr>
			<td align="CENTER">
				<cfinclude template="act_parse_dates.cfm">
				<cfinclude template="qry_report#attributes.Report#.cfm">
				<cfinclude template="dsp_report#attributes.Report#.cfm">
			</td>	
		</tr>	
	</table>
</cfoutput>