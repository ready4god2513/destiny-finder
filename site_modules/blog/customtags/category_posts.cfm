<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>
<cfset qPosts = obj_queries.category_posts()>
<cfset qCategory = obj_queries.retrieve_category()>

<div class="category_title">
	<cfoutput>Topic Listing For #qCategory.category_title#:</cfoutput>
</div><!-- class="archive_title" -->

<div class="post_list">
	<ul>
	<cfoutput query="qPosts">
	
		<cfset VARIABLES.post_media = "">

		<cfif LEN(qPosts.blog_media) GT 0>
			<cfif findnocase(RIGHT(qPosts.blog_media,3),"flv,mp4")>
				<cfset VARIABLES.post_media = "video">
			<cfelseif findnocase(RIGHT(qPosts.blog_media,3),"mp3")>
				<cfset VARIABLES.post_media = "audio">
			</cfif>
		<cfelseif LEN(qPosts.blog_youtube) GT 0>
			<cfset VARIABLES.post_media = "video">
		</cfif>	
		
		<cfset qAuthor = obj_queries.author_detail(author_id="#qPosts.blog_user_id#")>
		<li>
		<cfmodule template="post_preview.cfm"
				post_id="#qPosts.blog_id#"
				post_title="#qPosts.blog_title#"
				post_author_id="#qPosts.blog_user_id#"
				post_author_name="#qAuthor.user_first_name# #qAuthor.user_last_name#"
				post_short_description="#qPosts.blog_shorttext#"
				post_date="#qPosts.blog_publish_date#"
				post_media="#VARIABLES.post_media#"
				post_thumb="#qPosts.blog_thumb#"
			>			
		</li>
	</cfoutput>
	</ul>
</div><!-- class="post_list" -->