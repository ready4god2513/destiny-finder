<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>
<cfparam name="ATTRIBUTES.blog_id_list" default="">
<cfparam name="ATTRIBUTES.author" default="yes">
<cfparam name="ATTRIBUTES.description" default="yes">
<cfparam name="ATTRIBUTES.comments" default="yes">
<cfparam name="ATTRIBUTES.date" default="yes">


<cfloop list="#ATTRIBUTES.blog_id_list#" index="blog_id">
<cfif blog_id NEQ 0>
<div class="blog_preview_wrapper">
	<cfoutput>
		<cfset qBlogFeature = obj_queries.retrieve_blog(blog_id="#blog_id#")>
		<cfset qAuthor = obj_queries.author_detail(author_id="#qBlogFeature.blog_user_id#")>	
	
		<cfset VARIABLES.blog_media = "">
	
		<cfif LEN(qBlogFeature.blog_media) GT 0>
			<cfif findnocase(RIGHT(qBlogFeature.blog_media,3),"flv,mp4")>
				<cfset VARIABLES.blog_media = "video">
			<cfelseif findnocase(RIGHT(qBlogFeature.blog_media,3),"mp3")>
				<cfset VARIABLES.blog_media = "audio">
			</cfif>
		<cfelseif LEN(qBlogFeature.blog_youtube) GT 0>
			<cfset VARIABLES.blog_media = "video">
		</cfif>	
		
		<cfif LEN(qBlogFeature.blog_thumb) GT 0>
			<img src="#qBlogFeature.blog_thumb#" align="left" style="margin:0px 5px 5px 0px;">
		</cfif>
		<a href="/blog/index.cfm?page=blog&blog_id=#qBlogFeature.blog_id#">#qBlogFeature.blog_title#</a> 
		<cfif LEN(VARIABLES.blog_media) GT 0>
			<img src="../site_images/<cfif VARIABLES.blog_media EQ "video">video<cfelseif ATTRIBUTES.blog_media EQ "audio">audio</cfif>_icon.gif">
		</cfif>
		<cfif ATTRIBUTES.comments EQ "yes">
			<span class="comment_count"><cfmodule template="comment_count.cfm" blog_id="#qBlogFeature.blog_id#"></span>
			<br/>
		</cfif>
		<cfif ATTRIBUTES.author EQ "yes">
			<span class="blog_preview_author">by <a href="/blog/index.cfm?page=blog&author=#qBlogFeature.blog_user_id#">#qAuthor.user_first_name# #qAuthor.user_last_name#</a></span> 
		</cfif>
		<cfif ATTRIBUTES.date EQ "yes">
			<span class="blog_preview_date">on #DateFormat(qBlogFeature.blog_publish_date, 'mmm dd, yyyy')#</span>
		</cfif>
		<cfif ATTRIBUTES.description EQ "yes">
			<div class="blog_preview_shorttext">
				#qBlogFeature.blog_shorttext#
				<a href="/blog/index.cfm?page=blog&blog_id=#qBlogFeature.blog_id#">...Read More</a>		
			</div>
		</cfif>
		<br/>
	</cfoutput>	
</div>
</cfif>
</cfloop>
