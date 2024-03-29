<!--- THIS MODULE ALLOWS FOR MULTI TIER SUBPAGES --->
<cfparam name="ATTRIBUTES.qSubpages" default="">
<cfparam name="ATTRIBUTES.gateway" default="">
<cfparam name="ATTRIBUTES.parent_gateway" default="">
<cfparam name="ATTRIBUTES.gateway_page_name" default="">
<cfparam name="ATTRIBUTES.gateway_path" default="">
<cfparam name="ATTRIBUTES.gateway_url" default="#ATTRIBUTES.gateway#">
<cfparam name="ATTRIBUTES.menu_type" default="gnav">
<cfparam name="ATTRIBUTES.submenuheader" default="no">
<cfparam name="ATTRIBUTES.submenuindex" default="0">
<cfparam name="ATTRIBUTES.tier" default="1">
<!--- START MODULE <cfoutput>#ATTRIBUTES.tier#</cfoutput>--->

<cfparam name="URL.page" default="">
<cfparam name="URL.gateway" default="">


<!--- RETRIEVE MENU ITEMS ASSIGNED TO THIS GATEWAY --->
<cfquery name="qMenu" datasource="#APPLICATION.DSN#">
	SELECT *
	FROM Menu_Items
	INNER JOIN content
	ON Menu_Items.menu_item_id = content.content_pageID
	WHERE menu_gateway_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ATTRIBUTES.gateway#">
	AND content.content_active = 1
	ORDER BY menu_sortorder
</cfquery>

<!--- FOR GATEWAYS THAT ONLY HAVE 1 MENU ITEM, CHECK AND MAKE SURE ITS NOT THE GATEWAY DEFAULT PAGE TO PREVENT AN EMPTY DROP DOWN --->
<cfif qMenu.recordcount EQ 1>
	<cfquery name="qPageName" datasource="#APPLICATION.DSN#">
		SELECT content_name
		FROM content
		WHERE content_pageid = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMenu.menu_item_id[1]#">
        AND content_active = 1
	</cfquery>
	<cfif qPageName.content_name EQ ATTRIBUTES.gateway_page_name>
		<cfset VARIABLES.display_menu = 0>
	</cfif>
</cfif>


<cfparam name="VARIABLES.display_menu" default="1">

<!--- SUBMENUINDEX IS USED FOR THE LEFT NAV ACCORDION MENU --->
<cfset VARIABLES.submenuindex = 0>

