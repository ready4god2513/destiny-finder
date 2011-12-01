<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used for creating a variety of drop-down select boxes in the store. --->


<cfif thistag.executionmode IS 'start'>
<!-- DROPDOWN - RANGE OF NUMBERS -->
<cfif NOT CompareNoCase(attributes.mode,"numbered")>
	<cfloop
		index="iatools_dropdown"
		from="#attributes.from#"
		to="#attributes.to#"
		step="#attributes.step#">	
	<cfif NOT CompareNoCase(iatools_dropdown,attributes.selected)>
	<cfoutput><option value="#iatools_dropdown#" selected="selected">#iatools_dropdown#</option></cfoutput>
	<cfelse>
	<cfoutput><option value="#iatools_dropdown#">#iatools_dropdown#</option></cfoutput>
	</cfif>
	</cfloop>
</cfif>

<!--- DROPDOWN - USES KEY/VALUE --->
<cfif NOT CompareNoCase(attributes.mode,"combolist")>
	<cfloop
		index="iatools_dropdown"
		list="#attributes.valuelist#">
		
	<cfset key = ReReplace(iatools_dropdown,"\|.*","")>
	<cfset value = ReReplace(iatools_dropdown,".*\|","")>
	<cfif NOT CompareNoCase(value,attributes.selected)>
	<cfoutput><option value="#value#" selected="selected">#key#</option></cfoutput>
	<cfelse>
	<cfoutput><option value="#value#">#key#</option></cfoutput>
	</cfif>
	</cfloop>
</cfif>

<!--- DROPDOWN - USES LIST --->
<cfif NOT CompareNoCase(attributes.mode,"valuelist")>
	<cfloop
		index="iatools_dropdown"
		list="#attributes.valuelist#">
		
	<cfif NOT CompareNoCase(Trim(iatools_dropdown),Trim(attributes.selected)) OR ListFind(attributes.selected,Trim(iatools_dropdown))>
	<cfoutput><option value="#Trim(iatools_dropdown)#" selected="selected">#Trim(iatools_dropdown)#</option></cfoutput>
	<cfelse>
	<cfoutput><option value="#Trim(iatools_dropdown)#">#Trim(iatools_dropdown)#</option></cfoutput>
	</cfif>
	</cfloop>
</cfif>

<!--- DROPDOWN - 0/1 --->
<cfif NOT CompareNoCase(attributes.mode,"boolean")>
	<cfloop
		index="dropdown"
		list="YES|1,NO|0">
		
	<cfset key = ReReplace(dropdown,"\|.*","")>
	<cfset value = ReReplace(dropdown,".*\|","")>
		
	<cfif NOT CompareNoCase(value,attributes.selected)>
	<cfoutput><option value="#value#" selected="selected">#key#</option></cfoutput>
	<cfelse>
	<cfoutput><option value="#value#">#key#</option></cfoutput>
	</cfif>
	</cfloop>
</cfif>

<!--- DROPDOWN - TIME  --->
<cfif NOT CompareNoCase(attributes.mode,"time")>

	<cfparam name="set_time" default="">
	<cfparam name="dropdown_hour_marked" default="#TimeFormat(Now(),"hh")#">
	<cfparam name="dropdown_minute_marked" default="#DatePart('n',Now())#">
	<cfparam name="dropdown_period_marked" default="#TimeFormat(Now(),"tt")#">

	<cfparam name="step" default="15">
	
	<cfif isDefined("attributes.set_time")>
		<cfset set_time = attributes.set_time>
	</cfif>

	<cfif isDefined("attributes.step")>
		<cfset step = attributes.step>
	</cfif>
	
<!--- SET TIME BY FULL TIME SENT --->
	<cfif isDate(set_time)>
		<cfset dropdown_hour_marked	 ="#TimeFormat(set_time,"hh")#">
		<cfset dropdown_minute_marked  ="#TimeFormat(set_time,"mm")#">
		<cfset dropdown_period_marked  ="#TimeFormat(set_time,"tt")#">
	<cfelse>
<!--- SET TIME BY INDIVIDUAL ATTRIBUTES --->		
		<cfif isDefined("attributes.hour")>
			<cfset dropdown_hour_marked = attributes.hour>
			<cfset dropdown_minute_marked = attributes.minute>
			<cfset dropdown_period_marked=attributes.period>
		
