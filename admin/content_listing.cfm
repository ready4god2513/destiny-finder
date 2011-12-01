

<cfif isDefined('form.submit') AND form.submit EQ "Update Sort Order">
<!--- <cfset VARIABLES.page_id_array = ListToArray('#form.page_id_list#')> --->
<cfset VARIABLES.divorder = Replace('#FORM.divOrder#','pageContainer[]=','','ALL')>
<cfset VARIABLES.divorder = Replace('#VARIABLES.divorder#','&',',','All')>
<cfset VARIABLES.div_order_array = ListToArray('#VARIABLES.divOrder#')>

<cfset VARIABLES.page_id_array = ArrayNew(1)>
<cfset VARIABLES.div_marker = 0>

<cfloop from="1" to="#ListLen(page_id_list)#" index="i">
	<cfset VARIABLES.page_id_array[i] = StructNew()>
	<cfset VARIABLES.page_id_array[i].page_id = ListGetAt(FORM.page_id_list,i)>
	<cfset VARIABLES.page_id_array[i].div_id =  VARIABLES.div_marker>
	<cfset VARIABLES.div_marker = VARIABLES.div_marker + 1>
</cfloop>


<!--- <cfdump var="#VARIABLES.page_id_array#">
<cfdump var="#VARIABLES.div_order_array#"> --->

<cfloop from="1" to="#ArrayLen(VARIABLES.page_id_array)#" index="x">
	<cfquery name="update_sortorder" datasource="#APPLICATION.DSN#">
	UPDATE Menu_items set menu_sortorder= #x# WHERE menu_id = 
	<cfloop from="1" to="#ArrayLen(VARIABLES.page_id_array)#" index="y">
		<cfif VARIABLES.div_order_array[x] EQ VARIABLES.page_id_array[y].div_id>
			#VARIABLES.page_id_array[y].page_id#
		</cfif> 
	</cfloop>
</cfquery>


</cfloop>
<cfset URL.gateway = FORM.gateway>
</cfif>

<!--- QUERY FOR LISTING --->

<!---
<cfquery name="getpages" datasource="#APPLICATION.DSN#" dbtype="odbc">
	SELECT content_pageID, content_name, content_active,content_gateway,content_sortorder FROM content
	<cfif isDefined('URL.gateway')>WHERE content_gateway = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.gateway#"> 
	ORDER BY content_sortorder ASC
	<cfelse>
	ORDER BY content_name ASC
	</cfif>
</cfquery>
--->

<cfquery name="qGetMenu" datasource="#APPLICATION.DSN#">
	SELECT menu_id,menu_type,menu_item_id 
	FROM Menu_Items
	WHERE Menu_gateway_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.gateway#">
	ORDER BY menu_sortorder
</cfquery>



<cfif isDefined('URL.gateway')>
<cfquery name="getgateway" datasource="#APPLICATION.DSN#">
	SELECT gateway_name FROM Gateway_Pages
	WHERE gateway_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.gateway#">
</cfquery>
</cfif>

<!--- SET VARIABLES DEPENDANT UPON PAGE LISTING TYPE, BY GATEWAY OR AN "ALL PAGES" LISTING --->
<cfif isDefined('URL.gateway')>
	<!--- TITLE OF LISTING--->
	<cfset VARIABLES.title = getgateway.gateway_name>
	<!--- NAME OF EACH COLUMN SEPERATED BY COMMAS --->
	<cfset VARIABLES.column_headings = "#getgateway.gateway_name#, ,Active">
	<!--- THE URL FOR THE "ADD NEW - " LINK AT THE TOP OF THE PAGE...LEAVE BLANK ( "" )IF NOT NEEDED  --->
	<cfset VARIABLES.add_new_link = "">
<cfelse>
	<!--- TITLE OF LISTING--->
	<cfset VARIABLES.title = "Complete Page Listing">
	<!--- NAME OF EACH COLUMN SEPERATED BY COMMAS --->
	<cfset VARIABLES.column_headings = "Page Name,Gateway,Active">
	<!--- THE URL FOR THE "ADD NEW - " LINK AT THE TOP OF THE PAGE...LEAVE BLANK ( "" )IF NOT NEEDED  --->
	<cfset VARIABLES.add_new_link = "">
</cfif>

<!--- NUMBER OF COLUMN HEADINGDS --->
<cfset VARIABLES.columns = "3">
<!--- WIDTHS FOR EACH COLUMN SEPERATED BY COMMAS--->
<cfset VARIABLES.column_widths = "240,150,100">