<cfif (qMenu.recordcount GT 0 AND VARIABLES.display_menu EQ 1) OR (qMenu.recordcount GT 0 AND ATTRIBUTES.menu_type EQ "leftnav")>
	
	<ul class="dropdown-menu">
	
	<cfoutput query="qMenu">
	
		<cfset VARIABLES.subpage_class = "">
		<cfset VARIABLES.subpage_indent = "">
		<cfset VARIABLES.additional_url_var = "">
		
		<!--- IF THE MENU ITEM IS A PAGE, SIMPLY OUTPUT THE APPROPRIATE LINK --->	
		<cfif qMenu.menu_type EQ "page">
			<!--- DEBUG** ATTRIBUTES.submenuindex #ATTRIBUTES.submenuindex# --->
			<!--- DEBUG** ATTRIBUTES.tier #ATTRIBUTES.tier# --->
			<cfquery name="qPage" datasource="#APPLICATION.DSN#">
				SELECT content_gateway,content_external_link,content_name,content_action,content_additional_url_var,content_external_link_target
				FROM Content
				WHERE content_active = 1 AND content_pageid = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMenu.menu_item_id#">
			</cfquery>
			<!--- START WITH CLEAN MENU PAGE --->
			<cfset VARIABLES.menu_page = "">
										<cfif qPage.content_gateway EQ ATTRIBUTES.gateway>
											<cfif qPage.content_name NEQ ATTRIBUTES.gateway_page_name>
												
												<cfif LEN(qPage.content_external_link) GT 0>
												
													<cfset VARIABLES.menu_page = '<li><a href="http://#qPage.content_external_link#" target="#qPage.content_external_link_target#">#qPage.content_name#</a></li>'>
													
												<cfelse>
			
													<cfif URL.page EQ qPage.content_action>
														<cfset VARIABLES.subpage_class = "subnav_on">
													</cfif>
													
													<cfif ATTRIBUTES.submenuindex NEQ 0>
														<cfset VARIABLES.additional_url_var = "&submenuheader=" & (ATTRIBUTES.submenuindex - 1)>
													</cfif>
																									
													<cfset VARIABLES.menu_page = '<li><a href="#ATTRIBUTES.gateway_path#index.cfm?page=#qPage.content_action#&gateway=#ATTRIBUTES.gateway_url#&parent_gateway=#ATTRIBUTES.parent_gateway##VARIABLES.additional_url_var##qPage.content_additional_url_var#">#VARIABLES.subpage_indent##qPage.content_name#</a></li>'>
												</cfif>
											</cfif>
										</cfif>
										<cfif isDefined('VARIABLES.menu_page')>
											#VARIABLES.menu_page#
										</cfif>
						
		<!--- IF THE MENU ITEM IS A GATEWAY ITEM, RUN THIS CUSTOM TAG AGAIN TO GENERATE SUB MENU --->
		<cfelseif qMenu.menu_type EQ "gateway">
			<!---
			<cfif ATTRIBUTES.submenuindex EQ 0>
				<cfset ATTRIBUTES.tier = 1>
			</cfif>
			--->
			<!--- DEBUG** ATTRIBUTES.submenuindex #ATTRIBUTES.submenuindex# --->
			<!--- DEBUG** ATTRIBUTES.tier #ATTRIBUTES.tier# --->
			<cfquery name="qGateway" datasource="#APPLICATION.DSN#">
				SELECT gateway_name
				FROM gateway_pages
				WHERE gateway_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMenu.menu_item_id#">
				AND gateway_active = 1 
			</cfquery>
			
			<cfif qGateway.recordcount GT 0>
				
				<cfset VARIABLES.passed_gateway = qMenu.menu_item_id>
				<cfset VARIABLES.submenuindex = VARIABLES.submenuindex + 1>						
									
				<cfif ATTRIBUTES.menu_type EQ "leftnav">
					<cfset VARIABLES.submenuindex_for_gateway_link = VARIABLES.submenuindex>
				<cfelse>
					<cfset VARIABLES.submenuindex_for_gateway_link = VARIABLES.submenuindex - 1>
				</cfif>
				
				<!--- CREATE VARIABLES FOR THE LINK'S HREF ATTRIBUTE --->
				<cfset VARIABLES.link_string = "#ATTRIBUTES.gateway_path#index.cfm?gateway=#VARIABLES.passed_gateway#&parent_gateway=#ATTRIBUTES.parent_gateway#&submenuheader=#VARIABLES.submenuindex_for_gateway_link#">
								
				<li><a href="#VARIABLES.link_string#">#qGateway.gateway_name#</a>
				
				<cfif ATTRIBUTES.menu_type EQ "leftnav">
					<cfset VARIABLES.submenuheader = "yes">
				<cfelse>
					<cfset VARIABLES.submenuheader = "">
				</cfif>
									
				<cfset ATTRIBUTES.tier = ATTRIBUTES.tier + 1>
				
				<cfmodule template="../customtags/sub_menu_multi.cfm"
						gateway="#qMenu.menu_item_id#"	
						gateway_url="#VARIABLES.passed_gateway#"
						gateway_page_name="#qGateway.gateway_name#"
						gateway_path="#ATTRIBUTES.gateway_path#"				
						parent_gateway="#ATTRIBUTES.parent_gateway#"
						submenuheader="#VARIABLES.submenuheader#"
						submenuindex="#VARIABLES.submenuindex#"
						menu_type="#ATTRIBUTES.menu_type#"		
						tier="#ATTRIBUTES.tier#"	
					> 				
					<cfset ATTRIBUTES.tier = ATTRIBUTES.tier - 1>
			</li>
			</cfif>
									
									
		</cfif>
	</cfoutput> 
	</ul>

</cfif>
<!--- END MODULE <cfoutput>#ATTRIBUTES.tier#</cfoutput>--->