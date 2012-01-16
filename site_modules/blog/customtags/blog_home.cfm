<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

<cfquery name="qBlog" datasource="#APPLICATION.DSN#">
	SELECT * 
	FROM Blog_Home
	WHERE Blog_id = 1
</cfquery>

<cfoutput>
	<cfset VARIABLES.feature_count = qBlog.Blog_feature_one + qBlog.Blog_feature_two + qBlog.Blog_feature_three>
	
	<cfif VARIABLES.feature_count GT 0>
		
		<div class="home_feature_list">
			<cfif qBlog.Blog_feature_one GT 0>
				<cfmodule template="feature_posts.cfm" blog_id_list="#qBlog.Blog_feature_one#">
			</cfif>
			<cfif qBlog.Blog_feature_two GT 0>
				<cfmodule template="feature_posts.cfm" blog_id_list="#qBlog.Blog_feature_two#">
			</cfif>
			<cfif qBlog.Blog_feature_three GT 0>
				<cfmodule template="feature_posts.cfm" blog_id_list="#qBlog.Blog_feature_three#">
			</cfif>
		</div>
	</cfif>

	<cfset qPosts = obj_queries.recent_posts(max_rows="3")>		
	
	<cfif qPosts.recordcount GT 0>
	
		<cfloop query="qPosts">
			<cfset qAuthor = obj_queries.author_detail(author_id="#qPosts.blog_user_id#")>	
			<cfmodule template="post_preview.cfm"
				post_id="#qPosts.blog_id#"
				post_title="#qPosts.blog_title#"
				post_author_id="#qPosts.blog_user_id#"
				post_author_name="#qAuthor.user_first_name# #qAuthor.user_last_name#"
				post_content="#qPosts.blog_shorttext#"
				post_date="#qPosts.blog_publish_date#"
				post_thumb="#qPosts.blog_thumb#">		
		</cfloop>
	
	</cfif>
</cfoutput>