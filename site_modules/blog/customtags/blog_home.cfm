<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

<cfquery name="qBlog" datasource="#APPLICATION.DSN#">
	SELECT * 
	FROM Blog_Home
	WHERE Blog_id = 1
</cfquery>

<cfoutput>
	#qBlog.Blog_intro#
	
	<cfset VARIABLES.feature_count = qBlog.Blog_feature_one + qBlog.Blog_feature_two + qBlog.Blog_feature_three>
	
	<cfif VARIABLES.feature_count GT 0>
		<div class="blog_home_heading">
			FEATURED POSTS
		</div><!-- class="blog_home_heading" -->
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
	<div class="blog_home_heading">
		RECENT POSTS
	</div>
	
	
		<cfloop query="qPosts">
			<cfset qAuthor = obj_queries.author_detail(author_id="#qPosts.blog_user_id#")>	
			<cfmodule template="post_preview.cfm"
						post_id="#qPosts.blog_id#"
						post_title="#qPosts.blog_title#"
						post_author_id="#qPosts.blog_user_id#"
						post_author_name="#qAuthor.user_first_name# #qAuthor.user_last_name#"
						post_short_description="#qPosts.blog_shorttext#"
						post_date="#qPosts.blog_publish_date#"
						post_thumb="#qPosts.blog_thumb#"
					>			
		
		
		
		<!---
		<div class="post_preview_wrapper">
			<cfset VARIABLES.blog_media = "">
	
			<cfif LEN(qPosts.blog_media) GT 0>
				<cfif findnocase(RIGHT(qPosts.blog_media,3),"flv,mp4")>
					<cfset VARIABLES.blog_media = "video">
				<cfelseif findnocase(RIGHT(qPosts.blog_media,3),"mp3")>
					<cfset VARIABLES.blog_media = "audio">
				</cfif>
			<cfelseif LEN(qPosts.blog_youtube) GT 0>
				<cfset VARIABLES.blog_media = "video">
			</cfif>	
			
			
			
			<cfif LEN(qPosts.blog_thumb) GT 0>
				<img src="#qPosts.blog_thumb#" align="left" class="blog_thumb_image">
			</cfif>
			<a href="index.cfm?page=blog&blog_id=#qPosts.blog_id#" class="home_feature_title">#qPosts.blog_title#</a>
			<cfif LEN(VARIABLES.blog_media) GT 0>
				<img src="/site_images/<cfif VARIABLES.blog_media EQ "video">video<cfelseif VARIABLES.blog_media EQ "audio">audio</cfif>_icon.gif">
			</cfif>
			<span class="comment_count"><cfmodule template="comment_count.cfm" blog_id="#qPosts.blog_id#"></span>
			<br/>
			<span class="blog_preview_author">by <a href="index.cfm?page=blog&author=#qPosts.blog_user_id#">#qAuthor.user_first_name# #qAuthor.user_last_name#</a></span> 
			<span class="blog_preview_date">on #DateFormat(qPosts.blog_publish_date, 'mmm dd, yyyy')#</span>
			<div class="blog_preview_shorttext">
				#qPosts.blog_shorttext#
				<a href="index.cfm?page=blog&blog_id=#qPosts.blog_id#">...Read More</a>		
			</div>
			<br/>
			</div><!-- class="post_preview_wrapper" -->
			<div class="clear"></div>
			--->
		</cfloop>
	
	</cfif>
</cfoutput>