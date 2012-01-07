<cfquery name="qBlocks" datasource="#APPLICATION.DSN#">
	SELECT * 
	FROM MiscContent
</cfquery>
<cfquery name="qGateways" datasource="#APPLICATION.DSN#">
	SELECT *
	FROM Gateway_Pages
	WHERE gateway_parent_id = 0 AND gateway_id > 1
	AND gateway_active = 1
	ORDER BY gateway_sortorder ASC
</cfquery>

<cfparam name="ATTRIBUTES.html_title" default="">
<cfparam name="ATTRIBUTES.meta_desc" default="">
<cfparam name="ATTRIBUTES.page_name" default="">
<cfparam name="ATTRIBUTES.url_page" default="">
<cfparam name="ATTRIBUTES.gateway_id" default="">
<cfparam name="ATTRIBUTES.header_image" default="">
<cfparam name="URL.page" default="#ATTRIBUTES.url_page#">
<cfparam name="URL.gateway" default="" />

<cfif thistag.executionmode EQ 'start'>
	<cfinclude template="header.cfm" />
	<cfinclude template="banner_display.cfm" />
<cfelse>
	</div>
	<cfinclude template="footer.cfm" />
</cfif>