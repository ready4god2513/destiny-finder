<cfcomponent displayname="blog" output="no" hint="I handle the blog functions">

<cfset obj_admin = CreateObject("component","admin.cfcs.admin")>
<cfset obj_files = CreateObject("component","site_modules.blog.cfcs.files")>
<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

<cffunction name="process_form" returntype="string" output="false" hint="I process the blog form">
	<cfargument name="process" required="yes" type="string">
	<cfargument name="return_url" required="no" type="string">

	<!--- RETRIEVE USER DETAIL --->
	<cfset qAuthor = obj_queries.author_detail(author_id="#FORM.blog_user_id#")>


	<cfset FORM.blog_publish_date = CreateODBCDateTime("#FORM.blog_publish_date# #FORM.blog_publish_time#")>

	<cfparam name="VARIABLES.blog_media" default="">
	<cfparam name="VARIABLES.blog_thumb" default="">
	<cfparam name="FORM.blog_categories" default="">
	
	<cfswitch expression="#process#">
		<cfcase value="Post">	
				<cfif LEN(FORM.add_media_file) GT 0>
					<cfset VARIABLES.blog_media = obj_files.upload_file(form_file_field="add_media_file",file_purpose="blog")>
				</cfif>
				<cfif LEN(FORM.add_blog_thumb) GT 0>
					<cfset VARIABLES.blog_thumb = obj_files.upload_file(form_file_field="add_blog_thumb",file_purpose="blog")>
				</cfif>

				<cfquery name="Insert_Blog" datasource="#APPLICATION.dsn#">
					INSERT INTO	blogs
						(blog_title,blog_date,blog_publish_date,blog_content,blog_user_id,blog_active,blog_media,blog_thumb,blog_shorttext,
						blog_categories,blog_youtube,blog_wall,blog_facebook,blog_twitter,blog_meta_desc)
					VALUES
						(<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_title#">,
						<cfqueryparam cfsqltype="cf_sql_date" value="#FORM.blog_date#">,
						<cfqueryparam cfsqltype="cf_sql_timestamp" value="#FORM.blog_publish_date#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_content#">,
						<cfif LEN(FORM.blog_user_id) GT 0>
							<cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.blog_user_id#">,
						<cfelse>
							NULL,
						</cfif>
						<cfif qAuthor.user_moderate EQ 1>0<cfelse>1</cfif>,
						<cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.blog_media#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.blog_thumb#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_shorttext#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_categories#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_youtube#">,
						0,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_facebook#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_twitter#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_meta_desc#">
						)
				</cfquery>
				
				<cfquery name="GetMax" datasource="#APPLICATION.DSN#" maxrows="1">
					SELECT blog_id 
					FROM blogs
					ORDER BY blog_id DESC
				</cfquery>
				
				<!--- INSERT INTO TEMP TABLE FOR EDITING PURPOSES --->
				
				<cfquery name="Insert_blog_temp" datasource="#APPLICATION.dsn#">
					INSERT INTO	blogs_temp
						(blog_id,blog_title,blog_date,blog_publish_date,blog_content,blog_user_id,blog_active,blog_media,blog_thumb,blog_shorttext,
						blog_categories,blog_youtube,blog_wall,blog_facebook,blog_twitter,blog_meta_desc)
					VALUES
						(#GetMax.blog_id#,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_title#">,
						<cfqueryparam cfsqltype="cf_sql_date" value="#FORM.blog_date#">,
						<cfqueryparam cfsqltype="cf_sql_timestamp" value="#FORM.blog_publish_date#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_content#">,
						<cfif LEN(FORM.blog_user_id) GT 0>
							<cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.blog_user_id#">,
						<cfelse>
							NULL,
						</cfif>
						<cfif qAuthor.user_moderate EQ 1>0<cfelse>1</cfif>,
						<cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.blog_media#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.blog_thumb#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_shorttext#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_categories#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_youtube#">,
						0,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_facebook#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_twitter#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_meta_desc#">
						)
				</cfquery>
				
				
				
				
				<cfparam name="FORM.blog_id" default="#GetMax.blog_id#">
				
				<cfset obj_admin.lookup_table_update(
				lookup_table="Category_blog_Match",
				table_primkey_name="blog_id",
				checkbox_name="blog_categories",
				secondary_primkey_name="category_id"
				)>
				

				<!--- IF USER REQUIRES MODERATION, SEND NOTIFICATION --->				
				<cfif qAuthor.user_moderate EQ 1>
					
					<cfmail to="#REQUEST.admin_notification#" from="#REQUEST.from_email#" subject="#APPLICATION.sitename#: A new post has been made and is awaiting approval" type="html">
					
						<cfset qAuthor = obj_queries.author_detail(author_id="#FORM.blog_user_id#")>
						
						Please login and review the post "#FORM.blog_title#" by #qAuthor.user_first_name# #qAuthor.user_last_name#.
						<br />
						<br />
						<a href="#REQUEST.site_URL#admin/">#APPLICATION.sitename# Admin</a>				
					
					</cfmail>
				
				</cfif>
			
			<cfif isDefined('return_url')>
				<cflocation url="#return_url#" addtoken="no">
			<cfelse>
				<cflocation url="index.cfm?page=blog&admin=1" addtoken="no">
			</cfif>
		</cfcase>
		
		<cfcase value="Update Post">	
			
				<cfif LEN(FORM.add_media_file) GT 0>
					<cfset VARIABLES.blog_media = obj_files.upload_file(form_file_field="add_blog_thumb",file_purpose="blog")>
				</cfif>
				<cfif LEN(FORM.add_blog_thumb) GT 0>
					<cfset VARIABLES.blog_thumb = obj_files.upload_file(form_file_field="add_blog_thumb",file_purpose="blog")>
				</cfif>
				
				
				<cfquery name="Update_Blog" datasource="#APPLICATION.dsn#">
					UPDATE <cfif qAuthor.user_moderate EQ 1>blogs_temp<cfelse>blogs</cfif>
						SET 
						blog_title = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_title#">,
						blog_content = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_content#">,
						<cfif LEN(VARIABLES.blog_media) GT 0>
							blog_media = <cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.blog_media#">,
						</cfif>		
						<cfif LEN(VARIABLES.blog_thumb) GT 0>
							blog_thumb = <cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.blog_thumb#">,
						</cfif>		
						blog_publish_date = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#FORM.blog_publish_date#">,
						blog_shorttext = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_shorttext#">,
						blog_categories = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_categories#">,
						blog_youtube = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_youtube#">,
						blog_facebook = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_facebook#">,
						blog_twitter = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_twitter#">,
						blog_meta_desc = <cfqueryparam cfsqltype="cf_sql_char" value="#FORM.blog_meta_desc#">,
						blog_active = 1
						WHERE blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.blog_id#">
				</cfquery>
												
				<cfset obj_admin.lookup_table_update(
				lookup_table="Category_blog_Match",
				table_primkey_name="blog_id",
				checkbox_name="blog_categories",
				secondary_primkey_name="category_id"
				)>
				
				<!--- IF USER REQUIRES MODERATION, SEND NOTIFICATION --->				
				<cfif qAuthor.user_moderate EQ 1>.
				
					<cfmail to="#REQUEST.admin_notification#" from="#REQUEST.from_email#" subject="#APPLICATION.sitename#: A post has been edited and is awaiting approval" type="html">
					
						<cfset qAuthor = obj_queries.author_detail(author_id="#FORM.blog_user_id#")>
						
						Please login and review the post update for "#FORM.blog_title#" by #qAuthor.user_first_name# #qAuthor.user_last_name#.
						<br />
						<br />
						<a href="#REQUEST.site_URL#admin/">#APPLICATION.sitename# Admin</a>				
					
					</cfmail>
				
				</cfif>
				
			<cflocation url="index.cfm?page=blog&admin=1" addtoken="no">
		</cfcase>
		
		<cfdefaultcase>
		</cfdefaultcase>
	
	</cfswitch>
		
