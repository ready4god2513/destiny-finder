<cfset obj_queries = CreateObject('component','cfcs.queries')>

<cfparam name="URL.gateway" default="5">
<cfparam name="VARIABLES.page" default="">
<cfparam name="VARIABLES.gateway_id" default="">

<!--- THIS MODULE FINDS THE FIRST PAGE TO CALL FROM A GATEWAY --->
<cfmodule template="/templates/initial_page_call.cfm"
	gateway="#URL.gateway#"
>
<cfparam name="URL.page" default="#VARIABLES.page#">

<!--- RETRIEVE THE PAGE CONTENT --->
<cfset qContent = obj_queries.get_content(page='#VARIABLES.page#')>

<cfmodule template="../templates/site_wrapper.cfm"
	page_name="#qContent.content_name#"
	gateway_id="#URL.gateway#"
	header_image="#qContent.content_header_img#"
	html_title="#qContent.content_html_title#"
	meta_desc="#qContent.content_meta_desc#" >

        <!-- Content -->
		<cfinclude template="../templates/content_display.cfm">			
	    <!-- End Content -->

</cfmodule> 