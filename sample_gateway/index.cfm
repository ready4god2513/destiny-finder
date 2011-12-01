<cfparam name="URL.gateway" default="3">

<cfquery name="qFirstPage" datasource="#DSN#" maxrows="1">
	SELECT content_action
	FROM Content
	WHERE content_gateway = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.gateway#">
	ORDER BY content_sortorder ASC
</cfquery>

<cfparam name="url.page" default="#qFirstPage.content_action#">

<cfquery name="getcontent" datasource="#APPLICATION.DSN#" dbtype="ODBC">
SELECT * FROM Content 
WHERE content_action = <cfqueryparam cfsqltype="cf_sql_char" maxlength="35" value="#url.page#">
</cfquery>

<cfif getcontent.recordcount GT 0>
	<cfset VARIABLES.gateway_id = getcontent.content_gateway>
<cfelse>
	<cfset VARIABLES.gateway_id = URL.gateway>
</cfif>

<cfparam name="VARIABLES.gateway_id" default="">

<cfmodule template="../templates/site_wrapper.cfm"
	page_name="#getcontent.content_name#"
	gateway_id="#VARIABLES.gateway_id#"
	header_image="#getcontent.content_header_img#"
	html_title="#getcontent.content_html_title#"
	meta_desc="#getcontent.content_meta_desc#">

            <!-- Content -->
			
		<cfinclude template="../templates/content_display.cfm">			
			
            <!-- End Content -->

</cfmodule> 