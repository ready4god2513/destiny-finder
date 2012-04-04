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
		
		<cfquery datasource="#APPLICATION.DSN#">
			DELETE FROM results
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.user_id#">
			AND assessment_id = 4
		</cfquery>
		
		<cfquery name="local.insertRecords" datasource="#APPLICATION.DSN#">
			INSERT INTO results (user_id, assessment_id, result_gift_count, result_set, last_modified)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.user_id#">,
			4,
		    <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.calculateResults(ARGUMENTS.items)#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#SerializeJSON(ARGUMENTS.items)#">,
		    <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">)
		</cfquery>
		
	</cffunction>
	
	
	<cffunction name="calculateResults" output="false" return="string">
		<cfargument name="items" type="struct" required="true" />
		
		<cfset var local = {} />
		<cfset local.results = ArrayNew(1) />
		
		<cfquery name="local.gifts" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM gifts
		</cfquery>
		
		<cfloop query="local.gifts">
			<cfif isDefined("arguments.items.#gift_name#")>
				<cfset keys = {name = gift_name, counter = arguments.items[gift_name]} />
				<cfset ArrayAppend(local.results, keys) />
			</cfif>
		</cfloop>
		
		<cfreturn SerializeJSON(local.results) />
	</cffunction>
	
	
	<cffunction name="outputResults" output="true" return="void">
		
		<cfset var local = {} />
		<cfset local.top_result = {name = "", counter = 0} />
		<cfset local.secondary_result = {name = "", counter = 0} />
		<cfset local.gifts = {} />
		
		<cfquery name="local.results" datasource="#APPLICATION.DSN#">
			SELECT TOP 1 *
			FROM results
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.user_id#">
			AND assessment_id = 4
		</cfquery>
		
		<cfloop query="local.results">
			<cfset local.gifts = DeSerializeJSON(result_gift_count)>
				
			<!--- Get the top result --->
			<cfloop array="#local.gifts#" index="gift">
				<cfif gift.counter GT local.top_result.counter>
					<cfset local.top_result = {name = gift.name, counter = gift.counter}>
				</cfif>
			</cfloop>
			
			<!--- Get the secondary result --->
			<cfloop array="#local.gifts#" index="gift">
				<cfif gift.counter GT local.secondary_result.counter AND gift.name NEQ local.top_result.name>
					<cfset local.secondary_result = {name = gift.name, counter = gift.counter}>
				</cfif>
			</cfloop>
			
			<!--- Show a chart with the user's overall scores --->
			<cfchart
				chartWidth="600"
				format="flash">
				<cfchartseries
					type="bar"
					serieslabel="Survey Results Breakdown"
					paintStyle="shade">

					<cfloop array="#local.gifts#" index="gift">
						<cfchartdata item="#gift.name#" value="#gift.counter#">
					</cfloop>
				</cfchartseries>
			</cfchart>
		</cfloop>
		
		<cfquery name="local.gifts" datasource="#APPLICATION.DSN#">
			SELECT TOP 1 *
			FROM gifts
			WHERE gift_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#local.top_result.name#">
		</cfquery>
		
		<cfoutput>
			<cfloop query="local.gifts">
				<div class="short_desc">
					#gift_primary#<hr />
				</div>
			</cfloop>
		</cfoutput>
		
		
		<cfquery name="local.gifts" datasource="#APPLICATION.DSN#">
			SELECT TOP 1 *
			FROM gifts
			WHERE gift_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#local.secondary_result.name#">
		</cfquery>
		
		<cfoutput>
			<cfloop query="local.gifts">
				<div class="short_desc">
					#gift_primary#
				</div>
			</cfloop>
		</cfoutput>
	</cffunction>
	
	
</cfcomponent>