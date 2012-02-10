<cfcomponent displayname="delight" output="no" hint="I handle delight surveys">
	
	
	<!--- Insert the results of the survey --->
	<cffunction name="insertRecord" output="false" return="void">
		<cfargument name="user_id" type="numeric" required="true" />
		<cfargument name="aptitudes" type="string" required="true" />
		<cfargument name="delights" type="string" required="true" />
		
		<cfset var local = {} />
		
		<cfif this.getResults(user_id = ARGUMENTS.user_id).recordcount GT 0>
			<cfquery name="local.insertRecords" datasource="#APPLICATION.DSN#">
				UPDATE delight_survey_results
				SET aptitudes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#SerializeJSON(ARGUMENTS.aptitudes)#">,
				delights = <cfqueryparam cfsqltype="cf_sql_varchar" value="#SerializeJSON(ARGUMENTS.delights)#">,
				last_modified = <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.user_id#">
			</cfquery>
		<cfelse>
			<cfquery name="local.insertRecords" datasource="#APPLICATION.DSN#">
				INSERT INTO delight_survey_results (user_id, aptitudes, delights, last_modified)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.user_id#">,
			    <cfqueryparam cfsqltype="cf_sql_varchar" value="#SerializeJSON(ARGUMENTS.aptitudes)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#SerializeJSON(ARGUMENTS.delights)#">,
			    <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">)
			</cfquery>
		</cfif>
		
	</cffunction>
	
	
	<!--- Get the results of the survey --->
	<cffunction name="getResults" output="false" return="query">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset var local = {} />
		
		<cfquery name="local.results" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM delight_survey_results
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.user_id#">
		</cfquery>
		
		<cfreturn local.results />
	</cffunction>
	
	
	<!--- Compare the arrays to see if there are similarities --->
	<cffunction name="compareResults" output="false" return="array">
		<cfargument name="aptitudes" type="string" required="true" />
		<cfargument name="delights" type="string" required="true" />
		
		<cfset var local = {} />
		<cfset local.matches = ArrayNew(1) />
		
		<cfloop list="#ARGUMENTS.aptitudes#" index="i">
			<cfif ListFindNoCase(ARGUMENTS.delights, i)>
				<cfset ArrayAppend(local.matches, i)>
			</cfif>
		</cfloop>
		
		<cfreturn local.matches />
	</cffunction>
	
</cfcomponent>