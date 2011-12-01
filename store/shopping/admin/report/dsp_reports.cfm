
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

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Order Manager"
	Width="600"
	menutabs="yes">
	
	<cfinclude template="../order/dsp_menu.cfm">
	
<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext" style="color:###Request.GetColors.InputTText#">		

	<cfif StartDate IS "">
		<tr>
			<td align="CENTER">		
			<p><br/>	No orders found in the database.</p>
			</td></tr>
			
	<cfelseif isdefined("attributes.submit_report")>

		<tr>
			<td align="CENTER">
				<cfinclude template="act_parse_dates.cfm">
				<cfinclude template="qry_report#attributes.Report#.cfm">
				<cfinclude template="dsp_report#attributes.Report#.cfm">
			</td>
			
			<td align="CENTER"><br/>
				<form action="#self#?fuseaction=shopping.admin&order=reports#request.token2#"
			method="post">
				<input type="submit" value="Select New Report" class="formbutton"/> 
				<input type="button" value="Print this Report" class="formbutton" onclick="JavaScript:newWindow=window.open( '#self#?fuseaction=shopping.admin&order=printreport&report=#attributes.report#&#printstring##request.token2#', 'Report', 'width=550,height=400,toolbar=1,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1' ); newWindow.focus()"/>
				</form>
			</td>
			
		</tr>
		
	<cfelse>
	
			<form action="#self#?#cgi.query_string#" method="post">
			
			<!--- Start Date --->
			<tr><td colspan="3">
			<img src="#request.appsettings.defaultimages#/spacer.gif" alt="" height="12" width="1" /></td></tr>
			<tr>
				<td align="RIGHT" width="35%">Start Date:</td>
				<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
				<td width="65%">
				<select name="StartMonth" size="1" class="formfield">
				<cfloop index="num" from="1" to="12">
					<option value="#num#" #doSelected(num,NowMonth)#>#MonthAsString(num)#</option>
				</cfloop>
				</select>

				<select name="StartDay" size="1" class="formfield">
				<cfloop index="num" from="1" to="31">
					<option value="#num#" #doSelected(num,1)#>#num#</option>
				</cfloop>
				</select>

				<select name="StartYear" size="1" class="formfield">
				<cfloop index="num" from="#Year(StartDate)#" to="#NowYear#">
					<option value="#num#" #doSelected(num,NowYear)#>#num#</option>
				</cfloop>
				</select>
				
				</td>
			</tr>
	
			<!--- To Date --->
			<tr>
				<td align="RIGHT">Through Date:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
				<td>
					<select name="ToMonth" size="1" class="formfield">
					<cfloop index="num" from="1" to="12">
					<option value="#num#" #doSelected(num,NowMonth)#>#MonthAsString(num)#</option>
					</cfloop>
					</select>

					<select name="ToDay" size="1" class="formfield">
					<cfloop index="num" from="1" to="31">
					<option value="#num#" #doSelected(num,NowDays)#>#num#</option>
					</cfloop>
					</select>

					<select name="ToYear" size="1" class="formfield">
					<cfloop index="num" from="#Year(StartDate)#" to="#NowYear#">
					<option value="#num#" #doSelected(num,NowYear)#>#num#</option>
					</cfloop>
					</select>
				</td>
			</tr>
			
			<!--- Report --->
			<tr>
				<td align="RIGHT">Report:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
				<td>
					<select name="Report" size="1" class="formfield">
					<option value="1">Sales Summary</option>
					<option value="2">Product Totals (by ID)</option>
					<option value="8">Products Totals (by SKU)</option>
					<option value="3">Top Products by Quantity  (by ID)</option>
					<option value="9">Top Products by Quantity (by SKU)</option>
					<option value="4">Top Products by Total Sales (by ID)</option>
					<option value="10">Top Products by Total Sales (by SKU) </option>
					<option value="5">Sales Tax Report</option>
					<option value="6">Affiliate Sales</option>
					<option value="7">Coupon Totals</option>
					</select>
				</td>
			</tr>
			
			<cfinclude template="../../../includes/form/put_space.cfm">
			
			<tr>
				<td colspan="2"></td>
				<td><br/><input type="submit" name="submit_report" value="View Report" class="formbutton"/>
				</td>	
			</tr>	
		</form>
		
		<cfinclude template="../../../includes/form/put_requiredfields.cfm">
		
			</td>
		</tr>

	</cfif>

	</table>
</cfoutput>
</cfmodule>
