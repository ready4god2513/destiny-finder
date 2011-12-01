<cfcomponent displayname="queries" output="no" hint="I handle queries">

	<cffunction name="comment_list" returntype="query" output="true" hint="I return comments.">													
		<cfargument name="blog_id" type="numeric" required="yes">
		<cfquery name="qComments" datasource="#APPLICATION.dsn#">
			SELECT *
			FROM Comments
			WHERE comment_blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#blog_id#">
			AND comment_approved = 1
		</cfquery>
								
		<cfreturn qComments>						
										
	</cffunction>

	<cffunction name="author_list" returntype="query" output="true" hint="I return active authors.">
									
		<cfquery name="qAuthors" datasource="#APPLICATION.dsn#">
			SELECT *
			FROM Users
			WHERE user_active = 1
			AND user_type = 1
		</cfquery>
								
		<cfreturn qAuthors>						
										
	</cffunction>

	<cffunction name="author_detail" returntype="query" output="true" hint="I return author info.">
		<cfargument name="author_id" type="numeric" required="yes">
		
		<cfquery name="qAuthor" datasource="#APPLICATION.dsn#">
			SELECT *
			FROM Users
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#author_id#">
		</cfquery>
								
		<cfreturn qAuthor>						
										
	</cffunction>

	<cffunction name="author_post_list" returntype="query" output="true" hint="I return an author's post.">
		<cfargument name="author_id" type="numeric" required="yes">
		<cfargument name="addl_where" type="string" required="no">
		<cfargument name="publish_date" type="numeric" required="no">
		
		<cfparam name="publish_date" default="1">

			<cfquery name="qPostList" datasource="#APPLICATION.dsn#">
				SELECT *
				FROM blogs
				WHERE blog_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#author_id#">
				<cfif isDefined('addl_where')>
					#addl_where#
				</cfif>
				<cfif isDefined('publish_date') AND publish_date EQ 1>
					AND blog_publish_date <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateAdd('h',REQUEST.time_offset,NOW())#">
				</cfif>
				ORDER BY blog_publish_date DESC
			</cfquery>
								
		<cfreturn qPostList>						
										
	</cffunction>
	
	<cffunction name="user_verify" output="false" returntype="numeric" hint="I verify a user">
		<cfargument name="user_name" type="string" require="yes">		
		<cfargument name="password"	type="string" require="yes">
		<cfargument name="type" type="numeric" required="no">
	
		
		<cfquery name="qUser_Verify" datasource="#APPLICATION.dsn#">
			SELECT user_id
			FROM users
			WHERE user_username = <cfqueryparam cfsqltype="cf_sql_char" value="#user_name#">
				AND user_password = <cfqueryparam cfsqltype="cf_sql_char" value="#password#">
				AND user_active = 1
				<cfif isDefined('type')>
					AND user_type = #type#
				</cfif>
		</cfquery>
			
		<cfif qUser_Verify.recordcount EQ 0>
			<cfset VARIABLES.user_id = 0>
		<cfelse>
			<cfset VARIABLES.user_id = qUser_Verify.user_id>
		</cfif>
			
		<cfreturn VARIABLES.user_id>
			
	</cffunction>
	
	<cffunction name="retrieve_blog" returntype="query" output="true" hint="I return a post.">
		<cfargument name="blog_id" type="numeric" required="yes">
		<cfargument name="author_id" type="numeric" required="no">
		<cfargument name="admin" type="numeric" required="no">
		
		<cfparam name="admin" default="0">
		<cfparam name="author_id" default="0">
		
			<cfquery name="qBlog" datasource="#APPLICATION.DSN#">
				SELECT *
				FROM blogs
				WHERE blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#blog_id#">
				<cfif author_id GT 0>
					AND blog_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#author_id#">
				</cfif>
				<cfif admin EQ 0>
					AND blog_active = 1
					AND blog_publish_date  <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateAdd('h',REQUEST.time_offset,NOW())#">
				</cfif>
				
			</cfquery>
								
		<cfreturn qBlog>						
										
	</cffunction>
	
	<cffunction name="retrieve_blog_temp" returntype="query" output="true" hint="I return a post from the temp table for editing.">
		<cfargument name="blog_id" type="numeric" required="yes">
		<cfargument name="author_id" type="numeric" required="no">
		<cfargument name="admin" type="numeric" required="no">
		
		<cfparam name="admin" default="0">
		<cfparam name="author_id" default="0">
		
			<cfquery name="qBlog" datasource="#APPLICATION.DSN#">
				SELECT *
				FROM blogs_temp
				WHERE blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#blog_id#">
				<cfif author_id GT 0>
					AND blog_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#author_id#">
				</cfif>
				<cfif admin EQ 0>
					AND blog_active = 1
				</cfif>
			</cfquery>
								
		<cfreturn qBlog>						
										
	</cffunction>

	<cffunction name="archive_listing" returntype="query" output="true" hint="I return a list of archive dates.">
		<cfquery name="qArchive" datasource="#APPLICATION.dsn#">
		SELECT DISTINCT DatePart(year,blog_date) as year, DatePart(month,blog_date) as month
		FROM blogs
		WHERE blog_active = 1
		ORDER BY year DESC,month DESC
		</cfquery>
		
		<cfreturn qArchive>
	</cffunction>

	<cffunction name="archive_posts" returntype="query" output="true" hint="I return a list of posts within a given date/year.">
		<cfquery name="qPosts" datasource="#APPLICATION.dsn#">
		SELECT * FROM blogs
		WHERE 
		DatePart(month,blog_date) = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.month#">
		AND
		DatePart(year,blog_date) = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.year#">
		AND blog_active = 1
		AND blog_publish_date <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateAdd('h',REQUEST.time_offset,NOW())#">
		ORDER BY blog_date DESC,blog_user_id
		</cfquery>
		
		<cfreturn qPosts>
	</cffunction>
	
	<cffunction name="recent_posts" returntype="query" output="true" hint="I return recent posts">
		<cfargument name="max_rows" type="numeric" required="no">
		
		<cfquery name="qPosts" datasource="#APPLICATION.DSN#">
			SELECT 
			<cfif isDefined('max_rows')>
				TOP #max_rows#
			</cfif> *
			FROM blogs
			WHERE blog_active = 1
			AND blog_publish_date <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateAdd('h',REQUEST.time_offset,NOW())#">
			ORDER BY blog_publish_date DESC
		</cfquery>
		
		
		
		<cfreturn qPosts>
	</cffunction>
	
	<cffunction name="category_list" returntype="query" output="true" hint="I return a list of categories.">
		<cfquery name="qCategories" datasource="#APPLICATION.dsn#">
		SELECT category_id,category_title
		FROM Categories
		ORDER BY category_title
		</cfquery>
		
		<cfreturn qCategories>
	</cffunction>

	<cffunction name="category_posts" returntype="query" output="true" hint="I return a list of posts within a given category .">
	<cfargument name="category_id" required="no" default="0">
	<cfif category_id EQ 0 AND isDefined('URL.category')>
		<cfset category_id = URL.category>
	</cfif>
	
	
		<cfquery name="qPosts" datasource="#APPLICATION.dsn#">
		SELECT blogs.blog_id, blogs.blog_title, blogs.blog_user_id,blogs.blog_shorttext,blogs.blog_date,blogs.blog_media,blogs.blog_youtube,blogs.blog_publish_date,blogs.blog_thumb
		FROM blogs 
			INNER JOIN Category_blog_Match ON blogs.blog_id = Category_blog_Match.blog_id
		WHERE Category_blog_Match.category_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#category_id#">
		AND blogs.blog_active = 1
		AND blogs.blog_publish_date <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateAdd('h',REQUEST.time_offset,NOW())#">
		ORDER BY blogs.blog_date DESC
		</cfquery>
		
		<cfreturn qPosts>
	</cffunction>
	
	<cffunction name="retrieve_category" returntype="query" output="true" hint="I return a category.">
		<cfquery name="qCategory" datasource="#APPLICATION.dsn#">
		SELECT category_id,category_title
		FROM Categories
		WHERE Category_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.category#">
		</cfquery>
		
		<cfreturn qCategory>
	</cffunction>
	
	<cffunction name="all_posts" returntype="query" output="true" hint="I return all posts.">
		<cfargument name="where_condition" type="string" required="no">
		<cfargument name="order_condition" type="string" required="no">
		<cfargument name="max_rows" type="numeric" required="no">
		
		<cfset VARIABLES.query = "SELECT">

		
		<cfif isDefined('max_rows')>
			<cfset VARIABLES.query = VARIABLES.query & " TOP #max_rows#">
		</cfif> 
			<cfset VARIABLES.query = VARIABLES.query & " * FROM blogs">
		<cfif isDefined('where_condition')>
			<cfset VARIABLES.query = VARIABLES.query & " #where_condition#">
		</cfif>
		<cfif isDefined('order_condition')>
			<cfset VARIABLES.query = VARIABLES.query & " #order_condition#">
		</cfif>
	

		<cfquery name="qPosts" datasource="#APPLICATION.dsn#">
		#VARIABLES.query#
		</cfquery>
		
		<cfreturn qPosts>
	</cffunction>
	
	
	

	
</cfcomponent>