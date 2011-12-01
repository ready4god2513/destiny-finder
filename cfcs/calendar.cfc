<cfcomponent displayname="Calendar" output="no" hint="I handle any calendar functions">

 <cffunction name="getDatesFromDayOfWeek" output="false" returntype="struct">
    <cfargument name="dayOfWeek" required="true" type="string">
    <cfargument name="year" required="true" type="numeric">

    <!--- initialize --->
    <cfset var d = 0>
    <cfset var weekNo = 0>
    <cfset var day = "">
    <cfset var currentDate = "">
    <cfset var dayAsString = "">
    <cfset var days = "Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday">

    <!--- index of given day in days list --->
    <cfset var dayIndex = listFindNoCase(days, arguments.dayOfWeek)>
    <cfset var result = structnew()>
    <cfset result.isInputValid=false>
    <cfset result.dates = arrayNew(1)>

    <!--- validate input --->
    <!--- added: validation, year must be int --->
    <cfif dayIndex NEQ 0 and isNumeric(arguments.year) and arguments.year GT 0 and int(arguments.year) EQ arguments.year>
        <cfset result.isInputValid=true>
    </cfif>

    <cfif result.isInputValid>
         <!--- added: get out of loop when date matched, and set locale. Thanks to A. Cameron's feedback  --->
        <cfloop index="d" from="1" to="7">
            <!--- day in first week (of January) of the given year --->
            <cfset day = createDate(arguments.year,1,d)>
            <!--- day name (in the language of the locale!) --->
            <cfset dayAsString = dayofWeekAsString(dayOfWeek(day),setLocale("English (US)"))>
            <!--- find match with the given day--->

            <cfif dayAsString is arguments.dayOfWeek>
                <cfset result.dates[1]= day>
                <cfbreak>
            </cfif>

        </cfloop>
        
       <!---  roll out the rest of the week-days of the year sharing same day name --->
       <cfloop from="1" to="52" index="weekNo">
           <cfset currentdate = dateAdd("ww",weekNo,day)>

           <!--- week 53 may lap over to next year --->
           <cfif year(currentdate) EQ arguments.year>
               <!--- following week --->
               <cfset result.dates[weekNo+1]= currentdate>
           </cfif>

       </cfloop>

    </cfif>  

    <cfreturn result>  

</cffunction>


</cfcomponent>