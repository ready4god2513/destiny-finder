<cfcomponent displayname="passion" output="no" hint="I handle all functions related to the passion survey">
	
	<cfset variables.user_id = "" />
	
	
	<cffunction name="init" output="false">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset variables.user_id = ARGUMENTS.user_id />
		<cfreturn this />
	</cffunction>


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
		<cfset var local = {} />
		
		<cfif this.hasTakenSurvey()>
			<cfset local.survey = this.findSurvey() />
			<cfquery name="local.deleteOldResults" datasource="#APPLICATION.DSN#">
				DELETE
				FROM passion_survey_results
				WHERE passion_survey_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.survey.id#">
			</cfquery>
		<cfelse>
			<cfquery name="local.startingSurvey" datasource="#APPLICATION.DSN#">
				INSERT INTO passion_surveys (user_id, created_at)
				VALUES (
					<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.user_id#">,
					<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
				)
			</cfquery>
			
			<cfset local.survey = this.findSurvey() />
		</cfif>
			
		<cfreturn local.survey />
	</cffunction>
	
	
	<!--- 
		Check to see if the user has already taken the survey.
		Either way, this will return a query.  Use "hasTakenSurvey()"
		to check if the user has taken the survey or not
	--->
	<cffunction name="findSurvey" output="false" returnType="query">
		<cfset var local = {} />
			
		<cfquery name="local.surveyResults" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM passion_surveys
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.user_id#">
		</cfquery>
		
		<cfreturn local.surveyResults />
	</cffunction>
	
	
	<!---
		Check to see if the user has taken the survey.  Returns bool
	--->
	<cffunction name="hasTakenSurvey" output="false" returnType="boolean">
		<cfreturn this.findSurvey().recordcount GT 0 />
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
		Get a single requested answer.  We need to find ways to cache this a bit better down
		the road, but for now it will work.
	--->
	<cffunction name="getAnswer" output="false" returnType="string">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="delimiter" type="string" required="false" default="and" />
		
		<cfset var local = {} />
		
		<cfquery name="local.surveyResults" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM passion_survey_results
			WHERE passion_survey_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.findSurvey().id#">
			AND name = <cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.name#">
		</cfquery>
		
		<cfif local.surveyResults.recordcount GT 0>
			<cftry>
				<cfreturn ListChangeDelims(local.surveyResults.value, ", #ARGUMENTS.delimiter# ") />
				<cfcatch>
					<cfreturn local.surveyResults.value />
				</cfcatch>
			</cftry>
		<cfelse>
			<cfreturn "[none given]" />
		</cfif>
	</cffunction>
	
	
	<!--- 
		Parse through the answers provided and fill out the report for the user.
	--->
	<cffunction name="calculateResults" output="true" returnType="void">
		
		<cfset var local = {} />
		
		<cfoutput>
			<h3>Passion Survey Results</h3>
			<p>
				I am most passionate about bringing my primary kingdom impact in the sphere of 
				<strong>#this.getAnswer("sphere")#</strong>, specifically working in the area(s) of 
				<strong>#this.getAnswer("sphere_sub1")#</strong>.
			</p>
			<p>
				The causes I am most passionate about are <strong>#this.getAnswer("causes_societal")#</strong>. 
				I'm drawn to help people who are afflicted with <strong>#this.getAnswer("causes_human")#</strong>.
			</p>
			<p>
				I am most passionate serving others inside my church or group through  <strong>#this.getAnswer("causes_ministries")#</strong> 
				ministries. I am most passionate about bringing kingdom impact to those outside my church or group through <strong>#this.getAnswer("causes_ministry_activities")#</strong> activities.
			</p>
			<p>
				I feel the most fulfilled when communicating with others through 
				<strong>#this.getAnswer("causes_communication")#</strong>, and I feel most alive when expressing 
				myself through creative expressions of <strong>#this.getAnswer("causes_expressing")#</strong>. 
			</p>
			<p>
				My heart direction is mostly <strong>#this.getAnswer("causes_heart")#</strong> and I connect with God the most through
				<strong>#this.getAnswer("connect_god")#</strong>
			</p>
			<p>
				I'm most comfortable in a <strong>#this.getAnswer("scope_org")#</strong> 
				type of organization, and the size of group I am most comfortable working with is 
				<strong>#this.getAnswer("scope_group")#</strong>. In my church or ministry commitment, 
				I feel most comfortable serving as a <strong>#this.getAnswer("role_church")#</strong>.
			</p>
			<p>	
				In the workplace, I'm most comfortable in the role of 
				<strong>#this.getAnswer("role_workplace", "or")#</strong>.
			</p>
			<p>
				I want to impact the <strong>#this.getAnswer("impact_age_group")#</strong> age group in 
				<strong>#this.getAnswer("impact_area")#</strong> areas of
				<strong>#this.getAnswer("impact_region")#</strong>, of 
				<strong>#this.getAnswer("impact_ethnicity")#</strong> ethnicity and the 
				<strong>#this.getAnswer("impact_subculture")#</strong> subculture with a 
				<strong>#this.getAnswer("impact_religious")#</strong> religious orientation.
			</p>
			<p>
				I have a passion to bring kingdom impact and transformation to the 
				people I feel called to, and by God's grace I will!
			</p>
		</cfoutput>
		
	</cffunction>
	
</cfcomponent>