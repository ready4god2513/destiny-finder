<cfquery name="qEvent" datasource="#APPLICATION.DSN#">
	SELECT * 
	FROM Calendar_events
	WHERE calevent_id = #ATTRIBUTES.calevent_id#
</cfquery>

<cfquery name="qCategories" datasource="#APPLICATION.DSN#">
	SELECT event_cat_id,event_cat_name
	FROM Event_Categories
	ORDER BY event_cat_sortorder ASC
	</cfquery>
	
	
	<!--- DIVIDE THE TOTAL NUMBER OF CATEGORY GROUPS BY 3 TO EQUALLY DISTRIBUTE THE HEADINGS OVER THE 3 COLUMNS --->
	<cfset VARIABLES.column_count = ceiling(qCategories.recordcount / 3)  >

	<!--- SET THE STARTING ROW NUMBER, THIS WILL BE INCREMENTED ACCORDINGLY FOR FOLLOWING COLUMNS --->
	<cfset VARIABLES.start_row = 1 >
	<cfset VARIABLES.end_row = VARIABLES.column_count>
	
<cfoutput>
	<table width="98%" border="0" cellpadding="4" cellspacing="0">
    <tr valign="top">
      <td width="33%">

	  <cfset VARIABLES.value_array = ListToArray(qEvent.calevent_cat)>
	  
	<cfloop query="qCategories" startrow="#VARIABLES.start_row#" endrow="#VARIABLES.end_row#">
		<input type="checkbox" name="calevent_cat" value="#qCategories.event_cat_id#" <cfloop from="1" to="#arraylen(VARIABLES.value_array)#" index="i" step="1"> 
<cfif VARIABLES.value_array[i] EQ qCategories.event_cat_id>
checked</cfif></cfloop>> #qcategories.event_cat_name#<br/>
	  </cfloop>
	  </td>
	  <td width="33%">
	  <!--- SET THE STARTING ROW FOR THE NEXT COLUMN --->
	  <cfset VARIABLES.start_row = VARIABLES.column_count + VARIABLES.start_row>
	  <cfset VARIABLES.end_row = VARIABLES.end_row +  VARIABLES.column_count>
	  
	<cfloop query="qCategories" startrow="#VARIABLES.start_row#" endrow="#VARIABLES.end_row#">
		<input type="checkbox" name="calevent_cat" value="#qCategories.event_cat_id#" <cfloop from="1" to="#arraylen(VARIABLES.value_array)#" index="i" step="1"> 
<cfif VARIABLES.value_array[i] EQ qCategories.event_cat_id>
checked</cfif></cfloop>> #qcategories.event_cat_name#<br/>
	  </cfloop>
	  </td>
	  <td width="33%">
	  <!--- SET THE STARTING ROW FOR THE NEXT COLUMN --->
	  <cfset VARIABLES.start_row = VARIABLES.column_count + VARIABLES.start_row>
	  <cfset VARIABLES.end_row = VARIABLES.end_row +  VARIABLES.column_count>
	  
	<cfloop query="qCategories" startrow="#VARIABLES.start_row#" endrow="#VARIABLES.end_row#">
		<input type="checkbox" name="calevent_cat" value="#qCategories.event_cat_id#" <cfloop from="1" to="#arraylen(VARIABLES.value_array)#" index="i" step="1"> 
<cfif VARIABLES.value_array[i] EQ qCategories.event_cat_id>
checked</cfif></cfloop>> #qcategories.event_cat_name#<br/>
	  </cfloop>
	  </td>
	  </tr>
	  </table>
	  </cfoutput>