<cf_ct_admin_template title="#VARIABLES.title#" columns="#VARIABLES.columns#" column_widths="#VARIABLES.column_widths#" column_headings="#VARIABLES.column_headings#" add_new_link="#VARIABLES.add_new_link#" sortable_container="pageContainer" top_section="<a href='gateway_listing.cfm'>&laquo; Gateway Listing</a>" xml_update="">
	<cfoutput><a href="content.cfm?content_pageid=new&gateway=#URL.gateway#"><img src="images/action_add.gif" /> Add New Page</a>&nbsp;&nbsp;	<!--- <a href="gateway.cfm?gateway_id=new&gateway=#URL.gateway#"><img src="images/action_add.gif" /> Add New Gateway</a> ---></cfoutput>
	<form action="content_listing.cfm" method="post" <cfif isDefined('URL.gateway')>onSubmit="populateHiddenVars();"</cfif> enctype="multipart/form-data">
	<cfset VARIABLES.divcount = 0>
	<cfset VARIABLES.pageids = "">
	<div id="pageContainer">
	
	<cfoutput query="qGetMenu">
	
		<cfswitch expression="#qGetMenu.menu_type#">
			<cfcase value="page">
				<cfquery name="qPage" datasource="#APPLICATION.DSN#">
					SELECT content_pageID, content_name, content_active,content_gateway
					FROM content
					WHERE content_pageID = <cfqueryparam cfsqltype="cf_sql_integer" value="#qGetMenu.menu_item_id#">
				</cfquery>
				
				<cfset VARIABLES.name = qPage.content_name>
				<cfset VARIABLES.active = qPage.content_active>
				<cfset VARIABLES.URL = "content.cfm?content_pageid=#qPage.content_PageID#&gateway=#URL.gateway#">
				
			</cfcase>
			<cfcase value="gateway">
				<cfquery name="qGateway" datasource="#APPLICATION.DSN#">
					SELECT gateway_name,gateway_id,gateway_active
					FROM Gateway_Pages
					WHERE gateway_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qGetMenu.menu_item_id#">
				</cfquery>
				
				<cfset VARIABLES.name = qGateway.gateway_name>
				<cfset VARIABLES.active = qGateway.gateway_active>
				<cfset VARIABLES.URL = "gateway.cfm?gateway_id=#qGateway.gateway_id#&gateway=#URL.gateway#">
			</cfcase>
		</cfswitch>
	
	<div id="div_#VARIABLES.divcount#" style="<cfif isDefined('URL.gateway')>cursor:move;</cfif>border:1px solid ##D8D8D8; margin-bottom:2px;padding:2px;">
		
			<!--- FOR EVERY COLUMN SET EACH STYLE ELEMENT NEEDS TO ADDRESS THE APPROPRIATE WIDTH AS ASSIGNED ABOVE, THIS IS DONE BY SETTING THE LISTGETAT # TO IT'S RESPECTIVE COLUMN PLACEHOLDER, 1 IS FOR THE FIRST COLUMN, 2 IS FOR THE SECOND, AND SO ON. --->
			<div id="name_column" style="width:#ListGetAt(VARIABLES.column_widths, 1)#px;">
			<a href="#VARIABLES.URL#" style="cursor:hand;"><img src="images/edit.gif" />&nbsp;
			<cfif LEN(VARIABLES.name) GT 35>
				#Left(VARIABLES.name,32)#...
			<cfelse>
				#VARIABLES.name#
			</cfif>
			</a></div>
			<div id="column" style="width:#ListGetAt(VARIABLES.column_widths, 2)#px;">
			
			<cfswitch expression="#qGetMenu.menu_type#">
				<cfcase value="page">
					<cfif getgateway.gateway_name EQ VARIABLES.name>
						<span style="color:##ff0000;font-weight:bold;">[GATEWAY PAGE]</span>
					</cfif>
				</cfcase>
				<cfcase value="gateway">
					<a href="content_listing.cfm?gateway=#qGetMenu.menu_item_id#">[Menu Listing]</a> 
				</cfcase>
			
			</cfswitch>	
			</div>
			<div id="column" style="width:#ListGetAt(VARIABLES.column_widths, 3)#px;"><cfif "#VARIABLES.active#" EQ "1"><img src="images/action_check.gif" /><cfelse><img src="images/action_disabled.gif" /></cfif></div>
				<div style="clear:both;"></div>
		
		</div>
		
	<cfset VARIABLES.divcount = VARIABLES.divcount + 1>
	<cfset VARIABLES.pageids = ListAppend(VARIABLES.pageids,qGetMenu.menu_id)>
	</cfoutput>
	</div>
	<cfif isDefined('URL.gateway')>
	<cfoutput>
	
	<input type="hidden" name="page_id_list" value="#VARIABLES.pageids#"/>
	<input type="hidden" name="divOrder" id="divOrder" >
    <input type="hidden" name="gateway" value="#URL.gateway#" />
	
	
	</cfoutput>
	<div align="right" style="margin-right:30px;padding-top:8px;"><input type="submit" name="submit" value="Update Sort Order"></div></cfif>
	</form>
	<cfif isDefined('URL.gateway')>
	<script type="text/javascript">
		// <![CDATA[
						
			Sortable.create('pageContainer',{tag:'div'});
								
							// ]]>
	</script>
	</cfif>
</cf_ct_admin_template>