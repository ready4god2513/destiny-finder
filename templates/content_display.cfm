<cfset VARIABLE.gateway = Replace(CGI.SCRIPT_NAME,'index.cfm','')>
	
<cfif qContent.recordcount IS 0>
	<h3>I'm sorry. That page does not exist. Please try selecting a page from the menu bar.</h3>
<cfelse>
	<div class="page_content">
		<cfif isDefined('qContent.content_module') AND LEN(qContent.content_module) GT 0>

			<cfif qContent.content_includefunction EQ "below">
				<cfoutput>#qContent.content_content#</cfoutput>
			</cfif>

			<cfquery name="qModule" datasource="#APPLICATION.DSN#">
				SELECT module_file
				FROM Modules
				WHERE module_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qContent.content_module#">
			</cfquery>			

			<cfinclude template="/site_modules/#qModule.module_file#" />

			<cfif qContent.content_includefunction EQ "above">
				<cfoutput>#qContent.content_content#</cfoutput>
			</cfif>
		<cfelse>
			<cfoutput>#qContent.content_content#</cfoutput>
		</cfif>
		
		<div class="fb-like" data-href="https://www.facebook.com/pages/Destiny-Finder/101856686575972" data-send="true" data-width="450" data-show-faces="true"></div>
	</div><!---<div class="page_content">--->
                   					
</cfif>