</cffunction>

<cffunction name="email_notification" output="false" hint="I send email notifications">
	<cfargument name="mail_to" required="yes">
	<cfargument name="mail_from" required="yes">
	
	<cfmail to="#mail_to#" from="#mail_from#" subject="#subject#" type="html">
	
	</cfmail>
</cffunction>

<cffunction name="generate_html_title" output="false" returntype="string" hint="I create a dynamic HTML title">
	<cfset VARIABLES.title_post_text = "Insight Creative Group Advertising Blog">
	
	<cfif isDefined('URL.author')>
		<cfset qAuthor = obj_queries.author_detail(author_id="#URL.author#")>
		<cfset VARIABLES.html_title = "#qAuthor.user_first_name# #qAuthor.user_last_name# Blog Posts - #VARIABLES.title_post_text#">
		 
	<cfelseif isDefined('URL.blog_id')>
		<cfset qPost = obj_queries.retrieve_blog(blog_id="#URL.blog_id#")>
		<cfset VARIABLES.html_title = "#qPost.blog_title# - #VARIABLES.title_post_text#">
	
	<cfelseif isDefined('URL.month')>
		<cfset VARIABLES.html_title = "#MonthAsString(URL.month)# #Year# Blog Posts - #VARIABLES.title_post_text#">
	
	<cfelseif isDefined('URL.category')>
		<cfset qCategory = obj_queries.retrieve_category()>
		<cfset VARIABLES.html_title = "#qCategory.category_title# Blog Posts - #VARIABLES.title_post_text#">

	<cfelse>
		<cfset VARIABLES.html_title = "#VARIABLES.title_post_text#">
	</cfif>
	
	<cfreturn VARIABLES.html_title>

</cffunction>

</cfcomponent>