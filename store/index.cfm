<cfset obj_queries = CreateObject('component','cfcs.queries')>
<cfset pageTitle = "The Destiny Finder Store">
<cfparam name="URL.gateway" default="6">
<cfparam name="VARIABLES.page" default="">
<cfparam name="VARIABLES.gateway_id" default="">

<!--- THIS MODULE FINDS THE FIRST PAGE TO CALL FROM A GATEWAY --->
<cfmodule template="/templates/initial_page_call.cfm"
	gateway="#URL.gateway#"
>
<cfparam name="URL.page" default="#VARIABLES.page#">

<!--- RETRIEVE THE PAGE CONTENT --->
<cfset qContent = obj_queries.get_content(page='#URL.page#')>

<cfmodule template="../templates/site_wrapper.cfm"
	page_name="#pageTitle#"
	gateway_id="#URL.gateway#"
	header_image="#qContent.content_header_img#"
	html_title="#pageTitle#"
	meta_desc="">
	
	<div class="row">
		<div class="span11">
			<section id="main">
				<h2>The Destiny Finder Store</h2>
				<cfinclude template="products/listing.cfm" />
			</section>
		</div>

		<cfinclude template="../templates/sidebar.cfm" />
	</div>
</cfmodule>