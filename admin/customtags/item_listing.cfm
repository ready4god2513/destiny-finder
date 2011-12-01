<cfparam name="ATTRIBUTES.item_prefix" default="">
<cfparam name="ATTRIBUTES.table_name" default="">
<cfparam name="ATTRIBUTES.DSN" default="">
<cfparam name="ATTRIBUTES.sortable" default="no">
<cfparam name="ATTRIBUTES.addl_url_vars" default="">
<cfparam name="ATTRIBUTES.listing_page" default="">
<cfparam name="ATTRIBUTES.top_section" default="">
<cfparam name="ATTRIBUTES.listing_title" default="">
<cfparam name="ATTRIBUTES.select_colums" default="">
<cfparam name="ATTRIBUTES.column_headings" default="">
<cfparam name="ATTRIBUTES.column_widths" default="">
<cfparam name="ATTRIBUTES.add_new_link" default="">
<cfparam name="ATTRIBUTES.primary_key" default="">
<cfparam name="ATTRIBUTES.secondary_key" default="">
<cfparam name="ATTRIBUTES.secondary_value" default="">
<cfparam name="ATTRIBUTES.title_column" default="">
<cfparam name="ATTRIBUTES.order_by" default="">
<cfparam name="ATTRIBUTES.item_page" default="">
<cfparam name="ATTRIBUTES.xml_update" default="">
<cfparam name="ATTRIBUTES.column_detail" default="">
<cfparam name="ATTRIBUTES.paginate" default="0">
<cfparam name="ATTRIBUTES.maxrows" default="50">




	
	

<cfif Lcase(ATTRIBUTES.sortable) EQ "yes">
	
	<cfif isDefined('form.submit') AND form.submit EQ "Update Sort Order">
	<!--- SORTABLE CODE --->
	<!--- <cfset VARIABLES.page_id_array = ListToArray('#form.page_id_list#')> --->
	<cfset VARIABLES.divorder = Replace('#FORM.divOrder#','sortContainer[]=','','ALL')>
	<cfset VARIABLES.divorder = Replace('#VARIABLES.divorder#','&',',','All')>
	<cfset VARIABLES.div_order_array = ListToArray('#VARIABLES.divOrder#')>
	
	<cfset VARIABLES.sort_id_array = ArrayNew(1)>
	<cfset VARIABLES.div_marker = 0>
	
		<cfloop from="1" to="#ListLen(sort_id_list)#" index="i">
			<cfset VARIABLES.sort_id_array[i] = StructNew()>
			<cfset VARIABLES.sort_id_array[i].sort_id = ListGetAt(FORM.sort_id_list,i)>
			<cfset VARIABLES.sort_id_array[i].div_id =  VARIABLES.div_marker>
			<cfset VARIABLES.div_marker = VARIABLES.div_marker + 1>
		</cfloop>
	
	<!--- 
	Sort ID ARRAY:<br />
	<cfdump var="#VARIABLES.sort_id_array#">
	Div Order ARRAY:<br />
	<cfdump var="#VARIABLES.div_order_array#">
	--->
	
		<cfloop from="1" to="#ArrayLen(VARIABLES.sort_id_array)#" index="x">
			<cfquery name="update_sortorder" datasource="#APPLICATION.DSN#">
			UPDATE #ATTRIBUTES.table_name# set #ATTRIBUTES.item_prefix#_sortorder= #x# WHERE #ATTRIBUTES.primary_key# = 
			<cfloop from="1" to="#ArrayLen(VARIABLES.sort_id_array)#" index="y">
				<cfif VARIABLES.div_order_array[x] EQ VARIABLES.sort_id_array[y].div_id>
					#VARIABLES.sort_id_array[y].sort_id#
				</cfif> 
			</cfloop>
		</cfquery>
		
		
		</cfloop>
		
	</cfif>
	
	<!--- END SORTABLE CODE --->
	<cfif LEN(ATTRIBUTES.xml_update) GT 0>
		<cfmodule template="/admin/customtags/#ATTRIBUTES.xml_update#.cfm">
	</cfif>
</cfif>



<!--- QUERY FOR LISTING --->

<cfquery name="qItems" datasource="#APPLICATION.DSN#" dbtype="odbc">
	SELECT #ATTRIBUTES.select_columns#
	FROM #ATTRIBUTES.table_name#
    <cfif Len(ATTRIBUTES.secondary_key) GT 0>
    WHERE #ATTRIBUTES.secondary_key# = #ATTRIBUTES.secondary_value#
    </cfif>
	ORDER BY 
	<cfif LCase(ATTRIBUTES.sortable) EQ "yes">
		#ATTRIBUTES.item_prefix#_sortorder ASC
	<cfelse>
		#ATTRIBUTES.ORDER_BY#
	</cfif>
	
</cfquery>


<cfif LCase(ATTRIBUTES.sortable) EQ "yes">
	<cfset VARIABLES.sort_container = "sortContainer">
