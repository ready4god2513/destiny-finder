<cfparam name="ATTRIBUTES.post_title" default="">
<cfparam name="ATTRIBUTES.post_id" default="">
<cfparam name="ATTRIBUTES.post_author_id" default="">
<cfparam name="ATTRIBUTES.post_author_name" default="">
<cfparam name="ATTRIBUTES.post_date" default="">
<cfparam name="ATTRIBUTES.post_short_description" default="">
<cfparam name="ATTRIBUTES.post_media" default="">
<cfparam name="ATTRIBUTES.post_thumb" default="">

<cfoutput>
	<article class="single-blog-post">
		<header>
			<h2><a href="/blog/index.cfm?page=blog&blog_id=#ATTRIBUTES.post_id#">#ATTRIBUTES.post_title#</a></h2>
			<span class="blog_date">on #DateFormat(ATTRIBUTES.post_date, 'mmm dd, yyyy')#</span>
		</header>
		#ATTRIBUTES.post_content#
	</article>
</cfoutput>