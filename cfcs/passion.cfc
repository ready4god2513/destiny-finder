<cfcomponent displayname="passion" output="no" hint="I handle all functions related to the passion survey">


	<!--- 
		Insert a record into the passion_surveys table.
		This table simply keeps a single record for each user
		so that we can find all of the results.
		
		When restarting the survey, the results are deleted
		from the passion_survey_results table.
		
		This will return the query containing the survey id, user_id, and
		created_at
	--->
	<cffunction name="beginSurvey" output="false" returnType="query">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset var local = {} />
		
		<cfif this.hasTakenSurvey(user_id = ARGUMENTS.user_id)>
			<cfset local.survey = this.findSurvey(user_id = ARGUMENTS.user_id) />
			<cfquery name="local.deleteOldResults" datasource="#APPLICATION.DSN#">
				DELETE
				FROM passion_survey_results
				WHERE passion_survey_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.survey.id#">
			</cfquery>
		<cfelse>
			<cfquery name="local.startingSurvey" datasource="#APPLICATION.DSN#">
				INSERT INTO passion_surveys (user_id, created_at)
				VALUES (
					<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.user_id#">,
					<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
				)
			</cfquery>
			
			<cfset local.survey = this.findSurvey(user_id = ARGUMENTS.user_id) />
		</cfif>
			
		<cfreturn local.survey />
	</cffunction>
	
	
	<!--- 
		Check to see if the user has already taken the survey.
		Either way, this will return a query.  Use "hasTakenSurvey()"
		to check if the user has taken the survey or not
	--->
	<cffunction name="findSurvey" output="false" returnType="query">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset var local = {} />
			
		<cfquery name="local.surveyResults" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM passion_surveys
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.user_id#">
		</cfquery>
		
		<cfreturn local.surveyResults />
	</cffunction>
	
	
	<!---
		Check to see if the user has taken the survey.  Returns bool
	--->
	<cffunction name="hasTakenSurvey" output="false" returnType="boolean">
		<cfargument name="user_id" type="numeric" required="true" />
		<cfreturn this.findSurvey(user_id = ARGUMENTS.user_id).recordcount GT 0 />
	</cffunction>
	
	
	<!---
		This adds a name/value to the passion_survey_results table
		which will then be calculated once the survey has been completed
	--->
	<cffunction name="addAnswer" output="false" returnType="void">
		<cfargument name="passion_survey_id" type="numeric" required="true" />
		<cfargument name="name" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		
		<cfset var local = {} />
		
		
		<cfquery name="local.addingAnswer" datasource="#APPLICATION.DSN#">
			INSERT INTO passion_survey_results (passion_survey_id, name, value, created_at)
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.passion_survey_id#">,
				<cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.name#">,
				<cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.value#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
			)
		</cfquery>
		
	</cffunction>
	
	
	<!--- 
		Parse through the answers provided and fill out the report for the user.
	--->
	<cffunction name="calculateResults" output="true" returnType="void">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset var local = {} />
		
		<cfquery name="local.surveyResults" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM passion_survey_results
			WHERE passion_survey_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.findSurvey(user_id = ARGUMENTS.user_id).id#">
		</cfquery>
		
		<cfoutput>
			<h3>Passion Survey Results</h3>
			<cfdump var="#local.surveyResults#">
		</cfoutput>
		
	</cffunction>
	
</cfcomponent>