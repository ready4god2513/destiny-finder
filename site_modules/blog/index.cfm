<cfquery name="qFirstPage" datasource="#APPLICATION.DSN#" maxrows="1">
	SELECT content_action
	FROM tblContent
	WHERE content_gateway = 6
	ORDER BY content_sortorder ASC
</cfquery>

<cfparam name="url.page" default="#qFirstPage.content_action#">

<cfquery name="getcontent" datasource="#APPLICATION.DSN#" dbtype="ODBC">
SELECT * FROM tblContent 
WHERE content_action = <cfqueryparam cfsqltype="cf_sql_char" maxlength="35" value="#url.page#">
</cfquery>

<cfmodule template="../templates/site_wrapper.cfm"
	page_name="#getcontent.content_name#"
	gateway_id="#getcontent.content_gateway#"
	header_image="#getcontent.content_header_img#"
	html_title="#getcontent.content_html_title#"
	meta_desc="#getcontent.content_meta_desc#">

            <!-- Content -->
			
		<cfinclude template="../templates/content_display.cfm">			
			
            <!-- End Content -->

</cfmodule> 