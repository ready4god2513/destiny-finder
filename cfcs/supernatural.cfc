<cfcomponent displayname="supernatural" output="no" hint="I handle supernatural surveys">
	
	
	<cfset variables.user_id = "" />
	
	
	<cffunction name="init" output="false">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset variables.user_id = ARGUMENTS.user_id />
		<cfreturn this />
	</cffunction>
	
	
	<cffunction name="insertRecord" output="false" return="void">
		<cfargument name="items" type="struct" required="true" />
		
		<cfset var local = {} />
		
		<cfquery name="local.insertRecords" datasource="#APPLICATION.DSN#">
			INSERT INTO results (user_id, result_gift_count, result_set, last_modified)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.user_id#">,
		    <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.calculateResults(ARGUMENTS.results)#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#SerializeJSON(ARGUMENTS.items)#">,
		    <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">)
		</cfquery>
		
	</cffunction>
	
	
	<cffunction name="calculateResults" output="false" return="string">
		<cfargument name="items" type="struct" required="true" />
		<cfreturn SerializeJSON(ARGUMENTS.items)>
	</cffunction>
	
	
	<cffunction name="outputResults" output="true" return="void">
		
		<cfset var local = {} />
		
		<cfquery name="local.results" datasource="#APPLICATION.DSN#">
			SELECT TOP 1 *
			FROM results
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.user_id#">
			AND assessment_id = 4
		</cfquery>
		
		
		<cfquery name="local.gifts" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM gifts
		</cfquery>
		
		<cfoutput>
			This is a test
		</cfoutput>
	</cffunction>
	
	
</cfcomponent>