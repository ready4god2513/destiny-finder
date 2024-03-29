<cfset VARIABLE.gateway = Replace(CGI.SCRIPT_NAME,'index.cfm','')>
<div class="row">
	<div class="span11">
		<section id="main">
			<cfif qContent.recordcount IS 0>
				<h3>I'm sorry. That page does not exist. Please try selecting a page from the menu bar.</h3>
			<cfelse>
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
			</cfif>
		</section>
	</div>

	<cfinclude template="sidebar.cfm" />
</div>