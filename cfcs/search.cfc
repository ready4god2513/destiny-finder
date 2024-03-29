<cfcomponent displayname="Search" output="no" hint="I handle the search functions">

<cffunction name="content_search" returntype="query" output="false"	hint="I search the content">
	<cfargument name="search" required="yes" default="">
	
	<cfquery name="qContent" datasource="#APPLICATION.DSN#">
		SELECT DISTINCT content_action,content_name,content_gateway
		FROM  Content 		
		WHERE (content_name
		<cfif listlen(search, " ") GT 1>
			<cfloop from="1" to="#listlen(search, " ")#" index="i">
				LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #ListGetAt(search, i, " ")# %">
					<cfif i LT listlen(search, " ")>
					 OR content_name
					</cfif>
			</cfloop>
		<cfelse>
		LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #search# %">
		</cfif>
		
		OR content_content
		<cfif listlen(search, " ") GT 1>
		<cfloop from="1" to="#listlen(search, " ")#" index="i">
				LIKE <cfqueryparam cfsqltype="cf_sql_char" value=" %#ListGetAt(search, i, " ")# %">
					<cfif i LT listlen(search, " ")>
					 OR content_content
					</cfif>
			</cfloop>
		<cfelse>
		LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #search# %">
		</cfif>
		)
		
		AND content_active = 1 
	</cfquery>
	
	<cfreturn qContent>
	
</cffunction>

<cffunction name="article_search" returntype="query" output="false"	hint="I search the articles">
	<cfargument name="search" required="yes" default="">
	
	<cfquery name="qArticles" datasource="#APPLICATION.DSN#">
		SELECT DISTINCT articleid,title
		FROM  Articles
		WHERE (title
		<cfif listlen(search, " ") GT 1>
			<cfloop from="1" to="#listlen(search, " ")#" index="i">
				LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #ListGetAt(search, i, " ")# %">
					<cfif i LT listlen(search, " ")>
					 OR title
					</cfif>
			</cfloop>
		<cfelse>
		LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #search# %">
		</cfif>
		
		OR article_content
		<cfif listlen(search, " ") GT 1>
		<cfloop from="1" to="#listlen(search, " ")#" index="i">
				LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #ListGetAt(search, i, " ")# %">
					<cfif i LT listlen(search, " ")>
					 OR article_content
					</cfif>
			</cfloop>
		<cfelse>
		LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #search# %">
		</cfif>
		
		OR shorttext
		<cfif listlen(search, " ") GT 1>
		<cfloop from="1" to="#listlen(search, " ")#" index="i">
				LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #ListGetAt(search, i, " ")# %">
					<cfif i LT listlen(search, " ")>
					 OR shorttext
					</cfif>
			</cfloop>
		<cfelse>
		LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #search# %">
		</cfif>
		)
		AND livedate <= #NOW()#
		
	</cfquery>
	
	<cfreturn qArticles>
	
</cffunction>

<cffunction name="event_search" returntype="query" output="false"	hint="I search the events">
	<cfargument name="search" required="yes" default="">
	
	
	<cfset VARIABLES.today_plus_one = DAY(NOW())-1>
	<cfset VARIABLES.date_string_plus_one = "#YEAR(NOW())#-#MONTH(NOW())#-#VARIABLES.today_plus_one#">

	<cfquery name="qEvents" datasource="#APPLICATION.DSN#">
		SELECT DISTINCT calevent_id,calevent_title
		FROM  Calendar_Events
		WHERE (calevent_title
		<cfif listlen(search, " ") GT 1>
			<cfloop from="1" to="#listlen(search, " ")#" index="i">
				LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #ListGetAt(search, i, " ")# %">
					<cfif i LT listlen(search, " ")>
					 OR calevent_title
					</cfif>
			</cfloop>
		<cfelse>
		LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #search# %">
		</cfif>
		
		OR calevent_title
		<cfif listlen(search, " ") GT 1>
			<cfloop from="1" to="#listlen(search, " ")#" index="i">
				LIKE <cfqueryparam cfsqltype="cf_sql_char" value="%#ListGetAt(search, i, " ")# %">
					<cfif i LT listlen(search, " ")>
					 OR calevent_title
					</cfif>
			</cfloop>
		<cfelse>
			LIKE <cfqueryparam cfsqltype="cf_sql_char" value="%#search# %">
		</cfif>
		
		 OR calevent_content
		<cfif listlen(search, " ") GT 1>
		<cfloop from="1" to="#listlen(search, " ")#" index="i">
				LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #ListGetAt(search, i, " ")# %">
					<cfif i LT listlen(search, " ")>
					 OR calevent_content
					</cfif>
			</cfloop>
		<cfelse>
		LIKE <cfqueryparam cfsqltype="cf_sql_char" value="% #search# %">
		</cfif>
		
		)
		AND calevent_end_date > '#Dateformat(VARIABLES.date_string_plus_one,'yyyy-mm-dd')#'
		AND calevent_live_date <= '#DateFormat(NOW(),'yyyy-mm-dd')#'
		AND calevent_active = 1;
	</cfquery>
	
	<cfreturn qEvents>
	
</cffunction>

</cfcomponent>