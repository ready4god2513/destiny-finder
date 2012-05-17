<cfinclude template="../site_modules/require_login.cfm" />

<cfset obj_queries = CreateObject("component","cfcs.queries")>
<cfset profiler = CreateObject("component","cfcs.profiler").init(user_id = REQUEST.user_id) />

<cfparam name="URL.gateway" default="1">
<cfparam name="VARIABLES.page" default="summary">
<cfparam name="VARIABLES.gateway_id" default="">
<cfparam name="VARIABLES.subtitle" default="Profiler Summary">

<cfparam name="URL.page" default="#VARIABLES.page#">
	
<!--- RETRIEVE THE PAGE CONTENT --->
<cfset obj_queries = CreateObject("component","cfcs.queries") />
<cfset qContent = obj_queries.get_content(page="#URL.page#")>

<cfmodule template="../templates/site_wrapper.cfm"
	page_name="#qContent.content_name#"
    url_page="#URL.page#"
	gateway_id="#URL.gateway#"
	header_image="#qContent.content_header_img#"
	html_title="#qContent.content_html_title#"
	meta_desc="#qContent.content_meta_desc#" >

	<div class="row">
		<div class="span11">
			<section id="main">
				<cfif isDefined("URL.pdf")>
					<cfheader name="Content-Disposition" value="attachment; filename=Destiny-Profiler-Summary-Results.pdf">
					<cfdocument
						format="pdf">

						<cfdocumentitem type="header">
							<img src="/assets/images/logo.png" />
						</cfdocumentitem>
						
						<cfoutput>#profiler.summary()#</cfoutput>

						<cfdocumentitem type="footer">
							<cfoutput>#cfdocument.currentpagenumber# of #cfdocument.totalpagecount#</cfoutput>
						</cfdocumentitem>
					</cfdocument>
				<cfelse>	
					<cfoutput>#profiler.summary()#</cfoutput>
				</cfif>
			</section>
		</div>
		<cfinclude template="../templates/sidebar.cfm" />
	</div>

</cfmodule>