<cfcomponent displayname="supernatural" output="no" hint="I handle supernatural surveys">
	
	
	<cfset variables.user_id = "" />
	
	
	<cffunction name="init" output="false">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset variables.user_id = ARGUMENTS.user_id />
		<cfreturn this />
	</cffunction>
	
	
	<cffunction name="insertRecord" output="false" returnType="void">
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
	
	
	<cffunction name="sortResults" output="false" returnType="array">
		<cfset var local = {} />
		<cfset var sorted_to_query = "" />
		<cfset local.results = DeSerializeJSON(this.retrieveResults().result_gift_count) />
		
		<!--- convert array to CF query --->
		<cfset sorted_to_query = QueryNew("name, counter") />
		<cfloop array="#local.results#" index="result">
			<cfset local.newRow = QueryAddRow(sorted_to_query) />
			<cfset QuerySetCell(sorted_to_query, "name", result.name) />
			<cfset QuerySetCell(sorted_to_query, "counter", result.counter) />
		</cfloop>
		
		<cfquery name="local.sorted" dbtype="query">
			SELECT *
			FROM sorted_to_query
			ORDER BY counter DESC
		</cfquery>
		
		<cfset local.sorted_array = ArrayNew(1)>
		<cfloop query="local.sorted">
			<cfset local.temp = {name = name, counter = counter}>
			<cfset ArrayAppend(local.sorted_array, local.temp)>
		</cfloop>
		
		<cfreturn local.sorted_array />
	</cffunction>
	
	
	<cffunction name="calculateResults" output="false" returnType="string">
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
	
	
	<cffunction name="retrieveResults" output="false" returnType="query">
		<cfset var local = {} />
		<cfquery name="local.results" datasource="#APPLICATION.DSN#">
			SELECT TOP 1 *
			FROM results
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.user_id#">
			AND assessment_id = 4
		</cfquery>
		
		<cfreturn local.results />
	</cffunction>
	
	
	<cffunction name="outputResults" output="true" returnType="void">
		
		<cfset var local = {} />
		<cfset local.top_results = ArrayNew(1) />
		<cfset local.gifts = {} />
		<cfset local.results = this.retrieveResults() />
		
		
		<div class="row">
			<div class="span7">
				<h2>Supernatural Survey Results - #dateformat(local.results.last_modified,'mmm dd, yyyy')#</h2>
			</div>
			<div class="pull-right">
				<cfif not isDefined("URL.pdf")>
					<a href="#REQUEST.site_url#profile/?page=viewresult&amp;assessment_id=#val(URL.assessment_id)#&amp;gift_type_id=#val(URL.gift_type_id)#&amp;pdf=true" target="_blank" class="btn btn-info">Print PDF</a>
				</cfif>
			</div>
		</div>
		
		<cfoutput>
			<h3>Introduction</h3>
			<p>
				The average scores for each of the supernatural orientations is shown along with the bar chart. 
				The long text description is shown for the SOs with average scores of 3 or higher. 
			</p>
		</cfoutput>
		
		
		
		<cfloop query="local.results">
			<cfset local.gifts = DeSerializeJSON(result_gift_count)>
				
			<!--- Get the top results (Anything over an average of 3) --->
			<cfloop array="#local.gifts#" index="gift">
				<cfif (gift.counter / 4) GTE 3>
					<cfset ArrayAppend(local.top_results, gift.name)>
				</cfif>
			</cfloop>
		</cfloop>
		
		<!--- Display the average of each gift --->
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>Gift</th>
					<th>Average</th>
				</tr>
			</thead>
			<tbody>
				<cfloop array="#local.gifts#" index="gift">
					<tr>
						<td><cfoutput>#gift.name#</cfoutput></td>
						<td><cfoutput>#(gift.counter / 4)#</cfoutput></td>
					</tr>
				</cfloop>
			</tbody>
		</table>
		
		<cfif ArrayLen(local.top_results) GT 0>
			<cfquery name="local.qGifts" datasource="#APPLICATION.DSN#">
				SELECT *
				FROM gifts
				WHERE gift_name IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#ArrayToList(local.top_results)#" list="true">)
			</cfquery>

			<cfoutput>
				<cfloop query="local.qGifts">
					<div class="short_desc">
						#gift_primary#<hr />
					</div>
				</cfloop>
			</cfoutput>
		</cfif>
		
		<!--- Show a chart with the user's overall scores --->
		<cfchart
			chartWidth="600"
			format="flash">
			<cfchartseries
				type="bar"
				serieslabel="Survey Results Breakdown"
				paintStyle="shade">

				<cfloop array="#local.gifts#" index="gift">
					<cfchartdata item="#gift.name#" value="#(gift.counter / 4)#">
				</cfloop>
			</cfchartseries>
		</cfchart>
		
	</cffunction>
	
	
</cfcomponent>