<!--- SET TIME BY NUMBER OF MINUTES TO ADD --->
		<cfelseif isDefined("attributes.add_minutes")>
			<cfset dropdown_hour_marked ="#TimeFormat(dateadd('n',attributes.add_minutes,Now()),"hh")#">
			<cfset dropdown_minute_marked ="#TimeFormat(dateadd('n',attributes.add_minutes,Now()),"mm")#">
			<cfset dropdown_period_marked ="#TimeFormat(dateadd('n',attributes.add_minutes,Now()),"tt")#">
		</cfif>
	</cfif>

	<!--- HOUR --->
	
	<cfoutput><select name="#attributes.label#_hour" class="formfield"></cfoutput>
	<cfif isDefined("attributes.blank")>
		<cfoutput><option value=""> - </option></cfoutput>
	</cfif>
	<cfloop index="hourname" from="1" to="12">
		<cfif NOT Compare(Replace(dropdown_hour_marked,"0",""),hourname)
			and NOT isDefined("attributes.blank")>
			<cfset marked=" selected='selected'">
		<cfelse>
			<cfset marked="">		
		</cfif>
		<cfoutput><option value="#hourname#"#marked#>#hourname#</option></cfoutput>
	</cfloop>
	<cfoutput></select></cfoutput>

	<!--- MINUTE --->
	<cfoutput><select name="#attributes.label#_minute" class="formfield"></cfoutput>
	<cfif isDefined("attributes.blank")>
		<cfoutput><option value=""> - </option></cfoutput>
	</cfif>
	<cfloop index="minute" from="0" to="59" step="#step#">
		<cfif minute GTE dropdown_minute_marked AND minute LT dropdown_minute_marked+step>
			<cfset marked=" selected='selected'">
		<cfelseif len(minute) LT 2>
			<cfset minute = "0#minute#">
		<cfelse>
			<cfset marked="">		
		</cfif>
		<cfif NOT minute>
			<cfset minute = "00">
		</cfif>
		<cfoutput><option value="#minute#"#marked#>#minute#</option>
		</cfoutput>
	</cfloop>
	<cfoutput></select></cfoutput>

	<!--- AM/PM --->
	<cfoutput><select name="#attributes.label#_period" class="formfield"></cfoutput>
	<cfif isDefined("attributes.blank")>
		<cfoutput><option value=""> - </option></cfoutput>
	</cfif>
	
	<cfloop index="period" list="AM,PM">
		<cfif NOT CompareNoCase(dropdown_period_marked,period) and NOT isDefined("attributes.blank")>
			<cfset marked=" selected='selected'">
		<cfelse>
			<cfset marked="">		
		</cfif>
		<cfoutput><option value="#period#"#marked#>#period#</option></cfoutput>
	</cfloop>
	<cfoutput></select></cfoutput>
</cfif>

<!--- DROPDOWN - MONTH/DATE/YEAR  --->
<cfif NOT CompareNoCase(attributes.mode,"date")>
	
	<cfparam name="dropdown_month_marked" default="#DatePart('m',Now())#">
	<cfparam name="dropdown_date_marked" default="#DatePart('d',Now())#">
	<cfparam name="dropdown_year_marked" default="#DatePart('yyyy',Now())#">
	<cfparam name="set_date" default="">
	<cfparam name="First_of_Month" default="0">
	<cfparam name="year_range" default="10">
	<cfparam name="start_year" default="0">
	<cfparam name="add_months" default="0">
		
	<cfif isDefined("attributes.add_months")>
		<cfset add_months = attributes.add_months>
	</cfif>
		
	<cfif isDefined("attributes.set_date")>
		<cfset set_date = attributes.set_date>
	</cfif>

	<cfif isDefined("attributes.start_year")>
		<cfset start_year = attributes.start_year>
	</cfif>

	<cfif isDefined("attributes.First_of_Month")>
		<cfset first_of_month = attributes.first_of_month>
	</cfif>
		
	<cfif isDefined("attributes.year_range")>
		<cfset year_range = attributes.year_range>
	</cfif>


<!--- SET DATE BY FULL DATE SENT --->
	<cfif isDate(set_date)>
		<cfset dropdown_month_marked ="#DatePart('m',dateformat(set_date))#">
		<cfset dropdown_date_marked ="#DatePart('d',dateformat(set_date))#">
		<cfset dropdown_year_marked ="#DatePart('yyyy',dateformat(set_date))#">
	<cfelse>
