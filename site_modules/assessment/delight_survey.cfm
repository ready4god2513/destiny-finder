<cfif isDefined("FORM.aptitudes") AND isDefined("FORM.delights")>
	<cfquery name="insertRecords" datasource="#APPLICATION.DSN#">
		INSERT INTO delight_survey_results (user_id, aptitudes, delights, last_modified)
		VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">,
	    <cfqueryparam cfsqltype="cf_sql_varchar" value="#SerializeJSON(FORM.aptitudes)#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#SerializeJSON(FORM.delights)#">,
	    <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">)
	</cfquery>
	
	<cfinclude template="../delight_survey/results.cfm" />
<cfelse>
	<cfinclude template="../delight_survey/test.cfm" />
</cfif>