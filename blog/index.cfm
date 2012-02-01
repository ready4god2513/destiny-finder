<cfset obj_queries = CreateObject('component','cfcs.queries')>

<cfparam name="URL.gateway" default="6">
<cfparam name="VARIABLES.page" default="blog">
<cfparam name="VARIABLES.gateway_id" default="6">
<cfparam name="getBlogContent.blog_title" default="Our Blog">
<cfparam name="getBlogContent.blog_meta_desc" default="">


<cfparam name="URL.page" default="#VARIABLES.page#">

<cfif isDefined("URL.blog_id")>
	<cfquery name="getBlogContent" datasource="#APPLICATION.dsn#">
		SELECT *
		FROM Blogs
		WHERE blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.blog_id#">
	</cfquery>
</cfif>
<!--- RETRIEVE THE PAGE CONTENT --->
<cfset qContent = obj_queries.get_content(page='#VARIABLES.page#')>

<cfmodule template="../templates/site_wrapper.cfm"
	page_name="#qContent.content_name#"
	gateway_id="#URL.gateway#"
	header_image="#qContent.content_header_img#"
	html_title="#getBlogContent.blog_title#"
	meta_desc="#getBlogContent.blog_meta_desc#" >
	
	<!-- Content -->
	<cfinclude template="../templates/content_display.cfm">			
    <!-- End Content -->

</cfmodule> 