<!--- SET DATE BY INDIVIDUAL ATTRIBUTES --->		
		<cfif isDefined("attributes.month") AND NOT first_of_month>

			<cfif isDefined("attributes.month")>
				<cfset dropdown_month_marked = attributes.month>
			</cfif>
			<cfif isDefined("attributes.date")>
				<cfset dropdown_date_marked = attributes.date>
			</cfif>
			<cfif isDefined("attributes.year")>
				<cfset dropdown_year_marked = attributes.year>
			</cfif>
			
<!--- SET DATE BY INDIVIDUAL ATTRIBUTES, BUT USE First OF Month --->
		<cfelseif first_of_month>
			<cfif NOT Compare(DatePart('d',Now()),1)>
				<cfset add_months = attributes.add_months>
			<cfelse>
				<cfset add_months = attributes.add_months+1>
			</cfif>
		
			<cfset dropdown_month_marked  ="#DatePart('m',dateadd('m',add_months,Now()))#">
			<cfset dropdown_date_marked ="01">
			<cfset dropdown_year_marked  ="#DatePart('yyyy',dateadd('m',add_months,Now()))#">

<!--- SET DATE BY NUMBER OF MONTHS TO ADD --->
		<cfelseif isDefined("attributes.add_months")>

			<cfset dropdown_month_marked ="#DatePart('m',dateadd('m',attributes.add_months,Now()))#">
			<cfset dropdown_date_marked ="#DatePart('d',dateadd('m',attributes.add_months,Now()))#">
			<cfset dropdown_year_marked ="#DatePart('yyyy',dateadd('m',attributes.add_months,Now()))#">
		</cfif>
	</cfif>

	<!--- MONTH ---->
	<cfoutput><select name="#attributes.label#_month" class="formfield"></cfoutput>
	<cfif isDefined("attributes.blank")>
		<cfoutput><option value=""> </option></cfoutput>
	</cfif>
	<cfloop index="monthname" from="1" to="12">
		<cfif NOT Compare(dropdown_month_marked,monthname) and NOT isDefined("attributes.blank")>
			<cfset marked=" selected='selected'">
		<cfelse>
			<cfset marked="">		
		</cfif>
		<cfoutput><option value="#monthname#"#marked#>#MonthAsString(monthname)#</option></cfoutput>
	</cfloop>
	<cfoutput></select></cfoutput>

	<!--- DATE --->
	<cfoutput><select name="#attributes.label#_date" class="formfield"></cfoutput>
	<cfif isDefined("attributes.blank")>
		<cfoutput><option value=""> </option></cfoutput>
	</cfif>
	<cfloop index="date" from="1" to="31">
		<cfif NOT Compare(dropdown_date_marked,date) and NOT isDefined("attributes.blank")>
			<cfset marked=" selected='selected'">
		<cfelse>
			<cfset marked="">		
		</cfif>
		<cfoutput><option value="#date#"#marked#>#date#</option></cfoutput>
	</cfloop>
	<cfoutput></select></cfoutput>

	<!--- YEAR --->
	<cfoutput><select name="#attributes.label#_year" class="formfield"></cfoutput>
	<cfif isDefined("attributes.blank")>
		<cfoutput><option value=""> </option></cfoutput>
	</cfif>
	
	<cfif dropdown_year_marked GTE DatePart('yyyy',Now())>
		<cfset dropdown_year_from = DatePart('yyyy',Now())-1>
	<cfelse>
		<cfset dropdown_year_from = dropdown_year_marked>	
	</cfif>
	
	<cfif dropdown_year_marked GTE DatePart('yyyy',Now())+year_range>
		<cfset dropdown_year_to = dropdown_year_marked+year_range>

	<cfelse>
		<cfset dropdown_year_to = DatePart('yyyy',Now())+year_range>
	</cfif>

	<cfif start_year>
		<cfset syear = start_year>
	<cfelse>
		<cfset syear = evaluate(DatePart('yyyy',CreateDate(dropdown_year_from,01,01)))>	
	</cfif>
	
	<cfloop index="year"
		from="#syear#"
		to="#dropdown_year_to#">
		<cfif NOT Compare(dropdown_year_marked,year) and NOT isDefined("attributes.blank")>
			<cfset marked=" selected='selected'">
		<cfelse>
			<cfset marked="">		
		</cfif>
		<cfoutput><option value="#year#"#marked#>#year#</option></cfoutput>
	</cfloop>
	<cfoutput></select></cfoutput>
</cfif>

