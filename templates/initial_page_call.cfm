<!--- THIS MODULE FINDS THE FIRST PAGE TO CALL FROM A GATEWAY --->

<cfparam name="ATTRIBUTES.gateway" default="0">

<cfquery name="qFirstPage" datasource="#APPLICATION.DSN#" maxrows="1">
	SELECT Content.content_action, Menu_Items.menu_sortorder, Menu_Items.menu_type,Content.content_active
	FROM Content 
		INNER JOIN Menu_Items ON Content.content_pageid = Menu_Items.menu_item_id
		WHERE Menu_Items.menu_gateway_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ATTRIBUTES.gateway#">	
		AND Content.content_active = 1
		AND Menu_Items.menu_type = 'page'
	ORDER BY Menu_items.menu_sortorder ASC
</cfquery>

<cfif qFirstPage.recordcount GT 0>
	<cfset CALLER.page = qFirstPage.content_action>
</cfif>

