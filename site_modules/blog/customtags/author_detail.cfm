<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

<cfparam name="VARIABLES.todays_date" default="#DateFormat(NOW(),'yyyy-mm-dd')#">

<cfset qAuthor = obj_queries.author_detail(author_id="#URL.author#")>
<cfset qPosts = obj_queries.author_post_list(author_id="#URL.author#",addl_where="AND blog_active = 1")>

	<cfoutput>
		<div class="author_detail_name">
		#qAuthor.user_first_name# #qAuthor.user_last_name#
		</div><!--  class="author_detail_name" -->
		<div class="author_detail_description">
			<cfif LEN(qAuthor.user_image) GT 0>
				<img src="#qAuthor.user_image#" align="left">
			</cfif>
			#qAuthor.user_description#
		</div><!-- class="author_detail_description" -->
		<div class="clear"></div>
		<br/><Br/>
		
		<div class="post_list">
			<h2>#Ucase("#qAuthor.user_first_name# #qAuthor.user_last_name#'s Blog Posts")#</h2>
			<ul>
				<cfloop query="qPosts">
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
		
						<li>
						<cfmodule template="post_preview.cfm"
								post_id="#qPosts.blog_id#"
								post_title="#qPosts.blog_title#"
								post_author_id="#qPosts.blog_user_id#"
								post_author_name="#qAuthor.user_first_name# #qAuthor.user_last_name#"
								post_short_description="#qPosts.blog_shorttext#"
								post_date="#qPosts.blog_publish_date#"
								post_media="#VARIABLES.post_media#"
							>			
						</li>
				</cfloop>
			</ul>
		</div><!-- class="author_blog_list" -->
	</cfoutput>