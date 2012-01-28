<cfparam name="ATTRIBUTES.admin" default="0">
<cfparam name="ATTRIBUTES.author_id" default="0">
<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

<cfset qPost = obj_queries.retrieve_blog(blog_id="#URL.blog_id#",admin="#ATTRIBUTES.admin#",author_id="#ATTRIBUTES.author_id#")>
<cfset currentURL = "http://#CGI.HTTP_HOST#/blog/index.cfm?page=blog&amp;blog_id=#URL.blog_id#" />
<cfif qPost.recordcount GT 0>
	<cfset qAuthor = obj_queries.author_detail(author_id="#qPost.blog_user_id#")>
	
	<cfoutput query="qPost">
		<article class="single-blog-post">
			<header class="row">
				<h2 class="span7">#qPost.blog_title#</h2>
				<div class="get-social pull-right">
					<div class="fb-like" data-send="false" data-href="#currentURL#" data-layout="box_count" data-width="50" data-show-faces="false"></div>
					<a href="https://twitter.com/share" class="twitter-share-button" data-url="#currentURL#" data-lang="en" data-count="vertical">Tweet</a>
				</div>
			</header>
			
			<div class="post-body">
				#qPost.blog_content#
			</div>
			
			<footer>
				<a href="https://twitter.com/share" class="twitter-share-button" data-url="#currentURL#" data-lang="en">Tweet</a>
				<div class="fb-like" data-send="false" data-href="#currentURL#" data-width="400" data-show-faces="false"></div>
			</footer>
		</article>
	</cfoutput>
	
	<h5>COMMENTS:</h5>
	<cfmodule template="comment_box.cfm">

<cfelse>
	<div class="site_notification">- Post could not be retrieved -</div>
</cfif>
