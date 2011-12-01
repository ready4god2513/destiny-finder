<cfcomponent displayname="comments" output="no" hint="I handle the comment functions">
<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

	<cffunction name="log_comment" returntype="string" output="true" hint="I insert a comments into the database.">
									
		<cfquery name="Insert_Comment" datasource="#APPLICATION.dsn#">
			INSERT INTO	comments
				(comment_name,comment_email,comment_date,comment_content,comment_blog_id,comment_approved,comment_ip)
			VALUES
				(<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.comment_name#">,<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.comment_email#">,<cfqueryparam cfsqltype="cf_sql_timestamp" value="#FORM.comment_date#">,
				<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.comment_content#">,<cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.comment_blog_id#">,0,<cfqueryparam cfsqltype="cf_sql_char" value="#CGI.REMOTE_ADDR#">)
		</cfquery>
		
		<cfmail to="#REQUEST.admin_notification#" from="#REQUEST.from_email#" subject="#APPLICATION.sitename#: A new comment has been made and is awaiting approval" type="html">
				
					<cfset qPost = obj_queries.retrieve_blog(blog_id="#FORM.comment_blog_id#")>
					
					Please login and review the comment from #FORM.comment_name# (IP:#CGI.REMOTE_ADDR#) on the post #qPost.blog_title#.
					<br />
					<br />
					<a href="#REQUEST.site_URL#admin/">#APPLICATION.sitename# Admin</a>				
				
		</cfmail>
			
		
		<cfset VARIABLES.site_notification = "comment_logged">
			
		<cfreturn VARIABLES.site_notification>						
										
	</cffunction>

</cfcomponent>