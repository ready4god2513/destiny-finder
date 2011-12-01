<cfparam name="ATTRIBUTES.item_table" default="">
<cfparam name="ATTRIBUTES.item_primary_key" default="">
<cfparam name="ATTRIBUTES.item_primary_key_value" default="">
<cfparam name="ATTRIBUTES.item_cat_col" default="">
<cfparam name="ATTRIBUTES.cat_id_col" default="">
<cfparam name="ATTRIBUTES.cat_name_col" default="">
<cfparam name="ATTRIBUTES.cat_sort_col" default="">
<cfparam name="ATTRIBUTES.category_table" default="">

<cfquery name="qItem" datasource="#APPLICATION.DSN#">
	SELECT * 
	FROM #ATTRIBUTES.item_table#
	WHERE #ATTRIBUTES.item_primary_key# = #ATTRIBUTES.item_primary_key_value#
</cfquery>

<cfquery name="qCategories" datasource="#APPLICATION.DSN#">
	SELECT #ATTRIBUTES.cat_id_col#,#ATTRIBUTES.cat_name_col#
	FROM #ATTRIBUTES.category_table#
	<cfif LEN(ATTRIBUTES.cat_sort_col) GT 0>
		ORDER BY #ATTRIBUTES.cat_sort_col# ASC
	</cfif>
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

	  <cfset VARIABLES.value_array = ListToArray(VARIABLES['qItem']['#ATTRIBUTES.item_cat_col#'][1])>
	  
	<cfloop query="qCategories" startrow="#VARIABLES.start_row#" endrow="#VARIABLES.end_row#">
		<input type="checkbox" name="#ATTRIBUTES.item_cat_col#" value="#VARIABLES['qCategories']['#ATTRIBUTES.cat_id_col#'][qCategories.currentrow]#" <cfloop from="1" to="#arraylen(VARIABLES.value_array)#" index="i" step="1"> 
<cfif VARIABLES.value_array[i] EQ VARIABLES['qCategories']['#ATTRIBUTES.cat_id_col#'][qCategories.currentrow]>
checked</cfif></cfloop>> #VARIABLES['qCategories']['#ATTRIBUTES.cat_name_col#'][qCategories.currentrow]#<br/>
	  </cfloop>
	  </td>
	  <td width="33%">
	  <!--- SET THE STARTING ROW FOR THE NEXT COLUMN --->
	  <cfset VARIABLES.start_row = VARIABLES.column_count + VARIABLES.start_row>
	  <cfset VARIABLES.end_row = VARIABLES.end_row +  VARIABLES.column_count>
	  
		<cfloop query="qCategories" startrow="#VARIABLES.start_row#" endrow="#VARIABLES.end_row#">
		<input type="checkbox" name="#ATTRIBUTES.item_cat_col#" value="#VARIABLES['qCategories']['#ATTRIBUTES.cat_id_col#'][qCategories.currentrow]#" <cfloop from="1" to="#arraylen(VARIABLES.value_array)#" index="i" step="1"> 
<cfif VARIABLES.value_array[i] EQ VARIABLES['qCategories']['#ATTRIBUTES.cat_id_col#'][qCategories.currentrow]>
checked</cfif></cfloop>> #VARIABLES['qCategories']['#ATTRIBUTES.cat_name_col#'][qCategories.currentrow]#<br/>
	  </cfloop>
	  </td>
	  <td width="33%">
	  <!--- SET THE STARTING ROW FOR THE NEXT COLUMN --->
	  <cfset VARIABLES.start_row = VARIABLES.column_count + VARIABLES.start_row>
	  <cfset VARIABLES.end_row = VARIABLES.end_row +  VARIABLES.column_count>
	  
		<cfloop query="qCategories" startrow="#VARIABLES.start_row#" endrow="#VARIABLES.end_row#">
		<input type="checkbox" name="#ATTRIBUTES.item_cat_col#" value="#VARIABLES['qCategories']['#ATTRIBUTES.cat_id_col#'][qCategories.currentrow]#" <cfloop from="1" to="#arraylen(VARIABLES.value_array)#" index="i" step="1"> 
<cfif VARIABLES.value_array[i] EQ VARIABLES['qCategories']['#ATTRIBUTES.cat_id_col#'][qCategories.currentrow]>
checked</cfif></cfloop>> #VARIABLES['qCategories']['#ATTRIBUTES.cat_name_col#'][qCategories.currentrow]#<br/>
	  </cfloop>
	  </td>
	  </tr>
	  </table>
	  </cfoutput>