<!--- ASSEMBLE DATE  --->
<cfif NOT CompareNoCase(attributes.mode,"assemble_date")>
	
	<cfparam name="assemble_month" default="#DatePart('m',Now())#">
	<cfparam name="assemble_date" default="#DatePart('d',Now())#">
	<cfparam name="assemble_year" default="#DatePart('yyyy',Now())#">

	<cfif isDefined("attributes.month")>
		<cfset assemble_month = attributes.month>
	</cfif>

	<cfif isDefined("attributes.date")>
		<cfset assemble_date = attributes.date>
	</cfif>

	<cfif isDefined("attributes.year")>
		<cfset assemble_year = attributes.year>
	</cfif>

	<cfif NOT isDate("#MonthAsString(assemble_month)# #assemble_date#, #assemble_year#")>
		<cfset error_message = "<font color='red'><b>ERROR:</b></font> #MonthAsString(assemble_month)# #assemble_date#, #assemble_year# is an invalid date.">
		<cfset caller.assembled_date = CreateODBCDate(Now())>
	<cfelse>
	<cfset caller.assembled_date = CreateODBCDate(CreateDate(assemble_year,assemble_month,assemble_date))>
	</cfif>
</cfif>

<!--- ASSEMBLE TIME  --->
<cfif NOT CompareNoCase(attributes.mode,"assemble_time")>
	
	<cfparam name="assemble_hour" default="#TimeFormat(Now(),"hh")#">
	<cfparam name="assemble_minute" default="#TimeFormat(Now(),"mm")#">
	<cfparam name="assemble_period" default="#TimeFormat(Now(),"tt")#">

	<cfif isDefined("attributes.minute")>
		<cfset assemble_minute = attributes.minute>
	</cfif>

	<cfif isDefined("attributes.hour")>
		<cfset assemble_hour = attributes.hour>
	</cfif>

	<cfif isDefined("attributes.period")>
		<cfset assemble_period = attributes.period>
	</cfif>

	<cfif NOT isDate("#assemble_hour#:#assemble_minute#:00 #assemble_period#")>
		<cfset caller.error_message = "<font color='red'><b>ERROR:</b></font> #MonthAsString(assemble_month)# #assemble_date#, #assemble_year# IS an invalid date.">
		<cfset caller.assembled_time = CreateODBCTime(Now())>
	<cfelse>
	
		<cfset hour_mod = TimeFormat("#assemble_hour#:#assemble_minute# #assemble_period#", "HH:MM TT")>

		<cfset caller.assembled_time = CreateODBCTime("#hour_mod#")>
	</cfif>
</cfif>

<!--- ASSEMBLE DATE/TIME  --->
<cfif NOT CompareNoCase(attributes.mode,"assemble_datetime")>
	
	<cfparam name="assemble_month" default="#DatePart('m',Now())#">
	<cfparam name="assemble_date" default="#DatePart('d',Now())#">
	<cfparam name="assemble_year" default="#DatePart('yyyy',Now())#">

	<cfparam name="assemble_hour" default="#TimeFormat(Now(),"hh")#">
	<cfparam name="assemble_minute" default="#TimeFormat(Now(),"mm")#">
	<cfparam name="assemble_period" default="#TimeFormat(Now(),"tt")#">

	<cfif isDefined("attributes.month")>
		<cfset assemble_month = attributes.month>
	</cfif>

	<cfif isDefined("attributes.date")>
		<cfset assemble_date = attributes.date>
	</cfif>

	<cfif isDefined("attributes.year")>
		<cfset assemble_year = attributes.year>
	</cfif>

	<cfif isDefined("attributes.minute")>
		<cfset assemble_minute = attributes.minute>
	</cfif>

	<cfif isDefined("attributes.hour")>
		<cfset assemble_hour = attributes.hour>
	</cfif>

	<cfif isDefined("attributes.period")>
		<cfset assemble_period = attributes.period>
	</cfif>

	<cfif NOT isDate("#MonthAsString(assemble_month)# #assemble_date#, #assemble_year# #assemble_hour#:#assemble_minute#:00 #assemble_period#")>

		<cfset caller.error_message = "<font color='red'><b>ERROR:</b></font> #MonthAsString(assemble_month)# #assemble_date#, #assemble_year# IS an invalid date.">
		<cfset caller.assembled_datetime = CreateODBCDatetime(Now())>
	<cfelse>
		<cfset hour_mod = TimeFormat("#assemble_hour#:#assemble_minute# #assemble_period#", "HH")>
	
	<cfset date_block = CreateDatetime(assemble_year,assemble_month,assemble_date,hour_mod,assemble_minute,"00")>

	<cfset caller.assembled_datetime =
		 CreateODBCDatetime("#date_block#")>
	</cfif>
</cfif>

</cfif>
