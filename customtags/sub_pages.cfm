<cfsetting enablecfoutputonly="yes">

<cfparam name="ATTRIBUTES.gateway" default="">
<cfparam name="ATTRIBUTES.gateway_page_name" default="">
<cfparam name="ATTRIBUTES.gateway_path" default="">
<cfparam name="VARIABLES.avoid_menu" default="0">


<cfquery name="qSubpages" datasource="#APPLICATION.DSN#">
	SELECT DISTINCT Content.content_pageid, Menu_Items.menu_item_id,Menu_Items.menu_sortorder ,Content.content_action,Content.content_external_link,Content.content_external_link_target, Content.content_name, Content.content_sortorder,Content.content_gateway,Content.content_additional_url_var
		FROM Content INNER JOIN
        Menu_Items ON Content.content_pageid = Menu_Items.menu_item_id
		WHERE content.content_active = 1
		AND content.content_gateway = <cfqueryparam cfsqltype="cf_sql_integer" value="#ATTRIBUTES.gateway#">
		AND Menu_Items.menu_type = 'page'
		ORDER BY menu_sortorder
</cfquery>

<cfif qSubpages.recordcount GT 0>
	<!--- FOR GATEWAYS THAT HAVE ONLY 1 PAGE, MAKE SURE NOT TO START MENU BUILD --->
	<cfif qSubpages.recordcount EQ 1>
		<cfif qSubpages.content_name[1] EQ ATTRIBUTES.gateway_page_name>
			<cfset VARIABLES.avoid_menu = 1>
		</cfif>
	</cfif>

	<cfoutput>
		<cfif VARIABLES.avoid_menu EQ 0>
			<div class="sub">
				<div class="sub_top">
					<div class="sub_left">
						<div class="sub_right">
							<div class="sub_bottom">
								<ul>
		</cfif>
	</cfoutput>
</cfif>

<cfset VARIABLES.subpage_array = ArrayNew(1)>
						<cfsilent>
							<cfoutput query="qSubpages">
								<cfif qSubpages.content_gateway EQ ATTRIBUTES.gateway>
									<cfif qSubpages.content_name NEQ ATTRIBUTES.gateway_page_name>
										<cfif LEN(qSubpages.content_external_link) GT 0>
											<cfset ArrayAppend(VARIABLES.subpage_array,'<li><a href="http://#qSubpages.content_external_link#" target="#qSubpages.content_external_link_target#">#qSubpages.content_name#</a></li>')>
										<cfelse>
											<cfif URL.page EQ qSubpages.content_action>
												<cfset VARIABLES.link_text = '<span class="column_1_on">#qSubpages.content_name#</span>'>
											<cfelse>
												<cfset VARIABLES.link_text = '#qSubpages.content_name#'>
											</cfif>
											<cfif isDefined('URL.view')>
												<cfset VARIABLES.additional_vars = "&view=#URL.view#">
											</cfif>
											<cfparam name="VARIABLES.additional_vars" default="">
											<cfset ArrayAppend(VARIABLES.subpage_array,'<li><a href="../#ATTRIBUTES.gateway_path#/index.cfm?page=#qSubpages.content_action##qSubpages.content_additional_url_var##VARIABLES.additional_vars#">#VARIABLES.link_text#</a></li>')>
										</cfif>
									</cfif>
								</cfif>
							</cfoutput> 
						</cfsilent>
						<cfif arraylen(VARIABLES.subpage_array) GT 0>
							
								<cfloop from="1" to="#ArrayLen(VARIABLES.subpage_array)#" index="i">
									<cfoutput>#VARIABLES.subpage_array[i]#</cfoutput>
								</cfloop>
							
							<cfset ArrayClear(VARIABLES.subpage_array)>
						</cfif>
<cfif qSubpages.recordcount GT 0>
	<cfoutput>
			<cfif VARIABLES.avoid_menu EQ 0>
						</ul>
					<div class="clear"></div>
				</div>
			</div>
		</div>
	</div>
	</div>
			</cfif>
	</cfoutput>
</cfif>
<cfsetting enablecfoutputonly="no">