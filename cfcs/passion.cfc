<cfcomponent displayname="passion" output="no" hint="I handle all functions related to the passion survey">

	<cffunction name="beginSurvey" output="false" returnType="numeric">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset var local = {} />
		
		<cfif this.hasTakenSurvey(user_id = ARGUMENTS.user_id)>
			<cfset local.surveyId = this.usersSurvey(user_id = ARGUMENTS.user_id).id />
			<cfquery name="local.deleteOldResults" datasource="#APPLICATION.DSN#">
				DELETE
				FROM passion_survey_results
				WHERE survey_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.surveyId#">
			</cfquery>
		<cfelse>
			<cfquery name="local.startingSurvey" datasource="#APPLICATION.DSN#">
				SELECT *
				FROM passion_surveys
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.user_id#">
			</cfquery>
			
			<cfset local.surveyId = this.usersSurvey(user_id = ARGUMENTS.user_id).id />
		<cfif>
			
		<cfreturn local.surveyId />
	</cffunction>
	
	
	<cffunction name="hasTakenSurvey" output="false" returnType="boolean">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset var local = {} />
			
		<cfquery name="local.surveyResults" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM passion_surveys
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.user_id#">
		</cfquery>
		
		<cfreturn local.surveyResults.recordcount GT 0>
	</cffunction>
	
	<cffunction name="addAnswer" output="false" returnType="void">
		<cfargument name="passion_survey_id" type="numeric" required="true" />
		<cfargument name="key" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		
		<cfset var local = {} />
		
		
		<cfquery name="local.addingAnswer" datasource="#APPLICATION.DSN#">
			INSERT INTO passion_survey_results (passion_survey_id, key, value)
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.passion_survey_id#">,
				<cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.key#">,
				<cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.value#">
			)
		</cfquery>
		
	</cffunction>
	
	<cffunction name="calculateResults" output="true" returnType="void">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset var local = {} />
		
		<cfoutput>
			<h3>Here are your results</h3>
		</cfoutput>
		
	</cffunction>
	
</cfcomponent>