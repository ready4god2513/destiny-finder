<cfparam name="ATTRIBUTES.post_title" default="">
<cfparam name="ATTRIBUTES.post_id" default="">
<cfparam name="ATTRIBUTES.post_author_id" default="">
<cfparam name="ATTRIBUTES.post_author_name" default="">
<cfparam name="ATTRIBUTES.post_date" default="">
<cfparam name="ATTRIBUTES.post_short_description" default="">
<cfparam name="ATTRIBUTES.post_media" default="">
<cfparam name="ATTRIBUTES.post_thumb" default="">

<cfset urlToLike = "http://#CGI.HTTP_HOST#/blog/index.cfm?page=blog&amp;blog_id=#ATTRIBUTES.post_id#" />

<cfoutput>
	<article class="single-blog-post">
		<header class="row">
			<h2 class="span6"><a href="/blog/index.cfm?page=blog&amp;blog_id=#ATTRIBUTES.post_id#">#ATTRIBUTES.post_title#</a></h2>
			<div class="get-social span3 offset1">
				<div class="fb-like" data-send="false" data-layout="box_count" data-href="#urlToLike#" data-width="50" data-show-faces="false"></div>
				<a href="https://twitter.com/share" class="twitter-share-button" data-url="#urlToLike#" data-lang="en" data-count="vertical">Tweet</a>
			</div>
		</header>
		<div class="post-body">
			#ATTRIBUTES.post_content#
			
			<a href="/blog/index.cfm?page=blog&amp;blog_id=#ATTRIBUTES.post_id#" class="btn info">Continue Reading</a>
		</div>
		
	</article>
</cfoutput>