</cfif>

<cfparam name="VARIABLES.sort_container" default="">


<cfmodule template="../ct_admin_template.cfm"
	title="#ATTRIBUTES.listing_title#"
	columns="#ListLen(ATTRIBUTES.column_headings)#"
	column_widths="#ATTRIBUTES.column_widths#"
	column_headings="#ATTRIBUTES.column_headings#"
	add_new_link="#ATTRIBUTES.add_new_link#"
	sortable_container="#VARIABLES.sort_container#"
	top_section="#ATTRIBUTES.top_section#"
	xml_update="#ATTRIBUTES.xml_update#">
	
	<cfif LCase(ATTRIBUTES.sortable) EQ "yes">
	<form action="#ATTRIBUTES.listing_page#?#ATTRIBUTES.addl_url_vars#" method="post" onSubmit="populateHiddenVars();" enctype="multipart/form-data">
		<cfset VARIABLES.divcount = 0>
		<cfset VARIABLES.sortids = "">
		<div id="sortContainer">	
	</cfif>
	
	
	<cfif ATTRIBUTES.paginate EQ 1>
		<cfmodule template="../customtags/pagination.cfm" 
			max_recordcount="#qItems.recordcount#"
			max_display="#ATTRIBUTES.maxrows#"
			page_url="#ATTRIBUTES.listing_page#"
		>
	<cfelse>
		<cfif qItems.recordcount GT 0>
			<cfset ATTRIBUTES.maxrows = qItems.recordcount>
		</cfif>
		<cfset start_row = 1>		
	</cfif>
	
	
	<cfoutput query="qItems" startrow="#start_row#" maxrows="#ATTRIBUTES.maxrows#">
	
	<div id="<cfif LCase(ATTRIBUTES.sortable) EQ "yes">div_#VARIABLES.divcount#</cfif>" style="<cfif LCase(ATTRIBUTES.sortable) EQ "yes">cursor:move;</cfif>border:1px solid ##D8D8D8; margin-bottom:2px;padding:2px;">
		
			<!--- FOR EVERY COLUMN SET EACH STYLE ELEMENT NEEDS TO ADDRESS THE APPROPRIATE WIDTH AS ASSIGNED ABOVE, THIS IS DONE BY SETTING THE LISTGETAT # TO IT'S RESPECTIVE COLUMN PLACEHOLDER, 1 IS FOR THE FIRST COLUMN, 2 IS FOR THE SECOND, AND SO ON.
			<div id="name_column" style="width:#ListGetAt(ATTRIBUTES.column_widths, 1)#px;">
				<a href="#ATTRIBUTES.item_page#?#ATTRIBUTES.primary_key#=#VARIABLES['qItems']['#ATTRIBUTES.primary_key#'][qItems.currentrow]##ATTRIBUTES.addl_url_vars#" style="cursor:hand;"><img src="images/edit.gif" />&nbsp;#VARIABLES['qItems']['#ATTRIBUTES.title_column#'][qItems.currentrow]#</a>
			</div>
			 --->
			
				<cfloop from="1" to="#ListLen(ATTRIBUTES.column_headings)#" index="i">
					<div id="column" style="width:#ListGetAt(ATTRIBUTES.column_widths, i)#px;">
						#Evaluate(DE(ListGetAt(ATTRIBUTES.column_details,i)))#
					</div>
				</cfloop> <!--- --->

			<!--- 
			<div id="column" style="width:#ListGetAt(VARIABLES.column_widths, 3)#px;">
			<cfif VARIABLES['qItems']['#ATTRIBUTES.item_prefix#_active'][qItems.currentrow] EQ "1"><img src="images/action_check.gif" /><cfelse><img src="images/action_disabled.gif" /></cfif></div>
			--->
				<div style="clear:both;"></div>
		
		</div>

	<cfif LCase(ATTRIBUTES.sortable) EQ "yes">
		<cfset VARIABLES.divcount = VARIABLES.divcount + 1>
		<cfset VARIABLES.sortids = ListAppend(VARIABLES.sortids,VARIABLES['qItems']['#ATTRIBUTES.item_prefix#_id'][qItems.currentrow])>
	</cfif>
		
	</cfoutput>
	
	<cfif LCase(ATTRIBUTES.sortable) EQ "yes">
		</div>
		
		<cfoutput>
		<input type="hidden" name="sort_id_list" value="#VARIABLES.sortids#"/>
		<input type="hidden" name="divOrder" id="divOrder" >
		</cfoutput>
		<div align="right" style="margin-right:30px;padding-top:8px;"><input type="submit" name="submit" value="Update Sort Order"></div>
	</form>
	
	<script type="text/javascript">
		// <![CDATA[
						
			Sortable.create('sortContainer',{tag:'div'});
								
							// ]]>
	</script>
	
	</cfif>
	
</cfmodule>